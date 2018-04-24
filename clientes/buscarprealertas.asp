<%@LANGUAGE="VBSCRIPT" CODEPAGE="1252"%>
<!--#include file="../../Connections/CPV.asp" -->
<!--#include file="validar.asp" -->
<!--#include file="../../app/funciones/_db.asp" -->

<%
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
' *** Delete Record: declare variables

if (CStr(Request("MM_delete")) = "frdel" And CStr(Request("MM_recordId")) <> "") Then

  MM_editConnection = MM_CPV_STRING
  MM_editTable = "dbo.alertas"
  MM_editColumn = "alr_alerta_id"
  MM_recordId = "" + Request.Form("MM_recordId") + ""
  MM_editRedirectUrl = "buscarprealertas.asp"

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
' *** Delete Record: construct a sql delete statement and execute it

If (CStr(Request("MM_delete")) <> "" And CStr(Request("MM_recordId")) <> "") Then

  ' create the sql delete statement
  MM_editQuery = "delete from " & MM_editTable & " where " & MM_editColumn & " = " & MM_recordId

  If (Not MM_abortEdit) Then
    ' execute the delete
	dim conn
	call open_conn()
	conn.execute("delete alertas where alr_alerta_id=" & MM_recordId )
	
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
Dim id_cas
id_cas=REQUEST.Cookies("DATOS")("CAS_CASILLERO_ID")'Session("cas_casillero_id") 
Dim detalleid
'response.Write("id_casillero es "&id_cas)
%>

<%
Dim rsAlertas
Dim rsAlertas_numRows

Set rsAlertas = Server.CreateObject("ADODB.Recordset")
rsAlertas.ActiveConnection = MM_CPV_STRING
rsAlertas.Source = "SELECT pre_tracking as alr_guimia,pre_casillero as alr_casillero,pre_alerta_id as alr_alerta_id,pre_factura as alr_direccion,pre_transportadora as alr_tienda,isnull(pre_valdec,0) as alr_valor,pre_contenido as alr_descripcion,pre_activa as alr_activa,pre_proveedor,pre_tracking,pre_factura FROM prealertas inner join casilleros on prealertas.pre_casillero=casilleros.cas_casillero WHERE cas_casillero_id='"&id_cas&"'  ORDER BY pre_alerta_id desc"
rsAlertas.CursorType = 0
rsAlertas.CursorLocation = 2
rsAlertas.LockType = 1
rsAlertas.Open()

rsAlertas_numRows = 0
'response.Write("</br>"&rsAlertas.Source)
'Fin rsAlertas
%>


<%
Dim Repeat1__numRows
Dim Repeat1__index

Repeat1__numRows = 0
Repeat1__index = 0
detalleguias_numRows = detalleguias_numRows + Repeat1__numRows

%>



'

          <!--#include file="header.asp"-->
	<table border="2" cellpadding="3" cellspacing="0" class="reciboSMALL">
         <tr bgcolor="#CCCCCC"> <td colspan="7"> <div align="center"><span class="titulos"><%="Prealertas "%>&nbsp; <%=Session("cas_nombre")%></span></div></td></tr>
		     
		     
                <tr bgcolor="#CCCCCC"> 
				  
                  <td bgcolor="#CCCCCC" class="txtTextoJ"><strong>Tracking Id</strong></td>
                  
                  <td bgcolor="#CCCCCC" class="txtTextoJ"><strong>Compañia Courier</strong></td>
                  <td bgcolor="#CCCCCC" class="txtTextoJ"><strong>Valor</strong></td>
				  <td bgcolor="#CCCCCC" class="txtTextoJ"><strong>Descripcion</strong></td>
                 
				  <td bgcolor="#CCCCCC" class="txtTextoJ"><strong>Proveedor</strong></td>
				  <td bgcolor="#CCCCCC" class="txtTextoJ"><strong>Adjunto</strong></td>
				    <td bgcolor="#CCCCCC" class="txtTextoJ"><strong>Activa</strong></td>
                </tr>
                <% While  NOT rsAlertas.EOF %>
				<tr class="trs2">
				
                  <td nowrap class="txtTexto"><textarea rows="4" readonly><%=(rsAlertas.Fields.Item("alr_guimia").Value)%></textarea></td>
                 
                  <td nowrap class="txtTexto" valign="top">
				  <%if(rsAlertas.Fields.Item("alr_tienda").Value<>NULL or rsAlertas.Fields.Item("alr_tienda").Value<>"NULL")Then
				  Response.Write(rsAlertas.Fields.Item("alr_tienda").Value)
				  else
				  Response.Write("Ninguna")
				  End if%>
				  </td>
                  <td nowrap class="txtTexto"  valign="top">
				  <%if( rsAlertas.Fields.Item("alr_valor").Value<>"NULL")Then
				  Response.Write(rsAlertas.Fields.Item("alr_valor").Value)
				  else
				  Response.Write("0")
				  End if%>
				  </td>
				  <td nowrap class="txtTexto"><textarea rows="4" readonly><%=(rsAlertas.Fields.Item("alr_descripcion").Value)%></textarea></td>
				
				 <td nowrap class="txtTexto" valign="top">
				  <%if(rsAlertas.Fields.Item("pre_proveedor").Value<>"" )Then
				  Response.Write(rsAlertas.Fields.Item("pre_proveedor").Value)
				  else
				  Response.Write("Ninguna")
				  End if%>
				  </td>
				 <%'response.write(Request.ServerVariables("SERVER_NAME"))%>
				  <td class="tds"  valign="top"><div align="center"  >
				  <%if(rsAlertas.Fields.Item("alr_direccion").Value<>"")Then
				  if trim(lcase(Request.ServerVariables("SERVER_NAME")))="dev.controlbox.net" then
				   img="http://dev.controlbox.net:8888/zai/webcasilleros/clientes/facturas/" & rsAlertas("pre_tracking") & replace(replace(rsAlertas("pre_factura"), "#", ""), " ","")
				  else
				   if trim(lcase(Request.ServerVariables("SERVER_NAME")))="stg3.controlbox.net" then
				    img="http://stg3.controlbox.net/ZaiCargo/webcasilleros/clientes/facturas/" & rsAlertas("pre_tracking") & replace(replace(rsAlertas("pre_factura"), "#", ""), " ","")
				   else
				    img="http://zaicargo.controlbox.net/webcasilleros/clientes/facturas/" & rsAlertas("pre_tracking") & replace(replace(rsAlertas("pre_factura"), "#", ""), " ","")
				   end if
				  end if
				  
				 
				  %></br><a href="<%=img%>" target="_blank"><%="Ver adjunto"%></a> 
				  <%else%><%="No hay adjuntos"%><%End if%>
				</div></td>
				<td valign="top">
				
				 <% Response.Write(rsAlertas.Fields.Item("alr_activa").Value)
				  %>
				  </td>
				  
				 
				  
                </tr>
                <%
			  ent="1" 
			  rsAlertas.MoveNext()
			  Wend
			  rsAlertas.Close()
			  %>
			  <%if ent<>"1" then %>
				<tr>
				 <td colspan="6" class="txtTexto">
				   <p>&nbsp;</p>
			      <div align="center"><p class="titulos">Usted no tiene alertas. </p></div>
			      <p>&nbsp;</p></td>
			    </tr>
				<%End if%>
      </table> <!--#include file="footer.asp"-->