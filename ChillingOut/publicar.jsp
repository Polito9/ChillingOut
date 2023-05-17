
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
                <button onclick="cerrarVentana('asistente.jsp')">Cerrar</button>
            </div>
        </div>
        <%
            HttpSession sesion = request.getSession();
            String active_username = String.valueOf(sesion.getAttribute("user"));
            request.setCharacterEncoding("UTF-8");
            String descripcion = request.getParameter("descripcion");
            String usuarioRepor = request.getParameter("usuarioRepor");
            String idAsistente = request.getParameter("idAsistente");
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
                boolean existe = false;  
                resul = sta.executeQuery("select * from Actores where username like '"+usuarioRepor+"';");
                
                existe = (resul.next());
                resul.close();
                if(existe){
                    sta.executeUpdate("INSERT INTO `Reportes` (`id`, `fecha_reportado`, `hora_reportado`, `descripcion`, `usuario_reporto`, `assistant_username`, `gerente_soporte_asignado`, `gerente_mantenimiento_asignado`, `ingeniero_asignado_mantenimiento`, `ingeniero_asignado_soporte`, `fecha_asignacion`, `hora_asignacion`, `estado`, `retroalimentacion`, `fecha_terminado`, `hora_terminado`) VALUES (default, '"+date+"', '"+time+"', '"+descripcion+"', '"+usuarioRepor+"', '"+active_username+"', 'Sin asignar', 'Sin asignar', 'Sin asignar', 'Sin asignar', '1900-01-01', '00:00:00', 'Abierto', 'Sin asignar', '1900-01-01', '00:00:00');") ;
                    out.println("<script>mostrarVentana('Datos guardados', 'Reporte dado de alta')</script>");
                }else{
                    out.println("<script>mostrarVentana('Advertencia', 'No existe el usuario')</script>");
                }
                conx.close();
                sta.close();
            }catch(SQLException error){
                out.print(error.toString());
            }
        %>
        <h3>Registro dado de alta</h3>
    </body>
</html>
