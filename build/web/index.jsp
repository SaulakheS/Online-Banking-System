<%-- 
    Document   : index
    Created on : 19 Jan, 2026, 10:19:14 AM
    Author     : PC
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <title>Online Banking - Login</title>

    <style>
        body {
            margin: 0;
            font-family: Arial, sans-serif;
            background: linear-gradient(120deg, #2c3e50, #3498db);
            height: 100vh;
            display: flex;
            justify-content: center;
            align-items: center;
            color: #fff;
        }

        .container {
            width: 85%;
            height: 80%;
            background: #ffffff;
            display: grid;
            grid-template-columns: 1fr 1fr;
            border-radius: 12px;
            overflow: hidden;
            box-shadow: 0 0 25px rgba(0,0,0,0.4);
        }

        /* LEFT SIDE */
        .left-panel {
            background: linear-gradient(135deg, #1a252f, #3498db);
            color: white;
            padding: 50px;
        }

        .left-panel h1 {
            margin-top: 0;
            font-size: 32px;
        }

        .left-panel p {
            font-size: 16px;
            line-height: 1.6;
        }

        .feature {
            margin-top: 20px;
            padding: 12px;
            background: rgba(255,255,255,0.15);
            border-radius: 8px;
        }

        /* RIGHT SIDE */
        .right-panel {
            padding: 50px;
            display: flex;
            justify-content: center;
            align-items: center;
        }

        .login-card {
            width: 80%;
            text-align: center;
        }

        .login-card h2 {
            color: #1a252f;
        }

        .login-card input {
            width: 100%;
            padding: 12px;
            margin: 10px 0;
            border-radius: 6px;
            border: 1px solid #ccc;
        }

        .login-card input[type=submit] {
            background: #3498db;
            color: white;
            border: none;
            cursor: pointer;
        }

        .login-card input[type=submit]:hover {
            background: #2980b9;
        }

        .login-card a {
            color: #3498db;
            text-decoration: none;
        }
        .login-card select {
    width: 100%;
    padding: 12px;
    margin: 10px 0;
    border-radius: 6px;
    border: 1px solid #ccc;
    background: white;
    font-size: 14px;
}

    </style>
</head>

<body>

<div class="container">

    <!-- LEFT SIDE -->
    <div class="left-panel">
        <h1>Smart Online Banking</h1>
        <p>
            Manage your bank account anytime, anywhere.
            Our online banking system provides fast, secure,
            and reliable digital banking services.
        </p>

        <div class="feature">✔ 24×7 Account Access</div>
        <div class="feature">✔ Secure Fund Transfer</div>
        <div class="feature">✔ Instant Transaction History</div>
        <div class="feature">✔ Safe & Trusted Banking</div>
    </div>

    <!-- RIGHT SIDE -->
    <div class="right-panel">
        <div class="login-card">
            <h2> Login</h2>

            <!-- ✅ Keeping your original login code as it is -->
           <form action="login.jsp" method="post" autocomplete="off">

    <select name="role" required>
        <option value="" disabled selected>Login As</option>
        <option value="user">User</option>
        <option value="admin">Admin</option>
    </select>

    <input type="text" name="email" placeholder="Email / Username" required>

    <input type="password" name="pass" placeholder="Password" required>

    <input type="submit" value="Login">
</form>

<p>New User? <a href="register.html">Register Here</a></p>


          
        </div>
    </div>

</div>

</body>
</html>
