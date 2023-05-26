
function mostrarVentana(titulo, contenido) {
    var tituloVentana = document.getElementById('titulo');
    var contenidoVentana = document.getElementById('texto');

    // Actualizar el contenido de la ventana emergente con los parámetros recibidos
    tituloVentana.innerHTML = titulo;
    contenidoVentana.innerHTML = contenido;
    document.getElementById('ventanaEmergente').style.display = 'block';
}

// Función para cerrar la ventana emergente
function cerrarVentana(redirection) {
    document.getElementById('ventanaEmergente').style.display = 'none';
    window.open(redirection, "_self"); 
}