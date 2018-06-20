<%-- 
    Document   : Logado
    Created on : 28/03/2018, 09:54:43
    Author     : franklin
--%>


<%@page import="com.imd.telemaco.entity.Film"%>
<%@page import="java.util.ArrayList"%>
<%@page import="com.imd.telemaco.entity.User"%>
<%@page language="java" contentType="text/html" pageEncoding="UTF-8"%>
<%
    response.setHeader("Cache-Control", "no-cache, no-store, must-revalidate");
    User logged = new User();
    if (session.getAttribute("logged") == null) {
        response.sendRedirect("Login.jsp");
    } else {
        logged = (User) (session.getAttribute("logged"));
    }

    ArrayList<Film> list = (ArrayList<Film>) session.getAttribute("audiovisualList");
%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Welcome!</title>
    </head>
    <body>
        <h1>This is your logged page! </h1><br/>
        Welcome, <%=logged.getName()%><br/>
        <a href="RegisterFilm.jsp">Register program</a><br/>
        <a href="UpdatePassword.jsp">Update password</a><br/>

        <form action="SelectAllFilms" method="post">
            <button type="submit"> ver programes </button>
        </form>
        <br/>
        <h2>Your informations:</h2>
        <b>Birth: </b><%=logged.getBirth()%><br/>
        <b>Id: </b><%=logged.getId()%><br/>
        <b>Last name: </b><%=logged.getLastName()%><br/>
        <b>Email: </b><%=logged.getEmail()%><br/>
        <b>Password: </b><%=logged.getPassword()%><br/>
        <b>Gender: </b><%=logged.getGender()%><br/>

        <form name="search" action="SearchFilm">
            <input type="search" required name="input" />
            <input type="submit" value="Search" />
        </form>

        <div>
            <h2>Your programs</h2>
            <%
                if (list.isEmpty()) {
            %>
            <p>You have no programs in your list!</p>
            <%
            } else {
                for (Film program : list) {
            %>
            <p> 
            <form action="RemoveAudiovisualFromList" method="GET">
                <a href="SelectFilm?id=<%=program.getId()%>"> <%=program.getName()%> </a> 
                <input type="hidden" name="idAudiovisual" value="<%=program.getId()%>" />
                <input type="hidden" name="idUser" value="<%=logged.getId()%>" />
                <input type="submit" value="Remove from list" />
            </form>
            <%
                    }
                }
            %>
        </div>

        <form name="logout" action="LogoutUser" method="POST">
            <input type="submit" value="Logout" />
        </form>
    </body>
</html>