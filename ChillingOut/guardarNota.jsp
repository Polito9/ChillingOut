<%@ page import="java.sql.*" %>
<%@ page import="javax.sql.*" %>
<%@ page import="javax.naming.*" %>
<%@ page import="java.io.*" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>Guardar Nota</title>
    <link rel="stylesheet" href="ventana.css">
    <script src="ventanitas.js"></script>
    <!-- Cualquier otro estilo o script necesario -->
</head>
<body>
    <div id="ventanaEmergente" class="ventana">
        <div class="contenido">
            <h2 id="titulo">Ventana Emergente</h2>
            <p id="texto">Esta es una ventana emergente amigable.</p>
            <button onclick="cerrarVentana('notas.jsp')">Cerrar</button>
        </div>
    </div>
<%
request.setCharacterEncoding("UTF-8");
HttpSession sesion = request.getSession();
String id_usuario = String.valueOf(sesion.getAttribute("user"));
String nota = request.getParameter("nota");
int myInt = 0;
// Establecer conexión a la base de datos
Connection conx = null;
Statement sta = null;

try {
    
    Class.forName("com.mysql.jdbc.Driver");
    conx = DriverManager.getConnection("jdbc:mysql://localhost:3306/ChillingOut?useUnicode=true&characterEncoding=UTF-8","root", "n0m3l0");
    sta = conx.createStatement();
    // Insertar la nueva nota en la tabla 'notas'
    String sql = "INSERT INTO notas (nota, username) VALUES (?, ?)";
    PreparedStatement statement = conx.prepareStatement(sql);
    statement.setString(1, nota);
    statement.setString(2, id_usuario);
    statement.executeUpdate();

    // Cerrar la conexión y el statement
    statement.close();
    conx.close();

    // Redireccionar de regreso
    out.println("<script>mostrarVentana('Nota guardada', 'Puede cerrar la ventana')</script>");
} catch (SQLException error) {
    out.print(error.toString());
} catch (ClassNotFoundException error) {
    out.print(error.toString());
}
%>
</body>
</html>
