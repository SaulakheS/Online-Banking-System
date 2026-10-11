<%-- 
    Document   : transfer
    Created on : 14 Jan, 2026, 1:10:39 PM
    Author     : PC
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.sql.*"%>
<%@include file="dbconnect.jsp"%>

<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Fund Transfer</title>
    </head>
    <body>
       
<%
    // Get form inputs
    String receiver = request.getParameter("receiverAcc");
    double amount = Double.parseDouble(request.getParameter("amount"));
    String pass = request.getParameter("pass");

    // Sender details from session (set after login)
    String sender = (String) session.getAttribute("account_number");
    int userId = (Integer) session.getAttribute("user_id");
    // Prevent self-transfer
    if(sender.equals(receiver)) 
    {
             out.println("<script>alert('Cannot transfer to your own account'); location.href='transfer.html';</script>");
             return;
    }


    Statement st = null;
    ResultSet rs = null;

    try {
        st = c1.createStatement();
        c1.setAutoCommit(false); // Start Transaction

        // 1. Verify User Password
        String passQuery = "SELECT password_hash FROM allUsers WHERE user_id = " + userId;
        rs = st.executeQuery(passQuery);

        if(rs.next()) {
            String q = rs.getString("password_hash");

            if(!q.equals(pass))
            {
                out.println("<script>alert('Incorrect Password'); location.href='transfer.html';</script>");
            } 
            else
            {
                   
                // 2. Check Sender Account Balance & Status
                String sQuery = "SELECT account_id, balance, status FROM accounts WHERE account_number = '" + sender+"'";
                rs = st.executeQuery(sQuery);

                if(!rs.next())
                {
                    out.println("<script>alert('Sender Account Not Found'); location.href='transfer.html';</script>");
                } 
                else
                {
                    int sAccountId = rs.getInt("account_id");
                    double sBalance = rs.getDouble("balance");
                    String sStatus = rs.getString("status");

                    if(!sStatus.equals("ACTIVE"))
                    {
                        out.println("<script>alert('Sender Account Blocked'); location.href='transfer.html';</script>");
                    } 
                    else if(sBalance < amount)
                    {
                        out.println("<script>alert('Insufficient Balance'); location.href='transfer.html';</script>");
                    } 
                    else 
                    {
                        


                        // 3. Check Receiver Account
                        String rQuery = "SELECT account_id, status FROM accounts WHERE account_number = '" + receiver+"'";
                        rs = st.executeQuery(rQuery);

                        if(!rs.next())
                        {
                            out.println("<script>alert('Receiver Account Not Found'); location.href='transfer.html';</script>");
                        } 
                        else
                        {
                            int rAccountId = rs.getInt("account_id");
                            String rStatus = rs.getString("status");

                            if(!rStatus.equals("ACTIVE")) 
                            {
                                out.println("<script>alert('Receiver Account Blocked'); location.href='transfer.html';</script>");
                            } 
                            else
                            {
                                if(sender==receiver)
                                {
                                    out.println("<script>alert('Can't Transfer to self');location.href='transfer.html';</script>");
                                }
                                else
                                {

                                // 4. Debit Sender
                                String debitQuery = "UPDATE accounts SET balance = balance - " + amount +
                                                    " WHERE account_number = '" + sender+"'";
                                int r1 = st.executeUpdate(debitQuery);

                                // 5. Credit Receiver
                                String creditQuery = "UPDATE accounts SET balance = balance + " + amount +
                                                     " WHERE account_number = '" + receiver+"'";
                                int r2 = st.executeUpdate(creditQuery);

                                // 6. Insert Transaction Record (Sender)
                                String transQuery = "INSERT INTO transactions (account_id, transaction_type, amount, related_account) " + "VALUES (" + sAccountId + ", 'TRANSFER', " + amount + ", '" + receiver + "')";
                                int r3 = st.executeUpdate(transQuery);

                                if(r1 > 0 && r2 > 0 && r3 > 0)
                                {
                                    c1.commit();
                                    out.println("<script>alert('Fund Transfer Successful'); location.href='userdashboard.jsp';</script>");
                                }
                                else
                                {
                                    c1.rollback();
                                    out.println("<script>alert('Transfer Failed'); location.href='transfer.html';</script>");
                                }
                            }
                        }
                    }
                }
            }
        }

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
