<%@LANGUAGE="VBSCRIPT" CODEPAGE="1252"%>
<!--#include file="../../Connections/CPV.asp" -->
<!--#include file="validar.asp" -->
<%
dim entro

nrogui=trim(request.Form("nrogui"))
agencia=trim(request.Form("agencia"))
destinatario=trim(request.Form("destinatario"))
remitente=trim(request.Form("remitente"))
teldes=trim(request.Form("teldes"))
telrem=trim(request.Form("telrem"))
fechainicial=trim(request.Form("fechainicial"))
fechafinal=trim(request.Form("fechafinal"))
guimia=trim(request.Form("guimia"))

entro=false
if guimia<>"" or nrogui<>"" or agencia<>"" or destinatario<>"" or remitente<>"" or teldes<>"" or telrem<>"" or fechainicial<>"" or fechafinal<>"" then
	entro=true
end if

if Trim(Request.Form("AB_buscar"))="form1" and entro=true then 

Dim detalleguias__TMPfw
detalleguias__TMPfw = "00001"
If (session("ffw") <> "") Then 
  detalleguias__TMPfw = session("ffw")
End If
%>
<%
'-------

sql = "SELECT * FROM dbo.manifiesto " & _
	  "where casillero_id=" & session("cas_casillero_id") & " " 

if ucase(mid(nrogui,10,1))="P" then 
	sql=sql & "and manifiesto_id=" & mid(nrogui,4,6) & " "	
else
	if nrogui<>"" then sql=sql & "and nrogui like '%" & nrogui & "%' "	
end if
if agencia<>"" then sql=sql & "and agencia='" & agencia & "' " 
if remitente<>"" then sql=sql & "and rem_nombre like '%" & remitente & "%' " 
if destinatario<>"" then sql=sql & "and des_nombre like '%" & destinatario & "%' "	
if telrem<>"" then sql=sql & "and rem_telefono like '%" & telrem & "%' " 
if teldes<>"" then sql=sql & "and DES_telefono like '%" & teldes & "%' " 
if guimia<>"" then sql=sql & "and guimia like '%" & guimia & "%' " 
if fechainicial<>"" then sql=sql & "and manifiesto.fec_recibo >= '" & fechainicial & "' " 
if fechafinal<>"" then sql=sql & "and manifiesto.fec_recibo <= '" & fechafinal & " 23:59:59' " 
sql=sql & " order by fec_recibo desc"


Dim detalleguias
Dim detalleguias_numRows

Set detalleguias = Server.CreateObject("ADODB.Recordset")
detalleguias.ActiveConnection = MM_CPV_STRING
detalleguias.Source = sql 
detalleguias.CursorType = 0
detalleguias.CursorLocation = 2
detalleguias.LockType = 1
detalleguias.Open()

detalleguias_numRows = 0

%>
<%
Dim Repeat1__numRows
Dim Repeat1__index

Repeat1__numRows = 0
Repeat1__index = 0
detalleguias_numRows = detalleguias_numRows + Repeat1__numRows

end if
%>

<!--#include file="header.asp"-->

<script language="JavaScript1.2" src="../../app/images/mm_menu.js"></script>
<script language="javascript" src="../../app/funciones/cal.js"></script>
<script language="javascript" src="../../app/funciones/cal_conf.js"></script>
	
	<table width="800px" border="0" cellspacing="2" cellpadding="2">
        <tr>
          <td class="titulos"> 
            <span class="btnAccion"><br />
            Busqueda</span> 
          <hr size="1"></td>
        </tr>
        <tr>
          <td height="98" valign="top"> 
            <form name="form1" method="post" action="buscarguias.asp">
              <table width="100%" border="0" cellspacing="0" cellpadding="2">
                <tr>
                  <td width="100%"><table border="0" cellpadding="0" cellspacing="0" class="titulos2">
                    <tr>
                      <td width="140" class="txtTexto">Numero de guia<br> 
                        <span class="boxesNoCase">
                        <input name="nrogui" type="text" class="textbox" id="nrogui" value="<%=request("nrogui")%>">
                      </span></td>
                      <td width="175" class="txtTexto">
                        <span class="boxesNoCase">remitente<br>
                        <input name="remitente" type="text" class="textbox" id="remitente" value="<%=request("remitente")%>">
</span></td>
                    </tr>
                    <tr>
                      <td class="txtTexto">telefono remitente<span class="boxesNoCase"><br>
                        <input name="telrem" type="text" class="textbox" id="telrem" value="<%=request("telrem")%>">
                      </span></td>
                      <td class="txtTexto">
                        <span class="boxesNoCase">Guia de ingreso:<br>
                        <input name="guimia" type="text" class="textbox" id="guimia" value="<%=request("guimia")%>">
</span> </td>
                    </tr>
                    <tr>
                      <td colspan="2" class="txtTexto"><table border="0" align="left" cellpadding="3" cellspacing="0">
                        <tr class="letraspequenasnegras">
                          <td height="28" nowrap><div align="right" class="letras">Fecha
                              inicial:</div></td>
                          <td nowrap><input enabled="false" value="<%=request("fechainicial")%>" name="fechainicial" type="text" class="textbox" id="date1" size="10" maxlength="10" onFocus="this.blur(); showCal('Date1')"></td>
                          <td nowrap><div align="left"><a href="javascript:showCal('Date1')"><img src="../../app/images/date.gif" width="17" height="17" border="0"></a></div></td>
                          <td nowrap><div align="right" class="letras"> Fecha
                              final:</div></td>
                          <td nowrap><input enabled="false" value="<%=request("fechafinal")%>" name="fechafinal" type="text" class="textbox" id="date2" size="10" maxlength="10" onFocus="this.blur(); showCal('Date2')"></td>
                          <td nowrap><div align="left"><a href="javascript:showCal('Date2')"><img src="../../app/images/date.gif" width="19" height="17" border="0"></a>&nbsp; </div></td>
                          </tr>
                        <tr>
                          <td nowrap></td>
                          <td nowrap><span id="cal1" style="position:relative;">&nbsp;</span></td>
                          <td nowrap>&nbsp;</td>
                          <td nowrap>&nbsp;</td>
                          <td nowrap><span id="cal2" style="position:relative;">&nbsp;</span></td>
                          <td nowrap>&nbsp;</td>
                          </tr>
                      </table>                        <span class="boxesNoCase"><strong>                        <strong>
                        </strong> </strong></span></td>
                      </tr>
                    <tr>
                      <td class="txtTexto"><span class="boxesNoCase"><strong>
                        <input name="Submit" type="submit" class="botones" value="Buscar">
                        <strong><strong>
                        <input name="AB_buscar" type="hidden" id="AB_buscar" value="form1">
                        </strong></strong> </strong></span></td>
                      <td class="txtTexto"><a href="guiasIngreso.asp" class="botones"></a> </td>
                    </tr>
                  </table></td>
                </tr>
                <tr> 
                  <td><hr size="1"></td>
                </tr>
              </table>
            </form>
          </td>
        </tr>
        <tr>
          <td>
		  <% if Trim(Request.Form("AB_buscar"))="form1" and entro=true then %>
            
            <DIV style="BORDER-RIGHT: silver 1px solid; BORDER-TOP: silver 1px solid; BORDER-LEFT: silver 1px solid; BORDER-BOTTOM: silver 1px solid; width=500">

		      <table border="0" cellpadding="3" cellspacing="0" class="reciboSMALL">
                <tr bgcolor="#CCCCCC"> 
                  <td class="txtTexto"><strong>Guia</strong></td>
                  <td class="txtTexto"><strong>Fecha</strong></td>
                  <td class="txtTexto"><strong>Peso</strong></td>
                  <td class="txtTexto"><strong>Piezas</strong></td>
                  <td class="txtTexto"><strong>Remitente</strong></td>
                  <td class="txtTexto"><strong>Telefono</strong></td>
                </tr>
                <% While  NOT detalleguias.EOF %>
                <tr class="trs2"> 
                  <td nowrap class="txtTexto"> <a href="detalleguia.asp?id=<%=(detalleguias.Fields.Item("manifiesto_id").Value)%>" class="links"> 
                    <%=(detalleguias.Fields.Item("nrogui").Value)%> </a> </td>
                  <td nowrap class="txtTexto"><%=(detalleguias.Fields.Item("fec_recibo").Value)%></td>
                  <td nowrap class="txtTexto"><%=(detalleguias.Fields.Item("pesolb").Value)%></td>
                  <td nowrap class="txtTexto"><%=(detalleguias.Fields.Item("nropaq").Value)%></td>
                  <td nowrap class="txtTexto"><%=(detalleguias.Fields.Item("nomrem").Value)%></td>
                  <td nowrap class="txtTexto"><%=(detalleguias.Fields.Item("telrem").Value)%></td>
                </tr>
                <% 
			  detalleguias.MoveNext()
			  Wend
			  %>
              </table>
            </div>
			
			<% End If %>

</td>
        </tr>
      </table>
	  
	  
	  <!--#include file="footer.asp"-->
	  
	  
<%
if Trim(Request.Form("AB_buscar"))="form1" then 
	detalleguias.Close()
	Set detalleguias = Nothing
end if
%>
