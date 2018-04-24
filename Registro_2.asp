<%@LANGUAGE="VBSCRIPT" CODEPAGE="1252"%>
<!--#include file="../Connections/CPV.asp" -->
<!--#include file="../app/funciones/_db.asp" -->
<!--#include file="../app/funciones/email.asp" -->
<!--#include file="../app/encrypt/enc.asp" -->


<%
Server.ScriptTimeout =9000

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


dim tj
tj = true
tjn = request.form("tar_numero")
if tjn<>"" then 
	'no esta vacio determinamos si tiene por lo menos 15 caracteres
	if len(tjn)<15 then tj=false
	if not isnumeric(tjn) then tj=false
end if



'if telefono<>"" and nombre<>"" and direccion<>"" and email<>"" and cuenta<>"" and ciudad<>"" and clave<>"" and terminos="1" then
'if telefono<>"" and nombre<>"" and direccion<>"" and email<>""  and ciudad<>"" and clave<>"" and ((hid_des_id_obligatorio="1" and txt_des_id<>"") or (hid_des_id_obligatorio="0" and (txt_des_id="" or txt_des_id<>""))   ) then
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




'Response.Write(RsTemplate("TE_SUBJECT"))
'Response.End()
Dim Sqry
Dim Sqry1
Dim Sqry2
Dim Sqry3
Dim Sqry4
Dim Sqry5

Sqry  = "SELECT CASILLEROS.*, CIUDADES.nombre As cas_ciudad_nombre  FROM CASILLEROS INNER JOIN  CIUDADES on id_ciudad=cas_ciudad_id WHERE CAS_CASILLERO_ID IN(7550,6102)"

Sqry1 = "SELECT CASILLEROS.*, CIUDADES.nombre As cas_ciudad_nombre  FROM CASILLEROS INNER JOIN  CIUDADES on id_ciudad=cas_ciudad_id WHERE CAS_CASILLERO_ID IN  (7016, 7017, 7018, 7019, 7020, 7021, 7022, 7023, 7024, 7025, 7026, 7027, 7028, 7029, 7030, 7031, 7032)"

Sqry2 = "SELECT CASILLEROS.*, CIUDADES.nombre As cas_ciudad_nombre  FROM CASILLEROS INNER JOIN  CIUDADES on id_ciudad=cas_ciudad_id WHERE CAS_CASILLERO_ID IN  (7079, 7080, 7081, 7082, 7083, 7084, 7085, 7086, 7087, 7088, 7089, 7090, 7091, 7092, 7093, 7094, 7095, 7096, 7097, 7098, 7099, 7100, 7101, 7102, 7103, 7104, 7105, 7106, 7107, 7108, 7109, 7110, 7111, 7112, 7113, 7114, 7115, 7116, 7117, 7118, 7119, 7120, 7121, 7122, 7123, 7124, 7125, 7126, 7127, 7128, 7129, 7130, 7131, 7132, 7133, 7134, 7135, 7136, 7137, 7138, 7139, 7140, 7141, 7142, 7143, 7144, 7145, 7146, 7147, 7148, 7149, 7150, 7151, 7152, 7153, 7154, 7155, 7156, 7157, 7158, 7159, 7160, 7161)"

Sqry3 = "SELECT CASILLEROS.*, CIUDADES.nombre As cas_ciudad_nombre  FROM CASILLEROS INNER JOIN  CIUDADES on id_ciudad=cas_ciudad_id WHERE CAS_CASILLERO_ID IN  (7162, 7163, 7164, 7165, 7166, 7167, 7168, 7169, 7170, 7171, 7172, 7173, 7174, 7175, 7176, 7177, 7178, 7179, 7180, 7181, 7182, 7183, 7184, 7185, 7186, 7187, 7188, 7189, 7190, 7191, 7192, 7193, 7194, 7195, 7196, 7197, 7198, 7199, 7200, 7201, 7202, 7203, 7204, 7205, 7206, 7207, 7208, 7209, 7210, 7211, 7212, 7213, 7214, 7215, 7216, 7217, 7218, 7219, 7220, 7221, 7222, 7223, 7224, 7225, 7226, 7227, 7228, 7229, 7230, 7231, 7232, 7233, 7234, 7235, 7236, 7237, 7238, 7239, 7240, 7241, 7242, 7243, 7244, 7245, 7246, 7247, 7248, 7249, 7250, 7251, 7252, 7253, 7254, 7255, 7256, 7257, 7258, 7259, 7260, 7261, 7262, 7263, 7264, 7265, 7266, 7267, 7268, 7269, 7270, 7271, 7272, 7273, 7274, 7275, 7276, 7277, 7278, 7279, 7280, 7281, 7282, 7283, 7284, 7285, 7286, 7287, 7288, 7289, 7290 )"

Sqry4 = "SELECT CASILLEROS.*, CIUDADES.nombre As cas_ciudad_nombre  FROM CASILLEROS INNER JOIN  CIUDADES on id_ciudad=cas_ciudad_id WHERE CAS_CASILLERO_ID IN  (7344, 7345, 7346, 7347, 7348, 7349, 7350, 7351, 7352, 7353, 7354, 7355, 7356, 7357, 7358, 7359, 7360, 7361, 7362, 7363, 7364, 7365, 7366, 7367, 7368, 7369, 7370, 7371, 7372, 7373, 7374, 7375, 7376, 7377, 7378, 7379, 7380, 7381, 7382, 7383, 7384, 7385, 7386, 7387, 7388, 7389, 7390, 7391, 7392, 7393, 7394, 7395, 7396, 7397, 7398, 7399, 7400, 7401, 7402, 7403, 7404, 7405, 7406, 7407, 7408, 7409, 7410, 7411, 7412, 7413, 7414, 7415, 7416, 7417, 7418, 7419)"

Sqry5 = "SELECT CASILLEROS.*, CIUDADES.nombre As cas_ciudad_nombre  FROM CASILLEROS INNER JOIN  CIUDADES on id_ciudad=cas_ciudad_id WHERE CAS_CASILLERO_ID IN  (7420, 7421, 7422, 7423, 7424, 7425, 7426, 7427, 7428, 7429, 7430, 7431, 7432, 7433, 7434, 7435, 7436, 7437, 7438, 7439, 7440, 7441, 7442, 7443, 7444, 7445, 7446, 7447, 7448, 7449, 7450, 7451, 7452, 7453, 7454, 7455, 7456, 7457, 7458, 7459, 7460, 7461, 7462, 7463, 7464, 7465, 7466, 7467, 7468, 7469, 7470, 7471, 7472, 7473, 7474, 7475, 7476, 7477, 7478, 7479, 7480, 7481, 7482, 7483, 7484, 7485, 7486, 7487, 7488, 7489, 7490, 7491, 7492, 7493, 7494, 7495, 7496, 7497, 7498, 7499, 7500, 7501, 7502, 7503, 7504, 7505, 7506, 7507, 7508, 7509, 7510, 7511, 7512, 7513, 7514, 7515, 7516, 7517, 7518, 7519, 7520, 7521, 7522, 7523, 7524, 7525, 7526, 7527, 7528, 7529, 7530, 7531, 7532, 7533, 7534, 7535, 7536, 7537, 7538, 7539, 7540, 7541, 7542, 7543, 7544, 7545, 7546, 7549, 7550 )"

Dim RsCas
set RsCas=conn.execute(Sqry4)


'=======================================================================================================================================

Dim RsTemplate
set RsTemplate=conn.execute("SELECT TE_NAME,TE_SUBJECT,TE_BODY FROM template_emails WHERE TE_NAME='Crear Casilleros y Confirmacion' AND ISNULL(TE_DESABILITADO,0)=0")

Dim Rs_emailBody
Dim Rs_Te_subject

Rs_emailBody=RsTemplate("TE_BODY")
Rs_Te_subject=RsTemplate("TE_SUBJECT")


'=======================================================================================================================================
While  NOT RsCas.EOF


	emailBody=Rs_emailBody
	Te_subject=Rs_Te_subject

	cas_casillero=RsCas("cas_casillero")	
	cas_alias=RsCas("cas_alias")
	cas_password=RsCas("cas_password")
	cas_email=Trim(RsCas("cas_email"))
	cas_direccion=RsCas("cas_direccion")
	cas_telefono=RsCas("cas_telefono")
	cas_empresa=RsCas("cas_empresa")
	cas_ciudad=RsCas("cas_ciudad_nombre")
	cas_nombre=RsCas("cas_nombre")
	
	
	Response.Write("casillero " & RsCas("cas_casillero") & " // " & RsCas("cas_nombre") &"<br />" )
	'Response.Write("alias " &RsCas("cas_alias")&"<br />" )
	'Response.Write("pas " &RsCas("cas_password")&"<br />" )
	'Response.Write("email " &RsCas("cas_email")&"<br />" )
	'Response.Write("dir " &RsCas("cas_direccion")&"<br />" )
	'Response.Write("Tel " &RsCas("cas_telefono")&"<br />" )
	'Response.Write("Emp " &RsCas("cas_empresa")&"<br />" )
	'Response.Write("Ciudad " &RsCas("cas_ciudad_nombre")&"<br />" )
	'Response.Write("nomb " &RsCas("cas_nombre")&"<br />" )
	'Response.Write("Body " & emailBody &"<br />" )
	'Response.Write("asunto " & Te_subject&"<br />" )
	'Response.End()

	emailBody=replace(emailBody,"@nombre_casillero",trim(cas_nombre))
	emailBody=replace(emailBody,"@casillero",trim(cas_casillero))
	emailBody=replace(emailBody,"@Alias",cas_alias)
	emailBody=replace(emailBody,"@clave_casillero",cas_password)
	emailBody=replace(emailBody,"@email_casillero",trim(cas_email))
	emailBody=replace(emailBody,"@direccion_casillero",trim(cas_direccion))
	emailBody=replace(emailBody,"@telefono_casillero",cas_telefono)	
	emailBody=replace(emailBody,"@empresa_casillero",cas_empresa)
	emailBody=replace(emailBody,"@ciudad_casillero",cas_ciudad)
	
	
	Te_subject=replace(Te_subject,"@nombre_casillero",trim(cas_nombre))
	Te_subject=replace(Te_subject,"@casillero",trim(cas_casillero))
	Te_subject=replace(Te_subject,"@Alias",cas_alias)

    emailSubject=Te_subject

	'on error resume next
	
	emailTo=Trim(RsCas("cas_email"))
	call f_email(emailSubject,emailTo,emailFrom,emailBody,"")
	
	'if request.form("ccEmail")<>"" then
	'	emailTo=request.form("ccEmail")
	'	'call f_email(emailSubject,emailTo,emailFrom,emailBody,"")
	'end if

	'if request.form("ccEmail")<>"" and request.form("notificar")="1"then
'		emailTo=rs("cas_email")
'		call f_email(emailSubject,emailTo,emailFrom,emailBody,request.form("ccEmail"))
'	end if
	
	
	'errores="El casillero se creo satisfactoriamente, " 
	'if err<>0 then	errores=errores & err.description
	
RsCas.MoveNext()
Wend	
'Response.End()
'else 'no encontro el casillero que creo
	'errores="Errores creando el casillero"

'end if

'=======================================================================================================================================
'=======================================================================================================================================

'fin llamado stored procedure
'else
'	if Trim(Request.Form("MM_insert"))<>"" then
'		if hid_des_id_obligatorio="1" and txt_des_id="" then
'		errores="Falta Id del destinatario"
'		else
'		errores="Faltan datos para poder crear el casillero!! por favor verifique he intente nuevamente"
'		end if
'	end if
'End If 

%>
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

Set rsAgencias = Server.CreateObject("ADODB.Recordset")
rsAgencias.ActiveConnection = MM_CPV_STRING
rsAgencias.Source = "SELECT *  FROM dbo.AGENCIAS WHERE age_crea_casillero=1 and ffw='" + Replace(rsAgencias__tmpffw, "'", "''") + "'  ORDER BY nombre desc"
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
<div width="800px" border="0" cellspacing="0" cellpadding="0" align="center" style="color:#FF0000; margin:auto;background-color:#E4CD00; width:800px;"><%=(rsAgencia.Fields.Item("nombre").Value)%></div><% end if %>
<table width="800" border="0" cellspacing="0" cellpadding="0" align="center" style="background:url(Imagenes/Body.jpg)">
  
  <tr style="background:url(Imagenes/Gradiente_Cabecera_Z2.png)">
    <td colspan="2" scope="col" height="97" valign="bottom">
      <div align="right" style="vertical-align:bottom">
	  <form action="clientes/login.asp" method="POST" name="frmaIngreso">
        <table width="100" border="0" cellspacing="0" cellpadding="0" align="right">
          <tr>
            <th scope="col"><span class="txtTextoI">Usuario: </span></th>
            <th scope="col"><input name="usuario" type="text" class="txtCajas" size="8" /></th>
          </tr>
          <tr>
            <td align="left"><div align="right"><span class="txtTextoI">Clave:</span></div></td>
            <td align="left"><input name="clave" type="password" class="txtCajas" size="8" /></td>
          </tr>
          <tr>
            <td nowrap="nowrap"><a href="javascript:fp('oc.asp?id=<%=request.QueryString("agencia")%>');">Olvido su clave?</a></td>
            <td align="right"><input name="Ingreso" type="submit" value="Ingresar" class="btnAccion" /></td>
          </tr>
        </table>
		</form>
  </div><a href="http://www.zaicargo.com" target="_blank"><img src="Imagenes/Banner_Superior_Master_Logo.png" alt="Zaicargo" width="119" height="60" border="0" /></a>
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
        		<th scope="col"><a href="http://www.zaicargo.com/casillero_postal">Home</a></th>
      		</tr>
    	</table>
        <br />
        <table border="0" cellspacing="0" cellpadding="0" align="center">
      		<tr>
        		<td><!-- (c) 2005, 2009. Authorize.Net is a registered trademark of CyberSource Corporation --> <div class="AuthorizeNetSeal"> <script type="text/javascript" language="javascript">var ANS_customer_id="25e0789c-90dc-4aa3-b188-360d55b8894e";</script> <script type="text/javascript" language="javascript" src="//verify.authorize.net/anetseal/seal.js" ></script> <a href="http://www.authorize.net/" id="AuthorizeNetText" target="_blank">Online Payments</a> </div>
				
				
		<br />
<br />
		
<!--
SiteSeal Html Builder Code:
Shows the logo at URL https://seal.networksolutions.com/images/basicrecblue.gif
Logo type is  ("NETSB")
//-->
<script language="JavaScript" type="text/javascript"> SiteSeal("https://seal.networksolutions.com/images/basicrecblue.gif", "NETSB", "none");</script>
				
				
				</td>
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
			  		   <form method="post" action="registro.asp?agencia=<%=request.querystring("agencia") %>" name="form1">
            <table width="501" border="0" align="center" cellpadding="3" cellspacing="0" class="titulos2">
              <tr valign="baseline" >
                <td colspan="4" align="right" nowrap><div align="left"><span class="txtTituloJ"><%=errores%></span><br />
                </div></td>
              </tr>

			  <%if errores="El casillero se creo satisfactoriamente, " then %>	
              <tr valign="baseline" >
                <td colspan="4" align="right" nowrap><div align="left" class="reciboSMALLCAP">
                  
                  <p class="style1"><%=response.Write(emailBody)%></p>
                </div></td>
              </tr>
			<%else%>	
              <tr valign="baseline" >
                <td colspan="4" align="right" nowrap><div class="txtTituloJ">

(Toda esta infomaci&oacute;n es privada y est&aacute; protegida).</div></td>
              </tr>
              <tr valign="baseline" >
                <td colspan="4" align="right" nowrap bgcolor="#FEDA00"><div align="left" class="txtTextoNJ"><strong>Datos personales </strong></div></td>
              </tr>
              <tr valign="baseline">
                <td align="right" nowrap class="txtTextoJ"><div align="left" class="letras">Nombres
                    y apellidos:<span class="requeridos">*</span></div></td>
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
				<input type="button" onclick="javascript:fp('../app/Ciudades7.asp');" value="Ciudad">
				<!--<input type="button" onclick="javascript:fp('http://dev.controlbox.net:8888/zai/app/Ciudades8.asp');" value="Ciudad"></td>-->
                <td><div align="left"><span class="txtTextoJ"><span class="requeridos">
				<input type="hidden" name="cas_ciudad_id" id="cas_ciudad_id" value="<%=request("cas_ciudad_id")%>" />
                  <input name="nomciudad" id="nomciudad" type="text" class="txtCajas" value="<%=request("nomciudad")%>" readonly="True" />
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
                <td align="right" nowrap class="txtTextoJ"><div align="left">Telefono:*</div></td>
                <td><div align="left">
                  <input name="cas_telefono" type="text" class="txtCajas" value="<%=request.form("cas_telefono")%>">                
                </div></td>
                <td class="txtTextoJ">Fax:</td>
                <td><div align="left">
                  <input name="cas_fax" type="text" class="txtCajas" value="<%=request.form("cas_fax")%>">
                </div></td>
              </tr>
			   <tr valign="baseline">
			  <td nowrap  class="txtTextoJ"> Numero Identificacion:
			  <span id="Camp_Id" class="requeridos style2" style="display:none" >*</span>
			  </div>
			 </td>
                  <td>
                  <input name="txt_des_id" id="txt_des_id" type="text" class="textbox" value="<%=request.form("txt_des_id")%>" size="32">
				   <input name="hid_des_id_obligatorio" id="hid_des_id_obligatorio" type="HIDDEN" class="textbox" value="<%if request.form("hid_des_id_obligatorio")="" then %><%=0%><%else%><%=request.form("hid_des_id_obligatorio")%><%end if%>" size="32">
                
				   </td>
				</tr>
              <tr valign="baseline">
                <td colspan="4" align="right" nowrap>					
				    <div align="left">
					  <input type="hidden" name="cas_cuenta_id" value="">
                      
                      <input name="cas_pago" type="hidden" id="cas_pago" value="agencia">
				      <input type="hidden" value="VE" name="cas_servicio" id="cas_servicio"/>
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
                <td align="right" nowrap class="txtTextoJ"><div align="left" class="letras">Escriba su clave:<span class="requeridos">*</span></div></td>
                <td colspan="3" class="txtTextoJ"><input name="cas_password" type="password" class="txtCajas">
                  <input name="cas_alias" type="hidden" class="boxesNoCase" value=" " size="32">                <input name="ccEmail" type="hidden" class="txtCajas" id="ccEmail" /></td>
              </tr>
               <tr valign="baseline">
               <%if request.QueryString("agencia")<>"" then %>
                <input name="cas_agencia_id" type="hidden" class="boxesNoCase" size="32" value="<%response.Write(request.QueryString("agencia")) %>">
               <% else %>
                <td align="right" nowrap class="txtTextoJ"><div align="left" class="letras">Seleccione una agencia:</div></td>
                <td colspan="3" class="txtTextoJ">
                <select name="cas_agencia_id" class="reciboSMALLCAP" id="Select1" style="width : 100px">
                  <%
While (NOT rsAgencias.EOF)
%>
                  <option value="<%=(rsAgencias.Fields.Item("agencia_id").Value)%>"><%=(rsAgencias.Fields.Item("nombre").Value)%></option>
                  <%
  rsAgencias.MoveNext()
Wend
If (rsAgencias.CursorType > 0) Then
  rsAgencias.MoveFirst
Else
  rsAgencias.Requery
End If
%>
                </select>
              </tr>
              <%end if %>
			  <tr valign="baseline">
                <td align="right" nowrap class="txtTextoJ">
				</td>
				</tr>
             <!-- <tr valign="baseline">
                <td align="right" nowrap class="txtTextoJ">Referido por: </td>
                <td colspan="3" class="txtTextoJ"><select name="cas_Agencia_id" id="cas_Agencia_id">
                  <option value="1" selected="selected">Regional Centro</option>
                  <option value="2">Regional Eje Cafetero</option>
                  <option value="3">Regional Antioquia</option>
                  <option value="4">Regional Santanderes</option>
                  <option value="5">Regional Caribe</option>
                  <option value="6">Regional Occidente</option>
                  <option value="7">Regional USA</option>
                  <option value="8">Amigo</option>
                  <option value="9">Motor de busqueda</option>
                </select></td>
              </tr>-->
              
			 <!--<td colspan="4" align="right" nowrap bgcolor="#FEDA00"><div align="left"><strong>Informacion
			   de tarjeta de credito (no obligatoria) </strong></div></td>
                </tr>
              <tr valign="baseline">
                <td align="right" nowrap class="txtTextoJ">Tipo:</td>
                <td colspan="3" class="txtTextoJ"><select name="tar_tipo" id="tar_tipo">
                  <option value="Visa">Visa</option>
                  <option value="MasterCard">MasterCard</option>
                  <option value="AMEX">AMEX</option>
                                                                </select></td>
              </tr>
              <tr valign="baseline">
                <td align="right" nowrap class="txtTextoJ">Nombre: </td>
                <td colspan="3" class="txtTextoJ"><input name="tar_nombre" type="text" class="txtCajas" id="tar_nombre" value="<%=request.form("tar_nombre")%>" /></td>
              </tr>
              <tr valign="baseline">
                <td align="right" nowrap class="txtTextoJ">Numero: </td>
                <td colspan="3" class="txtTextoJ"><input name="tar_numero" type="text" class="txtCajas" id="tar_numero" value="<%=request.form("tar_numero")%>" /></td>
              </tr>
              <tr valign="baseline">
                <td align="right" nowrap class="txtTextoJ">Vencimiento</td>
                <td colspan="3" class="txtTextoJ">mes:
                  <select name="tar_exp_mes" id="tar_exp_mes">
                    <option value="1">1</option>
                    <option value="2">2</option>
                    <option value="3">3</option>
                    <option value="4">4</option>
                    <option value="5">5</option>
                    <option value="6">6</option>
                    <option value="7">7</option>
                    <option value="8">8</option>
                    <option value="9">9</option>
                    <option value="10">10</option>
                    <option value="11">11</option>
                    <option value="12">12</option>
                  </select>
A&ntilde;o:
<select name="tar_exp_ano" id="tar_exp_ano">
                    <option value="2009">2009</option>
                    <option value="2010">2010</option>
                    <option value="2011">2011</option>
                    <option value="2012">2012</option>
                    <option value="2013">2013</option>
                    <option value="2014">2014</option>
                    <option value="2015">2015</option>
                    <option value="2016">2016</option>
                    <option value="2017">2017</option>
                    <option value="2018">2018</option>
                    <option value="2019">2019</option>
                    <option value="2020">2020</option>
                                    </select></td>
              </tr>
              <tr valign="baseline">
                <td align="right" nowrap class="txtTextoJ">Codigo de verificacion: </td>
                <td colspan="3" class="txtTextoJ"><input name="tar_verificacion" type="text" class="txtCajas" id="tar_verificacion" value="<=request.form("tar_verificacion")%>" size="5" /></td>-->
              <tr valign="baseline" >
                <td colspan="4" align="right" nowrap bgcolor="#FEDA00" class="boxesNoCase"><div align="left" class="txtTextoNJ"><strong>Terminos y condiciones </strong></div></td>
              </tr>
              <tr valign="baseline">
                <td colspan="4" align="right" nowrap><div align="center">
                  <textarea name="textarea" cols="50" rows="6" readonly="readonly" wrap="virtual">Todos los que utilicen los casilleros Postales de Zai Cargo y hagan compras a traves de empresas como Amazon.com ? tigerdirect.com  y otras estan sujetos a los siguientes terminos y condiciones : 
1-Zai cargo NO se hace responsable de ningun envio que recibamos :
A-Con defectos
B-Rotos o deteriorados
C-Equivocados 
D-Sin informacion correcta 
2-Zai cargo NO asumira ningun tipo de pago a terceros por mercancias que se reciban en nuestras bodegas.
3-Zai Cargo NO se hace responsable de ningun tipo de pago fraudulento realizado por la mercancia que recibamos a traves del casillero postal .
4-Todo el que acepte utilizar a Zai cargo como transportadora, acepta pagar todos los costos por Libra /seguro/Impuestos exigidos por la empresa o por el pais de destino.
5-Solo transportaremos envios con CONTENIDOS legales en el pais origen como en el pais de destino cumpliendo todas las normas aduanales exigidas .

NO podemos transportar : 
A-Prendas Militares.
B-Explosivos o Inflamables.
C-Contaminantes.
D-Dinero o Titulos Valores.
E-Aerosoles
F-Articulos   como ?Vidrio? con empaques  insuficientes para su proteccion.

El Servicio de casillero internacional consiste en la asignación de un número de cuenta el cual habilita al subscriptor a recibir mercancía de cualquier índole dentro del marco legal. Realizar los procesos de clasificación, inspección, generación de documentación, transporte internacional, trámites aduaneros y entrega. 

Una vez aceptada la inscripción del servicio se asignara un número de cuenta con el cual pueden rastrear sus envíos vía Web. 

Nuestra empresa se compromete a realizar los trámites aduaneros correspondientes a la Mercancía y envíos urgentes los cuales incluyen desaduanamiento, reconocimiento, liberación y entrega

Si el SUSCRIPTOR entregara información errada sobre dirección u otros elementos necesarios para la oportuna y correcta entrega, nuestra empresa no se hará responsable de este envío y el SUSCRIPTOR correrá con los gastos extras que ocasione este error. 

Las tarifas de transporte podrán ser modificadas sin previo aviso para adecuarlas a los aumentos de costos de las aerolíneas y/o cualquier otro factor comercial que tenga que ver con la prestación del servicio. La mercancía se ASEGURA para garantizar la tranquilidad al suscriptor, el seguro no opera para daños o perdidas parciales de la mercancia ,todo opera en caso que el paquete no llegue a su destino. 

La Mercancía deberá recibirse para su envío Embalada de acuerdo a sus características, con el propósito de resguardar la misma, ya que el seguro no cubre  daños por  embalaje inapropiado. El suscriptor después que recibe la Mercancía  y firma  en conformidad  pierde el derecho de reclamar. Recomendamos abrir la Mercancía y chequear en presencia del personal de la Empresa.  Si la Mercancía requiere un embalaje especial es importante notificar a la Empresa para su elaboración.
Al  Suscriptor se le concede 03 días para retirar la Mercancía desde el momento de la notificación, en caso contrario la Empresa cobrara Almacenaje y no se responsabilizara por la misma.
Al realizar las compras es necesario que el Suscriptor coloque su nombre propio y  la direccion de zai cargo  , con la finalidad  que el pedido al llegar a la oficina se agregue  al sistema WEB. La página donde podrá rastrear sus compras es www.zaicargo.com.
Nuestra empresa no es responsable por el mal direccionamiento de la mercancía a nuestras oficinas de , el suscriptor entiende que debe hacer llegar la mercancía a nuestras oficinas  mediante compañías domesticas. 
Las direcciones de recibo de la mercancía pueden ser modificadas en cualquier momento, avisando a los suscriptores  para las correcciones pertinentes, con suficiente antelación. 
El suscriptor declara conocer las restricciones legales y administrativas a que pueden estar sujetos sus envíos y será responsable por todo aquello que llegue consignado a su casillero. Nuestra empresa no se hará responsable por pérdidas resultantes de confiscación aduanera, ni de retrasos ocasionados por la falta de documentación o información necesaria para el despacho o para el trámite aduanero.
Es prohibido Transportar : armas, precursores químicos, joyas, dinero en efectivo, material pornográfico, juguetes bélicos, billetes de lotería y todas aquellas que prohíban las autoridades correspondientes  y las contempladas como prohibidas por la Unión Postal Universal.
Nuestra empresa se reserva el derecho de rehusar o  retener envíos dirigidos a un suscriptor cuya cuenta se encuentre en mora.
Nos reservamos el derecho de admisión y la Empresa tiene autonomía para la cancelación de cuentas en abandono, inactivas o que presenten antecedentes de fraude o mal uso o uso anormal del mismo.


                  </textarea>
                </div></td>
              </tr>
              <tr valign="baseline">
                <td nowrap align="right">&nbsp;</td>
                <td colspan="3"><input name="terminos" type="checkbox" id="terminos" value="1" checked="checked" disabled="disabled" >
                  <span class="txtTituloJ">ACEPTO LOS TERMINOS Y CONDICIONES</span> 
				  <%if Trim(Request.Form("terminos"))<>"" and Trim(Request.Form("AB"))="AB" then%>
                  <span class="letraserrores"><br>
                  </span><span class="txtTextoJ">Debe aceptar los terminos y condiciones</span>				  
                  <% End If %>
				  <input name="AB" type="hidden" class="boxesNoCase" id="AB" value="AB" size="32"></td>
              </tr>
              <tr valign="baseline">
                <td nowrap align="right"><input type="hidden" name="cas_ffw" value="00001" size="32">
            <input type="hidden" name="MM_insert" value="form1"></td>
                <td align="right"><input type="submit" class="botones" value="Aceptar"></td>
                <td>&nbsp;</td>
                <td>&nbsp;</td>
              </tr>
			  
			  <%end if%>
              <tr valign="baseline">
                <td colspan="4" align="right" nowrap>
				  <div align="left" class="reciboSMALLCAP">
                  <p>&nbsp;</p>
                  </div></td>
              </tr>
            </table>
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
<%
rsAgencias.Close()
Set rsAgencias = Nothing
%>