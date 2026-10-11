<%-- 
    Document   : withdraw
    Created on : 14 Jan, 2026, 12:43:44 PM
    Author     : PC
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.sql.*"%>
<%@include file="dbconnect.jsp" %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Withdraw</title>
    </head>
    <body>
        <%
    double amount = Double.parseDouble(request.getParameter("amount"));
    String pass = request.getParameter("pass");

    // Get session values
    String accNo = (String) session.getAttribute("account_number");
    int userId = (Integer) session.getAttribute("user_id");

    Statement st = null;
    ResultSet rs = null;

    try {
        st = c1.createStatement();
        c1.setAutoCommit(false); // Start transaction

        // 1. Verify Password
        String checkPass = "SELECT password_hash FROM allUsers WHERE user_id = " + userId;
        rs = st.executeQuery(checkPass);

        if(rs.next()) {
            String p = rs.getString("password_hash");

            if(!p.equals(pass)) {
                out.println("<script>alert('Incorrect Password'); location.href='withdraw.html';</script>");
            } 
            else {

                // 2. Check Account and Balance
                String check = "SELECT account_id, balance, status FROM accounts WHERE account_number = '" + accNo + "'";
                rs = st.executeQuery(check);

                if(rs.next()) {
                    int accountId = rs.getInt("account_id");
                    double balance = rs.getDouble("balance");
                    String status = rs.getString("status");

                    if(!status.equals("ACTIVE")) {
                        out.println("<script>alert('Account is BLOCKED'); location.href='withdraw.html';</script>");
                    } 
                    else if(balance < amount) {
                        out.println("<script>alert('Insufficient Balance'); location.href='withdraw.html';</script>");
                    } 
                    else {

                        // 3. Deduct Balance  (FIXED LINE)
                        String q1 = "UPDATE accounts SET balance = balance - " + amount +
                                    " WHERE account_number = '" + accNo + "'";
                        int r1 = st.executeUpdate(q1);

                        // 4. Insert Transaction Record
                        String q2 = "INSERT INTO transactions (account_id, transaction_type, amount) " +
                                    "VALUES (" + accountId + ", 'WITHDRAW', " + amount + ")";
                        int r2 = st.executeUpdate(q2);

                        if(r1 > 0 && r2 > 0) 
                        {
                            c1.commit();
                            out.println("<script>alert('Withdrawal Successful'); location.href='userdashboard.jsp';</script>");
                        } else 
                        {
                            c1.rollback();
                            out.println("<script>alert('Withdrawal Failed'); location.href='withdraw.html';</script>");
                        }
                    }

                } else 
                {
                    out.println("<script>alert('Account Not Found'); location.href='withdraw.html';</script>");
                }
            }

        } else 
        {
            out.println("<script>alert('User Not Found'); location.href='withdraw.html';</script>");
        }

    }
    catch(Exception ex) 
    {
        c1.rollback(); 
        out.println("Database Exception: " + ex);
    } 
%>
    </body>
</html>
