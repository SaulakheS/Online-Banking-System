<%-- 
    Document   : changeStatus
    Created on : 19 Jan, 2026, 9:59:43 AM
    Author     : PC
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.sql.*"%>

<%@include file="dbconnect.jsp"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Status</title>
    </head>
    <body>
       

<%
String acc = request.getParameter("acc");
String stt = request.getParameter("st");

Statement st = c1.createStatement();
st.executeUpdate("UPDATE accounts SET status='"+stt+"' WHERE account_number='"+acc+"'");

response.sendRedirect("viewAccounts.jsp");
%>

    </body>
</html>
