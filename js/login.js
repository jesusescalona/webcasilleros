
$(document).ready(function(){
	var formInputs = $('input[type="email"],input[type="password"]');
	formInputs.focus(function() {
       $(this).parent().children('p.formLabel').addClass('formTop');
       $('div#formWrapper').addClass('darken-bg');
       $('div.logo').addClass('logo-active');
	});
	formInputs.focusout(function() {
		if ($.trim($(this).val()).length == 0){
		$(this).parent().children('p.formLabel').removeClass('formTop');
		}
		$('div#formWrapper').removeClass('darken-bg');
		$('div.logo').removeClass('logo-active');
	});
	$('p.formLabel').click(function(){
		 $(this).parent().children('.form-style').focus();
	});
});

function abrir_login()
{
 document.getElementById('gratis').style.display="none";
}

$(document).ready(function () 
{
	$("#login").click(function ()
	{
		window.open('http://zaicargo.controlbox.net/webcasilleros/clientes/login.asp','Iniciar Sesión','width=400,height=400,scrollbars=no,toolbar=no');
	});
	$("#register").click(function ()
	{
		window.open('http://zaicargo.controlbox.net/webcasilleros/registro.asp','Registro','width=400,height=500,scrollbars=yes,toolbar=no');
	});
	$("#reset_pass").click(function ()
	{
		window.open('http://zaicargo.controlbox.net/webcasilleros/oc.asp','title=Recuperar Contraseña','width=400,height=500,scrollbars=no,toolbar=no');
	});
	$("#sugestions").click(function ()
	{
		window.open('http://zaibox.net/sugerencias.asp','title=Sugerencias','width=500,height=400,scrollbars=no,toolbar=no');
	});
});