<%-- 
    Document   : register
    Created on : 15 Jan, 2026, 10:51:15 PM
    Author     : PC
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.sql.*" %>
<%@include file="dbconnect.jsp" %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>User Registration</title>
    </head>
    <body>
        <%
                // Read form data
    String surname = request.getParameter("surname");
    String name = request.getParameter("name");
    String fatherName = request.getParameter("father_name");
    String adharNo = request.getParameter("adhar_no");
    String panNo = request.getParameter("pan_no");
    String email = request.getParameter("email");
    String address = request.getParameter("address");
    String mobileNo = request.getParameter("mobile_no");
    String password = request.getParameter("password_hash");

    Statement st = null;
    ResultSet rs = null;

    try {
        st = c1.createStatement();
        c1.setAutoCommit(false); // Start Transaction

        // 1. Insert into allUsers table
        String userQuery = "INSERT INTO allUsers " +
            "(surname, name, father_name, adhar_no, pan_no, email, address, mobile_no, password_hash) VALUES (" +"'" + surname + "'," +
            "'" + name + "'," +"'" + fatherName + "'," +"'" + adharNo + "'," +"'" + panNo + "'," +"'" + email + "'," +"'" + address + "'," +
            "'" + mobileNo + "'," +"'" + password + "'" +")";

        int r1 = st.executeUpdate(userQuery);
            // Get user_id using email
        ResultSet rsUser = st.executeQuery
        (
            "SELECT user_id FROM allUsers WHERE email = '" + email + "'"
        );
        int userId = 0;
        if(rsUser.next()) {
            userId = rsUser.getInt(1);
        }

        // 2. Generate Account Number: First 2 letters of name + surname + 000000 + sequence
        String accPrefix = (name.charAt(0) + "" + name.charAt(1) + surname.charAt(0) + surname.charAt(1)).toUpperCase();

        ResultSet rsSeq = st.executeQuery("SELECT COUNT(*) AS total FROM accounts");
        int seq = 1;
        if(rsSeq.next()) {
            seq = rsSeq.getInt("total") + 1;
        }

        String accountNumber = accPrefix + "000000" + seq;

        // 3. Insert into accounts table
        String accQuery = "INSERT INTO accounts (user_id, account_number, balance) VALUES (" +
                          userId + ",'" + accountNumber + "',0.00)";

        int r2 = st.executeUpdate(accQuery);

        // 4. Commit if both successful
        if(r1 > 0 && r2 > 0) 
        {
            c1.commit();
            out.println("<script>alert('Registration Successful! Your Account Number is: " + accountNumber + "'); location.href='index.jsp';</script>");
        } 
        else 
        {
           
            out.println("<script>alert('Registration Failed'); location.href='register.html';</script>");
        }

    } catch(Exception ex) 
    {
        
        out.println("Database Exception: " + ex);
    } 
%>
    </body>
</html>
