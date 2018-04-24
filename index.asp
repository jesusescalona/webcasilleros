<%@LANGUAGE="VBSCRIPT" CODEPAGE="1252"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
<title>Zaicargo - Casillero Postal</title>

<script type='text/javascript' src='ValidarEmail.js'></script>

<script type="text/javascript">
function validar(e,obj) {
  tecla = (document.all) ? e.keyCode : e.which;
  if (tecla != 13) return;
  filas = obj.rows;
  txt = obj.value.split('\n');
  return (txt.length < filas);
}

function fp(URL)
{
    var winl = (screen.width - 400) / 2;
    var wint = (screen.height - 400) / 2;
	
	window.open(URL,"cityPopUp","width=400,height=400,top=" + wint + ",left=" + winl + ",scrollbars=no,toolbar=no,resizable=yes");
}
</script>

<link href="Imagenes/estilos.css" rel="stylesheet" type="text/css" />
<style type="text/css">
<!--
.style1 {color: #FFFFFF}
.style2 {font-family: Arial, Helvetica, sans-serif}
.style4 {
	color: #FFFFFF;
	font-size: 14px;
}
.style5 {font-size: 12px}
-->
</style>
</head>

<body>
<table width="800" border="0" cellspacing="0" cellpadding="0" align="center">
  <tr style="background:url(Imagenes/Gradiente_Cabecera_Z.png)">
    <td colspan="2" scope="col" height="97" valign="bottom">
      <div align="right" style="vertical-align:bottom">
      <form action="clientes/login.asp" method="POST" name="frmaIngreso">
        <table width="200" border="0" cellspacing="0" cellpadding="0" align="right">
          <tr>
            <td align="left">&nbsp;</td>
            <td align="left"><div align="right"><span class="txtTextoI">Usuario: </span></div></td>
            <td align="left"><input name="usuario" type="text" class="txtCajas" size="8" /></td>
          </tr>
          <tr>
            <td align="left">&nbsp;</td>
            <td align="left"><div align="right"><span class="txtTextoI">Clave:</span></div></td>
            <td align="left"><input name="clave" type="password" class="txtCajas" size="8" /></td>
          </tr>
          <tr>
            <td colspan="2" align="right"><a href="javascript:fp('oc.asp');">Olvido su clave?</a></td>
            <td align="left"><input name="Ingreso" type="submit" value="Ingresar" class="btnAccion" /></td>
          </tr>
        </table>
        </form>
  </div><a href="http://www.zaicargo.com" target="_blank"><img src="Imagenes/Logo.png" alt="Zaicargo" width="205" height="60" border="0" /></a>
  </tr>
   <tr>
    <th colspan="2" scope="col"><img src="Imagenes/Division.png" alt="Head" width="800" height="1"  /></th>
  </tr>
  <tr>
    <th colspan="2" scope="col"><img src="Imagenes/Banner.jpg" alt="Casillero" width="800" height="250" /></th>
  </tr>
  <tr>
    <td valign="top" bgcolor="#3086BC">
		<table width="200" border="0" cellspacing="0" cellpadding="0" bgcolor="#3086BC">
      		<tr bgcolor="#3086BC">
        		<th scope="col"><object classid="clsid:D27CDB6E-AE6D-11cf-96B8-444553540000" codebase="http://download.macromedia.com/pub/shockwave/cabs/flash/swflash.cab#version=7,0,19,0" width="200" height="216" title="Menu">
                  <param name="movie" value="Imagenes/Menu.swf" />
                  <param name="quality" value="high" />
                  <embed src="Imagenes/Menu.swf" quality="high" pluginspage="http://www.macromedia.com/go/getflashplayer" type="application/x-shockwave-flash" width="200" height="216"></embed>
      		  </object></th>
      		</tr>
    	</table>
        
        <table align="center">
        	<tr>
            	<td><div align="center" class="letrasLCEsp"><!-- BEGIN PHP Live! code, (c) OSI Codes Inc. -->
<script language="JavaScript" src="http://66.165.166.213:88/chat/js/status_image.php?base_url=http://66.165.166.213:88/chat&l=admin&x=1&deptid=0&"><a href="http://www.phplivesupport.com"></a></script>
<!-- END PHP Live! code : (c) OSI Codes Inc. --></div></td>
            </tr>
        </table>
        	</td>
	<td style="vertical-align:top">
		<table width="600" border="0" cellspacing="0" cellpadding="0" height="216" style="background:url(Imagenes/body.jpg)">
			<tr valign="top">
        		<th scope="col"><img src="Imagenes/CabeceraFacil.png" alt="Head" width="600" height="20" /></th>
      		</tr>
      		<tr>
        		<th scope="col"><p><a href="registro.asp"><img src="Imagenes/Paso1.png" alt="Registro" width="200" height="146" border="0" /></a><a href="registro.asp"><img src="Imagenes/Paso2.png" alt="Compra" width="200" height="146" border="0" /></a><a href="registro.asp"><img src="Imagenes/Paso3.png" alt="Paquetes" width="200" height="146" border="0" /></a></p>
       		    <form action="formu01.asp" method="POST" onsubmit="return validaForma(this)" name="frmMail"> 
<table border="1" align="center">
  <tr>
    <td colspan="2" bgcolor="#006699"><div align="center" class="style5 style1 style2"><span class="style4">SUGERENCIAS</span></div></td>
    </tr>
  
  <tr>
    <td><div align="left"><span class="style2 style1 style5">Nombre:</span></div></td>
    <td><input name="nombre" type="Text" size="40" maxlength="200"> </td>
  </tr>
  <tr>
    <td><div align="left"><span class="style2 style1 style5">Apellido:</span></div></td>
    <td><input name="apellido" type="Text" size="40" maxlength="200" /></td>
  </tr>
  <tr>
    <td><div align="left"><span class="style2 style1 style5">Email:</span></div></td>
    <td><input name="email" type="text" size="40" maxlength="200" /></td>
  </tr>
  
  
  <tr>
    <td><div align="left"><span class="style2 style1"><span class="style5">Sugerencias:</span> </span></div></td>
    <td><span class="style2">
      <textarea name="datos" cols="31" rows="4" onkeypress = "return validar(event,this)"></textarea>
    </span></td>
  </tr>
    <td colspan="2" align="center"><input name="submit" type="submit" value="Enviar"></td>
    </tr>
</table>

</form>
</th>
      		</tr>
    	</table>	</td>
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
