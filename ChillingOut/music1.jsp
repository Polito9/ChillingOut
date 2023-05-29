<%@ page import="java.sql.*" %>
<%@ page import="java.io.*" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Document</title>
    <link rel="stylesheet" href="styles2.css">
    <style>
        #player-container {
          display: flex;
          justify-content: center;
          align-items: center;
        }
        .buttons {
        display: flex;
        justify-content: center;
        margin-top: 1px;
        margin-bottom: 20px;
        }

        .button {
        display: inline-block;
        margin: 0 5px;
        padding: 10px 20px;
        background-color: #855b0d;
        color: #fff;
        text-decoration: none;
        border-radius: 5px;
        }

        .button:hover {
        background-color: #333;
        }
        .content {
			display: flex;
			flex-direction: column;
			align-items: center;
			justify-content: center;
			height: 100vh;
		}
        h1 {
            color: #6b5b95;
            text-align: center;
        }

        button {
            background-color: #6b5b95;
            color: white;
            font-size: 1.2em;
            border: none;
            border-radius: 5px;
            padding: 10px 20px;
            margin: 20px;
            cursor: pointer;
        }

        button:hover {
            background-color: #a692ba;
            color: #6b5b95;
        }
        /*marcar como favorito*/
        .favorite-checkbox {
        display: none;
        }

        .checkmark {
        position: relative;
        display: inline-block;
        width: 20px;
        height: 20px;
        background-color: #000000;
        border-radius: 30%;
        }

        .checkmark:before {
        content: "";
        position: absolute;
        top: 50%;
        left: 50%;
        transform: translate(-50%, -50%);
        width: 12px;
        height: 12px;
        background-color: #fbfbfb;
        border-radius: 50%;
        opacity: 0;
        transition: opacity 0.3s;
        }

        .favorite-checkbox:checked + .checkmark:before {
        opacity: 1;
        background-color: #fdf507;
        width: 15px;
        height: 15px;
        }
      </style>
</head>
<body>
<%
HttpSession sesion = request.getSession();
String usuarioId = sesion.getAttribute("user").toString();
%>
    <header clas="header">
        <div class="container">
            <div class="btn-menu">
                <label for="btn-menu">☰</label>
            </div>
            <div class="logo">
                <h1>ChillingOut</h1>
            </div>
            <nav class="menu">
                <a href="/">Inicio</a>
                <a href="">Nosotros</a>
                <a href="">Contacto</a>
                <a href="#">Bienvenido</a>
            </nav>
        </div>
    </header>
    <div class="capa"></div>
    <input type="checkbox" id="btn-menu" />
    <div class="container-menu">
        <div class="cont-menu">
            <nav>
                <a href="menu.html">Menú</a>
                <a href="music.html">Música</a>
                <a href="foro.jsp">Chat</a>
                <a href="phrases.html">Frases</a>
                <a href="games.html">Games</a>
              </nav>
            <label for="btn-menu">✖</label>
        </div>
    </div><br><br><br>
    <div class="content">
        <div class="buttons">
            <a href="music1.jsp" class="button">Crazy on you</a>
            <a href="music2.jsp" class="button">X - Poor Girl</a>
            <a href="music3.jsp" class="button">Come and Get Your Love</a>
            <a href="music4.jsp" class="button">Since You Been Gone</a>
            <a href="music5.jsp" class="button">I'm not in love</a>
            <a href="music6.jsp" class="button">Wicked Game</a>
            <a href="music7.jsp" class="button">Just the Way You Are</a>
          </div>
          <div id="player-container">
            <div id="player"></div>
        </div>
        <br>
        <label for="favorite-checkbox">
        <%
        request.setCharacterEncoding("UTF-8");
        Connection connection = null;
        Statement statement = null;
        ResultSet resultSet = null;
        try {
        // Establecer la conexi�n con la base de datos
        Class.forName("com.mysql.jdbc.Driver");
        connection = DriverManager.getConnection("jdbc:mysql://localhost:3306/ChillingOut?autoReconnect=true&useSSL=false","root", "n0m3l0");

        // Obtener las publicaciones del foro
        statement = connection.createStatement();
        resultSet = statement.executeQuery("SELECT * FROM favoritos WHERE id_cancion = 1 AND username = '"+usuarioId+"';");

        if(resultSet.next()){
          out.println("<input type='checkbox' id='favorite-checkbox' class='favorite-checkbox' onchange='updateFavorite()' checked>");
        }else{
          out.println("<input type='checkbox' id='favorite-checkbox' class='favorite-checkbox' onchange='updateFavorite()'>");
        }
        statement.close();
        connection.close();
        resultSet.close();
        }catch(SQLException error){
          out.print(error.toString());
        }
        %>
            <span class="checkmark"></span>
            Favorito
            <input type="hidden" id="cancion-id" value="1">
            <input type="hidden" id="user" value="<%= usuarioId %>">
        </label>
    </div>
    
<script src="https://www.youtube.com/iframe_api"></script>
<script>
  // Variable global para almacenar el reproductor de video
  var player;

  // Función para inicializar el reproductor de video
  function onYouTubeIframeAPIReady() {
    player = new YT.Player('player', {
      height: '360', // Altura del reproductor
      width: '640', // Ancho del reproductor
      videoId: 'OZuW6BH_Vak', // ID del video de YouTube
      playerVars: {
        autoplay: 1, // Reproducción automática (opcional)
        controls: 1, // Mostrar controles del reproductor (opcional)
        modestbranding: 1 // Ocultar el logo de YouTube (opcional)
      },
      events: {
        'onReady': onPlayerReady,
        'onStateChange': onPlayerStateChange
      }
    });
  }

  // Función que se ejecuta cuando el reproductor está listo
  function onPlayerReady(event) {
    event.target.playVideo(); // Iniciar la reproducción del video
  }

  // Función que se ejecuta cuando cambia el estado del reproductor
  function onPlayerStateChange(event) {
    // Aquí puedes realizar acciones adicionales según el estado del reproductor (opcional)
  }



  function updateFavorite() {
  var checkbox = document.getElementById("favorite-checkbox");
  var isChecked = checkbox.checked;
var cancionId = document.getElementById("cancion-id").value;
var userId = document.getElementById("user").value;
  // Envía una solicitud AJAX al servidor
  var xhr = new XMLHttpRequest();
  xhr.open("POST", "actualizarFavorito.jsp", true);
  xhr.setRequestHeader("Content-Type", "application/x-www-form-urlencoded");
  xhr.onreadystatechange = function () {
    if (xhr.readyState === 4 && xhr.status === 200) {
      // Respuesta del servidor
      console.log(xhr.responseText);
    }
  };
  
  // Envía los datos al servidor
  xhr.send("favorito=" + isChecked + "&cancionId=" + cancionId+ "&user=" + userId);
}
</script>

</body>
</html>