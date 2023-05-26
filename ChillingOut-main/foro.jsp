<%@ page import="java.sql.*" %>

<!DOCTYPE html>
<html>
<head>
  <title>ForoVirtual</title>
</head>
<body>
  <h1>Foro Virtual</h1>

  <% 
    Connection connection = null;
    Statement statement = null;
    ResultSet resultSet = null;
    try {
      // Establecer la conexi�n con la base de datos
      Class.forName("com.mysql.jdbc.Driver");
      connection = DriverManager.getConnection("jdbc:mysql://localhost:3306/Relaxing?autoReconnect=true&useSSL=false","root", "n0m3l0");

      // Obtener las publicaciones del foro
      statement = connection.createStatement();
      resultSet = statement.executeQuery("SELECT * FROM publicaciones ORDER BY fecha_public DESC");

      // Iterar sobre los resultados y mostrar las publicaciones
      while (resultSet.next()) {
        String titulo = resultSet.getString("titulo");
        String contenido = resultSet.getString("contenido");
        String autor = resultSet.getString("username");
        Date fecha = resultSet.getDate("fecha_public");

        // Generar el c�digo HTML para mostrar cada publicaci�n
        %>
        <div class="publicacion">
          <h2><%= titulo %></h2>
          <p><%= contenido %></p>
          <p>Autor: <%= autor %></p>
          <p>Fecha: <%= fecha %></p>
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
</body>
</html>
