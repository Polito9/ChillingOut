<%@page import="java.sql.*" %>
<!DOCTYPE html>
<html lang="en">

<head>
  <meta charset="UTF-8">
  <title>Document</title>
  <link rel="stylesheet" href="styles2.css">
  <style>
    .delete-button {
      background-color: #ff0000;
      color: #fff;
      border: none;
      padding: 5px 10px;
      border-radius: 3px;
      cursor: pointer;
    }
    .conect{
     margin-top: 50%;   
    }

    .buttons {
      display: flex;
      justify-content: center;
      margin-top: 1px;
      margin-bottom: 20px;
    }

    .button {
      display: inline-block;
      margin: 0 5px;
      padding: 10px 20px;
      background-color: #855b0d;
      color: #fff;
      text-decoration: none;
      border-radius: 5px;
      margin-left: -12%;
    }

    .button:hover {
      background-color: #333;
    }

    .note-container {
      position: relative;
      top: 200px;
      text-align: center;
      margin-bottom: 50px;
    }

    .note-title {
      font-size: 24px;
      font-weight: bold;
      margin-bottom: 20px;
    }

    .note-textarea {
      width: 400px;
      height: 200px;
      margin: 0 auto;
      resize: none;
      padding: 10px;
      border: 1px solid #ccc;
      border-radius: 5px;
    }

    .character-count {
      margin-top: 10px;
      font-size: 14px;
      color: #888;
    }

    @media screen and (max-width: 600px) {
      .note-container {
        top: 100px;
      }

      .note-textarea {
        width: 90%;
      }
    }

    @media screen and (max-width: 400px) {
      .note-textarea {
        height: 150px;
      }
    }
    .action-container {
      display: flex;  
      margin-top: 10px;
      margin-left: 38%;
    }
  </style>
</head>
<%
HttpSession sesion = request.getSession();
String usuarioId = sesion.getAttribute("user").toString();
%>
<body>
  <div>
    <header clas="header">
      <div class="container">
        <div class="btn-menu">
          <label for="btn-menu">☰</label>
        </div>
        <div class="logo">
          <h1>ChillingOut</h1>
        </div>
        <nav class="menu">
          <a href="/">Inicio</a>
          <a href="">Nosotros</a>
          <a href="">Contacto</a>
          <a href="#">Bienvenido</a>
        </nav>
      </div>
    </header>
    <div class="capa"></div>
    <input type="checkbox" id="btn-menu" />
    <div class="container-menu">
      <div class="cont-menu">
        <nav>
          <a href="register.html">Registro</a>
          <a href="login.html">Inicio de sesion</a>
          <a href="music.html">Música</a>
          <a href="formuPub.html">Chat</a>
          <a href="advice.html">Consejos de vida</a>
          <a href="phrases.html">Frases</a>
          <a href="games.html">Games</a>
        </nav>
        <label for="btn-menu">✖</label>
      </div>
    </div>
    <div class="note-container">
        <h1>Notas</h1>
    <form action="guardarNota.jsp" method="post">
        <input type="hidden" name="usuarioId" value="<%= usuarioId %>">
        <textarea class="note-textarea" maxlength="5000" placeholder="Escribe tu nota aquí..." name="nota"></textarea>
        <div class="action-container">
          Caracteres restantes: <span id="character-count">5000</span>
        </div>
        <button class="button">Guardar nota</button>
      </form>
    </div>

    <div class="conect">
        <%-- Obtener las notas del usuario actual desde la base de datos --%>
        <%
          Connection con = null;
          Statement stmt = null;
          ResultSet rs = null;
  
          try {
            Class.forName("com.mysql.jdbc.Driver");
            con = DriverManager.getConnection("jdbc:mysql://localhost:3306/ChillingOut?useUnicode=true&characterEncoding=UTF-8","root","n0m3l0");
            stmt = con.createStatement();
            String query = "SELECT * FROM notas WHERE username = " + usuarioId;
            rs = stmt.executeQuery(query);
  
            while (rs.next()) {
              int notaId = rs.getInt("id_nota");
              String nota = rs.getString("nota");
  
              out.println("<div class='note'>");
              out.println("<p>" + nota + "</p>");
              out.println("<button class='delete-button' onclick=\"location.href='eliminarNota.jsp?notaId=" + notaId + "'\">Eliminar</button>");
              out.println("</div>");
            }
          } catch (SQLException e) {
            out.println("Error: " + e.getMessage());
          } finally {
            if (rs != null) {
              try {
                rs.close();
              } catch (SQLException e) {
                out.println("Error: " + e.getMessage());
              }
            }
            if (stmt != null) {
              try {
                stmt.close();
              } catch (SQLException e) {
                out.println("Error: " + e.getMessage());
              }
            }
            if (con != null) {
              try {
                con.close();
              } catch (SQLException e) {
                out.println("Error: " + e.getMessage());
              }
            }
          }
        %>
  <script>
    const textarea = document.querySelector('.note-textarea');
    const characterCount = document.getElementById('character-count');
    
    textarea.addEventListener('input', function() {
      const remainingCharacters = 5000 - textarea.value.length;
      characterCount.textContent = remainingCharacters;
    });

  </script>
</div>
</body>

</html>