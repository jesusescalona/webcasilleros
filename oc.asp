<%@LANGUAGE="VBSCRIPT"%>
<!--#include file="../app/funciones/_db.asp" -->
<!--#include file="../app/funciones/email.asp" -->

<%
if request("email")<>"" then
	dim conn
	call open_conn()
	
	set rs=conn.execute("select top 1 * from casilleros where cas_email='" & replace(request("email"),"'","") & "'")
	if not rs.eof then
		Dim RsTemplate
		set RsTemplate=conn.execute("SELECT TE_NAME,TE_SUBJECT,TE_BODY FROM template_emails WHERE TE_NAME='Recordar Clave' AND ISNULL(TE_DESABILITADO,0)=0")
		IF NOT RsTemplate.EOF THEN
		emailBody=RsTemplate("TE_BODY")
		
		emailBody=replace(emailBody,"@nombre_casillero",trim(rs("cas_nombre")))
		emailBody=replace(emailBody,"@casillero",trim(rs("cas_casillero")))
		emailBody=replace(emailBody,"@clave_casillero",rs("cas_password"))
		
		
		Te_subject= RsTemplate("TE_SUBJECT")
		Te_subject=replace(Te_subject,"@casillero",rs("cas_casillero"))
		emailSubject=Te_subject
		
		emailFrom="zaibox@zaicargo.com"
		emailTo=rs("cas_email")
		else
		emailBody = emailBody & "Clave de acceso: " & rs("cas_password") & " y su Usuario de acceso es: " & rs("cas_alias") 
		emailFrom="zaibox@zaicargo.com"
		emailSubject="CASILLERO POSTAL ZAICARGO - CLAVE"
		'on error resume next
		emailTo=rs("cas_email")
		
		end if
		call f_email(emailSubject,emailTo,emailFrom,emailBody,"")
		msg="Se envio la clave con exito"
		
	else
		msg="Error enviando la clave"
	end if
end if
%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
<title>ZAI Cargo </title>
</head>

<body>
Ingrese su email<br />
<form id="form1" name="form1" method="post" action="oc.asp">
  <p>
    <input name="email" type="text" id="email" />
    <br />
    <br />
    <input type="submit" name="Submit" value="Enviar clave de acceso" />
    <br />
  </p>
  
<%=msg%>

</form> 
</body>
</html>
