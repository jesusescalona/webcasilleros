<%@ Language=VBScript %>
<% 
'option explicit 
Response.Expires = -1
Server.ScriptTimeout = 600
' All communication must be in UTF-8, including the response back from the request
Session.CodePage  = 65001

%>


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
  uploadsDirVar = Server.MapPath("archivos\")
  guardar=request.QueryString("save")
  numero_guia=request.QueryString("numeroguia")
  
  If (session("cas_casillero_id") <> "") Then 
  rsInformacion__tmpId = session("cas_casillero_id")
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
    <form name="frmSend" method="POST" enctype="multipart/form-data" accept-charset="utf-8" action="uploadarchivo.asp?save=1&numeroguia=<%=request.QueryString("i")%>" onSubmit="return onSubmitForm();">
	<table width="600">
	
	
	<tr align="left">
		
		
	</tr>
	
	
	
	<tr>
		
		
		<td width="250">
		</td>
		<td>
		</td>
	</tr>
	
	
	</table>
	
	<font color="#FF3300">Adjuntar Archivo:</font><br>
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
    <input style="margin-top:4" type=submit value="Cargar">
	<td>
	<button class="botones" onClick="javascript:window.close();">Cerrar</button>
	</td>
	
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


'response.End()
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
        SaveFiles = ""
		
		 
		  
		  
		  
		  %>
		
        <%for each fileKey in Upload.UploadedFiles.keys
		
            'SaveFiles = SaveFiles & Upload.UploadedFiles(fileKey).FileName & " (" & Upload.UploadedFiles(fileKey).Length & "B) "
			query="update guias_ingreso set gin_arc_path ='" & Upload.UploadedFiles(fileKey).FileName & "' where gin_guia ='"&numero_guia&"'"
			'response.write("archivo:" & Upload.UploadedFiles(fileKey).FileName & "<br>Consulta:" & query) 
			
			
			
			Dim FSO, Fich , NombreAnterior, NombreNuevo 
			
			
			Set MM_editCmd = Server.CreateObject("ADODB.Command")
			MM_editCmd.ActiveConnection = MM_CPV_STRING
			MM_editCmd.CommandText = query
			MM_editCmd.Execute
			MM_editCmd.ActiveConnection.Close
			
			'--------EN EL SIGUIENTE BLOQUE SE RENOMBRA EL ARCHIVO SUBIDO CONCATENANDO EL TRACKING Y QUITANDO ESPACIOS Y COMILLAS--------------------------------
			
			'Inicializacin
			NombreAnterior =Upload.UploadedFiles(fileKey).FileName   
			NombreNuevo =numero_guia & Upload.UploadedFiles(fileKey).FileName     
			NombreNuevo =replace(NombreNuevo, "'", "")
			NombreNuevo =replace(NombreNuevo, " ", "")
			NombreNuevo =replace(NombreNuevo, "#", "")
			
		  ' Instanciamos el objeto
		   Set FSO = Server.CreateObject("Scripting.FileSystemObject") 
		   ' Asignamos el fichero a renombrar a la variable fich
		   Set Fich = FSO.GetFile(Server.MapPath("archivos\" & NombreAnterior)) 
		   ' llamamos a la funcion copiar, 
		   'y duplicamos el archivo pero con otro nombre
		   Call Fich.Copy(Server.MapPath("archivos\" & NombreNuevo)) 
			' finalmente borramos el fichero original
		   Call Fich.Delete() 
			
		   Set Fich = Nothing 
		   Set FSO = Nothing 
		   guardado=true
		   
				 
			  
			 if trim(lcase(Request.ServerVariables("SERVER_NAME")))="dev.controlbox.net" then
				   img="http://dev.controlbox.net:8888/zai/webcasilleros/clientes/archivos/"  & NombreNuevo & ""
				  else
				   if trim(lcase(Request.ServerVariables("SERVER_NAME")))="stg1.controlbox.net" then
				    img="http://stg1.controlbox.net/zai/webcasilleros/clientes/archivos/" & NombreNuevo & ""
				   else
				    img="http://zaicargo.controlbox.net/webcasilleros/clientes/archivos/" & NombreNuevo & ""
				   end if
				end if
			 
			     
			   
		   
		   
		   
		  
		   '------------------------------------------------------------------------------------------------------------------------------------------------------
		   'SE ADICIONO EL COMENTARIO QUE SE SOLICITO y se muestra lo que se guarda VLO-816-77882
        next
		if guardado=true then
		SaveFiles = SaveFiles & "El archivo se subio correctamente <br>" &NombreAnterior & "<br>"
		
		else
		 SaveFiles = ""
		
		if NombreNuevo <> "" then response.Write( "") else SaveFiles = SaveFiles & "archivo = " &NombreNuevo & "<br>" end if
				
		end if
    else
        SaveFiles = ""
		
		if NombreNuevo <> "" then response.Write("") else SaveFiles = SaveFiles & "archivo = " &NombreNuevo & "<br>" end if
				
		
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


<%
Dim diagnostics
if Request.ServerVariables("REQUEST_METHOD") <> "POST" then
    diagnostics = TestEnvironment()
    if diagnostics<>"" then
        response.write "<div style=""margin-left:5; margin-top:30; margin-right:30; margin-bottom:30;"">"
        response.write diagnostics
        response.write "<p>Despues de corregir, cargue nuevamente la pagina."
        response.write "</div>"
    else
        response.write "<div style=""margin-left:5"">"
        OutputForm()
        response.write "</div>"
    end if
else
    response.write "<div style=""margin-left:5"">"
    OutputForm()
    response.write SaveFiles()
    response.write "<br><br></div>"
end if

%>



<!-- Please support this free script by having a link to freeaspupload.net either in this page or somewhere else in your site. -->
<div style="border-bottom: #A91905 2px solid;font-size:10" align="center">Powered by <A HREF="http://www.controlbox.net/" style="color:black">ControlBox</A></div>


<br><br>



</BODY>
</HTML>
