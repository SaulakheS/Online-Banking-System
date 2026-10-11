<%-- 
    Document   : logout
    Created on : 14 Jan, 2026, 11:09:57 PM
    Author     : PC
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Logout</title>
    </head>
    <body>
        <%
            // Invalidate the current session
            session.invalidate();

            // Redirect to login page
            response.sendRedirect("index.jsp"); 
        %>

    </body>
</html>
