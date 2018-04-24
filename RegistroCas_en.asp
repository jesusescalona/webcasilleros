<%@LANGUAGE="VBSCRIPT"%>
<!--#include file="../Connections/CPV.asp" -->
<!--#include file="../app/funciones/_db.asp" -->
<!--#include file="../app/funciones/email.asp" -->

<%
errores=""
emailBody=""
nombre=Trim(Request.Form("cas_nombre"))
direccion=Trim(Request.Form("cas_direccion"))
email=Trim(Request.Form("cas_email"))
cuenta=Trim(Request.Form("cas_agencia_id"))
ciudad=Trim(Request.Form("cas_ciudad_id"))
clave=Trim(Request.Form("cas_password"))
terminos=Trim(Request.Form("terminos"))
telefono=request.Form("cas_telefono")


if telefono<>"" and nombre<>"" and direccion<>"" and email<>"" and cuenta<>"" and ciudad<>"" and clave<>"" and terminos="1" then
'aqui va el llamado al stored procedure
dim conn
call open_conn()

txtSql= "crearCasillero " & _
"'" & request.Form("cas_nombre") & "'," & _
"'" & request.Form("cas_empresa") & "'," & _
"'" & request.Form("cas_direccion") & "'," & _
"'" & request.Form("cas_ciudad_id") & "'," & _
"'" & request.Form("cas_ciudad") & "'," & _
"'" & request.Form("cas_zip") & "'," & _
"'" & request.Form("cas_telefono") & "'," & _
"'" & request.Form("cas_fax") & "'," & _
"'" & request.Form("cas_email") & "'," & _
"'" & request.Form("cas_cuenta_id") & "'," & _
"'" & request.Form("cas_casillero") & "'," & _
"'" & request.Form("cas_ffw") & "'," & _
"'" & request.Form("cas_password") & "'," & _
"'" & request.Form("cas_alias") & "'," & _
"'" & request.Form("cas_agencia_id") & "'," & _
"'" & request.Form("cas_servicio") & "'," & _
"'" & request.Form("cas_pago") & "'"
	
set rs=conn.execute(txtSql)
if not rs.eof then
	link =  "www.zaicargo.com/casillero_postal"
	emailBody =  rs("cas_nombre") & _
	",<br>Thank you form create your postal box with us.<br>" & _
	"Remember that you can track your package on "  & _
	"&nbsp;<a href=""http://www.zaicargo.com/casillero_postal/ "" target=""_blank"" >" & link & " </a> <br>" & _
	"For more information, please cxontact us zaibox@zaicargo.com<br>" & _
	"Your account has been created with the following information:<br><br>" & _
	rs("cas_nombre") & "<br>" & _
	rs("cas_empresa") & "<br>" & _
	rs("cas_direccion") & "<br>" & _
	rs("cas_ciudad") & " " & "<br>" & _
	rs("cas_telefono") & "<br>" & _
	rs("cas_email") & "<br><br>NACCOUNT NUMBER<br>" & _
	rs("cas_alias") & "<br>PASSWORD: " & rs("cas_password") & "<br><br>" & _
	"Please verify this information." & "<br><br>" & _
	"so that their shipments arrive without problems so you must write your information this way: " & _
	"<br><br>" & _
	rs("cas_nombre") & "<br>" & _
	"6324 NW 97 Av." & "<br>" & _
	rs("cas_alias") & "<br>" & _
	"Doral, FL 33178 " & "<br><br><br>"

	emailBody = emailBody & "Thanks<br><br><br>ZAICARGO"

	emailFrom="zaibox@zaicargo.com"
	emailSubject="POSTAL BOX ZAICARGO"

	on error resume next
	
	emailTo=rs("cas_email")
	call f_email(emailSubject,emailTo,emailFrom,emailBody,"")
	
	if request.form("ccEmail")<>"" then
		emailTo=request.form("ccEmail")
		call f_email(emailSubject,emailTo,emailFrom,emailBody,"")
	end if

	'if request.form("ccEmail")<>"" and request.form("notificar")="1"then
	'	emailTo=rs("cas_email")
	'	call f_email(emailSubject,emailTo,emailFrom,emailBody,request.form("ccEmail"))
	'end if
	
	
	errores="The postal box was created successfully, " 
	if err<>0 then	errores=errores & err.description
	
else 'no encontro el casillero que creo
	errores="An error occurred trying to create the postal box"

end if



'fin llamado stored procedure
else
	if Trim(Request.Form("MM_insert"))="form1" then
		errores="Missing data to create the postal box! Please verify and try again"
	end if
End If %>
<%
Dim rsCiudad__tmpffw
rsCiudad__tmpffw = "00001"
If (request.cookies("ffw")  <> "") Then 
  rsCiudad__tmpffw = request.cookies("ffw") 
End If
%>
<%
Dim rsCiudad
Dim rsCiudad_numRows

Set rsCiudad = Server.CreateObject("ADODB.Recordset")
rsCiudad.ActiveConnection = MM_CPV_STRING
rsCiudad.Source = "SELECT id_ciudad,c.id_pais as id_pais,p.codigo as codPais,c.nombre as nomCiudad  FROM dbo.CIUDADES as c  inner join paises as p on  c.id_pais=p.id_pais  WHERE c.id_pais=9 and c.ffw='" + Replace(rsCiudad__tmpffw, "'", "''") + "'  ORDER BY c.nombre"
rsCiudad.CursorType = 0
rsCiudad.CursorLocation = 2
rsCiudad.LockType = 1
rsCiudad.Open()

rsCiudad_numRows = 0
%>
<%
Dim rsAgencias__tmpffw
rsAgencias__tmpffw = "00000"

If (request.cookies("ffw") <> "") Then 
  rsAgencias__tmpffw = request.cookies("ffw")
End If
%>
<%
Dim rsAgencias
Dim rsAgencias_numRows

Set rsAgencias = Server.CreateObject("ADODB.Recordset")
rsAgencias.ActiveConnection = MM_CPV_STRING
rsAgencias.Source = "SELECT *  FROM dbo.AGENCIAS  WHERE ffw='" + Replace(rsAgencias__tmpffw, "'", "''") + "'  ORDER BY nombre"
rsAgencias.CursorType = 0
rsAgencias.CursorLocation = 2
rsAgencias.LockType = 1
rsAgencias.Open()

rsAgencias_numRows = 0
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
<title>Zaicargo - Casillero Postal</title>
<link href="Imagenes_en/estilos.css" rel="stylesheet" type="text/css" />
<style type="text/css">
<!--
.style1 {
	font-size: 10px;
	font-family: Arial, Helvetica, sans-serif;
	color: #FFFFFF;
}
-->
</style>
</head>
<script language="javascript">

function fp(URL)
{
    var winl = (screen.width - 400) / 2;
    var wint = (screen.height - 400) / 2;
	
	window.open(URL,"cityPopUp","width=400,height=400,top=" + wint + ",left=" + winl + ",scrollbars=no,toolbar=no,resizable=yes");
}

</script>
<body>
<table width="800" border="0" cellspacing="0" cellpadding="0" align="center">
  <tr style="background:url(Imagenes_en/Gradiente_Cabecera_Z.png)">
    <td colspan="2" scope="col" height="97" valign="bottom">
      <div align="right" style="vertical-align:bottom">
	  <form action="http://zaicargo.controlbox.net/webcasilleros/clientes_en/login.asp" method="POST" name="frmaIngreso">
        <table width="100" border="0" cellspacing="0" cellpadding="0" align="right">
          <tr>
            <th scope="col" align="left"><span class="txtTextoI">User: </span></th>
            <th scope="col"><input name="usuario" type="text" class="txtCajas" size="8" /></th>
          </tr>
          <tr>
            <td align="left"><span class="txtTextoI">Password:</span></td>
            <td align="left"><input name="clave" type="password" class="txtCajas" size="8" /></td>
          </tr>
          <tr>
            <td colspan="2" align="right"><input name="Ingreso" type="submit" value="Login" class="btnAccion" /></td>
          </tr>
        </table>
		</form>
  </div><a href="http://www.zaicargo.com" target="_blank"><img src="Imagenes_en/Logo.png" alt="Zaicargo" width="205" height="60" border="0" /></a>
  </tr>
   <tr>
    <th colspan="2" scope="col"><img src="Imagenes_en/Division.png" alt="Head" width="800" height="1"  /></th>
  </tr>
  <tr>
    <th colspan="2" scope="col"><img src="Imagenes_en/Banner_Registro.jpg" alt="Casillero" width="800" height="250" /></th>
  </tr>
  <tr bgcolor="#3086BC">
    <td valign="top">
		<table width="200" border="0" cellspacing="0" cellpadding="0">
      		<tr>
        		<th scope="col"><a href="http://www.zaicargo.com/casillero_postal/english">Home</a></th>
      		</tr>
    	</table>
	</td>
	<td bgcolor="#3086BC" style="vertical-align:top">
		<table width="600" border="0" cellspacing="0" cellpadding="0" style="background:url(Imagenes_en/Body.jpg)" height="216">
			<tr valign="top">
        		<th scope="col"><img src="Imagenes_en/CabeceraRegistro.png" alt="Head" width="600" height="20" /></th>
      		</tr>
      		<tr>
       		  <th scope="col">
			  		   <form method="post" action="registrocas.asp" name="form1">
            <table width="501" border="0" align="center" cellpadding="3" cellspacing="0" class="titulos2">
              <tr valign="baseline" >
                <td colspan="4" align="right" nowrap><div align="left" class="reciboSMALLCAP">
                  <p class="style1"><span class="requeridos"><%=errores%><br />
                  </span><%=response.Write(emailBody)%></p><div class="txtTituloJ">All this information is private and protected).</div>
                </div></td>
              </tr>
              <tr valign="baseline" >
                <td colspan="4" align="right" nowrap bgcolor="#FEDA00"><div align="left" class="txtTextoNJ"><strong>Personal Information </strong></div></td>
              </tr>
              <tr valign="baseline">
                <td align="right" nowrap class="txtTextoJ"><div align="left" class="letras">Name and Last Name:<span class="requeridos">*</span></div></td>
                <td><div align="left">
                  <input name="cas_nombre" type="text" class="txtCajas" value="<%=request.form("cas_nombre")%>">                
                </div></td>
                <td class="txtTextoJ">Enterprise:</td>
                <td><div align="left">
                  <input name="cas_empresa" type="text" class="txtCajas" value="<%=request.form("cas_empresa")%>" />
                </div></td>
              </tr>
              <tr valign="baseline">
                <td align="right" nowrap class="txtTextoJ"><div align="left">Address:<span class="requeridos">*</span></div></td>
                <td><div align="left">
                  <input name="cas_direccion" type="text" class="txtCajas" value="<%=request.form("cas_direccion")%>">
                </div></td>
                <td class="txtTextoJ">
				<input type="button" onclick="javascript:fp('../app/ciudades7.asp');" value="State"></td>
                <td><div align="left"><span class="txtTextoJ"><span class="requeridos">
				<input type="hidden" name="cas_ciudad_id" value="<%=request("cas_ciudad_id")%>" />
                  <input name="nomciudad" type="text" class="txtCajas" value="<%=request("nomciudad")%>" readonly="True" />
                </span></span></div></td>
              </tr>
              <tr valign="baseline">
                <td align="right" nowrap class="txtTextoJ"><div align="left">Postal Code:</div></td>
                <td><div align="left">
                  <input name="cas_zip" type="text" class="txtCajas" value="<%=request.form("cas_zip")%>">
                </div></td>
                <td class="txtTextoJ">Email:<span class="requeridos">*</span></td>
                <td><div align="left">
                  <input name="cas_email" type="text" class="txtCajas" value="<%=request.form("cas_email")%>">
                </div></td>
              </tr>
              <tr valign="baseline">
                <td align="right" nowrap class="txtTextoJ"><div align="left">Phone:*</div></td>
                <td><div align="left">
                  <input name="cas_telefono" type="text" class="txtCajas" value="<%=request.form("cas_telefono")%>">                
                </div></td>
                <td class="txtTextoJ">Fax:</td>
                <td><div align="left">
                  <input name="cas_fax" type="text" class="txtCajas" value="<%=request.form("cas_fax")%>">
                </div></td>
              </tr>
              <tr valign="baseline">
                <td colspan="4" align="right" nowrap>					
				    <div align="left">
					  <input type="hidden" name="cas_cuenta_id" value="">
                      <input type="hidden" name="cas_agencia_id" value="00001">
                      <input name="cas_pago" type="hidden" id="cas_pago" value="agencia">
				      <input type="hidden" value="VE" name="cas_servicio" id="cas_servicio"/>
				    </div></td>
              </tr>
              <tr valign="baseline">
                <td colspan="4" align="right" nowrap class="requeridos">
				  <div align="left"></div></td>
              </tr>
              <tr valign="baseline" >
                <td colspan="4" align="right" nowrap bgcolor="#FEDA00"><div align="left" class="txtTextoNJ"><strong>Postal Box Information </strong></div></td>
              </tr>
              <tr valign="baseline">
                <td align="right" nowrap class="txtTextoJ"><div align="left" class="letras">Write your password:<span class="requeridos">*</span></div></td>
                <td colspan="3" class="txtTextoJ"><input name="cas_password" type="text" class="txtCajas">
                  <input name="cas_alias" type="hidden" class="boxesNoCase" value="" size="32">                <input name="ccEmail" type="hidden" class="txtCajas" id="ccEmail" /></td>
              </tr>
              <tr valign="baseline" >
                <td colspan="4" align="right" nowrap bgcolor="#FEDA00" class="boxesNoCase"><div align="left" class="txtTextoNJ"><strong>Terms and conditions</strong></div></td>
              </tr>
              <tr valign="baseline">
                <td colspan="4" align="right" nowrap><div align="center">
                  <textarea name="textarea" cols="50" rows="6" readonly="readonly" wrap="virtual">All that use the Zai Cargo Postal Box and make purchases through companies like Amazon.com - tigerdirect.com and others are under the following terms and conditions: 
1 - Zai Cargo is not responsible for any shipment received: 
A - With defects
B - Broken or damaged
C - Wrong 
D - Without proper information
2 - Zai Cargo won’t assume any kind of payment to third parties for goods that are received in our warehouses. 
3 - Zai Cargo is not responsible for any kind of fraudulent payments made by the goods we receive through the postal box. 
4 - All that accept to use Zai Cargo as transporter, agree to pay all costs for pound / insurance / taxes charged by the company or the country of destination.
5 – We’ll shipping only legal content in the origin and destination country to fulfill all the required customs rules. 

We cannot carry: 
A - Military Items. 
B - Flammable or explosives. 
C - Pollutants. 
D - Money or value titles. 
E - Aerosols. 
F - Items like "Glass" with inadequate packaging for its protection.

The international postal box service is about the allocation of an account number which entitles the subscriber to receive goods of any kind within the legal framework. Make the process of classification, inspection, documentation generation, transport, customs clearance and delivery. 

Once the service subscription is done will be assigned an account number with which you’ll be able to track your shipments online. 

Our company is committed to carry out customs formalities for goods and urgent shipping which include clearance, survey, release and delivery

If SUBSCRIBER supplies erroneous information about address or other items necessary for the proper and timely delivery, our company will not be responsible for this shipment and the subscriber will assume the extra expenses incurred for this error.

Freight rates may be changed without notice to adapt them to increases in cost of airline and / or any other commercial factor related with the service. The goods shall be SECURED to guarantee tranquility to the subscriber, the secure does not operate for damage or partial loss of merchandise, everything works if the package does not reach your destination. 

The goods must be received packaged for its shipment according to their characteristics, in order to preserve it, because the secure does not cover damage by improper packing. Subscriber after receiving the goods and sign in accordance loses the right to complain. We recommend opening the Merchandise and checking on presence of the Company personal. If the goods require special packaging is important to notify the Company for processing.
Subscriber is granted 03 days to remove the goods from the time of notification; otherwise the Company will charge the Storage and won’t be responsible for it.
When making purchases is necessary that the subscriber place his own name and address of Zai Cargo, with the aim that the order arrives at the office is added to the WEB site. The page where you can track your purchases is www.zaicargo.com.
Our company is not responsible for the bad routing of the goods to our offices; Subscriber understands that the goods must reach our offices by domestic companies. 
The addresses of receipt of the goods can be modified at any time alerting subscribers for necessary corrections, well in advance.
Subscriber acknowledges the administrative and legal restrictions may be subject to their shipments and will be responsible for everything that comes to his postal box. Our company will not be responsible for losses resulting from customs seizure, or delays caused by the lack of documentation or information required for the office or for processing customs. 
It is forbidden to transport: weapons, chemical precursors, jewelry, cash, pornography, war toys, lottery tickets and all those that prohibit the relevant authorities and treated as prohibited by the Universal Postal Union. 
Our company reserves the right to refuse or to withhold shipments to a subscriber whose account is in arrears. 
We reserve the right of admission and the Company has the autonomy to cancel accounts abandoned, inactive or having a history of fraud, misuse or abnormal use of it.

                  </textarea>
                </div></td>
              </tr>
              <tr valign="baseline">
                <td nowrap align="right">&nbsp;</td>
                <td colspan="3"><input name="terminos" type="checkbox" id="terminos" value="1">
                  <span class="txtTituloJ">I ACCEPT THE TERMS AND CONDITIONS</span> 
				  <%if Trim(Request.Form("terminos"))<>"" and Trim(Request.Form("AB"))="AB" then%>
                  <span class="letraserrores"><br>
                  </span><span class="txtTextoJ">You must accept the terms and conditions</span>				  
                  <% End If %>
				  <input name="AB" type="hidden" class="boxesNoCase" id="AB" value="AB" size="32"></td>
              </tr>
              <tr valign="baseline">
                <td nowrap align="right">&nbsp;</td>
                <td align="right"><input type="submit" class="botones" value="Accept"></td>
                <td>&nbsp;</td>
                <td>&nbsp;</td>
              </tr>
              <tr valign="baseline">
                <td colspan="4" align="right" nowrap>
				  <div align="left" class="reciboSMALLCAP">
                  <p>&nbsp;</p>
                  </div></td>
              </tr>
            </table>
              <input type="hidden" name="cas_ffw" value="00001" size="32">
            <input type="hidden" name="MM_insert" value="form1">
          </form>
				
				</th>
      		</tr>
    	</table>
	</td>
  </tr>
  <tr>
    <th colspan="2" scope="col"><img src="Imagenes_en/Division.png" alt="Head" width="800" height="1"  /></th>
  </tr>
  <tr>
    <td colspan="2"><img src="Imagenes_en/Footer.png" alt="Footer" width="800" height="30" /></td>
  </tr>
</table>
</body>
</html>
