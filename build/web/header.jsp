<%
Integer userId = (Integer) session.getAttribute("user_id");
String adminUser = (String) session.getAttribute("admin");
%>

<!DOCTYPE html>
<html>
<head>
    <title>Online Banking System</title>

    <!-- ===== INTERNAL CSS ===== -->
    <style>
        body {
            font-family: Arial, sans-serif;
            margin: 0;
            background: linear-gradient(120deg, #2c3e50, #3498db);
            color: #fff;
        }

        .header {
            text-align: center;
            padding: 15px;
            background-color: #1a252f;
        }

        .header h2 {
            margin: 0;
            color: #ffffff;
        }

        .navbar {
            display: flex;
            background-color: #1a252f;
            padding: 10px;
            justify-content: space-around;
            align-items: center;
            flex-wrap: wrap;
        }

        .navbar a {
            color: #fff;
            text-decoration: none;
            padding: 12px 20px;
            border-radius: 5px;
            transition: background 0.3s;
        }

        .navbar a:hover {
            background-color: #3498db;
        }

        .content {
            padding: 40px;
            text-align: center;
        }

        .center-page {
            max-width: 900px;
            margin: auto;
            background: rgba(255,255,255,0.10);
            padding: 25px;
            border-radius: 10px;
            box-shadow: 0 0 15px rgba(0,0,0,0.4);
            backdrop-filter: blur(8px);
        }

        h1, h2, h3 {
            margin-bottom: 20px;
        }

        input, select {
            padding: 10px;
            width: 80%;
            margin: 8px auto;
            border-radius: 5px;
            border: none;
            display: block;
        }
        .login-card input[type=submit] {
    width: 100%;
    background: #3498db;
    color: white;
    border: none;
    padding: 12px;
    border-radius: 6px;
    cursor: pointer;
}


       

        input[type=submit]:hover, button:hover {
            background: #2980b9;
        }

        table {
            width: 100%;
            border-collapse: collapse;
            margin-top: 20px;
            background: #ffffff;
            color: #222;
            border-radius: 8px;
            overflow: hidden;
        }

        th {
            background-color: #1a252f;
            color: white;
            padding: 10px;
        }

        td {
            padding: 10px;
            border-bottom: 1px solid #ddd;
        }

        .footer {
            background-color: #1a252f;
            color: white;
            text-align: center;
            padding: 10px;
            margin-top: 30px;
        }
        /* Dashboard Links Style */
.dashboard-menu a {
    display: block;
    background-color: #1a252f;
    color: #ffffff;
    text-decoration: none;
    padding: 12px;
    margin: 8px auto;
    width: 60%;
    border-radius: 6px;
    transition: background 0.3s;
}

.dashboard-menu a:hover {
    background-color: #3498db;
}

    </style>
</head>

<body>

<!-- ===== HEADER ===== -->
<div class="header">
    <h2>Online Banking System</h2>
</div>

<!-- ===== NAVBAR ===== -->
<div class="navbar">

    <!-- Before Login -->
    <% if(userId == null && adminUser == null){ %>
        <a href="index.jsp">Login</a>
        <a href="register.html">Register</a>
    <% } %>

    <!-- User Logged In -->
    <% if(userId != null){ %>
        <a href="userdashboard.jsp">Dashboard</a>
        <a href="deposit.html">Deposit</a>
        <a href="withdraw.html">Withdraw</a>
        <a href="transfer.html">Transfer</a>
        <a href="history.jsp">History</a>
        <a href="userProfile.jsp">My Profile</a>
        <a href="logout.jsp">Logout</a>
    <% } %>

    <!-- Admin Logged In -->
    <% if(adminUser != null){ %>
        <a href="adminDashboard.jsp">Admin</a>
        <a href="viewUsers.jsp">Users</a>
        <a href="viewAccounts.jsp">Accounts</a>
        <a href="viewTransactions.jsp">Transactions</a>
        <a href="logout.jsp">Logout</a>
    <% } %>

</div>

<!-- ===== PAGE CONTENT START ===== -->
<div class="content">
    <div class="center-page">
