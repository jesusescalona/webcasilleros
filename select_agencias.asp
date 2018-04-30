<select name="cas_agencia_id" class="reciboSMALLCAP" id="Select1" style="width : 100px">
	<%
	While (NOT rsAgencias.EOF)
		%>
		<option value="<%=(rsAgencias.Fields.Item("agencia_id").Value)%>"><%=(rsAgencias.Fields.Item("nombre").Value)%></option>
		<%
		rsAgencias.MoveNext()
	Wend
	If (rsAgencias.CursorType > 0) Then
		rsAgencias.MoveFirst
	Else
	rsAgencias.Requery
End If
%>
</select>