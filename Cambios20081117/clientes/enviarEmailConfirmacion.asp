<%@LANGUAGE="VBSCRIPT" CODEPAGE="1252"%>
<!--#include file="../app/funciones/email.asp" -->
<!--#include file="../app/funciones/_db.asp" -->
<%
dim conn
call open_conn()

set rs=conn.execute("select * from casilleros where (cas_alias like '%" & request.form("casillero") & "' or cas_casillero='" & request.form("casillero") & "') and cas_email='" & request.form("email") & "'" )
if not rs.eof then
	'envia el email
	emailBody =  rs("cas_nombre") & _
	",<br>Gracias por preferir los servicios de carga <br>" & _
	"los datos de su cuenta son los siguientes<br><br>" & _
	rs("cas_nombre") & "<br>" & _
	rs("cas_email") & "<br><br>NUMERO DE CASILLERO<br>" & _
	rs("cas_alias") & "<br>PIN: " & rs("cas_password") & "<br><br>" & _
	"para ingresar entre a <a href=""http://transexpress.controlbox.net/pobox"">www.transexpress.com</a> <br>" & _
	"Por favor verifique esta informacion y de ser necesario modifique lo ingresado" & "<br><br>"
	emailBody = emailBody & "Gracias<br><br><br>TRANS-EXPRESS"

	emailFrom="info@transexpress.com"
	emailSubject="TransExpress Global Boxes"
	emailTo=rs("cas_email")

	call f_email(emailSubject,emailTo,emailFrom,emailBody,"")

	response.Redirect("index.asp?email=ok")

else

	response.Redirect("index.asp?email=no")
	
end if

conn.close()

%>