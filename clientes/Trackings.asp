<%@ Language=VBScript %>
<%
Session.Timeout=500
%>
<% 
'option explicit 
Response.Expires = -1
Server.ScriptTimeout = 600
' All communication must be in UTF-8, including the response back from the request
Session.CodePage  = 65001

%>
<!-- #include file="freeaspupload.asp" -->
<!--#include file="../../Connections/CPV.asp" -->


<script language="JavaScript">


function fP(URL)
{
	window.open(URL,"wPAQ","width=400,height=300,scrollbars=no,toolbar=no,resizable=no");
}
</script>

<%
Dim MM_editCmd
  Dim guardado
  Dim guardar 
  Dim uploadsDirVar
  Dim rsInformacion__tmpId
  Dim casillero
  casillero=""
  uploadsDirVar = Server.MapPath("facturas\")
  guardar=request.QueryString("save")
  
  If (REQUEST.Cookies("DATOS")("CAS_CASILLERO_ID") <> "") then '(session("cas_casillero_id") <> "") Then 
	  rsInformacion__tmpId = REQUEST.Cookies("DATOS")("CAS_CASILLERO_ID") 'session("cas_casillero_id")
	  Dim rsInformacion
	  Dim rsInformacion_numRows
	  
	  Set rsInformacion = Server.CreateObject("ADODB.Recordset")
	  rsInformacion.ActiveConnection = MM_CPV_STRING
	  rsInformacion.Source = "select *,ciudades.nombre as ciudad from casilleros inner join ciudades on cas_ciudad_id=id_ciudad where cas_casillero_id=" + Replace(    rsInformacion__tmpId, "'", "''") + ""
	  rsInformacion.CursorType = 0
	  rsInformacion.CursorLocation = 2
	  rsInformacion.LockType = 1
	  rsInformacion.Open() 
	  casillero=rsInformacion.Fields.Item("cas_casillero").Value
  else
	  response.write("Sesion expirada")
  end if
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
sql = "SELECT * from guias_ingreso with (nolock)  where gin_casillero in (select cas_casillero from casilleros where cas_casillero_id=" & REQUEST.Cookies("DATOS")("CAS_CASILLERO_ID") & ") and gin_guia not in (select nrogui from manifiesto where isnull(wr,0)=0) and gin_tracking_activado is null order by gin_fecha desc"
Dim detalleguias
Dim detalleguias_numRows

Set detalleguias = Server.CreateObject("ADODB.Recordset")
detalleguias.ActiveConnection = MM_CPV_STRING
detalleguias.Source = sql 
detalleguias.CursorType = 0
detalleguias.CursorLocation = 2
'response.Write(sql)
detalleguias.LockType = 1
detalleguias.Open()
if not detalleguias.eof then 
fechacasillero=detalleguias.Fields.Item("gin_fecha").Value
else
fechacasillero=0
end if
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

<%
 Dim RsTemplate
  Dim RsTemplate_numRows
  
  Set RsTemplate = Server.CreateObject("ADODB.Recordset")
  RsTemplate.ActiveConnection = MM_CPV_STRING
  RsTemplate.Source = "SELECT TE_NAME,TE_SUBJECT,TE_BODY FROM template_emails WHERE TE_NAME='creacion consolidar' AND ISNULL(TE_DESABILITADO,0)=0"
  RsTemplate.CursorType = 0
  RsTemplate.CursorLocation = 2
  RsTemplate.LockType = 1
  RsTemplate.Open() 
%>

<%function OutputForm()

%>
<form name="frmSend" method="POST" enctype="multipart/form-data" accept-charset="utf-8" action="Trackings.asp?save=1" onSubmit="return onSubmitForm();">
           
           <br />
           <span class="btnAccion">Consolidaci&oacute;n de Cajas     </span><br />
		      <br />
			  
 <span>A continuaci&oacute;n enlistamos las cajas que han ingresado a su Casillero Postal y estan pendientes de su instrucci&oacute;n despacho, digite el valor a declarar y haga clic en las cajas que desee consolidar para nosotros realizar el proceso de uni&oacute;n y envi&oacute;. </span><br />
 <br />
 <span style="color:#FF0000" >Si despues de quince (15) dias calendario de la llegada de la primera caja usted no ha realizado este proceso de Consolidaci&oacute;n de Cajas, proseguiremos a unir las cajas existentes en su Casillero y despacharemos tomando las facturas como valores a declarar para seguro e impuestos.</span><br /><br />
 <span>La consolidaci&oacute;n la trabajamos bajo parametros l&oacute;gicos y realizables, nos reservamos el derecho de unir los paquetes en los casos en que la consolidaci&oacute;n no sea posible por excesos de peso, volumen u cualquier otra limitante.</span><br /><br />

			  
		      <table border="0" cellpadding="3" cellspacing="0" class="reciboSMALL">
                <tr bgcolor="#CCCCCC"> 
                  <td width="150" bgcolor="#3086BC" class="txtTextoJ"><strong>Numero de Guia </strong></td>
                  <td width="190" bgcolor="#3086BC" class="txtTextoJ"><strong>Ingreso Casillero Postal </strong></td>
                  <td width="150" bgcolor="#3086BC" class="txtTextoJ"><strong>Valor Declarado </strong></td>
				  <td width="150" bgcolor="#3086BC" class="txtTextoJ"><strong>Adjuntar Factura </strong></td>
				  <td width="130" bgcolor="#3086BC" class="txtTextoJ"><strong>Consolidar </strong></td>
				  
				  <td width="130" bgcolor="#3086BC" class="txtTextoJ"><strong>Observaciones </strong></td>
                </tr>
                <% While  NOT detalleguias.EOF%>
                <tr class="trs2"> 
                  <td nowrap class="txtTexto"> 
                    <%=ucase(detalleguias.Fields.Item("gin_guia").Value)%>  </td>
                  <td nowrap class="txtTexto"><%=(detalleguias.Fields.Item("gin_fecha").Value)%></td>				
				
				  <td nowrap="nowrap">
                  <input type="text" id="value_<%=replace((detalleguias.Fields.Item("gin_guia").Value),"_","*")%>" name="value_<%=replace((detalleguias.Fields.Item("gin_guia").Value),"_","*")%>" >				  </td>
				  
				  <!--<td nowrap="nowrap"><input name="attach1_<%'=(detalleguias.Fields.Item("gin_guia").Value)%>" id="attach1_<%'=(detalleguias.Fields.Item("gin_guia").Value)%>" type="file" size=35 />
				  <td>
				  -->
				  <td nowrap="nowrap">
					 <a href="javascript:fP('uploadarchivo.asp?i=<%=(detalleguias.Fields.Item("gin_guia").Value)%>');" class="button"><span><%= ("Agregar Archivo") %></span></a>				  </td>
			    </td>
				  <td nowrap="nowrap">
				  <input name="notificar_<%=replace((detalleguias.Fields.Item("gin_guia").Value),"_","*")%>" type="checkbox" id="notificar_<%=replace((detalleguias.Fields.Item("gin_guia").Value),"_","*")%>" tabindex="11" value="1"/>				  </td>
				  
				  
				  <td nowrap="nowrap">
                  <input type="text" id="comentarios_<%=replace((detalleguias.Fields.Item("gin_guia").Value),"_","*")%>" name="comentarios_<%=replace((detalleguias.Fields.Item("gin_guia").Value),"_","*")%>" >				  </td>
				  
				<!--  <td nowrap class="txtTexto"><%'=(detalleguias.Fields.Item("gin_peso").Value)%></td>-->
                 
                </tr>
                <%
			  ent="1" 
			  detalleguias.MoveNext()
			  Wend
			  %>
			   <br />
			   
			 
			  <%if ent<>"1" then %>
				<tr>
				 <td colspan="6" class="txtTexto">
				   <p>&nbsp;</p>
			      <p>No hay informacion disponible				  </p>
			      <p>&nbsp;</p></td>
			    </tr>
				<%end if%>
      </table>
       <br />
	   <input style="margin-top:4" type="submit" value="Consolidar">
	   <br />
	   <br />
	   <span>No desea consolidar o desea que una compra llegue rapidamente a sus manos?. Puede ingresar al menu de Prealerta Caja Individual y previamente a que su paquete llegue a Miami, diligenciar la informaci&oacute;n y asi su paquete o varios paquetes individuales, sean despachados inmediatamente lleguen a su Casillero Postal.</span>
	   <br />
	   <br />
    </form>
	   
	  	<%end function
	function TestEnvironment()
	
    Dim fso, fileName, testFile, streamTest
    TestEnvironment = ""
    Set fso = Server.CreateObject("Scripting.FileSystemObject")
    if not fso.FolderExists(uploadsDirVar) then
        TestEnvironment = "<B>La carpeta " & uploadsDirVar & " no existe.</B><br>"
        exit function
    end if
    fileName = uploadsDirVar & "\test.txt"
    'on error resume next
    Set testFile = fso.CreateTextFile(fileName, true)
    If Err.Number<>0 then
        TestEnvironment = "<B>La carpeta " & uploadsDirVar & " no tiene permisos de escritura o la ruta es incorrecta.</B><br>"
        exit function
    end if
    Err.Clear
    testFile.Close
    fso.DeleteFile(fileName)
    If Err.Number<>0 then
        TestEnvironment = "<B>La carpeta " & uploadsDirVar & " no tiene permisos de borrado y/o escritura"
        exit function
    end if
    Err.Clear
    Set streamTest = Server.CreateObject("ADODB.Stream")
    If Err.Number<>0 then
        TestEnvironment = "<B>The ADODB object <I>Stream</I> is not available in your server.</B><br>Check the Requirements page for information about upgrading your ADODB libraries."
        exit function
    end if
    Set streamTest = Nothing
end function

	function SaveFiles
	
    Dim Upload, fileName, fileSize, ks, i, fileKey
	Dim query
    Set Upload = New FreeASPUpload
	Dim guardarregistro
	
	'set guardarregistro=conn.execute(query)
	  
    Upload.Save(uploadsDirVar)
	
	 SaveFiles = ""
		
		actual = now()
		'Brayan Ramirez - concatenar segundos
		var2=replace(replace(FormatDateTime(Actual, 3),"AM",""),"PM","")
		var=Year(Date)&"-"&Month(Date)&"-"&Day(Date)&" "&var2
		
	
		
			for each x in Upload.Form1
	
	'response.write(x&"llllllllllllll")
	'response.End()
	
	if mid(x,1,9)="notificar" then ' es el campo texto
		'guia_todo=
		'debe sacar el id
		val=split(x,"_")
		guia = val(1)
		
		'response.write("<br>"&var&"guia")
	
	if isnumeric(Upload.Form("value_"& guia)) and Upload.Form("value_"& guia)<>"0"  then
	
		guiaoriginal=replace(guia,"*","_")
	

	
	
	query="update guias_ingreso set gin_valdec ='"& Upload.Form("value_"& guia) & "' , gin_comentarios = '"&Upload.Form("comentarios_"& guia)&"' ,gin_tracking_activado = '"&var&"' where gin_guia ='"&guiaoriginal&"'"
	
	'response.Write(query & "0	")
'	response.End()
	
	
	
	
	Set MM_editCmd = Server.CreateObject("ADODB.Command")
			MM_editCmd.ActiveConnection = MM_CPV_STRING
			MM_editCmd.CommandText = query
			MM_editCmd.Execute
			MM_editCmd.ActiveConnection.Close
			
	else
	SaveFiles = "<br /><B><font color=""red"">SU ORDEN DE CONSOLIDACION NO HA SIDO GUARDADA SATISFACTORIAMENTE, ARRIBA MOSTRAMOS EL CAMPO QUE FALTO DILIGENCIAR. POR FAVOR CORRIJA E INTENTELO DE NUEVO.</font></B> <br> <br>"
	
	response.Write("<font color=""red""> Falta Valor Declarado de Numero de Guia:</font>" & guia &"<br />")
			
	
	end if
	
	
	end if
			
	
	
	Next
	' If something fails inside the script, but the exception is handled
	'If Err.Number<>0 then Exit function
		
   
    ks = Upload.UploadedFiles.keys
	
    if isnumeric(Upload.Form("value_"& guia)) and Upload.Form("value_"& guia)<>"0"  then
	
	  
		SaveFiles = "<B><font color=""red"">SU ORDEN DE CONSOLIDACION HA SIDO CREADA SATISFACTORIAMENTE, USTED RECIBIRA UN EMAIL DE CONFIRMACION.'</font></B> <br>"
		  dim body1,MyMail,FROM_EMAIL,Te_subject,email,REPLY_TO,SMTP_SERVER,SUBJECT,USERNAME,PASSWORD,PORT,img
		  body1=""	 
		  Te_subject=""
		  email=""%>
		 <!-- #include file="../../SMTPinfo.asp"-->
		
        <%'for each fileKey in Upload.UploadedFiles.keys
            'response.Write("VAMggg" & guia)
			Dim FSO, Fich , NombreAnterior, NombreNuevo 
			 
			 
			 para_guias=""
			 para_guias="<table width=""500"" border=""0"" cellpadding=""3"" cellspacing=""0"" class=""letras""><tr><td class=""trs"">Numero de Guia</td><td class=""trs"">Ingreso Casillero Postal</td><td class=""trs"">Valor Declarado</td></tr>"
			for each x in Upload.Form1
			'response.write(x)
			if mid(x,1,9)="notificar" then ' es el campo texto
		'debe sacar el id
			val=split(x,"_")
			guia = val(1)
			para_guias=para_guias&"<tr><td>" & guia & "</td><td>" & (ucase(fechacasillero)) & "</td><td>" & (Upload.Form("value_"& guia)) & "</td></tr>"
			 			 
			 end if
			 next
		  
		   IF NOT RsTemplate.EOF THEN
		    'response.Write("CASILEROOOOOO" & ucase(casillero))
	         body1=RsTemplate.Fields.Item("TE_BODY").value
			 email=rsInformacion.Fields.Item("cas_email").value
				
			 body1=replace(body1,"@casillero",ucase(casillero))
			 'body1=replace(body1,"@Numeroguia",guia)
			 body1=replace(body1,"@para_guias",para_guias)
			 body1=replace(body1,"@nombre_casillero",ucase(rsInformacion.Fields.Item("cas_nombre").value))
			 'body1=replace(body1,"@fechacas",ucase(fechacasillero))
			' body1=replace(body1,"@valordeclarado",(Upload.Form("value_"& guia)))
			  
			 if trim(lcase(Request.ServerVariables("SERVER_NAME")))="dev.controlbox.net" then
				   img="http://dev.controlbox.net:8888/zai/webcasilleros/clientes/facturas/"  & NombreNuevo & ""
				  else
				   if trim(lcase(Request.ServerVariables("SERVER_NAME")))="stg1.controlbox.net" then
				    img="http://stg1.controlbox.net/zai/webcasilleros/clientes/facturas/" & NombreNuevo & ""
				   else
				    img="http://zaicargo.controlbox.net/webcasilleros/clientes/facturas/" & NombreNuevo & ""
				   end if
				end if
			 
			 
			 body1=replace(body1,"@archivo",img)
			 
			  
			
			Te_subject= RsTemplate.Fields.Item("TE_SUBJECT").value
			Te_subject=replace(Te_subject,"@casillero",ucase(casillero))
			
			
			
    		    Set MyMail = CreateObject("cdo.message")
                MyMail.From = FROM_EMAIL 
                MyMail.To = email
                MyMail.Subject =Te_Subject

                if REPLY_TO<>"" then MyMail.ReplyTo = REPLY_TO
                	

                MyMail.HTMLBody = body1

                MyMail.Configuration.Fields.Item("http://schemas.microsoft.com/cdo/configuration/sendusing") = 2
                MyMail.Configuration.Fields.Item("http://schemas.microsoft.com/cdo/configuration/smtpserver") = SMTP_SERVER
                MyMail.Configuration.Fields.Item("http://schemas.microsoft.com/cdo/configuration/sendusername") = USERNAME
                MyMail.Configuration.Fields.Item("http://schemas.microsoft.com/cdo/configuration/sendpassword") = PASSWORD
                MyMail.Configuration.Fields.Item("http://schemas.microsoft.com/cdo/configuration/smtpauthenticate") = 1
                MyMail.Configuration.Fields.Item("http://schemas.microsoft.com/cdo/configuration/smtpserverport") = PORT
                MyMail.Configuration.Fields.Update

                MyMail.Send
                
                if Err.Number<>0 then
                end if

                Set MyMail = nothing
		       end if
			   %>
			   <script language="javascript">
				window.setTimeout(Opentrack,6000)			 
				function Opentrack() 
				{
				location.href='trackings.asp';
				}									
				</script><%
			
    end if
	
end function



%>

<HTML>
<HEAD>
<TITLE>Prealerta de paquete</TITLE>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<style>
BODY {background-color: white;font-family:arial; font-size:12}
</style>

<script>
function onSubmitForm() {
    var formDOMObj = document.frmSend;
    if (formDOMObj.attach1.value == "" && formDOMObj.attach2.value == "" && formDOMObj.attach3.value == "" && formDOMObj.attach4.value == "" )
        alert("Por favor, seleccione un archivo.")
    else
        return true;
    return false;
}
</script>



<BODY>
<div><font size="+2"><%=casillero%></font></div>
<br>

<%
Dim diagnostics
if Request.ServerVariables("REQUEST_METHOD") <> "POST" then
    diagnostics = TestEnvironment()
    if diagnostics<>"" then
        response.write "<div style=""margin-left:20; margin-top:30; margin-right:30; margin-bottom:30;"">"
        response.write diagnostics
        response.write "<p>Despues de corregir, cargue nuevamente la pagina."
        response.write "</div>"
    else
        response.write "<div style=""margin-left:50"">"
        OutputForm()
        response.write "</div>"
    end if
else
    response.write "<div style=""margin-left:150"">"
    OutputForm()
    response.write SaveFiles()
    response.write "<br><br></div>"

	
	
	
	
end if


%>

<!--#include file="footer.asp"-->


<%
rsAgencias.Close()
Set rsAgencias = Nothing
%>

