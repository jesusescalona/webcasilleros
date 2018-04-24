<%@LANGUAGE="VBSCRIPT" CODEPAGE="1252"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
<title>Zaicargo - Casillero Postal</title>
<link href="Imagenes/estilos.css" rel="stylesheet" type="text/css" />

<script LANGUAGE="JavaScript"> 


   function Calcular(cbTipoProducto, txtValorProducto, txtPesoLibras, txtPesoKilos)
   { 
    
	//Declaración de variables 
	var r=1;
	 
	 //Validar los campos, que no sean nulos y que sean numéricos 
	if (formulario.txtValorProducto.value=="") {r=0;alert("Por favor ingrese el Valor del Producto"); formulario.txtValorProducto.focus}
	else if (formulario.txtValorProducto.value<1) {r=0;alert("El Valor del producto debe ser mayor a 0"); formulario.txtValorProducto.focus}
	else if (formulario.txtPesoLibras.value=="" && formulario.txtPesoKilos.value=="") {r=0;alert("Por favor ingrese el Peso en Libras ó en kilos"); formulario.txtPesoLibras.focus}
	else if (formulario.txtPesoLibras.value<5 && formulario.txtPesoKilos.value<2.27) {r=0;alert("El Peso mínimo debe ser 5 Lbs ó 2,27 Kgs"); formulario.txtPesoLibras.focus}
	else {r=1};
  
  if (r==1){
   
  var VarTipoProducto;
  var VarValorProducto;
  var VarPesoLibras;
  var VarPesoLibrasV;
  var VarPesoKilos;
  var VarPesoKilosV;
  var VarLargo;
  var VarAlto;
  var VarAncho;
  var VarDimensiones;
  
  var VarCIF;
  var VarArancel;
  var VarIVA;
  var VarAduana;
  var VarFlete;
  var VarSeguro;
  var VarCostoEnvio;
  var VarCostoTotal;
  var VarImpuestos;
  
  VarTipoProducto= parseFloat(formulario.cbTipoProducto.value);
  VarValorProducto= parseFloat(formulario.txtValorProducto.value);
  VarPesoLibras= parseFloat(formulario.txtPesoLibras.value);
  VarPesoLibrasV= parseFloat(formulario.txtPesoLibras.value);
  VarPesoKilos= parseFloat(formulario.txtPesoKilos.value);
  VarPesoKilosV= parseFloat(formulario.txtPesoKilos.value);
  VarLargo= parseFloat(formulario.txtLargo.value);
  VarAlto= parseFloat(formulario.txtAlto.value);
  VarAncho= parseFloat(formulario.txtAncho.value);
  
  VarDimensiones = (VarLargo * VarAlto * VarAncho)/166;
  if (VarDimensiones > VarPesoLibras) {VarPesoLibras = VarDimensiones}
  
  VarAduana = 0; /*VarValorProducto * 0.05;*/
  VarSeguro = VarValorProducto * 0.005;
  VarFlete = VarPesoLibras * 0.1587;
  VarCIF = VarValorProducto + VarSeguro + VarFlete;
  
  VarArancel = VarCIF * VarTipoProducto;
  VarIVA = (VarCIF + VarArancel) * 0.16
  
  VarImpuestos = VarArancel + VarIVA;
   
  //Costos
  VarCostoEnvio = VarAduana + VarSeguro + VarFlete + VarArancel + VarIVA;
  VarCostoTotal = VarValorProducto + VarCostoEnvio;
  
  //Flete Us
  VarFlete = VarPesoLibras * 3;
  if(VarPesoLibras < 5) {VarFlete = 15;}
  
  //Seguro Us
  VarSeguro = VarValorProducto * 0.03;
  
  //Costo Envío
  VarCostoEnvio = VarImpuestos + VarFlete + VarSeguro;
  
  //Resultados
  /*formulario.txtCIF.value = Math.round(VarCIF*100)/100;*/
  /*formulario.txtArancel.value = Math.round(VarArancel*100)/100;*/
  /*formulario.txtIVA.value = Math.round(VarIVA*100)/100;*/
  /*formulario.txtAduana.value = Math.round(VarAduana*100)/100;*/
  
  if(VarPesoLibrasV != 0){VarPesoKilosV = VarPesoLibrasV * 0.454;}
  else if (VarPesoKilosV != 0){VarPesoLibrasV = VarPesoKilosV / 0.454;}
  
  formulario.txtImpuestos.value = Math.round(VarImpuestos*100)/100;
  formulario.txtFlete.value = Math.round(VarFlete*100)/100;
  formulario.txtSeguro.value = Math.round(VarSeguro*100)/100;
  formulario.txtCostoEnvio.value = Math.round(VarCostoEnvio*100)/100;
  
  /*formulario.txtPesoLibras.value = Math.round(VarPesoLibrasV*100)/100;
  formulario.txtPesoKilos.value = Math.round(VarPesoKilosV*100)/100;*/
  /*formulario.txtCostoTotal.value = Math.round(VarCostoTotal*100)/100;*/
	  
	  return;
   } 
   }
   
	function ConvierteaKilos(txtPesoLibras)
   	{
   
    var VarPesoLibrasV;
	var VarPesoKilosV;
	
	VarPesoLibrasV= parseFloat(formulario.txtPesoLibras.value);   
	VarPesoKilosV = VarPesoLibrasV * 0.454;
	formulario.txtPesoKilos.value = Math.round(VarPesoKilosV*100)/100;
	
	}
	
	function ConvierteaLibras(txtPesoKilos)
   	{
   
    var VarPesoLibrasV;
	var VarPesoKilosV;
	
	VarPesoKilosV= parseFloat(formulario.txtPesoKilos.value);   
	VarPesoLibrasV = VarPesoKilosV / 0.454;
	formulario.txtPesoLibras.value = Math.round(VarPesoLibrasV*100)/100;
	
	}

</script> 


<script LANGUAGE="JavaScript"> 

	function Reflesh()
	{
		window.location.reload();
	}
</script>

<style type="text/css">
<!--
.style1 {font-family: Calibri}
.style2 {font-family: Calibri; color: #000000; }
.style3 {color: #000000}
.style7 {font-size: 16px}
.style18 {font-family: Arial, Helvetica, sans-serif; font-weight: bold; font-size: 14px; }
.style19 {font-family: Arial, Helvetica, sans-serif; color: #000000; font-size: 12px; font-weight: bold; }
.style21 {font-family: Arial, Helvetica, sans-serif; font-weight: bold; font-size: 12px; }
-->
</style>
</head>

<body>

<table width="800" border="0" cellspacing="0" cellpadding="0" align="center" style="background:url(Imagenes/Body.jpg)">
  <tr style="background:url(Imagenes/Gradiente_Cabecera_Z.png)">
    <td colspan="2" scope="col" height="97"  valign="bottom">
	<div align="right" style="vertical-align:bottom">
        <form action="http://zaicargo.controlbox.net/webcasilleros/clientes/login.asp" method="POST" name="frmaIngreso">
        <table width="100" border="0" cellspacing="0" cellpadding="0" align="right">
          <tr>
            <th scope="col"><span class="txtTextoI">Usuario: </span></th>
            <th scope="col"><input name="usuario" type="text" class="txtCajas" size="8" /></th>
          </tr>
          <tr>
            <td align="left"><span class="txtTextoI">Clave:</span></td>
            <td align="left"><input name="clave" type="password" class="txtCajas" size="8" /></td>
          </tr>
          <tr>
            <td colspan="2" align="right"><input name="Ingreso" type="submit" value="Ingresar" class="btnAccion" onclick="#" /></td>
          </tr>
        </table>
		</form>
  </div><a href="http://www.zaicargo.com" target="_blank"><img src="Imagenes/Logo.png" alt="Zaicargo" width="205" height="60" border="0" /></a>
  </tr>
   <tr>
    <th colspan="2" scope="col"><img src="Imagenes/Division.png" alt="Head" width="800" height="1"  /></th>
  </tr>
  <tr>
    <th colspan="2" scope="col"><img src="Imagenes/Banner_Cotizador.jpg" alt="Casillero" width="800" height="247" /></th>
  </tr>
  <tr bgcolor="#3086BC">
    <td valign="top">
		<table width="200" border="0" cellspacing="0" cellpadding="0">
      		<tr>
        		<th scope="col"><object classid="clsid:D27CDB6E-AE6D-11cf-96B8-444553540000" codebase="http://download.macromedia.com/pub/shockwave/cabs/flash/swflash.cab#version=7,0,19,0" width="200" height="216" tabindex="1" title="Menu">
                  <param name="movie" value="Imagenes/Menu.swf" />
                  <param name="quality" value="high" />
                  <embed src="Imagenes/Menu.swf" quality="high" pluginspage="http://www.macromedia.com/go/getflashplayer" type="application/x-shockwave-flash" width="200" height="216"></embed>
      		  </object></th>
      		</tr>
    	</table>
	</td>
	<td bgcolor="#3086BC" style="vertical-align:top">
		<table width="600" border="0" cellspacing="0" cellpadding="0" style="background:url(Imagenes/Body.jpg)" height="180">
			<tr>
        		<th scope="col"><img src="Imagenes/CabeceraCotizador.png" alt="Head" width="600" height="20" /></th>
      		</tr>
      		<tr>
        		<th scope="col"><a href="registro.html"></a><a href="tiendas.html"></a>
			
	<form action="procesa.phtml" method="GET" enctype="multipart/form-data" name="formulario" id="formulario">
        		  <table width="600" border="0" align="center" bgcolor="#FFFFFF" style="background:url(Imagenes/Body.png)">
  	<tr>
		<td colspan="10">		  
		<div align="center" class="txtTituloC"><br /></div></td>
	</tr>
    <tr>
      <td class="style2">&nbsp;</td>
      <td colspan="8" lass="txtTextoBJ" align="left"><p align="left" class="txtTituloJ"><strong>		  INFORMACI&Oacute;N DEL ENV&Iacute;O</strong></p></td>
      <td class="style2">&nbsp;</td>
    </tr>
    <tr>
      <td width="12" class="style2">&nbsp;</td>
	  <td width="218" class="txtTextoBJ"><div align="left">Tipo de Producto</div></td>
      <td colspan="7" ><div align="left">
        <select name="cbTipoProducto" id="cbTipoProducto">
            <option value="0.1">Art Deportivos, Maq. Ejercicios - (10.00%)</option>
            <option value="0.1">Artículos Deportivos - (10.00%)</option>
            <option value="0.05">Cámaras Fotográficas - (5.00%)</option>
            <option value="0.05">Computadoras - (5.00%)</option>
            <option value="0.05">Computadoras, Accesorios - (5.00%)</option>
            <option value="0.05">Computadoras, Monitores - (5.00%)</option>
            <option value="0.05">Computadoras, Partes - (5.00%)</option>
            <option value="0.05">Computadoras, Programas - (5.00%)</option>
            <option value="0.05">Electrónicos, Agendas - (5.00%)</option>
            <option value="0.05">Electrónicos, Cámara de Digital - (5.00%)</option>
            <option value="0.05">Electrónicos, Cámara de Video - (5.00%)</option>
            <option value="0.05">Herramienta Neumática - (5.00%)</option>
            <option value="0.05">Instrumentos metereología - (5.00%)</option>
            <option value="0.1">Instrumentos Musicales - (10.00%)</option>
            <option value="0.05">LABORATORY SUPPLIES  - (5.00%)</option>
            <option value="0">Libros - (0%)</option>
            <option value="0.1">Otros - (10.00%)</option>
            <option value="0.1">Partes - (10.00%)</option>
            <option value="0.05">Partes de Cromatografía - (5.00%)</option>
            <option value="0.1">Partes, Automotrices - (10.00%)</option>
            <option value="0.1">Partes, Electrónicos - (10.00%)</option>
            <option value="0.05">REACTIVOS DIAGNOSTICO - (5.00%)</option>
            <option value="0">Revistas - (0%)</option>
        </select>
      </div></td>
      <td width="17" class="style2"><label></label></td>
    </tr>
    <tr>
      
      <td class="style2">&nbsp;</td>
	  <td class="txtTextoBJ"><div align="left">Valor del Producto (Factura) </div></td>
      <td colspan="7" class="style2"><div align="left"><span class="style3"><span class="style18">
        <input name="txtValorProducto" type="text" id="txtValorProducto" tabindex="3" value="0" />
      </span></span></div></td>
      <td class="style2">&nbsp;</td>
    </tr>
    <tr>
      <td class="style2">&nbsp;</td>
      <td class="txtTextoBJ">Dimensiones Largo (Pulg)</td>
      <td colspan="7" class="txtTextoBJ"><span class="style18">
        <input name="txtLargo" type="text" id="txtLargo" tabindex="2" value="0" size="5" maxlength="10" />
      </span>        <div align="left"></div></td>
      <td class="style2">&nbsp;</td>
    </tr>
    <tr>
      <td class="style2">&nbsp;</td>
      <td class="txtTextoBJ">Dimensiones Alto (Pulg)</td>
      <td colspan="7" class="txtTextoBJ"><span class="style18">
        <input name="txtAlto" type="text" id="txtAlto" tabindex="2" value="0" size="5" maxlength="10" />
      </span>        <div align="left"></div></td>
      <td class="style2">&nbsp;</td>
    </tr>
    <tr>
      <td class="style2">&nbsp;</td>
      <td class="txtTextoBJ">Dimensiones Ancho (Pulg)</td>
      <td colspan="7" class="txtTextoBJ"><span class="style18">
        <input name="txtAncho" type="text" id="txtAncho" tabindex="2" value="0" size="5" maxlength="10" />
      </span>        <div align="left"></div></td>
      <td class="style2">&nbsp;</td>
    </tr>
    <tr>
      <td class="style2">&nbsp;</td>
      <td class="txtTextoBJ"><div align="left">Peso</div></td>
      <td width="31" class="txtTextoBJ"><div align="left"><span class="style3"><span class="style18">
        <input name="txtPesoLibras" type="text" id="txtPesoLibras" tabindex="2" value="0" size="5" maxlength="10" onblur="javascript:ConvierteaKilos();" />
      </span></span></div></td>
      <td width="39" class="txtTextoBJ">(Lbs)</td>
      <td width="21" class="txtTextoBJ" align="center"><div align="center" class="txtTextoBJ">
        <div align="center">&oacute;</div>
      </div></td>
      <td width="4" class="txtTextoBJ" align="center">&nbsp;</td>
      <td width="32" class="txtTextoBJ"><span class="style3"><span class="style18">
        <input name="txtPesoKilos" type="text" id="txtPesoKilos" tabindex="2" value="0" size="5" maxlength="10" onblur="javascript:ConvierteaLibras();" />
      </span></span></td>
      <td width="164" class="txtTextoBJ">(Kgs)</td>
      <td width="20" class="txtTextoBJ">&nbsp;</td>
      <td class="style2">&nbsp;</td>
    </tr>
    
    <tr>
      <td class="style2">&nbsp;</td>
      <td colspan="8" class="style2">&nbsp;</td>
      <td class="style2">&nbsp;</td>
    </tr>
    <tr>
      <td class="style2">&nbsp;</td>
      <td class="style2">&nbsp;</td>
      <td colspan="7" class="style2"><div align="left">
        <input type="button" value=" Calcular " onclick="javascript:Calcular();" />
        <input type="button" value=" Limpiar " onclick="javascript:Reflesh();" />
      </div></td>
      <td class="style2">&nbsp;</td>
    </tr>
    <tr>
      <td class="style2">&nbsp;</td>
      <td class="style2">&nbsp;</td>
      <td colspan="7" class="style2">&nbsp;</td>
      <td class="style2">&nbsp;</td>
    </tr>
    <tr>
      <td class="style2">&nbsp;</td>
      <td colspan="8" align="left"><p align="left" class="txtTituloJ"><strong>COSTO DEL ENV&Iacute;O</strong></p></td>
      <td class="style2">&nbsp;</td>
    </tr>
    
    
    
    <tr>
      <td class="style2">&nbsp;</td>
      <td bgcolor="#FFCC00" class="style7 style3 style1 txtTextoBJ"><span class="style21">Impuestos (Arancel + IVA)</span></td>
      <td colspan="7" class="style2"><div align="left"><span class="style18">
          <input name="txtImpuestos" type="text" id="txtImpuestos" value="0" readonly="readonly" />
      </span></div></td>
      <td class="style2">&nbsp;</td>
    </tr>
    <tr>
      <td class="style2">&nbsp;</td>
      <td bgcolor="#FFCC00" class="style7 style3 style1 txtTextoBJ"><span class="style21">Flete</span></td>
      <td colspan="7" class="style2"><div align="left"><span class="style18">
        <input name="txtFlete" type="text" id="txtFlete" value="0" readonly="readonly" />
      </span></div></td>
      <td class="style2">&nbsp;</td>
    </tr>
    <tr>
      <td class="style2">&nbsp;</td>
      <td bgcolor="#FFCC00" class="style7 style3 style1 txtTextoBJ"><span class="style21">Seguro</span></td>
      <td colspan="7" class="style2"><div align="left"><span class="style18">
        <input name="txtSeguro" type="text" id="txtSeguro" value="0" readonly="readonly" />
      </span></div></td>
      <td class="style2">&nbsp;</td>
    </tr>
    <tr>
      <td class="style2">&nbsp;</td>
      <td bgcolor="#FF9900" class="style7 style3 style1 txtTextoBJ"><span class="style21">Costo Total de Env&iacute;o</span></td>
      <td colspan="7" class="style2"><div align="left"><span class="style18">
        <input name="txtCostoEnvio" type="text" id="txtCostoEnvio" value="0" readonly="readonly" />
      </span></div></td>
      <td class="style2">&nbsp;</td>
    </tr>
    
    
    <tr>
      <td colspan="10" align="center">&nbsp;</td>
    </tr>
  </table>
                  <div align="justify"><span class="txtTituloJ">* El precio calculado es un estimado del costo de env&iacute;o, los costos finales pueden variar con base en el peso real del mismo y del valor de la factura de compra.</span></div>
                  <br />
	</form>      		  
       		    <a href="rastreo.html"></a></th>
      		</tr>
    	</table>
	</td>
  </tr>
  <tr>
    <th colspan="2" scope="col"><img src="Imagenes/Division.png" alt="Head" width="800" height="1"  /></th>
  </tr>
  <tr>
    <td colspan="2"><img src="Imagenes/Footer.png" alt="Footer" width="800" height="30" /></td>
  </tr>
</table>

</body>
</html>
