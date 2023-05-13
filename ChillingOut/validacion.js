function validar(){
    formulario = document.getElementById("publicación");
    titulo = document.getElementById("titulo").value;
    contenido = document.getElementById("contenido").value;
    valido = (descripcion === "" || usuarioRepor === "");
    if (valido){
        alert("Llena todos los campos para poder publicar");
    } 
    else{
        formulario.submit();
    }

}