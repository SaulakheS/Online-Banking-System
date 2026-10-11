<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%@ include file="dbconnect.jsp" %>

<%
int totalAccounts = 0;
double totalBalance = 0;
int pendingUsers = 0;

Statement st = c1.createStatement();

ResultSet rs1 = st.executeQuery("SELECT COUNT(*) FROM accounts");
if(rs1.next()) totalAccounts = rs1.getInt(1);

ResultSet rs2 = st.executeQuery("SELECT SUM(balance) FROM accounts");
if(rs2.next()) totalBalance = rs2.getDouble(1);

ResultSet rs3 = st.executeQuery("SELECT COUNT(*) FROM allUsers WHERE status='PENDING'");
if(rs3.next()) pendingUsers = rs3.getInt(1);
%>

<!DOCTYPE html>
<html>
<head>
    <title>Admin Dashboard</title>

    <style>
        body {
            margin:0;
            font-family: Arial, sans-serif;
            background: #f4f6f9;
        }

        .container {
            display: flex;
            height: 100vh;
        }

        /* LEFT SIDEBAR */
        .sidebar {
            width: 260px;
            background: #1a252f;
            color: white;
            padding-top: 20px;
        }

        .admin-profile {
            text-align: center;
            margin-bottom: 30px;
        }

        .admin-profile img {
            width: 80px;
            height: 80px;
            border-radius: 50%;
            border: 3px solid #3498db;
        }

        .admin-profile h3 {
            margin: 10px 0 0;
        }

        .menu a {
            display: block;
            padding: 15px;
            color: white;
            text-decoration: none;
            transition: background 0.3s;
        }

        .menu a:hover {
            background: #3498db;
        }

        /* MAIN CONTENT */
        .main-content {
            flex: 1;
            padding: 40px;
            background: linear-gradient(120deg, #2c3e50, #3498db);
            color: white;
        }

        .cards {
            display: flex;
            flex-wrap: wrap;
            gap: 40px;
            justify-content: center;
            margin-top: 100px;
        }

        .card {
            background: white;
            color: #1a252f;
            padding: 40px;
            width: 280px;
            text-align: center;
            border-radius: 10px;
            box-shadow: 0 0 15px rgba(0,0,0,0.3);
        }

        .card h2 {
            margin: 0;
            font-size: 22px;
        }

        .card p {
            font-size: 32px;
            margin: 15px 0 0;
            font-weight: bold;
            color: #3498db;
        }

        .btn {
            display:inline-block;
            margin-top:15px;
            padding:10px 15px;
            background:#3498db;
            color:white;
            text-decoration:none;
            border-radius:5px;
        }

        .btn:hover {
            background:#217dbb;
        }
    </style>
</head>

<body>

<div class="container">

    <!-- LEFT SIDEBAR -->
    <div class="sidebar">

        <div class="admin-profile">
            <img src="images/admin logo.jpg" alt="Admin">
            <h3>Admin</h3>
        </div>

        <div class="menu">
            <a href="adminDashboard.jsp">Dashboard</a>
            <a href="pendingUsers.jsp">Pending Requests (<%= pendingUsers %>)</a>
            <a href="viewUsers.jsp">View Users</a>
            <a href="viewAccounts.jsp">View Accounts</a>
            <a href="viewTransactions.jsp">View Transactions</a>
            <a href="logout.jsp">Logout</a>
        </div>

    </div>

    <!-- MAIN CONTENT -->
    <div class="main-content">

        <h1>Bank Overview</h1>

        <div class="cards">

            <div class="card">
                <h2>Total Accounts</h2>
                <p><%= totalAccounts %></p>
            </div>

            <div class="card">
                <h2>Total Money in Bank</h2>
                <p>₹ <%= totalBalance %></p>
            </div>

            <div class="card">
                <h2>Pending Requests</h2>
                <p><%= pendingUsers %></p>
                <a href="pendingUsers.jsp" class="btn">View</a>
            </div>

        </div>

    </div>

</div>

</body>
</html>

<%@include file="footer.jsp"%>