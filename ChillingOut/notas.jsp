<%@page import="java.sql.*" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">

<head>
  <meta charset="UTF-8">
  <title>Document</title>
  <link rel="stylesheet" href="styles2.css">
  <style>


  .containergeneral{
    display: flex;
    flex-direction: column;
    height: 100vh;
  }
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
      flex: 1;
      top: 200px;
      text-align: center;
    }

    .note-title {
      font-size: 24px;
      font-weight: bold;
      margin-bottom: 5px;
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

    .action-container {
  margin-top: 10px;
  font-size: 14px;
}

.button {
  background-color: #007bff;
  color: #fff;
  border: none;
  padding: 10px 20px;
  font-size: 16px;
  cursor: pointer;
}

/* Estilos para las notas */

.notes{
      top: 2px;
      text-align: center;
      align-self: center;
}
.note {

  margin-bottom: 10px;
  max-width: 100%;
  padding: 10px;
  background-color: #f2f2f2;
}

.note p {
  margin: 0;
}

.delete-button {
  background-color: #dc3545;
  color: #fff;
  border: none;
  padding: 5px 10px;
  font-size: 14px;
  cursor: pointer;
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

<body>
  <%
  HttpSession sesion = request.getSession();
  String usuarioId = sesion.getAttribute("user").toString();
  %>
  <div>
    <header clas="header">
      <div class="container">
        <div class="btn-menu">
          <label for="btn-menu">☰</label>
        </div>
        <div class="logo">
          <h1>ChillingOut</h1>
      </div>
    </header>
    <div class="capa"></div>
    <input type="checkbox" id="btn-menu" />
    <div class="container-menu">
      <div class="cont-menu">
        <nav>
          <a href="menu.html">Menú</a>
          <a href="music.html">Música</a>
          <a href="foro.jsp">Chat</a>
          <a href="phrases.html">Frases</a>
          <a href="games.html">Games</a>
        </nav>
        <label for="btn-menu">✖</label>
      </div>
    </div>
    <div class="containergeneral">
    <div class="note-container">
        <h1>Notas</h1>
    <form action="guardarNota.jsp" method="post">
        <input type="hidden" name="usuarioId" value="<%= usuarioId %>">
        <textarea class="note-textarea" maxlength="500" placeholder="Escribe tu nota aquí..." name="nota"></textarea>
        <div class="action-container">
          Caracteres restantes: <span id="character-count">500</span>
        </div>
        <button class="button">Guardar nota</button>
      </form>

      <div><br>
      
      </div>
    </div>
    <div class="notes">
    <h1>Mis notas</h1>
        <%-- Obtener las notas del usuario actual desde la base de datos --%>
        <%
          Connection con = null;
          Statement stmt = null;
          ResultSet rs = null;
  
          try {
            request.setCharacterEncoding("UTF-8");
            Class.forName("com.mysql.jdbc.Driver");
            con = DriverManager.getConnection("jdbc:mysql://localhost:3306/ChillingOut?useUnicode=true&characterEncoding=UTF-8","root","n0m3l0");
            stmt = con.createStatement();
            String query = "SELECT * FROM notas WHERE username LIKE '" + usuarioId+"'";
            rs = stmt.executeQuery(query);
            if (!rs.next()) {
            out.println("<h2>Crea tu primera nota!</h2>");
            }
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
        </div>
      </div>
  <script>
    const textarea = document.querySelector('.note-textarea');
    const characterCount = document.getElementById('character-count');
    
    textarea.addEventListener('input', function() {
      const remainingCharacters = 500 - textarea.value.length;
      characterCount.textContent = remainingCharacters;
    });

  </script>
</body>

</html>