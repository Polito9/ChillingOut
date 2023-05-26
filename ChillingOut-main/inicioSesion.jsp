<%@page import="java.sql.*"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Altas</title>
        <script src="ventanitas.js"></script>
        <link rel="stylesheet" href="ventana.css">
    </head>
    <body>
        <%
        
            HttpSession sesion = request.getSession();
            String usu = request.getParameter("username");
            String pass = request.getParameter("password");
            sesion.setAttribute("user", usu);
            Connection conx = null;
            Statement sta = null;
            ResultSet resultSet = null;
            String closeWindow = "cerrarVentana('register.html')";
            try{
                Class.forName("com.mysql.jdbc.Driver");   
                //para establecerr la conexión con la base de datos
                conx = DriverManager.getConnection("jdbc:mysql://localhost:3306/ChillingOut?useUnicode=true&characterEncoding=UTF-8","root", "n0m3l0");
                sta = conx.createStatement();
            }catch(SQLException error){
                out.print(error.toString());
            }
            try{
                out.println("<div id='ventanaEmergente' class='ventana'><div class='contenido'><h2 id='titulo'>Ventana Emergente</h2><p id='texto'>Esta es una ventana emergente amigable.</p>");
                resultSet = sta.executeQuery("SELECT * FROM `usuarios` WHERE `username` LIKE '"+usu+"' AND `contrasenia` LIKE '"+pass+"'") ;
                if (resultSet.next()){
                    closeWindow = "cerrarVentana('menu.html')";
                    closeWindow = closeWindow.replace("'", "&#39;");
                    out.println("<button onclick='"+closeWindow+"''>Cerrar</button></div></div>");
                    out.println("<script>mostrarVentana('Usuario correcto', 'Bienvenido!')</script>");
                }
                else{
                    closeWindow =   "cerrarVentana('login.html')";
                    closeWindow = closeWindow.replace("'", "&#39;");
                    out.println("<button onclick='"+closeWindow+"''>Cerrar</button></div></div>");
                    out.println("<script>mostrarVentana('Usuario incorrecto', 'Intentelo nuevamente')</script>");
                }
                conx.close();
                sta.close();
            }catch (SQLException error){
                out.print(error.toString());
            }
        %>
    </body>
</html>