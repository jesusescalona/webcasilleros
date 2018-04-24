<%@LANGUAGE="VBSCRIPT" CODEPAGE="1252"%>
<!--#include file="../Connections/CPV.asp" -->
<!--#include file="validar.asp" -->

<% If Trim(Request.Form("guia"))<>"" Then %>
<%
Dim rsGuiaMia__tmpguia
rsGuiaMia__tmpguia = "0"
If (request.form("guia") <> "") Then 
  rsGuiaMia__tmpguia = request.form("guia")
End If
%>
<%
Dim rsGuiaMia
Dim rsGuiaMia_numRows

Set rsGuiaMia = Server.CreateObject("ADODB.Recordset")
rsGuiaMia.ActiveConnection = MM_CPV_STRING
rsGuiaMia.Source = "SELECT *  FROM dbo.GUIAS_INGRESO  WHERE gin_guia='" + Replace(rsGuiaMia__tmpguia, "'", "''") + "'"
rsGuiaMia.CursorType = 0
rsGuiaMia.CursorLocation = 2
rsGuiaMia.LockType = 1
rsGuiaMia.Open()

rsGuiaMia_numRows = 0
%>
<% End If %>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<title>TransExpress</title>
<style type="text/css">
<!--
body {
	margin-left: 0px;
	margin-top: 0px;
	margin-right: 0px;
	margin-bottom: 0px;
}
-->
</style>
<link href="../app/syles.css" rel="stylesheet" type="text/css">
<link href="../app/CSS/divs.css" rel="stylesheet" type="text/css">
</head>

<body>
<table width="100%"  border="0" cellspacing="0" cellpadding="2">
  <tr>
    <td><!--#include file="menu.asp"--></td>
  </tr>
  <tr>
    <td><span class="titulos">Guias de ingreso de UPS, FedEx, USPS, etc. con informacion incompleta
    </span>      <hr size="1"></td>
  </tr>
  <tr>
    <td>
	<form action="guiasIngreso.asp" method="post" >
	<span class="titulos2">Guia de ingreso:</span><br>
    <input name="guia" type="text" class="textbox" id="guia">
    <br>
    <br>
    <input name="Submit" type="submit" class="botones" value="Buscar">
	</form>
	</td>
  </tr>
  <tr>
    <td class="titulos2">
	<% If Trim(Request.Form("guia"))<>"" Then %>
	
	<% if rsGuiaMia.eof then%>
		La Guia que esta buscando no se encuentra
	<% Else %>
		La guia <span class="titulos"> <%= Trim(Request.Form("guia")) %></span> se encontro en el sistema, si desea  contactar al departamento de servicio al cliente, <a href="#">click aqui</a>	<% End If %>

	
	<% End If %>

	</td>
  </tr>
</table>
</body>
</html>
<% If Trim(Request.Form("guia"))<>"" Then %>
<%
rsGuiaMia.Close()
Set rsGuiaMia = Nothing
%>
<% End If %>
