<%@LANGUAGE="VBSCRIPT" CODEPAGE="1252"%>
<!--#include file="../../Connections/CPV.asp" -->
<!--#include file="validar.asp" -->
<%
' *** Edit Operations: declare variables

Dim MM_editAction
Dim MM_abortEdit
Dim MM_editQuery
Dim MM_editCmd

Dim MM_editConnection
Dim MM_editTable
Dim MM_editRedirectUrl
Dim MM_editColumn
Dim MM_recordId

Dim MM_fieldsStr
Dim MM_columnsStr
Dim MM_fields
Dim MM_columns
Dim MM_typeArray
Dim MM_formVal
Dim MM_delim
Dim MM_altVal
Dim MM_emptyVal
Dim MM_i

MM_editAction = CStr(Request.ServerVariables("SCRIPT_NAME"))
If (Request.QueryString <> "") Then
  MM_editAction = MM_editAction & "?" & Server.HTMLEncode(Request.QueryString)
End If

' boolean to abort record edit
MM_abortEdit = false

' query string to execute
MM_editQuery = ""
%>
<%
' *** Update Record: set variables

If (CStr(Request("MM_update")) = "form1" And CStr(Request("MM_recordId")) <> "") Then

  MM_editConnection = MM_CPV_STRING
  MM_editTable = "dbo.CASILLEROS"
  MM_editColumn = "cas_casillero_id"
  MM_recordId = "" + Request.Form("MM_recordId") + ""
  MM_editRedirectUrl = ""
  MM_fieldsStr  = "cas_alias|value|cas_nombre|value|cas_empresa|value|cas_direccion|value|cas_ciudad_id|value|cas_ciudad|value|cas_zip|value|cas_telefono|value|cas_fax|value|cas_email|value|cas_password|value"
  MM_columnsStr = "cas_alias|',none,''|cas_nombre|',none,''|cas_empresa|',none,''|cas_direccion|',none,''|cas_ciudad_id|none,none,NULL|cas_ciudad|',none,''|cas_zip|',none,''|cas_telefono|',none,''|cas_fax|',none,''|cas_email|',none,''|cas_password|',none,''"

  ' create the MM_fields and MM_columns arrays
  MM_fields = Split(MM_fieldsStr, "|")
  MM_columns = Split(MM_columnsStr, "|")
  
  ' set the form values
  For MM_i = LBound(MM_fields) To UBound(MM_fields) Step 2
    MM_fields(MM_i+1) = CStr(Request.Form(MM_fields(MM_i)))
  Next

  ' append the query string to the redirect URL
  If (MM_editRedirectUrl <> "" And Request.QueryString <> "") Then
    If (InStr(1, MM_editRedirectUrl, "?", vbTextCompare) = 0 And Request.QueryString <> "") Then
      MM_editRedirectUrl = MM_editRedirectUrl & "?" & Request.QueryString
    Else
      MM_editRedirectUrl = MM_editRedirectUrl & "&" & Request.QueryString
    End If
  End If

End If
%>
<%
' *** Update Record: construct a sql update statement and execute it

If (CStr(Request("MM_update")) <> "" And CStr(Request("MM_recordId")) <> "") Then

  ' create the sql update statement
  MM_editQuery = "update " & MM_editTable & " set "
  For MM_i = LBound(MM_fields) To UBound(MM_fields) Step 2
    MM_formVal = MM_fields(MM_i+1)
    MM_typeArray = Split(MM_columns(MM_i+1),",")
    MM_delim = MM_typeArray(0)
    If (MM_delim = "none") Then MM_delim = ""
    MM_altVal = MM_typeArray(1)
    If (MM_altVal = "none") Then MM_altVal = ""
    MM_emptyVal = MM_typeArray(2)
    If (MM_emptyVal = "none") Then MM_emptyVal = ""
    If (MM_formVal = "") Then
      MM_formVal = MM_emptyVal
    Else
      If (MM_altVal <> "") Then
        MM_formVal = MM_altVal
      ElseIf (MM_delim = "'") Then  ' escape quotes
        MM_formVal = "'" & Replace(MM_formVal,"'","''") & "'"
      Else
        MM_formVal = MM_delim + MM_formVal + MM_delim
      End If
    End If
    If (MM_i <> LBound(MM_fields)) Then
      MM_editQuery = MM_editQuery & ","
    End If
    MM_editQuery = MM_editQuery & MM_columns(MM_i) & " = " & MM_formVal
  Next
  MM_editQuery = MM_editQuery & " where " & MM_editColumn & " = " & MM_recordId

  If (Not MM_abortEdit) Then
    ' execute the update
    Set MM_editCmd = Server.CreateObject("ADODB.Command")
    MM_editCmd.ActiveConnection = MM_editConnection
    MM_editCmd.CommandText = MM_editQuery
    MM_editCmd.Execute
    MM_editCmd.ActiveConnection.Close

    If (MM_editRedirectUrl <> "") Then
      Response.Redirect(MM_editRedirectUrl)
    End If
  End If

End If
%>
<%
Dim rsCasillero__tmpid
rsCasillero__tmpid = "0"
If (request.querystring("id") <> "") Then 
  rsCasillero__tmpid = request.querystring("id")
End If
%>
<%
Dim rsCasillero
Dim rsCasillero_numRows

Set rsCasillero = Server.CreateObject("ADODB.Recordset")
rsCasillero.ActiveConnection = MM_CPV_STRING
rsCasillero.Source = "select *,ciudades.nombre as ciudad from casilleros inner join ciudades on cas_ciudad_id=id_ciudad where cas_casillero_id=" + Replace(rsCasillero__tmpid, "'", "''") + ""
rsCasillero.CursorType = 0
rsCasillero.CursorLocation = 2
rsCasillero.LockType = 1
rsCasillero.Open()

rsCasillero_numRows = 0
%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<title><%=session("ffw_nombre")%></title>
<link href="../app/syles.css" rel="stylesheet" type="text/css">
<link href="../app/CSS/divs.css" rel="stylesheet" type="text/css">
<link href="../Imagenes/estilos.css" rel="stylesheet" type="text/css">
<style type="text/css">
<!--
body {
	background-color: #D5EAFF;
}
-->
</style></head>

<body <%if request.Form("MM_update")="form1" then response.Write("onload=""javascript:window.close()"";")%> onUnload="window.opener.location.reload();" >
<form method="post" action="<%=MM_editAction%>" name="form1">
  <table width="100%" class="titulos2">
    <tr valign="baseline">
      <td colspan="2" align="right" nowrap bgcolor="#FFFFFF" class="txtTextoI"><div align="center">Editar informacion </div></td>
    </tr>
    <tr valign="baseline">
      <td width="69" align="right" nowrap class="txtTexto"><div align="left"><strong>casillero:
          <input name="cas_ciudad_id" type="hidden" value="<%=(rsCasillero.Fields.Item("cas_ciudad_id").Value)%>">
      </strong></div></td>
      <td width="163" class="txtTexto"><strong><%=(rsCasillero.Fields.Item("cas_casillero").Value)%></strong></td>
    </tr>
    <tr valign="baseline">
      <td align="right" nowrap class="txtTexto"><div align="left"><strong>Alias:</strong></div></td>
      <td class="txtTexto"><input name="cas_alias" type="hidden" class="reciboSMALLCAP" value="<%=(rsCasillero.Fields.Item("cas_alias").Value)%>" size="32">
        <strong><%=(rsCasillero.Fields.Item("cas_alias").Value)%></strong> </td>
    </tr>
    <tr valign="baseline">
      <td align="right" nowrap class="txtTexto"><div align="left"><strong>Nombre:</strong></div></td>
      <td class="txtTexto"><input name="cas_nombre" type="hidden" class="reciboSMALLCAP" value="<%=(rsCasillero.Fields.Item("cas_nombre").Value)%>" size="32">
        <strong><%=(rsCasillero.Fields.Item("cas_nombre").Value)%></strong> </td>
    </tr>
    <tr valign="baseline">
      <td align="right" nowrap class="txtTexto"><div align="left"><strong>Empresa:</strong></div></td>
      <td class="txtTexto"><input name="cas_empresa" type="text" class="txtCajas" value="<%=(rsCasillero.Fields.Item("cas_empresa").Value)%>" size="32">      </td>
    </tr>
    <tr valign="baseline">
      <td align="right" valign="middle" nowrap class="txtTexto"><div align="left"><strong>Direccion:</strong></div></td>
      <td valign="baseline" class="txtTexto"><textarea name="cas_direccion" cols="32" rows="3" class="txtTexto"><%=(rsCasillero.Fields.Item("cas_direccion").Value)%></textarea>      </td>
    </tr>
    <tr valign="baseline">
      <td align="right" nowrap class="txtTexto"><div align="left"><strong>Ciudad:</strong></div></td>
      <td class="txtTexto"><strong><%=(rsCasillero.Fields.Item("ciudad").Value)%></strong>
      <input name="cas_ciudad" type="hidden" class="textbox" value="<%=(rsCasillero.Fields.Item("cas_ciudad").Value)%>" size="32"></td>
    </tr>
    <tr valign="baseline">
      <td align="right" nowrap class="txtTexto"><div align="left"><strong>Zip:</strong></div></td>
      <td class="txtTexto"><input name="cas_zip" type="text" class="txtCajas" value="<%=(rsCasillero.Fields.Item("cas_zip").Value)%>" size="32">      </td>
    </tr>
    <tr valign="baseline">
      <td align="right" nowrap class="txtTexto"><div align="left"><strong>Telefono:</strong></div></td>
      <td class="txtTexto"><input name="cas_telefono" type="text" class="txtCajas" value="<%=(rsCasillero.Fields.Item("cas_telefono").Value)%>" size="32">      </td>
    </tr>
    <tr valign="baseline">
      <td align="right" nowrap class="txtTexto"><div align="left"><strong>Fax:</strong></div></td>
      <td class="txtTexto"><input name="cas_fax" type="text" class="txtCajas" value="<%=(rsCasillero.Fields.Item("cas_fax").Value)%>" size="32">      </td>
    </tr>
    <tr valign="baseline">
      <td align="right" nowrap class="txtTexto"><div align="left"><strong>Email:</strong></div></td>
      <td class="txtTexto"><input name="cas_email" type="text" class="txtCajas" value="<%=(rsCasillero.Fields.Item("cas_email").Value)%>" size="32">      </td>
    </tr>
    <tr valign="baseline">
      <td align="right" nowrap class="txtTexto"><div align="left"><strong>Clave:</strong></div></td>
      <td class="txtTexto"><input name="cas_password" type="text" class="txtCajas" value="<%=(rsCasillero.Fields.Item("cas_password").Value)%>" size="32">      </td>
    </tr>
    <tr valign="baseline">
      <td nowrap align="right">&nbsp;</td>
      <td><input type="submit" class="btnAccion" value="Actualizar">      </td>
    </tr>
  </table>
  <input type="hidden" name="MM_update" value="form1">
  <input type="hidden" name="MM_recordId" value="<%= rsCasillero.Fields.Item("cas_casillero_id").Value %>">
</form>
<p>&nbsp;</p>
</body>
</html>
<%
rsCasillero.Close()
Set rsCasillero = Nothing
%>
