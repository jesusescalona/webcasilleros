<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"> 
<% 
'Option Explicit 

Dim iMsg
Dim iConf
Dim Flds
Dim strHTML
Dim strSmartHost
Dim cuenta
Dim nombre
Dim apellido
Dim direccion
Dim pais
Dim email
Dim telefono
Dim datos
Dim cuerpo

'Form
'cuenta = request.form("cuenta")
nombre = request.form("nombre")
apellido = request.form("apellido") 
'direccion = request.form("direccion")
'pais = request.form("pais") 
email = request.form("email")
'telefono = request.form("telefono")
datos = request.form("datos")

'cuerpo = cuerpo & "Cuenta: " & cuenta & VBNEWLINE & "<br>"
cuerpo = cuerpo & "Nombre: " & nombre & VBNEWLINE & "<br>"
cuerpo = cuerpo & "Apellido: " & apellido & VBNEWLINE & "<br>"
'cuerpo = cuerpo & "Dirección: " & direccion & VBNEWLINE & "<br>"
'cuerpo = cuerpo & "País: " & pais & VBNEWLINE & "<br>"
cuerpo = cuerpo & "E-mail: " & email & VBNEWLINE & "<br>"
'cuerpo = cuerpo & "Teléfono: " & telefono & VBNEWLINE & VBNEWLINE & "<br>" & "<br>"
cuerpo = cuerpo & "Datos: " & datos

Const cdoSendUsingPort = 2

Set iMsg = CreateObject("CDO.Message")
set iConf = CreateObject("CDO.Configuration")
Set Flds = iConf.Fields

With Flds
'.Item("http://schemas.microsoft.com/cdo/configuration/smtpserver") = strSmartHost
.Item("http://schemas.microsoft.com/cdo/configuration/sendusing") = 1
.Item("http://schemas.microsoft.com/cdo/configuration/smtpserverport") = 25
.Item("http://schemas.microsoft.com/cdo/configuration/smtpconnectiontimeout") = 10
.Update
End With

iConf.Fields.Update

With iMsg
Set .Configuration = iConf
.To = "zaibox@zaicargo.com"
.From = "zaibox@zaicargo.com"
.Subject = "Registro Zaibox-Casillero"
.HTMLBody = cuerpo'
.Send
End With

' cleanup of variables
Set iMsg = Nothing
Set iConf = Nothing
Set Flds = Nothing

Response.Write("<script>window.open('index.asp','_self');</script>")

%>
 