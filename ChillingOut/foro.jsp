<%@ page import="java.sql.*" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html>
<head>
  <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
  <title>ForoVirtual</title>
  <link rel="stylesheet" href="styles2.css">
  <style>
  body {

    font-family: Arial, sans-serif;
    margin: 0;
    padding: 20px;
  }

  h1 {
    text-align: center;
  }

  .publicacion {
    border: 1px solid #ccc;
    border-radius: 5px;
    padding: 10px;
    margin-bottom: 20px;
  }

  h2 {
    color: #dbd9d9;
    font-size: 18px;
    margin-top: 0;
  }

  p {
    color: #b6b9ff;
    margin: 5px 0;
  }

  .publicacion p:first-child {
    font-weight: bold;
  }

  .publicacion p:nth-child(2),
  .publicacion p:nth-child(3) {
    font-style: italic;
  }
  .register {
      display: inline-block;
      padding: 10px 20px;
      margin: 5px;
      background-color: #c7c7c7;
      text-decoration: none;
      border-radius: 3px;
      font-size: 30px;
  }
  a:hover{
    background-color: #e482d2;
  }
  .delete-button {
      background-color: #ff0000;
      color: #fff;
      border: none;
      padding: 5px 10px;
      border-radius: 3px;
      cursor: pointer;
    }
</style>
</head>

<body>
    <header clas="header">
      <div class="container">
        <div class="btn-menu">
          <label for="btn-menu">☰</label>
        </div>
        <div class="logo">
          <h1>ChillingOut</h1>
        </div>
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
    </div>
    <br><br><br><br>
  <div class="foro">
  <h1>Foro Virtual</h1>
  <% 
  request.setCharacterEncoding("UTF-8");
  HttpSession sesion = request.getSession();
  String id_usuario = String.valueOf(sesion.getAttribute("user"));
    Connection connection = null;
    Statement statement = null;
    ResultSet resultSet = null;
    try {
      // Establecer la conexi�n con la base de datos
      Class.forName("com.mysql.jdbc.Driver");
      connection = DriverManager.getConnection("jdbc:mysql://localhost:3306/ChillingOut?autoReconnect=true&useSSL=false","root", "n0m3l0");

      // Obtener las publicaciones del foro
      statement = connection.createStatement();
      resultSet = statement.executeQuery("SELECT * FROM publicaciones ORDER BY fecha_public DESC");

      // Iterar sobre los resultados y mostrar las publicaciones
      while (resultSet.next()) {
        String titulo = resultSet.getString("titulo");
        String contenido = resultSet.getString("contenido");
        String autor = resultSet.getString("username");
        Date fecha = resultSet.getDate("fecha_public");
        int id_pub = resultSet.getInt("id_publicacion");
        // Generar el c�digo HTML para mostrar cada publicaci�n
        %>
        <div class="publicacion">
          <h2><%= titulo %></h2>
          <p><%= contenido %></p>
          <br>
          <p>Autor: <%= autor %></p>
          <p>Fecha: <%= fecha %></p>
          <%
          
          if (autor.equals(id_usuario)){
            out.println("<button class='delete-button' onclick=\"location.href='eliminarPub.jsp?idPub=" + id_pub + "'\">Eliminar</button>");
          }
          %>
        </div>
        <%
      }
    } catch (Exception e) {
      e.printStackTrace();
    } finally {
      // Cerrar recursos y liberar la conexi�n a la base de datos
      if (resultSet != null) {
        try { resultSet.close(); } catch (Exception e) {}
      }
      if (statement != null) {
        try { statement.close(); } catch (Exception e) {}
      }
      if (connection != null) {
        try { connection.close(); } catch (Exception e) {}
      }
    }
  %>
  <a href="formuPub.html" class="register">Publica algo</a>
  </div>
</body>
</html>
