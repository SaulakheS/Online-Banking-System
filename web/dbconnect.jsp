<%-- 
    Document   : dbconnect
    Created on : 14 Jan, 2026, 11:41:38 AM
    Author     : PC
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.sql.*"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Database</title>
    </head>
    <body>
         <%
            String dbURL = "jdbc:mysql://localhost:3306/online_banking_db";
            String dbUser = "root";
            String dbPass = "root";

            Connection c1 = null;
            try 
            {
                Class.forName("com.mysql.jdbc.Driver");
                c1 = DriverManager.getConnection(dbURL, dbUser, dbPass);
                // out.println("Database connected successfully!"); 
            } 
            catch (Exception ex) 
            {
                out.println("Database connection error: " + ex);
            }
        %>
    </body>
</html>
