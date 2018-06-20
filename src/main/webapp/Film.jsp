<%-- 
    Document   : Film
    Created on : 10/04/2018, 23:56:54
    Author     : franklin
--%>

<%@page import="com.imd.telemaco.entity.Rating"%>
<%@page import="com.imd.telemaco.entity.User"%>
<%@page import="java.util.ArrayList"%>
<%@page import="com.imd.telemaco.entity.Film"%>
<%@page language="java" contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<%
    response.setHeader("Cache-Control", "no-cache, no-store, must-revalidate");
    User logged = new User();
    if (session.getAttribute("logged") == null) {
        response.sendRedirect("Login.jsp");
    } else {
        logged = (User) (session.getAttribute("logged"));
    }
    Film program = (Film) session.getAttribute("audiovisual");

    if (program == null) {
        response.sendRedirect("Logged.jsp");
    }

    ArrayList<Rating> ratings = (ArrayList<Rating>) session.getAttribute("ratings");
    ArrayList<Film> list = (ArrayList<Film>) session.getAttribute("audiovisualList");

    boolean alreadyRated = false;
    boolean alreadyOnList = false;

    for (Rating rating : ratings) {
        if (rating.getUser().getId() == logged.getId()) {
            alreadyRated = true;
        }
    }

    for (Film current : list) {
        if (current.getId() == program.getId()) {
            alreadyOnList = true;
        }
    }
%>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link rel="stylesheet" type="text/css" href="./resources/css/rating.css">
        <script type="text/javascript" src="http://ajax.googleapis.com/ajax/libs/jquery/1.4/jquery.min.js"></script>
        <script type="text/javascript" src="./resources/js/rating.js"></script>
        <title></title>
    </head>
    <body>
        <p> <%=program.getName()%> </p>
        <p> Ano: <%=program.getYear()%> </p>
        <%
            if (alreadyOnList == false) {
        %>
        <form action="AddAudiovisualToList" method="GET">
            <input type="hidden" value="<%=program.getId()%>" name="idAudiovisual" />
            <input type="hidden" value="<%=logged.getId()%>" name="idUser" />
            <input type="submit" value="Add to list" name="button" />
        </form>
        <%
        } else {
        %>
        <p>This program is already on your list!</p>
        <%
            }
        %>
        <hr>

        <p> Sinopse: <%=program.getSynopsis()%> </p>
        <hr>
        <p>Comentários</p>
        <table>
            <%
                if (ratings.isEmpty()) {
            %>
            <b>No comments yet!</b>
            <%
            } else {
                for (Rating rating : ratings) {
            %>
            <tr>
                <td><%=rating.getUser().getName()%></td>
                <td><%=rating.getDate()%></td>
                <td><%=rating.getComment()%></td>
                <td>(stars: <%=rating.getStars()%>)</td>
                <%
                    if (rating.getUser().getId() == logged.getId()) {
                %>
                <td>
                    <form action="RemoveRatingFilm" method="GET">
                        <input type="hidden" name="idRating" value="<%=rating.getId()%>" />
                        <input type="hidden" name="idAudiovisual" value="<%=program.getId()%>" />
                        <input type="submit" value="Apagar sua avaliação" />
                    </form>
                </td>
                <%
                    }
                %>
            </tr>
            <%
                    }
                }
            %>
        </table>
        <hr>

        <%
            if (alreadyRated == false) {
        %>
        <form action="AddRatingFilm" method="GET">
            <label>Add your comment here </label>
            <br>
            <textarea name="content" required maxlength="500" placeholder="..."></textarea>
            <br>
            <div class="rating">
                <span><input type="radio" name="rating" id="str5" value="5"><label for="str5"></label></span>
                <span><input type="radio" name="rating" id="str4" value="4"><label for="str4"></label></span>
                <span><input type="radio" name="rating" id="str3" value="3"><label for="str3"></label></span>
                <span><input type="radio" name="rating" id="str2" value="2"><label for="str2"></label></span>
                <span><input type="radio" name="rating" id="str1" value="1" required><label for="str1"></label></span>
            </div>
            <br>
            <br>
            <input type="submit" value="Add comment" />
            <input type="hidden" name="idAudiovisual" value="${program.getId()}"/>
            <input type="hidden" name="idUser" value="${logged.getId()}"/>
        </form>
        <%
        } else {
        %>
        <p>You have already rated this program.</p>
        <%
            }
        %>
        <hr>
</body>
</html>
