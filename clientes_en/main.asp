<%@LANGUAGE="VBSCRIPT" CODEPAGE="1252"%>
<!--#include file="../../Connections/CPV.asp" -->
<!--#include file="validar.asp" -->
<%
Dim rsAgencias__tmpffw
rsAgencias__tmpffw = "00001"
If (session("ffw") <> "") Then 
  rsAgencias__tmpffw = session("ffw")
End If
%>

<%
Dim rsAgencias
Dim rsAgencias_numRows

Set rsAgencias = Server.CreateObject("ADODB.Recordset")
rsAgencias.ActiveConnection = MM_CPV_STRING
rsAgencias.Source = "select * from AGENCIAS where ffw='" + Replace(rsAgencias__tmpffw, "'", "''") + "' order by nombre"
rsAgencias.CursorType = 0
rsAgencias.CursorLocation = 2
rsAgencias.LockType = 1
rsAgencias.Open()

rsAgencias_numRows = 0

%>
<%

Dim detalleguias__TMPfw
detalleguias__TMPfw = "00001"
If (session("ffw") <> "") Then 
  detalleguias__TMPfw = session("ffw")
End If
%>
<%
'-------
sql = "SELECT top 15 manifiesto.* FROM dbo.manifiesto " & _
	  "where fechaAnulacion is null and "
sql=sql & "casillero_id=" & session("cas_casillero_id")
sql=sql & " order by fec_recibo desc"


Dim detalleguias
Dim detalleguias_numRows

Set detalleguias = Server.CreateObject("ADODB.Recordset")
detalleguias.ActiveConnection = MM_CPV_STRING
detalleguias.Source = sql '"SELECT * FROM dbo.manifiesto inner join remitente on remitente.n_remitente=manifiesto.n_remitente    inner join DES_DESTINATARIO on  DES_DESTINATARIO.n_beneficiario=manifiesto.n_beneficiario and  DES_DESTINATARIO.n_remitente=manifiesto.n_remitente  where manifiesto.ffw=" + Replace(detalleguias__TMPfw, "'", "''") + ""
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

%>

<!--#include file="header.asp"-->

           
           <br />
           <span class="btnAccion">Envios recientes      </span><br />
		      <br />
		      <table border="0" cellpadding="3" cellspacing="0" class="reciboSMALL">
                <tr bgcolor="#CCCCCC"> 
                  <td bgcolor="#3086BC" class="txtTextoJ"><strong>Guia</strong></td>
                  <td bgcolor="#3086BC" class="txtTextoJ"><strong>Fecha</strong></td>
                  <td bgcolor="#3086BC" class="txtTextoJ"><strong>Peso</strong></td>
                  <td bgcolor="#3086BC" class="txtTextoJ"><strong>Piezas</strong></td>
                  <td bgcolor="#3086BC" class="txtTextoJ"><strong>Remitente</strong></td>
                  <td bgcolor="#3086BC" class="txtTextoJ"><strong>Telefono</strong></td>
                </tr>
                <% While  NOT detalleguias.EOF %>
                <tr class="trs2"> 
                  <td nowrap class="txtTexto"> <a href="detalleguia.asp?id=<%=(detalleguias.Fields.Item("manifiesto_id").Value)%>" class="links"> 
                    <%=ucase(detalleguias.Fields.Item("nrogui").Value)%> </a> </td>
                  <td nowrap class="txtTexto"><%=(detalleguias.Fields.Item("fec_recibo").Value)%></td>
                  <td nowrap class="txtTexto"><%=(detalleguias.Fields.Item("pesolb").Value)%></td>
                  <td nowrap class="txtTexto"><%=(detalleguias.Fields.Item("nropaq").Value)%></td>
                  <td nowrap class="txtTexto"><%=(detalleguias.Fields.Item("rem_nombre").Value)%></td>
                  <td nowrap class="txtTexto"><%=(detalleguias.Fields.Item("rem_telefono").Value)%></td>
                </tr>
                <%
			  ent="1" 
			  detalleguias.MoveNext()
			  Wend
			  %>
			  <%if ent<>"1" then %>
				<tr>
				 <td colspan="6" class="txtTexto">
				   <p>&nbsp;</p>
			      <p>No hay informacion disponible				  </p>
			      <p>&nbsp;</p></td>
			    </tr>
				<%end if%>
      </table>
           
			

<!--#include file="footer.asp"-->


<%
rsAgencias.Close()
Set rsAgencias = Nothing
%>
<%
if Trim(Request.Form("AB_buscar"))="form1" then 
	detalleguias.Close()
	Set detalleguias = Nothing
end if
%>
