<%@LANGUAGE="VBSCRIPT" CODEPAGE="1252"%>
<!--#include file="../Connections/CPV.asp" -->
<!--#include file="../app/funciones/_db.asp" -->
<!--#include file="../app/funciones/email.asp" -->
<!--#include file="../app/encrypt/enc.asp" -->

<%
errores=""
emailBody=""
nombre=Trim(Request.Form("cas_nombre"))
direccion=Trim(Request.Form("cas_direccion"))
email=Trim(Request.Form("cas_email"))
cuenta=Trim(Request.Form("cas_agencia_id"))
ciudad=Trim(Request.Form("cas_ciudad_id"))
clave=Trim(Request.Form("cas_password"))
terminos=Trim(Request.Form("terminos"))
telefono=request.Form("cas_telefono")
hid_des_id_obligatorio=request.form("hid_des_id_obligatorio")
txt_des_id=request.Form("txt_des_id")
zip=TRIM(Request.Form("cas_zip"))
txt_des_id=TRIM(Request.Form("txt_des_id"))

dim tj
tj = true
tjn = request.form("tar_numero")
if tjn<>"" then 
	'no esta vacio determinamos si tiene por lo menos 15 caracteres
	if len(tjn)<15 then tj=false
	if not isnumeric(tjn) then tj=false
end if

'if telefono<>"" and nombre<>"" and direccion<>"" and email<>"" and cuenta<>"" and ciudad<>"" and clave<>"" and terminos="1" then
if telefono<>"" and nombre<>"" and direccion<>"" and zip <>"" and email<>""  and ciudad<>"" and clave<>"" and ((hid_des_id_obligatorio="1" and txt_des_id<>"") or (hid_des_id_obligatorio="0" and (txt_des_id="" or txt_des_id<>""))   ) then
'aqui va el llamado al stored procedure
dim conn
call open_conn()
    Dim rsvalida_agencia

Set rsvalida_agencia = Server.CreateObject("ADODB.Recordset")
rsvalida_agencia.ActiveConnection = MM_CPV_STRING
rsvalida_agencia.Source = "select * from AGENCIAS where agencia_id= '"&request.Form("cas_agencia_id")&"' and age_crea_casillero=1"
rsvalida_agencia.CursorType = 0
rsvalida_agencia.CursorLocation = 2
rsvalida_agencia.LockType = 1
rsvalida_agencia.Open()
if not rsvalida_agencia.eof then
cas_agencia_id=request.Form("cas_agencia_id") 
else
cas_agencia_id="1"
'cas_agencia_id="8026" ''''''TENER CUIDADO ESTE ID SOLO ES EN PRODUCCION, PARA STAGING Y DESARROLLO IGUALAR A 1
errores="este casillero fu enviado a la agencia principal por que la que selecciono no poseee este servicio"
end if 
txtSql= "crearCasillerosweb " & _
"'" & request.Form("cas_nombre") & "'," & _
"'" & request.Form("cas_empresa") & "'," & _
"'" & request.Form("cas_direccion") & "'," & _
"'" & request.Form("cas_ciudad_id") & "'," & _
"'" & request.Form("cas_ciudad") & "'," & _
"'" & request.Form("cas_zip") & "'," & _
"'" & request.Form("cas_telefono") & "'," & _
"'" & request.Form("cas_fax") & "'," & _
"'" & request.Form("cas_email") & "'," & _
"'" & request.Form("cas_cuenta_id") & "'," & _
"'" & request.Form("cas_email") & "'," & _
"'" & request.Form("cas_ffw") & "'," & _
"'" & request.Form("cas_password") & "'," & _
"'" & request.Form("cas_email") & "'," & _
"'" & cas_agencia_id & "'," & _
"'" & request.Form("cas_servicio") & "'," & _
"'" & request.Form("cas_pago") & "'," & _
"'" & encrypt(request.Form("tar_numero")) & "'," & _
"'" & request.Form("tar_exp_mes") & "'," & _
"'" & request.Form("tar_exp_ano") & "'," & _
"'" & request.Form("tar_nombre") & "'," & _
"'" & request.Form("tar_tipo") & "'," & _
"'" & request.Form("tar_verificacion") & "'," & _
"'" & txt_des_id & "'"
	
set rs=conn.execute(txtSql)
if not rs.eof then
	Dim RsTemplate
	set RsTemplate=conn.execute("SELECT TE_NAME,TE_SUBJECT,TE_BODY FROM template_emails WHERE TE_NAME='Crear Casilleros y Confirmacion' AND ISNULL(TE_DESABILITADO,0)=0")

	IF NOT RsTemplate.EOF THEN
	
	cas_casillero=rs("cas_casillero")	
	cas_alias=rs("cas_alias")
	cas_password=rs("cas_password")
	cas_email=rs("cas_email")
	cas_direccion=rs("cas_direccion")
	cas_zip=rs("cas_zip")
	cas_telefono=rs("cas_telefono")
	cas_empresa=rs("cas_empresa")
	cas_ciudad=rs("cas_ciudad_nombre")
	cas_nombre=rs("cas_nombre")
	txt_des_id=txt_des_id
	emailBody=RsTemplate("TE_BODY")
	Te_subject= RsTemplate("TE_SUBJECT")
	
	emailBody=replace(emailBody,"@nombre_casillero",trim(cas_nombre))
	emailBody=replace(emailBody,"@txt_des_id",trim(txt_des_id))
	emailBody=replace(emailBody,"@casillero",trim(cas_casillero))
	emailBody=replace(emailBody,"@Alias",cas_alias)
	emailBody=replace(emailBody,"@clave_casillero",cas_password)
	emailBody=replace(emailBody,"@email_casillero",trim(cas_email))
	emailBody=replace(emailBody,"@direccion_casillero",trim(cas_direccion))
	emailBody=replace(emailBody,"@cas_zip",trim(cas_zip))
	emailBody=replace(emailBody,"@telefono_casillero",cas_telefono)	
	emailBody=replace(emailBody,"@empresa_casillero",cas_empresa)
	emailBody=replace(emailBody,"@ciudad_casillero",cas_ciudad)
	
	Te_subject=replace(Te_subject,"@nombre_casillero",trim(cas_nombre))
	Te_subject=replace(Te_subject,"@casillero",trim(cas_casillero))
	Te_subject=replace(Te_subject,"@Alias",cas_alias)
	
	END IF

emailSubject=Te_subject
	'on error resume next
	emailTo=rs("cas_email")
	call f_email(emailSubject,emailTo,emailFrom,emailBody,"")
	
	if request.form("ccEmail")<>"" then
		emailTo=request.form("ccEmail")
		call f_email(emailSubject,emailTo,emailFrom,emailBody,"")
	end if

	'if request.form("ccEmail")<>"" and request.form("notificar")="1"then
	'	emailTo=rs("cas_email")
	'	call f_email(emailSubject,emailTo,emailFrom,emailBody,request.form("ccEmail"))
	'end if
	
	errores="El casillero se creo satisfactoriamente, " 
	if err<>0 then	errores=errores & err.description
	
else 'no encontro el casillero que creo
	errores="Errores creando el casillero"

end if

'fin llamado stored procedure
else
	if Trim(Request.Form("MM_insert"))<>"" then
		if hid_des_id_obligatorio="1" and txt_des_id="" then
		errores="Falta Id del destinatario"
		else
		errores="Faltan datos para poder crear el casillero!! por favor verifique he intente nuevamente"
		end if
	end if
End If %>
<%
Dim rsCiudad__tmpffw
rsCiudad__tmpffw = "00001"
If (request.cookies("ffw")  <> "") Then 
  rsCiudad__tmpffw = request.cookies("ffw") 
End If
%>
<%
Dim rsCiudad
Dim rsCiudad_numRows

Set rsCiudad = Server.CreateObject("ADODB.Recordset")
rsCiudad.ActiveConnection = MM_CPV_STRING
rsCiudad.Source = "SELECT id_ciudad,c.id_pais as id_pais,p.codigo as codPais,c.nombre as nomCiudad  FROM dbo.CIUDADES as c  inner join paises as p on  c.id_pais=p.id_pais  WHERE c.id_pais=9 and c.ffw='" + Replace(rsCiudad__tmpffw, "'", "''") + "'  ORDER BY c.nombre"
rsCiudad.CursorType = 0
rsCiudad.CursorLocation = 2
rsCiudad.LockType = 1
rsCiudad.Open()

rsCiudad_numRows = 0
%>
<%
Dim rsAgencias__tmpffw
rsAgencias__tmpffw = "00001"

If (request.cookies("ffw") <> "") Then 
  rsAgencias__tmpffw = request.cookies("ffw")
End If
%>
<%
Dim rsAgencias
Dim rsAgencias_numRows
''Brayan Ramirez - Ordenar DropDownList por  la columna orden
Set rsAgencias = Server.CreateObject("ADODB.Recordset")
rsAgencias.ActiveConnection = MM_CPV_STRING
rsAgencias.Source = "SELECT *  FROM dbo.AGENCIAS WHERE age_crea_casillero=1 and ffw='" + Replace(rsAgencias__tmpffw, "'", "''") + "'  ORDER BY isnull(age_orden,1) asc , nombre desc"
rsAgencias.CursorType = 0
rsAgencias.CursorLocation = 2
rsAgencias.LockType = 1
rsAgencias.Open()

rsAgencias_numRows = 0
Dim rsAgencia
Set rsAgencia = Server.CreateObject("ADODB.Recordset")
rsAgencia.ActiveConnection = MM_CPV_STRING
rsAgencia.Source = "SELECT *  FROM dbo.AGENCIAS WHERE agencia_id = '" + request.QueryString("agencia")  + "'" 
rsAgencia.CursorType = 0
rsAgencia.CursorLocation = 2
rsAgencia.LockType = 1
rsAgencia.Open()
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
	<meta charset="utf-8"/>
	<title>Zaicargo - Casillero Postal</title>
	<link href="Imagenes/estilos.css" rel="stylesheet" type="text/css" />
	<style type="text/css">
	<!--
	.style1
	{
		font-size: 10px;
		font-family: Arial, Helvetica, sans-serif;
		color: #FFFFFF;
	}
	-->
	</style>
	<link rel="stylesheet" href="css/base.css"/>
	<link rel="stylesheet" href="css/skeleton.css"/>
	<link rel="stylesheet" href="css/layout.css"/>
	<link rel="stylesheet" href="css/font-awesome.css"/>	
	<link rel="stylesheet" href="css/jquery.fancybox.css"/>
	<link rel="stylesheet" href="css/flat_filled_styles.css"><!--SVG Animation Styles-->
	<link rel="stylesheet" href="css/retina.css"/>
	<link rel="stylesheet" href="css/style.css"/>
	<script src="https://code.jquery.com/jquery-2.1.0.min.js"></script>
	<!-- Favicons ================================================== -->
	<link rel="shortcut icon" href="zaicon.png"/>
	<link rel="apple-touch-icon" href="zaiconpng"/>
	<link rel="apple-touch-icon" sizes="72x72" href="zaicon.png"/>
	<link rel="apple-touch-icon" sizes="114x114" href="zicon.png"/>
	<script language="JavaScript" src="https://seal.networksolutions.com/siteseal/javascript/siteseal.js" type="text/javascript"></script>
</head>
<script language="javascript">
	function fp(URL)
	{
		var winl = (screen.width - 400) / 2;
		var wint = (screen.height - 400) / 2;
		window.open(URL,"cityPopUp","width=400,height=400,top=" + wint + ",left=" + winl + ",scrollbars=no,toolbar=no,resizable=yes");
	}
</script>
<body>
	<%if request.QueryString("agencia")<>"" then %>
		<div width="800px" border="0" cellspacing="0" cellpadding="0" align="center" style="color:#FF0000; margin:auto;background-color:#E4CD00; width:800px;">
			<%=(rsAgencia.Fields.Item("nombre").Value)%>
		</div>
	<% end if %>
	<div id="sep1">
		<div id="contact">
			<div class="container">
				<div class="sixteen columns" data-scrollreveal="enter top and move 150px over 1s">
					<div class="header-text">
						<div class="header-shadow-text">Afíliate</div>
						<h1>Afíliate</h1>
						<p>Es totalmente gratis, suscribete a nuestro servicio, para recibir todo lo que compres en USA, nosotros te lo entregamos en la puerta de la casa u oficina.</p>
					</div>
				</div>
			</div>
			<div class="container">	
				<!-- <form name="ajax-form" id="ajax-form" action="mail-it.php" method="post"> -->
				<form method="post" action="registro_new.asp?agencia=<%=request.querystring("agencia") %>" name="form1">
					<div class="con">
						<span class="txtTituloJ"><%=errores%></span>
						<%if errores="El casillero se creo satisfactoriamente, " then %>
						<p class="style1"><%=response.Write(emailBody)%></p>
						<%else%>
						<p>Datos Personales</p>
					</div>
					<div class="eight columns">
						<label for="name">
							Nombres y apellidos: * 
							<span class="error" id="err-name">please enter name</span>
						</label>
						<input name="name" id="name" type="text" />
					</div>
					<div class="eight columns">
						<label for="email">
							Empresa: * 
							<span class="error" id="err-email">please enter e-mail</span>
							<span class="error" id="err-emailvld">e-mail is not a valid format</span>
						</label>
						<input name="email" id="email" type="text" />
					</div>
					<div class="clear"></div>	
					<div class="error" id="err-state"></div>
					<!-- segunda linea form -->
					<div class="eight columns">
						<label for="name">
							Dirección: * 
							<span class="error" id="err-name">please enter name</span>
						</label>
						<input name="name" id="name" type="text" />
					</div>
					<div class="eight columns">
						<label for="email">
							Ciudad: * 
							<span class="error" id="err-email">please enter e-mail</span>
							<span class="error" id="err-emailvld">e-mail is not a valid format</span>
						</label>
						<input name="email" id="email" type="text" />
					</div>
					<div class="clear"></div>	
					<div class="error" id="err-state"></div>
					<!-- 3 linea form -->
					<div class="eight columns">
						<label for="name">
							Codigo postal: * 
							<span class="error" id="err-name">please enter name</span>
						</label>
						<input name="name" id="name" type="text" />
					</div>
					<div class="eight columns">
						<label for="email">
							E-Mail: * 
							<span class="error" id="err-email">please enter e-mail</span>
							<span class="error" id="err-emailvld">e-mail is not a valid format</span>
						</label>
						<input name="email" id="email" type="text" />
					</div>
					<div class="clear"></div>	
					<div class="error" id="err-state"></div>
					<!-- 4 linea form -->
					<div class="eight columns">
						<label for="name">
							Teléfono: * 
							<span class="error" id="err-name">please enter name</span>
						</label>
						<input name="name" id="name" type="text" />
					</div>
					<div class="eight columns">
						<label for="email">
							fax: * 
							<span class="error" id="err-email">please enter e-mail</span>
							<span class="error" id="err-emailvld">e-mail is not a valid format</span>
						</label>
						<input name="email" id="email" type="text" />
					</div>
					<div class="clear"></div>	
					<div class="error" id="err-state"></div>
					<div class="con"><p>Información Casilleros</p></div>
					<div class="eight columns">
						<label for="name">
							Teléfono: * 
							<span class="error" id="err-name">please enter name</span>
						</label>
						<select name="cas_agencia_id" class="reciboSMALLCAP" id="Select1" style="width : 100%; padding:2%;padding-top: 10px; padding-bottom: 10px; font: 13px/22px 'Open Sans', sans-serif;  ">
							<option value="8026">ZAI CARGO CP</option>
							<option value="8730">NISSI BOX</option>
							<option value="8998">MILLENNIALS SHOP</option>
							<option value="7754">MASTER SHOP</option>
							<option value="8496">ECUAPOSTAL S.A</option>
						</select>
					</div>
					<div class="eight columns">
						<label for="email">
							digite su clave: * 
							<span class="error" id="err-email">please enter e-mail</span>
							<span class="error" id="err-emailvld">e-mail is not a valid format</span>
						</label>
						<input name="cas_password" id="email" type="password" />
					</div>
					<div class="clear"></div>	
					<div class="error" id="err-state"></div>
					<div class="con"><p>Términos y condiciones</p></div>
					<!-- 6 linea form -->
					<div class="sixteen columns">
						<textarea name="textarea" cols="50" rows="6" readonly="readonly" wrap="virtual"
						style="height:200px;">Todos los que utilicen los casilleros Postales de Zai Cargo y hagan compras a través de empresas como Amazon.com tigerdirect.com  y otras están sujetos a los siguientes términos y condiciones:
						1-Zai cargo NO se hace responsable de ningúnenvío que recibamos:
						A-Con defectos
						B-Rotos o deteriorados
						C-Equivocados 
						D-Sin información correcta 
						2-Zai cargo NO asumiráningún tipo de pago a terceros por mercancías que se reciban en nuestras bodegas.
						3-Zai Cargo NO se hace responsable de ningún tipo de pago fraudulento realizado por la mercancía que recibamos 
						a través del casillero postal.
						4-Todo el que acepte utilizar a Zai cargo como transportadora, acepta pagar todos los costos por Libra /seguro/
						Impuestos exigidos por la empresa o por el país de destino.
						5-Solo transportaremos envíos con CONTENIDOS legales en el país origen como en el país de destino cumpliendo 
						todas las normas aduanales exigidas.

						NO podemos transportar: 
						A-Prendas Militares.
						B-Explosivos o Inflamables.
						C-Contaminantes.
						D-Dinero o Títulos Valores.
						E-Aerosoles
						F-Artículos como, Vidrio, con empaques  insuficientes para su protección.

						El Servicio de casillero internacional consiste en la asignación de un número de cuenta el cual habilita al subscriptor a 
						recibir mercancía de cualquier índole dentro del marco legal. Realizar los procesos de clasificación, inspección, 
						generación de documentación, 
						transporte internacional, trámites aduaneros y entrega. 

						Una vez aceptada la inscripción del servicio se asignara un número de cuenta con el cual pueden rastrear sus envíos vía 
						Web. 

						Nuestra empresa se compromete a realizar los trámites aduaneros correspondientes a la Mercancía y envíos urgentes 
						los cuales incluyen desaduana miento, reconocimiento, liberación y entrega

						Si el SUSCRIPTOR entregara información errada sobre dirección u otros elementos necesarios para la oportuna y 
						correcta entrega, nuestra empresa no se hará responsable de este envío y el SUSCRIPTOR correrá con los gastos extras 
						que ocasione este error. 

						Las tarifas de transporte podrán ser modificadas sin previo aviso para adecuarlas a los aumentos de costos de las 
						aerolíneas y/o cualquier otro factor comercial que tenga que ver con la prestación del servicio. La mercancía se 
						ASEGURA para garantizar la tranquilidad al suscriptor, el seguro no opera para daños o perdidas parciales de la 
						mercancía,todo opera en caso  que el paquete no llegue a su destino. 

						La Mercancía deberá recibirse para su envío Embalada de acuerdo a sus características, con el propósito de 
						resguardar la misma, ya que el seguro no cubre  daños por  embalaje inapropiado. El suscriptor después que 
						recibe la Mercancía  y firma  en conformidad  pierde el derecho de reclamar. Recomendamos abrir la Mercancía 
						y chequear en presencia del personal de la Empresa.  Si la Mercancía requiere un embalaje especial es 
						importante notificar a la Empresa para su elaboración.
						Al  Suscriptor se le concede 03 días para retirar la Mercancía desde el momento de la notificación, en caso 
						contrario la Empresa cobrara Almacenaje y no se responsabilizara por la misma. Al realizar las compras es 
						necesario que el Suscriptor coloque su nombre propio y  la dirección de zai cargo, con la finalidad  que el 
						pedido al llegar a la oficina se agregue  al sistema WEB. La página donde podrá rastrear sus compras es 
						www.zaicargo.com. Nuestra empresa no es responsable por el mal direcciónamiento de la mercancía a nuestras 
						oficinas del suscriptor entiende que debe hacer llegar la mercancía a nuestras oficinas  mediante compañías 
						domésticas.  Las direcciónes de recibo de la mercancía pueden ser modificadas en cualquier momento, avisando 
						a los suscriptores  para las correcciones pertinentes, con suficiente antelación. 

						El suscriptor declara conocer las restricciones legales y administrativas a que pueden estar sujetos sus envíos y será 
						responsable por todo aquello que llegue consignado a su casillero. Nuestra empresa no se hará responsable por 
						pérdidas  resultantes de confiscación aduanera, ni de retrasos ocasionados por la falta de documentación o 
						información necesaria para el despacho o para el trámite aduanero. 

						Es prohibido Transportar : armas, precursores químicos, joyas, dinero en efectivo, material pornográfico, juguetes 
						bélicos, billetes de lotería y todas aquellas que prohíban las autoridades correspondientes  y las contempladas como 
						prohibidas por la Unión Postal Universal.

						Nuestra empresa se reserva el derecho de rehusar o  retener envíos dirigidos a un suscriptor cuya cuenta se encuentre
						en mora.

						Nos reservamos el derecho de admisión y la Empresa tiene autonomía para la cancelación de cuentas en abandono, 
						inactivas o que presenten antecedentes de fraude o mal uso o uso anormal del mismo.

					</textarea>
					<tr valign="baseline">
						<td nowrap="" align="right">&nbsp;</td>
						<td colspan="3">
							<span class="txtTituloJ"><input name="terminos" type="checkbox" id="terminos" value="1" checked="checked" disabled="disabled">ACEPTO LOS TERMINOS Y CONDICIONES</span> 
							<input name="AB" type="hidden" class="boxesNoCase" id="AB" value="AB" size="32"></td>
						</tr>
					</div>
					<div class="three columns">
						<div id="button-con"><button class="send_message" id="send">Submit</button></div>
					</div>
					<div class="clear"></div>	
					<div class="error text-align-center" id="err-form">There was a problem validating the form please check!</div>
					<div class="error text-align-center" id="err-timedout">The connection to the server timed out!</div>
					<div class="error" id="err-state"></div>
				</form>	
				<div class="clear"></div>
				<div id="ajaxsuccess">Successfully sent!!</div>	
				<div class="clear"></div>
				<div class="eight columns" data-scrollreveal="enter left and move 150px over 1s">
					<div class="contact-wrap">
						<p><i class="icon-contact1">&#xf095;</i><span>Télefono</span><label>(381) 267-6386</label> <small><em>Monday–Friday | 9am–5pm (GMT +1)</em></small></p>
					</div>
				</div>
				<div class="eight columns" data-scrollreveal="enter right and move 150px over 1s">	
					<div class="contact-wrap">
						<p>
							<i class="icon-contact1">&#xf041;</i>
							<span>Dirección</span>
							<label>First Street, Sunrise Avenue, New York, USA</label>
						</p>	
					</div>
				</div>	
			</div>
		</div>
	</div>
	<!-- JAVASCRIPT ================================================== -->
	<!-- <script type="text/javascript" src="js/pop.js"></script>
	<script type="text/javascript" src="js/login.js"></script> -->
	<script type="text/javascript" src="js/jquery.js"></script>
	<!-- <script type="text/javascript" src="js/modernizr.custom.js"></script> -->	 
	<!-- <script type="text/javascript" src="js/royal_preloader.min.js"></script> -->
	<!-- <script type="text/javascript">
		(function($)
			{ "use strict"; Royal_Preloader.config(
			{
					mode:           'text', // 'number', "text" or "logo"
					text:           'Zaibox.net',
					timeout:        0,
					showInfo:       true,
					opacity:        1,
					background:     ['#FFFFFF']
				});
		})(jQuery);
	</script> -->
	<script type="text/javascript" src="js/classie.js"></script>
	<script type="text/javascript" src="js/cbpAnimatedHeader.min.js"></script>
	<script type="text/javascript">
		(function($)
		{ 
			"use strict";
			var pos = 0;

			window.setInterval(function()
			{
				pos++;
				document.getElementsByClassName('parallax-home')[0].style.backgroundPosition = pos + "px 0px";
			}, 40);
		})(jQuery);
	</script>
	<script type="text/javascript" src="js/retina-1.1.0.min.js"></script>
	<script type="text/javascript" src="js/jquery.easing.js"></script> 
	<script type="text/javascript" src="js/flippy.js"></script>
	<script type="text/javascript" src="js/jquery.fitvids.js"></script>
	<script type="text/javascript" src="js/tiltSlider.js"></script>
	<script>
		(function($)
		{
			"use strict";
			new TiltSlider( document.getElementById( 'slideshow' ) );
		})(jQuery);
	</script>
	<script type="text/javascript" src="js/jquery.parallax-1.1.3.js"></script>
	<script type="text/javascript" src="js/jquery.localscroll-1.2.7-min.js"></script>
	<script type="text/javascript" src="js/jquery.scrollTo-1.4.2-min.js"></script>
	<script type="text/javascript" src="js/jquery.fancybox.js"></script>
	<script type="text/javascript" src="js/svg_inject_flat_icons_filled.js"></script><!--Inject SVG and Toggle CSS Styles-->
	<script type="text/javascript" src="js/contact.js"></script>
	<script type="text/javascript" src="js/plugins.js"></script>
	<script type="text/javascript" src="js/template.js"></script>  	  
	<!-- End Document ================================================== -->
</body>
</html>
<%
rsAgencias.Close()
Set rsAgencias = Nothing
%>