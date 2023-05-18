<%@ page import="java.sql.*" %>
<%@ page import="javax.sql.*" %>
<%@ page import="javax.naming.*" %>
<%@ page import="java.io.*" %>
<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>Guardar Nota</title>
    <link rel="stylesheet" href="css/style.css">
    <!-- Cualquier otro estilo o script necesario -->
</head>
<body>
<%
int usuarioId = Integer.parseInt(request.getParameter("id_usuario"));
String nota = request.getParameter("nota");

// Establecer conexión a la base de datos
Connection conx = null;
Statement sta = null;

try {
    Class.forName("com.mysql.jdbc.Driver");
    conx = DriverManager.getConnection("jdbc:mysql://localhost:3306/relaxing?useUnicode=true&characterEncoding=UTF-8","root", "n0m3l0");
    sta = conx.createStatement();

    // Insertar la nueva nota en la tabla 'notas'
    String sql = "INSERT INTO notas (id_usuario, nota) VALUES (?, ?)";
    PreparedStatement statement = conx.prepareStatement(sql);
    statement.setInt(1, usuarioId);
    statement.setString(2, nota);
    statement.executeUpdate();

    // Cerrar la conexión y el statement
    statement.close();
    conx.close();

    // Redireccionar de regreso
    response.sendRedirect("notas.html");
} catch (SQLException error) {
    out.print(error.toString());
} catch (ClassNotFoundException error) {
    out.print(error.toString());
}
%>
</body>
</html>