<%@ page import="java.sql.*" %>
<%@ page import="javax.sql.*" %>
<%@ page import="javax.naming.*" %>
<%@ page import="java.io.*" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>Actualizador</title>
</head>
<body>
<%
try{
  String favoritoParam = request.getParameter("favorito");
  boolean favorito = Boolean.parseBoolean(favoritoParam);
  String id_cancion = request.getParameter("cancionId");
  String user = request.getParameter("user");
  // Actualiza la base de datos según el valor del favorito
  if (favorito) {
    try{
        Connection conx = null;
    Statement sta = null;
     Class.forName("com.mysql.jdbc.Driver");
    conx = DriverManager.getConnection("jdbc:mysql://localhost:3306/ChillingOut?useUnicode=true&characterEncoding=UTF-8","root", "n0m3l0");
    sta = conx.createStatement();
        //Agregamos la columna a la base de datos
        String sql = "INSERT INTO favoritos (username, id_cancion) VALUES (?, ?)";
        PreparedStatement statement = conx.prepareStatement(sql);
        statement.setString(1, user);
        statement.setString(2, id_cancion);
        statement.executeUpdate();
        // Cerrar la conexión y el statement
        statement.close();
        conx.close();
    }catch(SQLException error){
        out.print(error.toString());
    }
  } else {
    try{
        Connection conx = null;
    Statement sta = null;
     Class.forName("com.mysql.jdbc.Driver");
    conx = DriverManager.getConnection("jdbc:mysql://localhost:3306/ChillingOut?useUnicode=true&characterEncoding=UTF-8","root", "n0m3l0");
    sta = conx.createStatement();
        //Agregamos la columna a la base de datos
        String sql = "DELETE FROM favoritos WHERE username = ? AND id_cancion = ?";
        PreparedStatement statement = conx.prepareStatement(sql);
        statement.setString(1, user);
        statement.setString(2, id_cancion);
        statement.executeUpdate();
        // Cerrar la conexión y el statement
        statement.close();
        conx.close();
    }catch(SQLException error){
        out.print(error.toString());
    }
  }
}catch(IOException e){
    out.println(e.toString());
}

%>
</body>
</html>