
<%@page import="java.sql.*" %>
<%@page import="java.time.LocalDateTime"%>
<%@page import="java.time.format.DateTimeFormatter"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    </head>
    <body>
        <div id="ventanaEmergente" class="ventana">
            <div>
                <h2>Ventana Emergente</h2>
                <p>Esta es una ventana emergente amigable.</p>
                <button onclick="cerrarVentana('foro.jsp')">Cerrar</button>
            </div>
        </div>
        <%
            HttpSession sesion = request.getSession();
            String active_username = String.valueOf(sesion.getAttribute("user"));
            request.setCharacterEncoding("UTF-8");
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
                conx = DriverManager.getConnection("jdbc:mysql://localhost:3306/Soporte?autoReconnect=true&useSSL=false","root", "n0m3l0");
                sta = conx.createStatement();
            }catch(SQLException error){
                out.print(error.toString());
            }
            try{
                sta.executeUpdate("INSERT INTO `publicaciones` (`id_publicacion`, `titulo`, `contenido`, `fecha_public`, `hora_public`, `id_usuario`) VALUES (default, '"+titulo+"', '"+contenido+"', '"+date+"', '"+time+"', '"+active_username+"');");
                out.println("<script>mostrarVentana('Publicación registrada', 'Ya puede visualizar su publicación')</script>");
                conx.close();
                sta.close();
            }catch(SQLException error){
                out.print(error.toString());
            }
        %>
        <h3>Registro dado de alta</h3>
    </body>
</html>
