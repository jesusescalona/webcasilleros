<%@LANGUAGE="VBSCRIPT" CODEPAGE="1252"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
<title>Zaicargo - Casillero Postal</title>
<link href="Imagenes/estilos.css" rel="stylesheet" type="text/css" />

<script LANGUAGE="JavaScript"> 


   function Calcular(txtValorFobMercancia, txtPesoLibras, txtDimensionLargo, txtDimensionAlto, txtDimensionAncho, TxtPosicionArancelaria) 
   { 
    
	//Declaración de variables 
	 var r=1;
	 var VarValorFobMercancia;
   	 var VarPesoLibras;
	 var VarDimensionLargo;
	 var VarDimensionAlto;
	 var VarDimensionAncho;
	 var VarPesoVolumetricoLibras;
	 var VarPesoMayor;
	 var VarVacio2;
	 var VarVacio3;
	 var VarValorCIF;
	 var VarArancelAprox;
	 var VarTasaModerniacion;
	 var VarFodinfa;
	 var VarIva1;
	 var VarTotalCaeDas;
	 var VarTramite;
	 var VarFleteImport;
	 var VarRedondeoPesoMayor;
	 var Libras;
	 var ValorFlete;
	 var x;
	 var y;
	 var VarVector;
	 var VarAuxFleteImport;
	 var VarAux2FleteImport;
	 var VarIva2;
	 var VarTotal;
	 var VarTotalImportacion;
	 var VarCreditoTributarioIva;
	 var CostoImportacion;
	 var VarSeguro;
	 var VarPosicionArancelaria;
	 var VarArancelAprox;
	 
	 //Validar los campos, que no sean nulos y que sean numéricos 
	if (formulario.txtValorFobMercancia.value=="") {r=0;alert("Por favor ingrese el Valor FOB Mercancia"); formulario.txtValorFobMercancia.focus}
   else if (isNaN(formulario.txtValorFobMercancia.value)) {r=0;alert("El Valor FOB Mercancia debe ser numérico"); formulario.txtValorFobMercancia.focus}
   else if (formulario.txtPesoLibras.value=="") {r=0;alert("Por favor ingrese el Peso en Libras"); formulario.txtPesoLibras.focus}
   else if (isNaN(formulario.txtPesoLibras.value)) {r=0;alert("El valor Peso en Libras debe ser numérico"); formulario.txtPesoLibras.focus}
   else if (formulario.txtDimensionLargo.value=="") {r=0;alert("Por favor ingrese Las Dimensiones Largo"); formulario.txtDimensionLargo.focus}
   else if (isNaN(formulario.txtDimensionLargo.value)) {r=0;alert("El valor de las Dimensiones Largo debe ser numérico"); formulario.txtDimensionLargo.focus}
   else if (formulario.txtDimensionAlto.value=="") {r=0;alert("Por favor ingrese Las Dimensiones Alto"); formulario.txtDimensionAlto.focus}
   else if (isNaN(formulario.txtDimensionAlto.value)) {r=0;alert("El valor de las Dimensiones Alto debe ser numérico"); formulario.txtDimensionAlto.focus}
   else if (formulario.txtDimensionAncho.value=="") {r=0;alert("Por favor ingrese Las Dimensiones Ancho"); formulario.txtDimensionAncho.focus}
   else if (isNaN(formulario.txtDimensionAncho.value)) {r=0;alert("El valor las Dimensiones Ancho debe ser numérico"); formulario.txtDimensionAncho.focus};
   
   
   //Si los campos son válidos, se hallan los cálculos de los campos 
   if (r==1)
   {
   		//Los valores que el usuario ingresa son almacenados en variables
		VarValorFobMercancia = parseFloat(formulario.txtValorFobMercancia.value)
   		VarPesoLibras = parseFloat(formulario.txtPesoLibras.value)
   		VarDimensionLargo = parseFloat(formulario.txtDimensionLargo.value)
   		VarDimensionAlto = parseFloat(formulario.txtDimensionAlto.value)
   		VarDimensionAncho = parseFloat(formulario.txtDimensionAncho.value)
		VarSeguro = parseFloat(VarValorFobMercancia) * 0.01;
		
		//Posición Aracncelaria
		//var indice = combo.selectedIndex;
        //var valor = combo.options[combo.selectedIndex].text;
		//var x=document.getElementById("mySelect")
  		//alert(x.selectedIndex)
		var x=document.getElementById("TxtPosicionArancelaria");
		//alert(x.value);
		VarPosicionArancelaria = parseFloat(x.value);
		//formulario.txtArancelAprox.value = x.value;//VarPosicionArancelaria;
		
   //Resultado del campo Peso Volumetrico Libras
   VarPesoVolumetricoLibras = parseFloat(VarDimensionLargo) * parseFloat(VarDimensionAlto) * parseFloat(VarDimensionAncho) / 6000 * 22 / 10;
   VarPesoVolumetricoLibras = Math.round(VarPesoVolumetricoLibras*100)/100;
   formulario.txtPesoVolumetricoLibras.value = VarPesoVolumetricoLibras;
   
   //Resultado del campo Peso Mayor
   if (VarPesoLibras > VarPesoVolumetricoLibras) {VarPesoMayor = VarPesoLibras}
   else {VarPesoMayor =  VarPesoVolumetricoLibras};
   VarPesoMayor = Math.round(VarPesoMayor*100)/100;
   formulario.txtPesoMayor.value = VarPesoMayor;
   
   //Resultado del campo vacío 1
   //VarFobMercancia = Math.round(VarFobMercancia*100)/100;
   formulario.txtVacio1.value = VarValorFobMercancia;
   
   //Resultado del campo vacío 2
   VarVacio2 = VarPesoLibras * 0.6
   VarVacio2 = Math.round(VarVacio2*100)/100;
   formulario.txtVacio2.value = VarVacio2;
   
   //Resultado del campo vacío 3
   VarVacio3 = (parseFloat(VarValorFobMercancia) + parseFloat(VarVacio2)) * 0.02
   VarVacio3 = Math.round(VarVacio3*100)/100;
   formulario.txtVacio3.value = VarVacio3;
   
   //Resultado del campo Valor CIF
   VarValorCIF = parseFloat(VarValorFobMercancia) + parseFloat(VarVacio2) + parseFloat(VarVacio3)
   VarValorCIF = Math.round(VarValorCIF*100)/100;
   formulario.txtValorCIF.value = VarValorCIF;
   
   //Resultado del campo Arancel Aprox
   VarArancelAprox = ((VarValorCIF * VarPosicionArancelaria) / 100)
   VarArancelAprox = Math.round(VarArancelAprox*100)/100;
   formulario.txtArancelAprox.value = parseFloat(VarArancelAprox);
   
   //Resultado del campo Tasa Modernización
   VarTasaModerniacion = 0
   VarTasaModerniacion = Math.round(VarTasaModerniacion*100)/100;
   formulario.txtTasaModerniacion.value = VarTasaModerniacion;
   
   //Resultado del campo Fodinfa
   VarFodinfa = (parseFloat(VarValorCIF) * 0.05 / 10)
   VarFodinfa = Math.round(VarFodinfa*100)/100;
   formulario.txtFodinfa.value = VarFodinfa;
   
   //Resultado del campo Iva 1
   VarIva1 = (VarValorCIF + VarArancelAprox + VarFodinfa) * 0.12
   VarIva1 = Math.round(VarIva1*100)/100;
   formulario.txtIva1.value = VarIva1;
   
   //Resultado del campo Total a la CAE DAS
   VarTotalCaeDas = VarArancelAprox + VarTasaModerniacion + VarFodinfa + VarIva1
   VarTotalCaeDas = Math.round(VarTotalCaeDas*100)/100;
   formulario.txtTotalCaeDas.value = VarTotalCaeDas;
   
   //Resultado del campo Tramite
   if (VarValorFobMercancia < 501) {VarTramite = 5}
   else if (VarValorFobMercancia >500 && VarValorFobMercancia <1001) {VarTramite =  10}
   else if (VarValorFobMercancia < 2001) {VarTramite = 25};
   formulario.txtTramite.value = VarTramite;
   
   //Resultado del campo Flete Import
   VarRedondeoPesoMayor = Math.round(VarPesoMayor);
   
   Libras = new Array('1', '2', '3', '4', '5', '6', '7', '8', '9', '10', '11', '12', '13', '14', '15', '16', '17', '18', '19', '20', '21', '22', '23', '24', '25', '26', '27', '28', '29', '30', '31', '32', '33', '34', '35', '36', '37', '38', '39', '40', '41', '42', '43', '44', '45', '46', '47', '48', '49', '50');
   ValorFlete = new Array('4.00', '8.00', '12.00', '16.00', '20.00', '24.00', '28.00', '32.00', '36.00', '40.00', '44.00', '48.00', '52.00', '56.00', '60.00', '64.00', '68.00', '72.00', '76.00', '80.00', '79.80', '83.60', '87.40', '91.20', '95.00', '98.80', '102.60', '106.40', '110.20', '114.00', '108.50', '112.00', '115.50', '119.00', '122.50', '126.00', '129.50', '133.00', '136.50', '140.00', '143.50', '147.00', '150.50', '154.00', '157.50', '161.00', '164.50', '168.00', '171.50', '175.00')
   
   if((VarPesoLibras>50) && (VarPesoLibras<81)) {VarAuxFleteImport = 3.3}
    else if((VarPesoLibras>80) && (VarPesoLibras<101)) {VarAuxFleteImport = 3.2}
		 else if((VarPesoLibras>100) && (VarPesoLibras<151)) {VarAuxFleteImport = 3}
		 	 else if((VarPesoLibras>150) && (VarPesoLibras<201)) {VarAuxFleteImport = 2.8}
			 	 else if(VarPesoLibras>200) {VarAuxFleteImport = 2.5};
	
	if (VarRedondeoPesoMayor>50) {VarAux2FleteImport = VarAuxFleteImport}
		else {for(x=0; x<50; x++)
				{
					for(y=0; y<50; y++)
						{
							if(Libras[x] == VarRedondeoPesoMayor){VarAux2FleteImport = ValorFlete[x]};
						}
				}
			};
	
	if(VarRedondeoPesoMayor>50) {VarFleteImport = VarRedondeoPesoMayor * parseFloat(VarAux2FleteImport)}
		else {VarFleteImport = parseFloat(VarAux2FleteImport)};
   
   formulario.txtFleteImport.value = VarFleteImport;
   
   //Resultado del campo Iva 2
   VarIva2 = ((VarFleteImport + VarTramite) * 0.12);
   VarIva2 = Math.round(VarIva2*100)/100;
   formulario.txtIva2.value = VarIva2;
   
   //Resultado del campo Total
   VarTotal = (VarTramite + VarFleteImport + VarIva2 + VarSeguro);
   VarTotal = Math.round(VarTotal*100)/100;
   formulario.txtTotal.value = VarTotal;
  
  //Resultado del campo Total Importación
  VarTotalImportacion = (VarTotalCaeDas + VarTotal + VarSeguro);
  VarTotalImportacion = Math.round(VarTotalImportacion*100)/100;
  formulario.txtTotalImportacion.value = VarTotalImportacion;
  
  //Resulatado del campo Credito Tributario Iva
  VarCreditoTributarioIva = (VarIva1 + VarIva2);
  VarCreditoTributarioIva = Math.round(VarCreditoTributarioIva*100)/100;
  formulario.txtCreditoTributarioIva.value = VarCreditoTributarioIva;
	
  //Resulatado del campo Costo de Importacion
  VarCostoImportacion = (VarArancelAprox + VarFodinfa + VarTramite + VarFleteImport);
  VarCostoImportacion = Math.round(VarCostoImportacion*100)/100;
  formulario.txtCostoImportacion.value = VarCostoImportacion;
  
  //Resultado del campo Seguro
  VarSeguro = Math.round(VarSeguro*100)/100;
  formulario.txtSeguro.value = VarSeguro;
	  
	  return;
   } 
   }

</script>

<script LANGUAGE="JavaScript"> 

	function Reflesh()
	{
		window.location.reload();
	}
</script>

</head>

<body>

<table width="800" border="0" cellspacing="0" cellpadding="0" align="center">
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
            <td colspan="2" align="right"><input name="Ingreso" type="submit" value="Ingresar" class="btnAccion" /></td>
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
		<table width="600" border="0" cellspacing="0" cellpadding="0" height="180">
			<tr>
        		<th scope="col"><img src="Imagenes/CabeceraCotizador.png" alt="Head" width="600" height="20" /></th>
      		</tr>
      		<tr>
        		<th scope="col"><a href="registro.html"></a><a href="tiendas.html"></a>
			
	<form action="procesa.phtml" method="GET" enctype="multipart/form-data" name="formulario" id="formulario">
        		  <table width="600" border="0" align="center" bgcolor="#FFFFFF" style="background:url(Imagenes/Body.jpg)">
  	<tr>
		<td colspan="6">
		  <p class="styleTitulo" align="center"><em class="txtTituloC"><strong>ECUADOR </strong></em><br/>
		        </p></td>
	</tr>
	
    <tr>
      <td colspan="2" class="style1"><div align="center" class="txtTituloC">DATOS</div></td>
      <td width="1%">&nbsp;</td>
      <td colspan="3" class="style1"><div align="center" class="txtTituloC">C&Aacute;LCULOS</div></td>
    </tr>
    <tr>
      <td width="22%">&nbsp;</td>
      <td width="25%">&nbsp;</td>
      <td>&nbsp;</td>
      <td width="23%">&nbsp;</td>
      <td width="4%">&nbsp;</td>
      <td width="25%">&nbsp;</td>
    </tr>
    <tr>
      <td class="txtTextoJ"><div align="left">Valor FOB Mercancia </div></td>
      <td><input name="txtValorFobMercancia" type="text" id="txtValorFobMercancia" tabindex="1" value="100.00"  maxlength="15">
      </span></td>
      <td>&nbsp;</td>
      <td class="txtTextoJ">&nbsp;</td>
      <td class="style3" align="center">$</td>
      <td><input name="txtVacio1" type="text" id="txtVacio1" value="100.00" ReadOnly></td>
    </tr>
    <tr>
      <td class="txtTextoJ"><div align="left">Peso en Libra </div></td>
      <td><span class="style18">
        <input name="txtPesoLibras" type="text" id="txtPesoLibras" tabindex="2" value="100"  maxlength="10">
      </span></td>
      <td>&nbsp;</td>
      <td class="txtTextoJ">&nbsp;</td>
      <td class="style3" align="center">$</td>
      <td><input name="txtVacio2" type="text" id="txtVacio2" value="60.00" ReadOnly></td>
    </tr>
    <tr>
      <td class="txtTextoJ"><div align="left">Dimensiones Largo (cms) </div></td>
      <td><span class="style18">
        <input name="txtDimensionLargo" type="text" id="txtDimensionLargo" tabindex="3" value="0">
      </span></td>
      <td>&nbsp;</td>
      <td class="txtTextoJ">&nbsp;</td>
      <td class="style3" align="center">$</td>
      <td><input name="txtVacio3" type="text" id="txtVacio3" value="3.20" ReadOnly></td>
    </tr>
    <tr>
      <td class="txtTextoJ"><div align="left">Dimensiones Alto (cms) </div></td>
      <td><span class="style18">
        <input name="txtDimensionAlto" type="text" id="txtDimensionAlto" tabindex="4" value="0">
      </span></td>
      <td>&nbsp;</td>
      <td class="txtTextoJ">Valor CIF </td>
      <td class="style5" align="center">$</td>
      <td class="style5"><input name="txtValorCIF" type="text" id="txtValorCIF" value="163.20" ReadOnly></td>
    </tr>
    <tr>
      <td class="txtTextoJ"><div align="left">Dimensiones Ancho (cms) </div></td>
      <td><span class="style18">
        <input name="txtDimensionAncho" type="text" id="txtDimensionAncho" tabindex="5" value="0">
      </span></td>
      <td>&nbsp;</td>
      <td class="txtTextoJ">Arancel APROX </td>
      <td class="style3" align="center">$</td>
      <td><input name="txtArancelAprox" type="text" id="txtArancelAprox" value="-" ReadOnly></td>
    </tr>
    <tr>
      <td class="txtTextoJ"><div align="left">Peso Volum&eacute;trico en Libras </div></td>
      <td><span class="style18">
        <input name="txtPesoVolumetricoLibras" type="text" id="txtPesoVolumetricoLibras" value="0.00" ReadOnly>
      </span></td>
      <td>&nbsp;</td>
      <td class="txtTextoJ">Tasa Modernizaci&oacute;n </td>
      <td class="style3" align="center">$</td>
      <td><span class="style18">
        <input name="txtTasaModerniacion" type="text" id="txtTasaModerniacion" value="-" ReadOnly>
      </span></td>
    </tr>
    <tr>
      <td class="txtTextoJ"><div align="left">Peso Mayor (Real Vs. Vol) </div></td>
      <td><span class="style18">
        <input name="txtPesoMayor" type="text" id="txtPesoMayor" value="100.00" ReadOnly>
      </span></td>
      <td>&nbsp;</td>
      <td class="txtTextoJ">FODINFA</td>
      <td class="style3" align="center">$</td>
      <td><input name="txtFodinfa" type="text" id="txtFodinfa" value="0.82" ReadOnly></td>
    </tr>
    <tr>
      <td class="txtTextoJ"><div align="left">Posici&oacute;n Arancelaria </div></td>
      <td><select name="TxtPosicionArancelaria" id="TxtPosicionArancelaria" tabindex="6">
        <option value="0" selected>10</option>
        <option value="20">20</option>
        <option value="30">30</option>
        <option value="0">40</option>
        <option value="0">50</option>
        <option value="0">60</option>
        <option value="0">70</option>
        <option value="0">81</option>
        <option value="0">82</option>
        <option value="0">83</option>
        <option value="0">91</option>
        <option value="0">92</option>
        <option value="0">93</option>
        <option value="0">94</option>
        <option value="0">95</option>
        <option value="0">96</option>
        <option value="0">97</option>
        <option value="0">99</option>
      </select></td>
      <td>&nbsp;</td>
      <td class="txtTextoJ">IVA (12%) </td>
      <td class="style3" align="center">$</td>
      <td><input name="txtIva1" type="text" id="txtIva1" value="19.68" ReadOnly></td>
    </tr>
    <tr>
      <td>&nbsp;</td>
      <td>&nbsp;</td>
      <td>&nbsp;</td>
      <td class="txtTextoJ">Total  CAE - DAS </td>
      <td class="style5" align="center">$</td>
      <td class="style5"><input name="txtTotalCaeDas" type="text" id="txtTotalCaeDas" value="20.50" ReadOnly></td>
    </tr>
    <tr>
      <td align="center"><INPUT Type="button" Value=" Calcular " onClick="javascript:Calcular();"></td>
      <td align="center"><INPUT Type="button" Value=" Limpiar " onClick="javascript:Reflesh();"></td>

      <td>&nbsp;</td>
      <td class="txtTextoJ"><div align="left">Facturaci&oacute; de Servicios </div></td>
      <td>&nbsp;</td>
      <td>&nbsp;</td>
    </tr>
    <tr>
      <td></td>
      <td>&nbsp;</td>
      <td>&nbsp;</td>
      <td class="txtTextoJ">TRAMITE</td>
      <td class="style3" align="center">$</td>
      <td><input name="txtTramite" type="text" id="txtTramite" value="5.00" ReadOnly></td>
    </tr>
    <tr>
      <td align="center"></td>
      <td align="center"></td>
      <td>&nbsp;</td>
      <td class="txtTextoJ">Flete Import </td>
      <td class="style3" align="center">$</td>
      <td><input name="txtFleteImport" type="text" id="txtFleteImport" value="320.00" ReadOnly></td>
    </tr>
    <tr>
      <td>&nbsp;</td>
      <td>&nbsp;</td>
      <td>&nbsp;</td>
      <td class="txtTextoJ">IVA (12%) </td>
      <td class="style3" align="center">$</td>
      <td><label>
        <input name="txtIva2" type="text" id="txtIva2" value="39.00" ReadOnly>
      </label></td>
    </tr>
	<tr>
      <td>&nbsp;</td>
      <td>&nbsp;</td>
      <td>&nbsp;</td>
      <td class="txtTextoJ">Seguro</td>
      <td class="style3" align="center">$</td>
      <td><label>
        <input name="txtSeguro" type="text" id="txtSeguro" value="0.00" ReadOnly>
      </label></td>
    </tr>
    <tr>
      <td>&nbsp;</td>
      <td>&nbsp;</td>
      <td>&nbsp;</td>
      <td class="txtTextoJ">TOTAL</td>
      <td class="style3" align="center">$</td>
      <td><label>
        <input name="txtTotal" type="text" id="txtTotal" value="364.00" ReadOnly>
      </label></td>
    </tr>
    <tr>
      <td>&nbsp;</td>
      <td>&nbsp;</td>
      <td>&nbsp;</td>
      <td class="txtTextoJ">TOTAL IMPORTACI&Oacute;N </td>
      <td class="style5" align="center">$</td>
      <td class="style5"><label>
        <input name="txtTotalImportacion" type="text" id="txtTotalImportacion" value="384.50" ReadOnly>
      </label></td>
    </tr>
    <tr>
      <td>&nbsp;</td>
      <td>&nbsp;</td>
      <td>&nbsp;</td>
      <td class="txtTextoJ">Cr&eacute;dito Tributario IVA </td>
      <td class="style5" align="center">$</td>
      <td class="style5"><label>
        <input name="txtCreditoTributarioIva" type="text" id="txtCreditoTributarioIva" value="58.68" ReadOnly>
      </label></td>
    </tr>
    <tr>
      <td>&nbsp;</td>
      <td>&nbsp;</td>
      <td>&nbsp;</td>
      <td class="txtTextoJ">Costo de Importaci&oacute;n </td>
      <td class="style5" align="center">$</td>
      <td class="style5"><label>
        <input name="txtCostoImportacion" type="text" id="txtCostoImportacion" value="325.82" ReadOnly>
      </label></td>
    </tr>
  </table>
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
