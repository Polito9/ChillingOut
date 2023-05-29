<%@ page import="java.sql.*" %>
<%@ page import="javax.sql.*" %>
<%@ page import="javax.naming.*" %>
<%@ page import="java.io.*" %>
<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>Eliminar Nota</title>
    <link rel="stylesheet" href="css/style.css">
    <!-- Cualquier otro estilo o script necesario -->
</head>
<body>
<%
HttpSession sesion = request.getSession();
String usuarioId = sesion.getAttribute("user").toString();
String nota = request.getParameter("notaId");

Connection conx = null;
Statement sta = null;

try {
    Class.forName("com.mysql.jdbc.Driver");
    conx = DriverManager.getConnection("jdbc:mysql://localhost:3306/ChillingOut?useUnicode=true&characterEncoding=UTF-8","root", "n0m3l0");
    sta = conx.createStatement();

    // Eliminar la nota de la tabla 'notas'
    String sql = "DELETE FROM notas WHERE username = ? AND id_nota = ?";
    PreparedStatement statement = conx.prepareStatement(sql);
    statement.setString(1, usuarioId);
    statement.setString(2, nota);
    statement.executeUpdate();
    // Cerrar la conexión y el statement
    statement.close();
    conx.close();

    // Redireccionar de regreso a notas
    response.sendRedirect("notas.jsp?usuarioId=" + usuarioId);
} catch (SQLException error) {
    out.print(error.toString());
} catch (ClassNotFoundException error) {
    out.print(error.toString());
}
%>
</body>
</html>
