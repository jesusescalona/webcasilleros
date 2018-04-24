function validaForma(form)
	{
		if(form.nombre.value == '')
		{
			alert("No ha digitado el Nombre");
			form.nombre.focus();
			return false;
		}
		
		if(form.email.value == '')
		{
			alert("No ha digitado su Email");
			form.email.focus();
			return false;
		}
		
		else if(form.datos.value == '')
		{
			alert("No ha digitado las sugerencias");
			form.datos.focus();
			return false;
		}
				
		else
		{
			if (!confirm('Está seguro de enviar el e-mail???'))
			{ 
        		return false;
			}
		}
	}