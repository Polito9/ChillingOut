<%@page import="java.sql.*"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Registro</title>
        <link rel="stylesheet" href="ventana.css">
        <script src="ventanitas.js"></script>
    </head>
    <body>
        
        <%
        HttpSession sesion = request.getSession();
        String name = request.getParameter("name");
        String age = request.getParameter("age");
        String username = request.getParameter("username");
        String password = request.getParameter("password");
        String email = request.getParameter("email");
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
        String query1 = "SELECT * FROM `usuarios` where `username` = '"+username+"';";
        try{
            out.println("<div id='ventanaEmergente' class='ventana'><div class='contenido'><h2 id='titulo'>Ventana Emergente</h2><p id='texto'>Esta es una ventana emergente amigable.</p>");
            resultSet = sta.executeQuery(query1);
            if (resultSet.next()){
                closeWindow =   "cerrarVentana('register.html')";
                closeWindow = closeWindow.replace("'", "&#39;");
                out.println("<button onclick='"+closeWindow+"''>Cerrar</button></div></div>");
                out.println("<script>mostrarVentana('Usuario duplicado', 'Ese username esta ocupado, intente con otro')</script>");
                conx.close();
                sta.close();
            }
            else{

                String query = "INSERT INTO `usuarios` (`username`, `nombre`, `edad`, `contrasenia`, `correo`) VALUES ('"+username+"', '"+name+"', '"+age+"' , '"+password+"', '"+email+"');";            
            try{
                
                sta.executeUpdate(query) ;
                out.println("<script>mostrarVentana('Datos guardados', 'Usuario registrado')</script>");
                conx.close();
                sta.close();
                closeWindow =   "cerrarVentana('login.html')";
                closeWindow = closeWindow.replace("'", "&#39;");
                out.println("<button onclick='"+closeWindow+"'>Cerrar</button></div></div>");
            }catch (SQLException error){
                out.print(error.toString());
            }
            }
        }catch(SQLException error){
            out.print(error.toString());
        } 
        %>
    </body>
</html>