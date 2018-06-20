<%-- 
    Document   : Series
    Created on : 10/04/2018, 23:56:42
    Author     : franklin
--%>

<%@page import="com.imd.telemaco.entity.User"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page import="com.imd.telemaco.entity.Film" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="java.sql.SQLException" %>
<!DOCTYPE html>
<%
    response.setHeader("Cache-Control", "no-cache, no-store, must-revalidate");
    User logged = new User();
    if (session.getAttribute("logged") == null) {
        response.sendRedirect("Login.jsp");
    } else {
        logged = (User) (session.getAttribute("logged"));
    }
%>
<html> 
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Films</title>
    </head>
    <body>
        <h1>Films</h1>
        <%
            ArrayList<Film> programs;
            if (session.getAttribute("audiovisualList") == null)
                response.sendRedirect("SelectAllFilms");
            else {
                programs = (ArrayList<Film>) session.getAttribute("audiovisualList");

                for (Film program : programs) {
        %> 
        <p> <a href="SelectFilm?id=<%=program.getId()%>"> <%=program.getName()%> </a> </p>
        <%
                }
            }
        %>
    </body>
</html>
