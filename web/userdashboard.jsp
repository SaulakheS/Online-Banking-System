<%-- 
    Document   : userdashboard
    Created on : 14 Jan, 2026, 11:24:01 PM
    Author     : PC
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.sql.*" %>
<%@include file="dbconnect.jsp" %>
<%@include file="header.jsp" %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>User Dashboard</title>
    </head>
    <body>
        <h2>Online Banking System - User Dashboard</h2>

        <%
            // Get session values set during login
             userId = (Integer) session.getAttribute("user_id");
            String accNo = (String) session.getAttribute("account_number");

    // If session expired or not logged in
    if(userId == null || accNo == null) {
        response.sendRedirect("index.jsp");
        return;
    }

    Statement st = null;
    ResultSet rs = null;

    String fullName = "";
    double balance = 0;

    try {
        st = c1.createStatement();

        // Fetch user name
        String userQuery = "SELECT surname, name FROM allUsers WHERE user_id = " + userId;
        rs = st.executeQuery(userQuery);
        if(rs.next())
        {
            fullName = rs.getString("name") + " " + rs.getString("surname");
        }

        // Fetch account balance
        String accQuery = "SELECT balance FROM accounts WHERE account_number = '" + accNo+"'";
        rs = st.executeQuery(accQuery);
        if(rs.next()) 
        {
            balance = rs.getDouble("balance");
        }

    } 
    catch(Exception ex)
    {
        out.println("Database Error: " + ex);
    } 
%>

<h3>Welcome, <%= fullName %></h3>

<p><b>Account Number:</b> <%= accNo %></p>
<p><b>Current Balance:</b> ₹ <%= balance %></p>

<hr>

<h3>Banking Services</h3>
<div class="dashboard-menu">
<ul>
    <li><a href="userProfile.jsp">My Profile</a></li>
    <li><a href="deposit.html">Deposit Money</a></li>
    <li><a href="withdraw.html">Withdraw Money</a></li>
    <li><a href="transfer.html">Fund Transfer</a></li>
    <li><a href="history.jsp">Transaction History</a></li>
    <li><a href="logout.jsp">Logout</a></li>
</ul>
</div>      
    </body>
</html>
<%@ include file="footer.jsp" %>

