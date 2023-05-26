function validar(){
    formulario = document.getElementById("publicacion");
    titulo = document.getElementById("titulo").value;
    contenido = document.getElementById("contenido").value;
    valido = (contenido === "");
    if (valido){
        alert("Necesitas escribir algo para poder publicar algo");
    } 
    else{
        formulario.submit();
    }
}