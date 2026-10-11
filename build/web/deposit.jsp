<%-- 
    Document   : deposit
    Created on : 14 Jan, 2026, 11:24:21 AM
    Author     : PC
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.sql.*"%>
<%@include file="dbconnect.jsp" %>
<%@include file="header.jsp" %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Deposit</title>
    </head>
    <body>
        <%
    // Get form values
    double amt = Double.parseDouble(request.getParameter("amt"));
    // Get account number from session
String accNo = (String) session.getAttribute("account_number");
   
    Statement st = null;
    ResultSet rs = null;

    try {
        st = c1.createStatement();
        c1.setAutoCommit(false); // Start DB Transaction

        // 1. Check whether account exists and is ACTIVE
        String checkAcc = "SELECT account_id, status FROM accounts WHERE account_number = '" + accNo+"'";
        rs = st.executeQuery(checkAcc);

        if(rs.next()) {
            int accountId = rs.getInt("account_id");
            String status = rs.getString("status");

            if(status.equals("ACTIVE")) {

                // 2. Update balance
               String q1 = "UPDATE accounts SET balance = balance + " + amt +" WHERE account_number = '" + accNo + "'";
                int r1 = st.executeUpdate(q1);

                // 3. Insert into transactions table
                String q2 = "INSERT INTO transactions (account_id, transaction_type, amount,related_account) " +"VALUES (" + accountId + ", 'DEPOSIT', " + amt + ", 'SELF')";
                int r2 = st.executeUpdate(q2);

                if(r1 > 0 && r2 > 0) 
                {
                    c1.commit();
                    out.println("<script>alert('Money Deposited Successfully'); location.href='userdashboard.jsp';</script>");
                } 
                else 
                {
                    c1.rollback();
                    out.println("<script>alert('Deposit Failed'); location.href='deposit.html';</script>");
                }

            }
            else 
            {
                out.println("<script>alert('Account is BLOCKED'); location.href='deposit.html';</script>");
            }

        } 
        else 
        {
            out.println("<script>alert('Account Number Not Found'); location.href='deposit.html';</script>");
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
<%@include file="footer.jsp" %>
