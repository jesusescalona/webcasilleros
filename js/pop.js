
    var popup = document.getElementById("poper");
    var boton = document.getElementById("but");

    function cambio(){
    	popup.style.display="block";
    
    }
    
    boton.onclick = cambio;
    

    var cerrado = document.getElementById("close");

    function cerrar(){
    	popup.style.display="none";
    
    }

    cerrado.onclick = cerrar;