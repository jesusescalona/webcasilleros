<%@LANGUAGE="VBSCRIPT"%>
<!--#include file="../Connections/CPV.asp" -->
<!--#include file="../app/funciones/_db.asp" -->
<!--#include file="../app/funciones/email.asp" -->

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

if nombre<>"" and direccion<>"" and email<>"" and cuenta<>"" and ciudad<>"" and clave<>"" and terminos="1" then
'aqui va el llamado al stored procedure
dim conn
call open_conn()

txtSql= "crearCasillero " & _
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
"'" & request.Form("cas_casillero") & "'," & _
"'" & request.Form("cas_ffw") & "'," & _
"'" & request.Form("cas_password") & "'," & _
"'" & request.Form("cas_alias") & "'," & _
"'" & request.Form("cas_agencia_id") & "'," & _
"'" & request.Form("cas_servicio") & "'," & _
"'" & request.Form("cas_pago") & "'"
	
set rs=conn.execute(txtSql)
if not rs.eof then
	link =  "www.zaicargo.com/casillero_postal"
	emailBody =  rs("cas_nombre") & _
	",<br>Gracias por crear su casillero con nosotros.<br>" & _
	"Recuerde que puede hacer seguimiento a sus paquetes en "  & _
	"&nbsp;<a href=""http://www.zaicargo.com/casillero_postal/ "" target=""_blank"" >" & link & " </a> <br>" & _
	"Si desea mas informacion, puede contactarnos a zaibox@zaicargo.com<br>" & _
	"Su cuenta se ha creado con la siguiente informacion:<br><br>" & _
	rs("cas_nombre") & "<br>" & _
	rs("cas_empresa") & "<br>" & _
	rs("cas_direccion") & "<br>" & _
	rs("cas_ciudad") & " " & "<br>" & _
	rs("cas_telefono") & "<br>" & _
	rs("cas_email") & "<br><br>NUMERO DE CUENTA<br>" & _
	rs("cas_alias") & "<br>CLAVE: " & rs("cas_password") & "<br><br>" & _
	"Por favor verifique esta informacion." & "<br><br>" & _
	"Para que sus envios lleguen sin problemas debe escribir asi su informacion " & _
	"<br><br>" & _
	rs("cas_nombre") & "<br>" & _
	"6324 NW 97 Av." & "<br>" & _
	rs("cas_alias") & "<br>" & _
	"Doral, FL 33178 " & "<br><br><br>"

	emailBody = emailBody & "Gracias<br><br><br>ZAICARGO"

	emailFrom="zaibox@zaicargo.com"
	emailSubject="CASILLERO POSTAL ZAICARGO"

	on error resume next
	
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
	if Trim(Request.Form("MM_insert"))="form1" then
		errores="Faltan datos para poder crear el casillero!! por favor verifique he intente nuevamente"
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
rsAgencias__tmpffw = "00000"

If (request.cookies("ffw") <> "") Then 
  rsAgencias__tmpffw = request.cookies("ffw")
End If
%>
<%
Dim rsAgencias
Dim rsAgencias_numRows

Set rsAgencias = Server.CreateObject("ADODB.Recordset")
rsAgencias.ActiveConnection = MM_CPV_STRING
rsAgencias.Source = "SELECT *  FROM dbo.AGENCIAS  WHERE ffw='" + Replace(rsAgencias__tmpffw, "'", "''") + "'  ORDER BY nombre"
rsAgencias.CursorType = 0
rsAgencias.CursorLocation = 2
rsAgencias.LockType = 1
rsAgencias.Open()

rsAgencias_numRows = 0
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
<title>Zaicargo - Casillero Postal</title>
<link href="Imagenes/estilos.css" rel="stylesheet" type="text/css" />
<style type="text/css">
<!--
.style1 {
	font-size: 10px;
	font-family: Arial, Helvetica, sans-serif;
	color: #FFFFFF;
}
-->
</style>
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
<table width="800" border="0" cellspacing="0" cellpadding="0" align="center" style="background:url(Imagenes/Body.jpg)">
  <tr style="background:url(Imagenes/Gradiente_Cabecera_Z.png)">
    <td colspan="2" scope="col" height="97" valign="bottom">
      <div align="right" style="vertical-align:bottom">
	  <form action="http://zaicargo.controlbox.net/webcasilleros/clientes/login.asp" method="POST" name="frmaIngreso">
        <table width="100" border="0" cellspacing="0" cellpadding="0" align="right">
          <tr>
            <th scope="col"><span class="txtTextoI">Usuario: </span></th>
            <th scope="col"><input name="usuario" type="text" class="txtCajas" size="8" /></th>
          </tr>
          <tr>
            <td align="left"><span class="txtTextoI">Clave:</span></td>
            <td align="left"><input name="clave" type="password" class="txtCajas" size="8" /></td>
          </tr>
          <tr>
            <td colspan="2" align="right"><input name="Ingreso" type="submit" value="Ingresar" class="btnAccion" /></td>
          </tr>
        </table>
		</form>
  </div><a href="http://www.zaicargo.com" target="_blank"><img src="Imagenes/Logo.png" alt="Zaicargo" width="205" height="60" border="0" /></a>
  </tr>
   <tr>
    <th colspan="2" scope="col"><img src="Imagenes/Division.png" alt="Head" width="800" height="1"  /></th>
  </tr>
  <tr>
    <th colspan="2" scope="col"><img src="Imagenes/Banner_Registro.jpg" alt="Casillero" width="800" height="250" /></th>
  </tr>
  <tr bgcolor="#3086BC">
    <td valign="top">
		<table width="200" border="0" cellspacing="0" cellpadding="0">
      		<tr>
        		<th scope="col"><a href="http://www.zaicargo.com/casillero_postal">Inicio</a></th>
      		</tr>
    	</table>
	</td>
	<td bgcolor="#3086BC" style="vertical-align:top">
		<table width="600" border="0" cellspacing="0" cellpadding="0" style="background:url(Imagenes/Body.jpg)" height="216">
			<tr valign="top">
        		<th scope="col"><img src="Imagenes/CabeceraRegistro.png" alt="Head" width="600" height="20" /></th>
      		</tr>
      		<tr>
       		  <th scope="col">
			  		   <form method="post" action="registrocas.asp" name="form1">
            <table width="501" border="0" align="center" cellpadding="3" cellspacing="0" class="titulos2">
              <tr valign="baseline" >
                <td colspan="4" align="right" nowrap><div align="left" class="reciboSMALLCAP">
                  <p class="style1"><span class="requeridos"><%=errores%><br />
                  </span><%=response.Write(emailBody)%></p>
                </div></td>
              </tr>
              <tr valign="baseline" >
                <td colspan="4" align="right" nowrap bgcolor="#FEDA00"><div align="left" class="txtTextoNJ"><strong>Datos personales </strong></div></td>
              </tr>
              <tr valign="baseline">
                <td align="right" nowrap class="txtTextoJ"><div align="left" class="letras">Nombre
                    y apellido:<span class="requeridos">*</span></div></td>
                <td><div align="left">
                  <input name="cas_nombre" type="text" class="txtCajas" value="<%=request.form("cas_nombre")%>">                
                </div></td>
                <td class="txtTextoJ">Empresa:</td>
                <td><div align="left">
                  <input name="cas_empresa" type="text" class="txtCajas" value="<%=request.form("cas_empresa")%>" />
                </div></td>
              </tr>
              <tr valign="baseline">
                <td align="right" nowrap class="txtTextoJ"><div align="left">Direccion:<span class="requeridos">*</span></div></td>
                <td><div align="left">
                  <input name="cas_direccion" type="text" class="txtCajas" value="<%=request.form("cas_direccion")%>">
                </div></td>
                <td class="txtTextoJ">
				<input type="button" onclick="javascript:fp('../app/ciudades7.asp');" value="Ciudad"></td>
                <td><div align="left"><span class="txtTextoJ"><span class="requeridos">
				<input type="hidden" name="cas_ciudad_id" value="<%=request("cas_ciudad_id")%>" />
                  <input name="nomciudad" type="text" class="txtCajas" value="<%=request("nomciudad")%>" readonly="True" />
                </span></span></div></td>
              </tr>
              <tr valign="baseline">
                <td align="right" nowrap class="txtTextoJ"><div align="left">Codigo
                    postal :</div></td>
                <td><div align="left">
                  <input name="cas_zip" type="text" class="txtCajas" value="<%=request.form("cas_zip")%>">
                </div></td>
                <td class="txtTextoJ">Email:<span class="requeridos">*</span></td>
                <td><div align="left">
                  <input name="cas_email" type="text" class="txtCajas" value="<%=request.form("cas_email")%>">
                </div></td>
              </tr>
              <tr valign="baseline">
                <td align="right" nowrap class="txtTextoJ"><div align="left">Telefono:</div></td>
                <td><div align="left">
                  <input name="cas_telefono" type="text" class="txtCajas" value="<%=request.form("cas_telefono")%>">                
                </div></td>
                <td class="txtTextoJ">Fax:</td>
                <td><div align="left">
                  <input name="cas_fax" type="text" class="txtCajas" value="<%=request.form("cas_fax")%>">
                </div></td>
              </tr>
              <tr valign="baseline">
                <td align="right" nowrap class="txtTextoJ"><div align="left">Servicio:</div></td>
                <td valign="baseline"><div align="left">
                  <select name="cas_servicio" id="cas_servicio">
                    <option value="VE" selected>Paquetes y Documentos</option>
                  </select>
                </div></td>
                <td valign="baseline">&nbsp;</td>
                <td valign="baseline"><div align="left"></div></td>
              </tr>
              <tr valign="baseline">
                <td colspan="4" align="right" nowrap>					
				    <div align="left">
					  <input type="hidden" name="cas_cuenta_id" value="">
                      <input type="hidden" name="cas_agencia_id" value="00001">
                      <input name="cas_pago" type="hidden" id="cas_pago" value="agencia">
				    </div></td>
              </tr>
              <tr valign="baseline">
                <td colspan="4" align="right" nowrap class="requeridos">
				  <div align="left"></div></td>
              </tr>
              <tr valign="baseline" >
                <td colspan="4" align="right" nowrap bgcolor="#FEDA00"><div align="left" class="txtTextoNJ"><strong>Informacion del casillero </strong></div></td>
              </tr>
              <tr valign="baseline">
                <td align="right" nowrap class="txtTextoJ"><div align="left" class="letras">clave:<span class="requeridos">*</span></div></td>
                <td colspan="3" class="txtTextoJ"><input name="cas_password" type="text" class="txtCajas">
                  <input name="cas_alias" type="hidden" class="boxesNoCase" value="" size="32">                    
                  (Personalice su propia clave)</td>
              </tr>
              <tr valign="baseline">
                <td colspan="4" align="right" class="txtTextoJ"><div align="left" class="letras">
                  <p class="txtTituloJ">si desea podemos enviar una copia adicional de la creacion de su cuenta a el email que especifique.					 </p>
                  </div>                </td>
              </tr>
              <tr valign="baseline">
                <td align="right" nowrap class="boxesNoCase"><div align="left" class="txtTextoJ">Enviar copia  a: </div></td>
                <td colspan="3" align="right" class="boxesNoCase"><div align="left">
                  <input name="ccEmail" type="text" class="txtCajas" id="ccEmail">
                  <span class="txtTextoJ">                (email) </span></div></td>
              </tr>
              <tr valign="baseline" >
                <td colspan="4" align="right" nowrap bgcolor="#FEDA00" class="boxesNoCase"><div align="left" class="txtTextoNJ"><strong>Terminos y condiciones </strong></div></td>
              </tr>
              <tr valign="baseline">
                <td colspan="4" align="right" nowrap><div align="center">
                  <textarea name="textarea" cols="50" rows="6" readonly="readonly" wrap="virtual">El Servicio de casillero internacional consiste en la asignación de un número de cuenta el cual habilita al subscriptor a  recibir mercancía de cualquier índole dentro del marco legal.  Realizar los procesos de clasificación, inspección, generación de documentación, transporte internacional, trámites aduaneros y entrega. 

Una vez aceptada la inscripción del servicio se asignara un número de cuenta con el cual pueden rastrear sus envíos vía Web. 

Nuestra empresa se compromete a realizar los trámites aduaneros correspondientes a la Mercancía  y envíos urgentes los cuales incluyen desaduanamiento, reconocimiento, liberación y entrega
 
Si el SUSCRIPTOR entregara información errada sobre dirección u otros elementos necesarios para la oportuna y correcta entrega, nuestra empresa no se hará responsable de este envío y el SUSCRIPTOR correrá con los gastos extras que ocasione este error.   

Las tarifas de transporte podrán ser modificadas sin previo aviso, para adecuarlas a los aumentos de costos de las aerolíneas y/o cualquier otro factor comercial que tenga que ver con la prestación del servicio. La mercancía se ASEGURA para garantizar  la tranquilidad al suscriptor, al menos que decida no asegurar ninguna Mercancía y la misma viajara por cuenta y riesgo del SUSCRIPTOR. 

La Mercancía deberá recibirse para su envío Embalada de acuerdo a sus características, con el propósito de resguardar la misma, ya que el seguro no cubre  danos por  embalaje inapropiado. El suscriptor después que recibe la Mercancía  y firma  en conformidad  pierde el derecho de reclamar cualquier faltante o desperfecto, es por ello que recomendamos abrir la Mercancía y chequear en presencia del personal de la Empresa.  
Si la Mercancía requiere un embalaje especial es importante notificar a la Empresa para su elaboración.

Al  Suscriptor se le concede 03 días para retirar la Mercancía desde el momento de la notificación, en caso contrario la Empresa cobrara Almacenaje y no se responsabilizara por la misma

Al realizar las compras es necesario que el Suscriptor coloque su nombre y  el número de suite asignada, con la finalidad  que el pedido al llegar a la oficina se agregue  al sistema WEB. La página donde podrá rastrear sus compras es
www.zaicargo.com/clientes 
Clave: 123456 (puede ser cambiada en la pagina)

Nuestra empresa no es responsable por el mal direccionamiento de la mercancía a nuestras oficinas de Miami, el suscriptor entiende que debe hacer llegar la mercancía a nuestras oficinas en Miami mediante compañías tales como UPS, FEDEX, DHL o cualquier transporte autorizado. 

Las direcciones de recibo de la mercancía pueden ser modificadas en cualquier momento, avisando a los suscriptores  para las correcciones pertinentes, con suficiente antelación.
 
El suscriptor declara conocer las restricciones legales y administrativas a que pueden estar sujetos sus envíos y será responsable por todo aquello que llegue consignado a su casillero. Nuestra empresa no se hará responsable por pérdidas resultantes de confiscación aduanera, ni de retrasos ocasionados por la falta de documentación o información necesaria para el despacho o para el trámite aduanero.

Mercancías prohibidas: armas, precursores químicos, joyas, dinero en efectivo, material pornográfico, juguetes bélicos, billetes de lotería y todas aquellas que prohíban las autoridades correspondientes  y las contempladas como prohibidas por la Unión Postal Universal.

Nuestra empresa se reserva el derecho de rehusar o  retener envíos dirigidos a un suscriptor cuya cuenta se encuentre en mora.

Nos reservamos el derecho de admisión y la Empresa tiene autonomía para la cancelación de cuentas en abandono, inactivas o que presenten antecedentes de fraude o mal uso o uso anormal del mismo.

                  </textarea>
                </div></td>
              </tr>
              <tr valign="baseline">
                <td nowrap align="right">&nbsp;</td>
                <td colspan="3"><input name="terminos" type="checkbox" id="terminos" value="1">
                  <span class="txtTituloJ">ACEPTO LOS TERMINOS Y CONDICIONES</span> 
				  <%if Trim(Request.Form("terminos"))<>"" and Trim(Request.Form("AB"))="AB" then%>
                  <span class="letraserrores"><br>
                  </span><span class="txtTextoJ">Debe aceptar los terminos y condiciones</span>				  
                  <% End If %>
				  <input name="AB" type="hidden" class="boxesNoCase" id="AB" value="AB" size="32"></td>
              </tr>
              <tr valign="baseline">
                <td nowrap align="right">&nbsp;</td>
                <td align="right"><input type="submit" class="botones" value="Aceptar"></td>
                <td>&nbsp;</td>
                <td>&nbsp;</td>
              </tr>
              <tr valign="baseline">
                <td colspan="4" align="right" nowrap>
				  <div align="left" class="reciboSMALLCAP">
                  <p>&nbsp;</p>
                  </div></td>
              </tr>
            </table>
              <input type="hidden" name="cas_ffw" value="00001" size="32">
            <input type="hidden" name="MM_insert" value="form1">
          </form>
				
				</th>
      		</tr>
    	</table>
	</td>
  </tr>
  <tr>
    <th colspan="2" scope="col"><img src="Imagenes/Division.png" alt="Head" width="800" height="1"  /></th>
  </tr>
  <tr>
    <td colspan="2"><img src="Imagenes/Footer.png" alt="Footer" width="800" height="30" /></td>
  </tr>
</table>
</body>
</html>
