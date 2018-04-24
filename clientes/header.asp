<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
<title>Zaicargo - Casillero Postal</title>
<link href="Imagenes/estilos.css" rel="stylesheet" type="text/css" />
<link href="../Imagenes/estilos.css" rel="stylesheet" type="text/css" />
</head>

<body bgcolor="#4684C1">
<script type="text/javascript">
function fp(URL)
				{
					var winl, wint;
					var navegador = navigator.appName;
					if (navegador == "Microsoft Internet Explorer")
					{
						//alert("si entra");
						window.open(URL,"Prealerta_de_paquete","width=900,height=410,top=200,left=300,scrollbars=no,toolbar=no,resizable=yes");
					}
					else
					{
						winl = (screen.width - 800) / 2;
						wint = (screen.height - 400) / 2;
						window.open(URL,"Prealerta de paquete","width=900,height=410,top=" + wint + ",left=" + winl + ",scrollbars=no,toolbar=no,resizable=yes");
					}
				}
</script>	
<table width="800" border="0" cellspacing="0" cellpadding="0" align="center">
  <tr bgcolor="#FFFFFF">
    <%'SE MODIFICO COMO MUESTRA LA VENTANA EN EL uploadTester.ASP VLO-816-77882%>
	<td scope="col" height="32">
	<a href="main.asp" class="txtTextoI">Env&iacute;os recientes</a> | 
	<a href="informacioncasillero.asp" class="txtTextoI" >Datos Personales</a> | 
	<a href="uploadTester.asp" class="txtTextoI" >Prealerta Caja Individual</a> |
	<a href="Trackings.asp" class="txtTextoI" >Consolidaci&oacute;n de cajas</a> | 
	<%if Session("cas_consultar_prealertas") then%>
	<a href="buscarprealertas.asp" class="txtTextoI" >Consultar Prealertas</a> | 
	<%end if%>
	<a href="buscarguias.asp" class="txtTextoI" >Busqueda</a> | 
	
	<a href="ValidarSalir.asp" class="txtTextoI" >Salir</a> </td>
  </tr>
  <tr>
    <td bgcolor="#ffffff" >
	
	
	
	
	
