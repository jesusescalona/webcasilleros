<%@LANGUAGE="VBSCRIPT" CODEPAGE="1252"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
<title>Zaicargo - Casillero Postal</title>
<link href="Imagenes/estilos.css" rel="stylesheet" type="text/css" />

<script LANGUAGE="JavaScript"> 


   function Calcular(txtPesoLibras, txtImpuesto, txtSeguro, txtAlto, txtAncho, txtLargo)
   { 
    
	//Declaración de variables 
	var r=1;
	 
	 //Validar los campos, que no sean nulos y que sean numéricos 
	if (formulario.txtPesoLibras.value=="") {r=0;alert("Por favor ingrese el Peso en Libras"); formulario.txtPesoLibras.focus}
	else if (formulario.txtPesoLibras.value<1) {r=0;alert("El Peso debe ser mínimo de 1 Libra"); formulario.txtPesoLibras.focus}
	else if (formulario.txtImpuesto.value=="") {r=0;alert("Por favor ingrese el Valor a declarar"); formulario.txtImpuesto.focus}
	else if (formulario.txtAlto.value=="" || formulario.txtAlto.value=="0") {r=0;alert("Por favor ingrese el Alto del paquete"); formulario.txtImpuesto.focus}
	else if (formulario.txtAncho.value=="" || formulario.txtAncho.value=="0") {r=0;alert("Por favor ingrese el Ancho del paquete"); formulario.txtImpuesto.focus}
	else if (formulario.txtLargo.value=="" || formulario.txtLargo.value=="0") {r=0;alert("Por favor ingrese el Largo del paquete"); formulario.txtImpuesto.focus}
	else if (formulario.txtSeguro.value=="") {r=1;formulario.txtSeguro.value=0};
  
  if (r==1){
   
  var VarPesoL;
  var VarImpuesto;
  var VarImpuestoI;
  var VarSeguro;
  var VarSeguroI;
  var VarTotalImportacion;
  var VarDimensiones;
  var VarDolarPeso;
  var VarPesoLimite;
  var VarRecargoDistribucion;
  
  VarDimensiones = parseFloat(formulario.txtAlto.value) * parseFloat(formulario.txtAncho.value) * parseFloat(formulario.txtLargo.value); 
  VarPesoL = parseFloat(formulario.txtPesoLibras.value);
  VarImpuesto = parseFloat(formulario.txtImpuesto.value);
  VarImpuestoI = VarImpuesto /** 0.28;*/
  VarSeguro = parseFloat(formulario.txtSeguro.value);
  VarSeguroI = VarSeguro * 0.05;
  VarRecargoDistribucion = 10;
  
   //if (formulario.txtPesoLibras.value < 6) {VarDolarPeso = 15}
  if (formulario.txtPesoLibras.value < 6) {VarDolarPeso = 6; VarPesoLimite = 0}
  else {VarDolarPeso = 6; VarPesoLimite = 0}
  
  if (VarDimensiones/166 > VarPesoL) {VarPesoL = VarDimensiones/166 * VarDolarPeso}
  //else {VarPesoL = VarPesoL * VarDolarPeso};
  else if (VarPesoLimite == 15) {VarPesoL = VarPesoLimite}
  else {VarPesoL = VarPesoL * VarDolarPeso};
  
  //VarTotalImportacion = (VarPesoL + VarImpuesto + VarImpuestoI + VarSeguro + VarSeguroI);
  VarTotalImportacion = (VarPesoL + VarImpuestoI + VarSeguroI + VarRecargoDistribucion);
  VarTotalImportacion = Math.round(VarTotalImportacion*100)/100;
  formulario.txtTotalImportacion.value = VarTotalImportacion;
	  
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

<table width="800" border="0" cellspacing="0" cellpadding="0" align="center" style="background:url(Imagenes/Body.jpg)">
  <tr style="background:url(Imagenes/Gradiente_Cabecera_Y.png)">
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
		<td colspan="4"><p align="center" class="txtTituloC"><strong>URUGUAY</strong></p>		  <div align="center" class="txtTituloC"></div></td>
	</tr>
    <tr>
      <td width="67" class="style2">&nbsp;</td>
	  <td width="228" class="txtTextoBJ"><div align="left">Peso en Libras</div></td>
      <td width="145" class="style2"><span class="style3"><span class="style18">
        <input name="txtPesoLibras" type="text" id="txtPesoLibras" tabindex="2" value="1"  maxlength="10">
      </span></span></td>
      <td width="142" class="style2">&nbsp;</td>
    </tr>
    <tr>
      
      <td class="style2">&nbsp;</td>
	  <td class="txtTextoBJ"><div align="left">Valor a declarar (Impuesto) </div></td>
      <td class="style2"><span class="style3"><span class="style18">
        <input name="txtImpuesto" type="text" id="txtImpuesto" tabindex="3" value="0" readonly="readonly" disabled="disabled">
      </span></span></td>
      <td class="style2">&nbsp;</td>
    </tr>
    <tr>
      <td class="style2">&nbsp;</td>
      <td class="txtTextoBJ"><div align="left">Dimensiones Alto (Pulgadas)  </div></td>
      <td class="style2"><span class="style3"><span class="style18">
        <input name="txtAlto" type="text" id="txtAlto" tabindex="3" value="0" >
      </span></span></td>
      <td class="style2">&nbsp;</td>
    </tr>
    <tr>
      <td class="style2">&nbsp;</td>
      <td class="style2"><div align="left"><span class="txtTextoBJ">Dimensiones Ancho (Pulgadas)  </span></div></td>
      <td class="style2"><span class="style3"><span class="style18">
        <input name="txtAncho" type="text" id="txtAncho" tabindex="3" value="0" >
      </span></span></td>
      <td class="style2">&nbsp;</td>
    </tr>
    <tr>
      
      <td class="style2">&nbsp;</td>
	  <td class="style2"><div align="left"><span class="txtTextoBJ">Dimensiones Largo (Pulgadas)  </span></div></td>
      <td class="style2"><span class="style3"><span class="style18">
        <input name="txtLargo" type="text" id="txtLargo" value="0" >
      </span></span></td>
      <td class="style2">&nbsp;</td>
    </tr>
    <tr>
      <td class="style2">&nbsp;</td>
      <td class="style2"><div align="left"><span class="txtTextoBJ">Valor a Asegurar </span></div></td>
      <td class="style2"><span class="style3"><span class="style18">
        <input name="txtSeguro" type="text" id="txtSeguro" value="0" readonly="readonly">
      </span></span></td>
      <td class="style2">&nbsp;</td>
    </tr>
    <tr>
      
      <td class="style2">&nbsp;</td>
	  <td class="txtTextoBJ"><div align="left">Total</div></td>
      <td class="style2"><span class="style3">
        <input name="txtTotalImportacion" type="text" id="txtTotalImportacion" value="0" ReadOnly>
      </span></td>
      <td class="style2">&nbsp;</td>
    </tr>
    
    <tr>
	
      <td colspan="4" align="center"><br><INPUT Type="button" Value=" Calcular " onClick="javascript:Calcular();">        <INPUT Type="button" Value=" Limpiar " onClick="javascript:Reflesh();">
        <label></label>        
        <label></label>        
        <label></label>        
        <label></label>        
        <label></label>        <label></label></td>
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
