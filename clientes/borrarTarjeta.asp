<%@LANGUAGE="VBSCRIPT" CODEPAGE="1252"%>
<!--#include file="../app/funciones/email.asp" -->
<!--#include file="../app/funciones/_db.asp" -->
<%
dim conn
call open_conn()

'response.Write("delete tarjetas where tar_tarjeta_id=" & request.querystring("id") & " ")

conn.execute("delete tarjetas where tar_tarjeta_id=" & request.querystring("id") & " " )
conn.execute("insert into log_cambios (usuario,ffw,detalle,fecha,tipo) values(100,'00009','borro tarjeta de credito',getdate(),'delete')" )

response.Redirect("informacioncasillero.asp")

conn.close()

%>