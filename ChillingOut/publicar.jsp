
<%@page import="java.sql.*" %>
<%@page import="java.time.LocalDateTime"%>
<%@page import="java.time.format.DateTimeFormatter"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
    <meta charset="UTF-8">
        <link rel="stylesheet" href="styles2.css">
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <script src="ventanitas.js"></script>
        <link rel="stylesheet" href="ventana.css">
        
    </head>
    <body>
        <div id="ventanaEmergente" class="ventana">
            <div class="contenido">
                <h2 id="titulo">Ventana Emergente</h2>
                <p id="texto">Esta es una ventana emergente amigable.</p>
                <button onclick="cerrarVentana('foro.jsp')">Cerrar</button>
            </div>
        </div>
        <%
            request.setCharacterEncoding("UTF-8");
            HttpSession sesion = request.getSession();
            String active_username = String.valueOf(sesion.getAttribute("user"));
            String titulo = request.getParameter("titulo");
            String contenido = request.getParameter("contenido");
            String dateTime = LocalDateTime.now().format(DateTimeFormatter.ofPattern("yyyy-MM-dd'T'HH:mm:ss"));
            String[] parts = dateTime.split("T");
            String time = parts[1];
            String date = parts[0];
            ResultSet resul = null;
            ResultSet resul1 = null;
            Connection conx = null;
            Statement sta = null;
            try{
                Class.forName("com.mysql.jdbc.Driver");
                conx = DriverManager.getConnection("jdbc:mysql://localhost:3306/ChillingOut?autoReconnect=true&useSSL=false","root", "n0m3l0");
                sta = conx.createStatement();
            }catch(SQLException error){
                out.print(error.toString());
            }
            try{
                sta.executeUpdate("INSERT INTO `publicaciones` (`id_publicacion`, `titulo`, `contenido`, `fecha_public`, `hora_public`, `username`) VALUES (default, '"+titulo+"', '"+contenido+"', '"+date+"', '"+time+"', '"+active_username+"');");
                out.println("<script>mostrarVentana('Publicación registrada', 'Ya puede visualizar su publicación')</script>");
                conx.close();
                sta.close();
            }catch(SQLException error){
                out.print(error.toString());
            }
        %>
    </body>
</html>
