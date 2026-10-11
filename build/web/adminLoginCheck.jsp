<%-- 
    Document   : adminLoginCheck
    Created on : 19 Jan, 2026, 9:48:36 AM
    Author     : PC
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.sql.*"%>
<%@include file="dbconnect.jsp"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Admin Login Check</title>
    </head>
    <body>
       <%
            String user = request.getParameter("username");
            String pass = request.getParameter("password");

            Statement st = c1.createStatement();
            ResultSet rs = st.executeQuery("SELECT * FROM admin WHERE username='"+user+"' AND password='"+pass+"'");

            if(rs.next())
            {
                session.setAttribute("admin", user);
                response.sendRedirect("adminDashboard.jsp");
            }
            else
            {
                out.println("<script>alert('Invalid Admin Login');location.href='adminLogin.jsp';</script>");
            }
        %>

    </body>
</html>
