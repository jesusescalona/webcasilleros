<%@LANGUAGE="VBSCRIPT"%>
<!--#include file="../../Connections/CPV.asp" -->
<!--#include file="../../app/funciones/_db.asp" -->
<!--#include file="validar.asp" -->

<%
Dim DetMan__TMPmanid
DetMan__TMPmanid = "0"
If (request.querystring("id")   <> "") Then 
  DetMan__TMPmanid = request.querystring("id")  
End If
%>
<%
Dim DetMan
Dim DetMan_numRows

Set DetMan = Server.CreateObject("ADODB.Recordset")
DetMan.ActiveConnection = MM_CPV_STRING
DetMan.Source = "SELECT cas_pago,crt_descripcion,cas_servicio,cas_casillero,cas_alias,manifiesto.*,remitente.nombre as nomr,remitente.direccion as dirr,remitente.ciudad as ciur,remitente.pais as pair,remitente.estado as estr,remitente.zip as zipr,remitente.telefono as telr,DESTINATARIO.nombre as nomd,DESTINATARIO.direccion as dird,DESTINATARIO.zip as  zipd,DESTINATARIO.telefono as teld,CIUDADES.nombre as ciudes,CIUDADES.estado as estadodes,AGENCIAS.nombre as nomage,AGENCIAS.direccion1 as dirage,AGENCIAS.telefono as telage,CUENTAS.empresa + ' - ' + CUENTAS.nombre as cuenta,usuarios.nombre as cajero  FROM dbo.manifiesto    left outer join usuarios on usuarios.id_usuario=manifiesto.codemp    inner join remitente on   remitente.n_remitente=manifiesto.n_remitente   inner join DESTINATARIO on    DESTINATARIO.n_beneficiario = manifiesto.n_beneficiario and   DESTINATARIO.n_remitente = manifiesto.n_remitente   inner join CIUDADES on  manifiesto.id_ciudad=CIUDADES.id_ciudad  inner join AGENCIAS on  AGENCIAS.agencia=manifiesto.agencia and  AGENCIAS.ffw=manifiesto.ffw  left outer join CUENTAS on  manifiesto.cuenta_id=CUENTAS.cuenta_id left outer join casilleros on cas_casillero_id=casillero_id left outer join codigos_retencion on crt_codigo_retencion_id = codigo_retencion_id WHERE manifiesto_id=" + Replace(DetMan__TMPmanid, "'", "''") + " and casillero_id=" & session("cas_casillero_id")
DetMan.CursorType = 0
DetMan.CursorLocation = 2
DetMan.LockType = 1
DetMan.Open()

DetMan_numRows = 0
%>
<%
Dim staguia__TMPid
staguia__TMPid = "5"
If (request.querystring("id") <> "") Then 
  staguia__TMPid = request.querystring("id")
End If
%>
<%
Dim staguia
Dim staguia_numRows

Set staguia = Server.CreateObject("ADODB.Recordset")
staguia.ActiveConnection = MM_CPV_STRING
staguia.Source = "SELECT status.* ,tipstatus.dessta as descri  FROM dbo.status  inner join manifiesto on  manifiesto.ffw=status.ffw and  manifiesto.nrogui=status.nrogui  inner join tipstatus on  status.codsta=tipstatus.codsta and  status.ffw=tipstatus.ffw and tipstatus.publico=1 WHERE manifiesto.manifiesto_id=" + Replace(staguia__TMPid, "'", "''") + "  ORDER BY status.fecreal desc"
staguia.CursorType = 0
staguia.CursorLocation = 2
staguia.LockType = 1
staguia.Open()

staguia_numRows = 0
%>
<%
Dim rsPaqAdjuntos__tmpid
rsPaqAdjuntos__tmpid = "0"
If (request.querystring("id") <> "") Then 
  rsPaqAdjuntos__tmpid = request.querystring("id")
End If
%>
<%
Dim rsPaqAdjuntos
Dim rsPaqAdjuntos_numRows

Set rsPaqAdjuntos = Server.CreateObject("ADODB.Recordset")
rsPaqAdjuntos.ActiveConnection = MM_CPV_STRING
rsPaqAdjuntos.Source = "SELECT *  FROM dbo.PAQADJUNTOS  WHERE paq_manifiesto_id=" + Replace(rsPaqAdjuntos__tmpid, "'", "''") + ""
rsPaqAdjuntos.CursorType = 0
rsPaqAdjuntos.CursorLocation = 2
rsPaqAdjuntos.LockType = 1
rsPaqAdjuntos.Open()

rsPaqAdjuntos_numRows = 0
%>
<%
Dim rsContenido__tmpId
rsContenido__tmpId = "0"
If (request.querystring("id") <> "") Then 
  rsContenido__tmpId = request.querystring("id")
End If
%>
<%
Dim rsContenido
Dim rsContenido_numRows

Set rsContenido = Server.CreateObject("ADODB.Recordset")
rsContenido.ActiveConnection = MM_CPV_STRING
rsContenido.Source = "SELECT *  FROM contenido  WHERE cnt_manifiesto_id=" + Replace(rsContenido__tmpId, "'", "''") + ""
rsContenido.CursorType = 0
rsContenido.CursorLocation = 2
rsContenido.LockType = 1
rsContenido.Open()

rsContenido_numRows = 0
%>
<%
Dim Repeat1__numRows
Dim Repeat1__index

Repeat1__numRows = -1
Repeat1__index = 0
staguia_numRows = staguia_numRows + Repeat1__numRows
%>
	
<!--#include file="header.asp"-->
	<table width="800px" border="0" cellspacing="0" cellpadding="2">
        <tr>
          <td class="titulos"> 
            <span class="btnAccion"><br />
            Detalle guia            </span>
          <hr size="1" noshade></td>
        </tr>
        <tr>
          <td valign="top"> 
            <table border="0" cellpadding="2" cellspacing="1" class="txtTexto">
              <tr> 
                <td width="10%" bgcolor="#F0F0F0" class="trs2"><strong>Guia No.</strong></td>
                <td><%=(DetMan.Fields.Item("nrogui").Value)%></td>
                <td bgcolor="#F0F0F0" class="trs2"><strong>Fecha </strong></td>
                <td width="39%"><%=(DetMan.Fields.Item("fec_recibo").Value)%></td>
              </tr>
              <tr> 
                <td bgcolor="#F0F0F0" class="trs2"><strong>Agencia</strong></td>
                <td><%=(DetMan.Fields.Item("agencia").Value)%>- <%=(DetMan.Fields.Item("nomage").Value)%><br></td>
                <td bgcolor="#F0F0F0" class="trs2"><strong>Recibida por </strong></td>
                <td><%=(DetMan.Fields.Item("cajero").Value)%></td>
              </tr>
              <tr> 
                <td colspan="2"> 
                  <DIV style="BORDER-RIGHT: silver 1px solid; BORDER-TOP: silver 1px solid; BORDER-LEFT: silver 1px solid; BORDER-BOTTOM: silver 1px solid; width=300; heigth=200"> 
                    <span class="titulos">Remitente</span><br>
                    <%=(DetMan.Fields.Item("nomr").Value)%><br>
                    <%=(DetMan.Fields.Item("dirr").Value)%><br>
                    <%=(DetMan.Fields.Item("ciur").Value)%> <%=(DetMan.Fields.Item("pair").Value)%> <%=(DetMan.Fields.Item("estr").Value)%> <%=(DetMan.Fields.Item("zipr").Value)%><br>
                    <%=(DetMan.Fields.Item("telr").Value)%><br>
                  </div></td>
                <td colspan="2"> 
                  <DIV style="heigth=200;BORDER-RIGHT: silver 1px solid; BORDER-TOP: silver 1px solid; BORDER-LEFT: silver 1px solid; BORDER-BOTTOM: silver 1px solid; width=300"> 
                    <span class="titulos">Destinatario</span><br>
                    <%=(DetMan.Fields.Item("nomd").Value)%><br>
                    <%=(DetMan.Fields.Item("dird").Value)%><br>
                    <%=(DetMan.Fields.Item("ciudes").Value)%> <%=(DetMan.Fields.Item("estadodes").Value)%><%=(DetMan.Fields.Item("zipd").Value)%><br>
                    <%=(DetMan.Fields.Item("teld").Value)%> <br>
                  </div></td>
              </tr>
              <tr>
                <td bgcolor="#F0F0F0" class="trs2"><strong>Ingreso</strong></td>
                <td><%=(DetMan.Fields.Item("guimia").Value)%></td>
                <td bgcolor="#F0F0F0" class="trs2">&nbsp;</td>
                <td class="titulos">&nbsp;</td>
              </tr>
              <tr>
                <td bgcolor="#F0F0F0" class="trs2"><strong>Cuenta</strong></td>
                <td><%=(DetMan.Fields.Item("cuenta").Value)%></td>
                <td bgcolor="#F0F0F0" class="trs2"><strong>Casillero</strong></td>
                <td class="titulos"><%=(DetMan.Fields.Item("cas_alias").Value)%></td>
              </tr>
              <tr> 
                <td bgcolor="#F0F0F0" class="trs2"><strong>Peso</strong></td>
                <td><%=(DetMan.Fields.Item("pesolb").Value)%></td>
                <td bgcolor="#F0F0F0" class="trs2"><strong>Impuestos</strong></td>
                <td><%= FormatCurrency((DetMan.Fields.Item("impuestos").Value), 2, -2, -2, -2) %></td>
              </tr>
              <tr> 
                <td bgcolor="#F0F0F0" class="trs2"><strong>Valor dec.</strong></td>
                <td><%=(DetMan.Fields.Item("valordeclarado").Value)%></td>
                <td bgcolor="#F0F0F0" class="trs2"><strong>Piezas</strong></td>
                <td><%=(DetMan.Fields.Item("nropaq").Value)%></td>
              </tr>
              <tr> 
                <td bgcolor="#F0F0F0" class="trs2"><strong>Peso real</strong></td>
                <td><%=(DetMan.Fields.Item("peso_real").Value)%></td>
                <td bgcolor="#F0F0F0" class="trs2"><strong>Seguro</strong></td>
                <td><%=(formatnumber(DetMan.Fields.Item("seguroffw").Value) * 1)+(formatnumber(DetMan.Fields.Item("seguroagencia").Value) * 1)%></td>
              </tr>
              <tr>
                <td bgcolor="#F0F0F0" class="trs2"><strong>TOTAL:</strong></td>
                <td><%if (DetMan.Fields.Item("cas_pago").Value)="prepago" then response.Write(formatcurrency(DetMan.Fields.Item("total").Value))%></td>
                <td bgcolor="#F0F0F0" class="trs2"><strong>Pagado en: </strong></td>
                <td><%=(DetMan.Fields.Item("pagado").Value)%></td>
              </tr>
              <tr> 
                <td bgcolor="#F0F0F0" class="trs2" style="font-weight: bold">volumenes</td>
                <td colspan="3"><table border="1" cellpadding="1" cellspacing="1" bordercolor="#EFEFEF" class="textbox">
                  <tr>
                    <td class="txtTexto"><strong>Alto</strong></td>
                    <td class="txtTexto"><strong>Largo</strong></td>
                    <td class="txtTexto"><strong>Ancho</strong></td>
                    <td class="txtTexto"><strong>Volumen</strong></td>
                    <td class="txtTexto"><strong>Peso</strong></td>
                    <td class="txtTexto"><strong>Guia</strong></td>
                  </tr>
                  <% While ((Repeat1__numRows <> 0) AND (NOT rsPaqAdjuntos.EOF)) %>
                  <tr>
                    <td class="txtTexto"><%=(rsPaqAdjuntos.Fields.Item("paq_alto").Value)%></td>
                    <td class="txtTexto"><%=(rsPaqAdjuntos.Fields.Item("paq_largo").Value)%></td>
                    <td class="txtTexto"><%=(rsPaqAdjuntos.Fields.Item("paq_ancho").Value)%></td>
                    <td class="txtTexto"><%=(rsPaqAdjuntos.Fields.Item("paq_volumen").Value)%></td>
                    <td class="txtTexto"><%=(rsPaqAdjuntos.Fields.Item("paq_peso").Value)%></td>
                    <td class="txtTexto"><%=(rsPaqAdjuntos.Fields.Item("paq_nrogui").Value)%></td>
                  </tr>
                  <% 
  Repeat1__index=Repeat1__index+1
  Repeat1__numRows=Repeat1__numRows-1
  rsPaqAdjuntos.MoveNext()
Wend
%>
                </table></td>
              </tr>
              <tr> 
                <td colspan="4" class="titulos2"><table border="0" cellpadding="2" cellspacing="0" class="textbox">
                  <tr bgcolor="#F0F0F0">
                    <td class="txtTexto"><strong>Detalle</strong></td>
                    <td class="txtTexto"><strong>Cantidad</strong></td>
                    <td class="txtTexto"><strong>Guia</strong></td>
                  </tr>
                  <% While (NOT rsContenido.EOF) %>
                  <tr>
                    <td class="txtTexto"><%=(rsContenido.Fields.Item("cnt_detalle").Value)%></td>
                    <td class="txtTexto"><strong><%=(rsContenido.Fields.Item("cnt_cantidad").Value)%></strong></td>
                    <td class="txtTexto"><%=(rsContenido.Fields.Item("cnt_nrogui").Value)%></td>
                  </tr>
                  <% 
					  rsContenido.MoveNext()
					Wend
					%>
                </table></td>
              </tr>
              <tr>
                <td colspan="4" class="titulos style1">
				<% If not isnull(DetMan.Fields.Item("fechaanulacion").Value)=true Then %>
				Esta guia fue anulada en <%=(DetMan.Fields.Item("fechaanulacion").Value)%>
				<% End If %>				</td>
              </tr>
            </table>
            <hr size="1" noshade>


 </td>
        </tr>
        
        <tr>
          <td> <span class="btnAccion">Status</span><span class="titulos"><span class="txtTextoI"> <%=(DetMan.Fields.Item("crt_descripcion").Value)%></span> </span> 
            <table border="0" cellpadding="3" cellspacing="0" class="reciboSMALLCAP">
              <tr bgcolor="#CCCCCC" class="titulos2"> 
                <td width="105" class="txtTexto"><strong>fecha real</strong></td>
                <td width="96" class="txtTexto"><strong>Estado</strong></td>
                <td width="27" class="txtTexto"><strong>comentarios</strong></td>
              </tr>
              <% While ((Repeat1__numRows <> 0) AND (NOT staguia.EOF)) %>
              <tr class="trs2"> 
                <td class="txtTexto"><%=(staguia.Fields.Item("fecreal").Value)%></td>
                <td class="txtTexto"><%=(staguia.Fields.Item("descri").Value)%></td>
                <td class="txtTexto"><%=(staguia.Fields.Item("comentarios").Value)%></td>
              </tr>
              <% 
  Repeat1__index=Repeat1__index+1
  Repeat1__numRows=Repeat1__numRows-1
  staguia.MoveNext()
Wend
%>
            </table> </td>
        </tr>
      </table>
	  
<!--#include file="footer.asp"-->
	  
<%
DetMan.Close()
Set DetMan = Nothing
%>
<%
staguia.Close()
Set staguia = Nothing
%>
<%
rsPaqAdjuntos.Close()
Set rsPaqAdjuntos = Nothing
%>
<%
rsContenido.Close()
Set rsContenido = Nothing
%>
