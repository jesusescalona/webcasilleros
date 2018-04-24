<%@ Language=VBScript %>
<% 
'option explicit 
Response.Expires = -1
Server.ScriptTimeout = 600
' All communication must be in UTF-8, including the response back from the request
Session.CodePage  = 65001

%>

<!--#include file="header.asp"-->
<!-- #include file="freeaspupload.asp" -->

<!--#include file="../../Connections/CPV.asp" -->

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
  
  'If (session("cas_casillero_id") <> "") Then
  If (REQUEST.Cookies("DATOS")("CAS_CASILLERO_ID") <> "") Then 
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
  
  Dim RsTemplate
  Dim RsTemplate_numRows
  
  Set RsTemplate = Server.CreateObject("ADODB.Recordset")
  RsTemplate.ActiveConnection = MM_CPV_STRING
  RsTemplate.Source = "SELECT TE_NAME,TE_SUBJECT,TE_BODY FROM template_emails WHERE TE_NAME='Creacion Prealertas' AND ISNULL(TE_DESABILITADO,0)=0"
  RsTemplate.CursorType = 0
  RsTemplate.CursorLocation = 2
  RsTemplate.LockType = 1
  RsTemplate.Open() 
  
  
  
  
function OutputForm()

%>
    <form name="frmSend" method="POST" enctype="multipart/form-data" accept-charset="utf-8" action="uploadTester.asp?save=1" onSubmit="return onSubmitForm();">
	<table width="600">
	
	
	<tr align="left">
		<td width="100">
			# Tracking:
		</td>
		
		<td width="200">
			<input type="text" name="tracking">
		</td>
		<td width="250">
			Compa&ntilde;ia courier:
		</td>
		<td>
			<input type="text" name="company">
		</td>
		<TD rowspan="5">&nbsp;&nbsp;</TD>
		<td  rowspan="5" nowrap="nowrap" >Toda la informaci&oacute;n debe estar <br />diligenciada y la factura anexada<br /> para que el prealerta sea creada.<br />La informaci&oacute;n contenida en este prealerta <br /> es responsabilidad &uacute;nica de quien la<br />Introduce.<br />El valor declarado sera usado para<br />efectos de impuestos de entrada al <br /> pais y para el seguro de su paquete.</td>
	</tr>
	
	<tr>
		<td width="200">
			Proveedor:
		</td>
		<td width="200">
			<input type="text" name="provider">
		</td>
		<td width="250">
			Contenido:
		</td>
		<td>
			<input type="text" name="content">
		</td>
	</tr>
	
	<tr>
		<td width="200">
			Valor declarado:
		</td>
		<td width="200">
			<input type="text" name="value">
		</td>
		<td width="250">
		</td>
		<td>
		</td>
	</tr>
	
	
	</table>
	
	<font color="#FF3300">Adjuntar Factura:</font><br>
	<input name="attach1" type="file" size=35><br>
	
	<!--<B>File names:</B><br>
	
    File 1: <input name="attach1" type="file" size=35><br>-->
    <!--File 2: <input name="attach2" type="file" size=35><br>
    File 3: <input name="attach3" type="file" size=35><br>
    File 4: <input name="attach4" type="file" size=35><br>-->
    <br> 
	<!-- These input elements are obviously optional and just included here for demonstration purposes -->
	<!--<B>Additional fields (demo):</B><br>
	Enter a tracking: <input type="text" name="tracking"><br>
    Enter a company: <input type="text" name="company"><br>
	Enter a provider: <input type="text" name="provider"><br>
	Enter a content: <input type="text" name="content"><br>
	Enter a declared value: <input type="text" name="value"><br>
	<!-- End of additional elements -->
    <input style="margin-top:4" type=submit value="Guardar prealerta">
	
    </form>
<%
end function

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
	
	' If something fails inside the script, but the exception is handled
	'If Err.Number<>0 then Exit function

    SaveFiles = ""
    ks = Upload.UploadedFiles.keys
    if (UBound(ks) <> -1) then
        SaveFiles = "<B><font color=""red"">SU PREALERTA HA SIDO CREADA SATISFACTORIAMENTE, USTED RECIBIRA UN EMAIL DE CONFIRMACION, SI DESEA VERIFICAR LA INFORMACION DE SU PREALERTA POR FAVOR INGRESE A SU CASILLERO POSTAL EN LA SECCION DE 'CONSULTAR PREALERTAS'</font></B> <br>"
		
		  dim body1,MyMail,FROM_EMAIL,Te_subject,email,REPLY_TO,SMTP_SERVER,SUBJECT,USERNAME,PASSWORD,PORT,img
		  body1=""	 
		  Te_subject=""
		  email=""%>
		 <!-- #include file="../../SMTPinfo.asp"-->
        <%for each fileKey in Upload.UploadedFiles.keys
            'SaveFiles = SaveFiles & Upload.UploadedFiles(fileKey).FileName & " (" & Upload.UploadedFiles(fileKey).Length & "B) "
			query="insert into prealertas(pre_tracking, pre_transportadora, pre_proveedor, pre_contenido, pre_valdec, pre_factura, pre_activa, pre_casillero) values "
			query=query & "('" & Upload.Form("tracking") & "', '" & Upload.Form("company") & "', '" & Upload.Form("provider") & "', '" & Upload.Form("content") & "', '"
			query=query & Upload.Form("value") & "', '" & Upload.UploadedFiles(fileKey).FileName & "', 1, '" & casillero & "')"
			'response.write("archivo:" & Upload.UploadedFiles(fileKey).FileName & "<br>Consulta:" & query) 
			Dim FSO, Fich , NombreAnterior, NombreNuevo 
			
			if Upload.Form("tracking") <> "" and Upload.Form("company") <> "" and Upload.Form("provider") <> "" and Upload.Form("content") <> "" and Upload.Form("tracking") <> "" and  Upload.Form("value") <> "" and casillero <>"" then
			Set MM_editCmd = Server.CreateObject("ADODB.Command")
			MM_editCmd.ActiveConnection = MM_CPV_STRING
			MM_editCmd.CommandText = query
			MM_editCmd.Execute
			MM_editCmd.ActiveConnection.Close
			
			'--------EN EL SIGUIENTE BLOQUE SE RENOMBRA EL ARCHIVO SUBIDO CONCATENANDO EL TRACKING Y QUITANDO ESPACIOS Y COMILLAS--------------------------------
			
			'Inicializacin
			NombreAnterior =Upload.UploadedFiles(fileKey).FileName   
			NombreNuevo =Upload.Form("tracking") & Upload.UploadedFiles(fileKey).FileName     
			NombreNuevo =replace(NombreNuevo, "'", "")
			NombreNuevo =replace(NombreNuevo, " ", "")
			NombreNuevo =replace(NombreNuevo, "#", "")
			
		  ' Instanciamos el objeto
		   Set FSO = Server.CreateObject("Scripting.FileSystemObject") 
		   ' Asignamos el fichero a renombrar a la variable fich
		   Set Fich = FSO.GetFile(Server.MapPath("facturas\" & NombreAnterior)) 
		   ' llamamos a la funcion copiar, 
		   'y duplicamos el archivo pero con otro nombre
		   Call Fich.Copy(Server.MapPath("facturas\" & NombreNuevo)) 
			' finalmente borramos el fichero original
		   Call Fich.Delete() 
			
		   Set Fich = Nothing 
		   Set FSO = Nothing 
		   guardado=true
		   
		    
		 
		 
		  
		   
		   IF NOT RsTemplate.EOF THEN
			
			body1=RsTemplate.Fields.Item("TE_BODY").value
			 email=rsInformacion.Fields.Item("cas_email").value
				
			 body1=replace(body1,"@casillero",ucase(casillero))
			 body1=replace(body1,"@NumeroRastreo",ucase(Upload.Form("tracking")))
			 body1=replace(body1,"@nombre_casillero",ucase(rsInformacion.Fields.Item("cas_nombre").value))
			 body1=replace(body1,"@proveedor",Upload.Form("provider"))
			 body1=replace(body1,"@compania",Upload.Form("company"))
			 body1=replace(body1,"@contenido",Upload.Form("content"))
			 body1=replace(body1,"@valordeclarado",Upload.Form("value"))
			  
			 if trim(lcase(Request.ServerVariables("SERVER_NAME")))="dev.controlbox.net" then
				   img="http://dev.controlbox.net:8888/zai/webcasilleros/clientes/facturas/"  & NombreNuevo & ""
				  else
				   if trim(lcase(Request.ServerVariables("SERVER_NAME")))="stg3.controlbox.net" then
				    img="http://stg3.controlbox.net/zaicargo/webcasilleros/clientes/facturas/" & NombreNuevo & ""
				   else
				    img="http://zaicargo.controlbox.net/webcasilleros/clientes/facturas/" & NombreNuevo & ""
				   end if
				end if
			 
			 
			 body1=replace(body1,"@archivo",img)
			 
			  
			
			Te_subject= RsTemplate.Fields.Item("TE_SUBJECT").value
			Te_subject=replace(Te_subject,"@NumeroRastreo",ucase(Upload.Form("tracking")))
			
			
			
    		    Set MyMail = CreateObject("cdo.message")
                MyMail.From = FROM_EMAIL 
                MyMail.To = email & ", zaibox@zaicargo.com"
                MyMail.Subject =Te_Subject

                
                	

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
			   
		   
		   
		   
		   
		   
		   
		   
		   
		   else
		   '--------SI NO SE GUARD[O EN LA BASE DE DATOS ENTONCES BORRAMOS EL ARCHIVO FISICO
		   NombreNuevo =Upload.UploadedFiles(fileKey).FileName
		   'response.write("el nombre nuevo es " & NombreNuevo)
		   Set FSO = Server.CreateObject("Scripting.FileSystemObject") 
		   ' Asignamos el fichero a renombrar a la variable fich
		   Set Fich = FSO.GetFile(Server.MapPath("facturas\" & NombreNuevo)) 
		   'borramos el fichero original
		   'Call Fich.Delete() 
			
		   Set Fich = Nothing 
		   Set FSO = Nothing 
		   
		   guardado=false
		   
		   end if '158
		   '------------------------------------------------------------------------------------------------------------------------------------------------------
		   'SE ADICIONO EL COMENTARIO QUE SE SOLICITO y se muestra lo que se guarda VLO-816-77882
        next
		if guardado=true then
		SaveFiles = SaveFiles & "<br>Tracking = " & Upload.Form("tracking") & "<br>"
		SaveFiles = SaveFiles & "Compa&ntilde;ia = " & Upload.Form("company") & "<br>"
		SaveFiles = SaveFiles & "Proveedor = " & Upload.Form("provider") & "<br>"
		SaveFiles = SaveFiles & "Contenido = " & Upload.Form("content") & "<br>"
		SaveFiles = SaveFiles & "Valor = " & Upload.Form("value") & "<br>"
		SaveFiles = SaveFiles & "Factura = " &NombreAnterior & "<br>"
		
		else
		 SaveFiles = "<font color=""red"">SU PREALERTA NO HA SIDO GUARDADA SATISFACTORIAMENTE, ABAJO MOSTRAMOS EL CAMPO QUE FALTO DILIGENCIAR. POR FAVOR CORRIJA E INTENTELO DE NUEVO  <br></font>"
		if Upload.Form("tracking") <> "" then response.Write("") else SaveFiles = SaveFiles & "<br>Tracking = " & Upload.Form("tracking") & "<br>" end if
		
		if Upload.Form("company") <> "" then response.Write( "") else SaveFiles = SaveFiles & "Compa&ntilde;ia = " & Upload.Form("company") & "<br>" end if
		
		if Upload.Form("provider")  <> "" then response.Write( "") else SaveFiles = SaveFiles & "Proveedor = " & Upload.Form("provider") & "<br>" end if
		
		if Upload.Form("content") <> "" then response.Write( "") else SaveFiles = SaveFiles & "Contenido = " & Upload.Form("content") & "<br>" end if
		
		if Upload.Form("value")  <> "" then response.Write( "") else SaveFiles = SaveFiles & "Valor = " & Upload.Form("value") & "<br>" end if
		
		if NombreNuevo <> "" then response.Write( "") else SaveFiles = SaveFiles & "Factura = " &NombreNuevo & "<br>" end if
				
		end if
    else
        SaveFiles = "<font color=""red"">SU PREALERTA NO HA SIDO GUARDADA SATISFACTORIAMENTE, ABAJO MOSTRAMOS EL CAMPO QUE FALTO DILIGENCIAR. POR FAVOR CORRIJA E INTENTELO DE NUEVO  <br></font>"
		if Upload.Form("tracking") <> "" then response.Write("") else SaveFiles = SaveFiles & "<br>Tracking = " & Upload.Form("tracking") & "<br>" end if
	
		if Upload.Form("company") <> "" then response.Write("") else SaveFiles = SaveFiles & "Compa&ntilde;ia = " & Upload.Form("company") & "<br>" end if
		
		if Upload.Form("provider")  <> "" then response.Write("") else SaveFiles = SaveFiles & "Proveedor = " & Upload.Form("provider") & "<br>" end if
		
		if Upload.Form("content") <> "" then response.Write("") else SaveFiles = SaveFiles & "Contenido = " & Upload.Form("content") & "<br>" end if
		
		if Upload.Form("value")  <> "" then response.Write("") else SaveFiles = SaveFiles & "Valor = " & Upload.Form("value") & "<br>" end if
		
		if NombreNuevo <> "" then response.Write("") else SaveFiles = SaveFiles & "Factura = " &NombreNuevo & "<br>" end if
				
		
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

</HEAD>

<BODY>
<div><font size="+2"><%=casillero%></font></div>
<br>
<div  style="font-size:16"><font color="#CC6600" >Prealerta de paquete </font></div><br />
	  <div style=" color:#FF0000;font-size:16">
			Este men&uacute; solo aplica para caja individual, no para consolidar varias cajas, si desea unir sus env&iacute;os<br /> 
			por favor dir&iacute;jase al men&uacute; "Consolidaci&oacute;n de Cajas".
			</div>
			<div style="border-bottom: #A91905 2px solid;font-size:16">Ingrese la informaci&oacute;n solicitada para prealertar el paquete que usted ha comprado, por favor ingrese<br />
			La informaci&oacute;n completa,n&uacute;mero de rastreo  (Tracking #) exactamente igual como fue proporcionado a usted.</div>
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

<!-- Please support this free script by having a link to freeaspupload.net either in this page or somewhere else in your site. -->
<div style="border-bottom: #A91905 2px solid;font-size:10" align="center">Powered by <A HREF="http://www.controlbox.net/" style="color:black">ControlBox</A></div>


<br><br>

<!--#include file="footer.asp"-->

</BODY>
</HTML>
