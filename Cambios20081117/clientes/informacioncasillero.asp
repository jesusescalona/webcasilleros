<%@LANGUAGE="VBSCRIPT" CODEPAGE="1252"%>
<!--#include file="../../Connections/CPV.asp" -->
<!--#include file="validar.asp" -->
<%
Dim rsInformacion__tmpId
rsInformacion__tmpId = "0"
If (session("cas_casillero_id") <> "") Then 
  rsInformacion__tmpId = session("cas_casillero_id")
End If
%>
<%
Dim rsInformacion
Dim rsInformacion_numRows

Set rsInformacion = Server.CreateObject("ADODB.Recordset")
rsInformacion.ActiveConnection = MM_CPV_STRING
rsInformacion.Source = "select *,ciudades.nombre as ciudad from casilleros inner join ciudades on cas_ciudad_id=id_ciudad where cas_casillero_id=" + Replace(rsInformacion__tmpId, "'", "''") + ""
rsInformacion.CursorType = 0
rsInformacion.CursorLocation = 2
rsInformacion.LockType = 1
rsInformacion.Open()

rsInformacion_numRows = 0
%>
<%
Dim Repeat1__numRows
Dim Repeat1__index

Repeat1__numRows = -1
Repeat1__index = 0
rsAutorizados_numRows = rsAutorizados_numRows + Repeat1__numRows
%>
 
 
 <!--#include file="header.asp"-->
	
	<script language="javascript">

function fp(URL)
{
    var winl = (screen.width - 400) / 2;
    var wint = (screen.height - 400) / 2;
	
	window.open(URL,"cityPopUp","width=400,height=400,top=" + wint + ",left=" + winl + ",scrollbars=no,toolbar=no,resizable=yes");
}

</script>

	
	<table width="100%" border="0" cellpadding="2" cellspacing="0" class="titulos2">
      <tr bgcolor="#CCCCCC">
        <td colspan="3" class="txtTexto"><strong>Informacion Personal </strong></td>
        <td class="txtTexto"></div></td>
      </tr>
      <tr class="trs2">
        <td class="txtTexto"><div align="right"><strong>Casillero:</strong></div></td>
        <td class="txtTexto"><%=(rsInformacion.Fields.Item("cas_alias").Value)%></td>
        <td class="txtTexto"><div align="right"></div></td>
        <td class="txtTexto">&nbsp;</td>
      </tr>
      <tr class="trs2">
        <td class="txtTexto"><div align="right"><strong>Nombre:</strong></div></td>
        <td class="txtTexto"><%=(rsInformacion.Fields.Item("cas_nombre").Value)%></td>
        <td class="txtTexto"><div align="right"><strong>Empresa:</strong></div></td>
        <td class="txtTexto"><%=(rsInformacion.Fields.Item("cas_empresa").Value)%></td>
      </tr>
      <tr class="trs2">
        <td class="txtTexto"><div align="right"><strong>Direccion</strong></div></td>
        <td class="txtTexto"><%=(rsInformacion.Fields.Item("cas_direccion").Value)%></td>
        <td class="txtTexto"><div align="right"><strong>CIudad:</strong></div></td>
        <td class="txtTexto"><%=(rsInformacion.Fields.Item("ciudad").Value)%></td>
      </tr>
      <tr class="trs2">
        <td nowrap class="txtTexto"><div align="right"></div></td>
        <td class="txtTexto">&nbsp;</td>
        <td class="txtTexto">&nbsp;</td>
        <td class="txtTexto">&nbsp;</td>
      </tr>
      <tr class="trs2">
        <td class="txtTexto"><div align="right"><strong>telefono:</strong></div></td>
        <td class="txtTexto"><%=(rsInformacion.Fields.Item("cas_telefono").Value)%></td>
        <td class="txtTexto"><div align="right"><strong>Fax:</strong></div></td>
        <td class="txtTexto"><%=(rsInformacion.Fields.Item("cas_fax").Value)%></td>
      </tr>
      <tr class="trs2">
        <td class="txtTexto"><div align="right"><strong>Email:</strong></div></td>
        <td class="txtTexto"><%=(rsInformacion.Fields.Item("cas_email").Value)%></td>
        <td class="txtTexto"><div align="right"></div></td>
        <td class="txtTexto">&nbsp;</td>
      </tr>
      <tr class="trs2">
        <td colspan="4" class="txtTexto"><div align="center"><a href="javascript:fp('editarcasilleros.asp?id=<%=(rsInformacion.Fields.Item("cas_casillero_id").Value)%>');" class="txtTextoI">Editar Informacion
          personal</a></div></td>
        </tr>
    </table>
<br>    
    </td>
  </tr>
  <tr>
    <td>&nbsp;</td>
  <!--#include file="footer.asp"-->
  
<%
rsInformacion.Close()
Set rsInformacion = Nothing
%>