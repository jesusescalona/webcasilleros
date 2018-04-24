<%@LANGUAGE="VBSCRIPT" CODEPAGE="1252"%>
<!--#include file="../../Connections/CPV.asp" -->
<%
session("cuenta_id")=""
session("MM_Username")=""
%>
<%
' *** Validate request to log in to this site.
MM_LoginAction = Request.ServerVariables("URL")
If Request.QueryString<>"" Then MM_LoginAction = MM_LoginAction + "?" + Server.HTMLEncode(Request.QueryString)
MM_valUsername=CStr(Request.Form("usuario"))

If MM_valUsername <> "" Then
  MM_fldUserAuthorization=""
  MM_redirectLoginSuccess="main.asp"
  MM_redirectLoginFailed="../registro.asp?err=Error"
  MM_flag="ADODB.Recordset"
  set MM_rsUser = Server.CreateObject(MM_flag)
  MM_rsUser.ActiveConnection = MM_CPV_STRING
  MM_rsUser.Source = "SELECT * "
  MM_rsUser.Source = MM_rsUser.Source & " FROM dbo.casilleros WHERE cas_alias='" & Replace(MM_valUsername,"'","''") & "' and isnull(cas_alias,'')<>'' and isnull(cas_password,'')<>'' "
 
  MM_rsUser.CursorType = 0
  MM_rsUser.CursorLocation = 2
  MM_rsUser.LockType = 3
  MM_rsUser.Open
   
  If Not MM_rsUser.EOF Then 
      if cstr(Request.Form("clave")) = cstr(trim(MM_rsUser.Fields.Item("cas_password").Value)) then 
		Session("MM_Username") = MM_valUsername
		Session("cas_casillero_id") = MM_rsUser.Fields.Item("cas_casillero_id").Value
		response.Cookies("DATOS")("CAS_CASILLERO_ID") = MM_rsUser.Fields.Item("cas_casillero_id").Value
		Session("cas_alias") = MM_rsUser.Fields.Item("cas_alias").Value
		Session("cas_consultar_prealertas")=MM_rsUser.Fields.Item("cas_consultar_prealertas").Value
		
		'session("ffw") = MM_rsUser.Fields.Item("ffw").Value
		'session("logo") = MM_rsUser.Fields.Item("logo").Value
			if session("cas_casillero_id") = "" then
				response.Redirect(MM_redirectLoginFailed & " session")
			else
				Response.Redirect(MM_redirectLoginSuccess)
			end if
	  Else
		Response.Redirect(MM_redirectLoginFailed)
	  End If
  Else
	Response.Redirect(MM_redirectLoginFailed)
  End If
  MM_rsUser.Close
 End If
 
%>
