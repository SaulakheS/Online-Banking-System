<%-- 
    Document   : history
    Created on : 14 Jan, 2026, 10:35:09 PM
    Author     : PC
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page  import="java.sql.*"%>
<%@include file="dbconnect.jsp" %>
<%@include file="header.jsp" %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Transaction History</title>
    </head>
    <body>
        <h2>Transaction History </h2>
        <%
            // Get logged-in user's account number from session
            String accNo = (String) session.getAttribute("account_number");

            Statement st = null;
            ResultSet rs = null;

            try
            {
                    st = c1.createStatement();

                    // Get account_id using account_number
                    String accQuery = "SELECT account_id FROM accounts WHERE account_number = '" + accNo+"'";
                    rs = st.executeQuery(accQuery);

                if(rs.next()) 
                {
                    int accountId = rs.getInt("account_id");

                    // Fetch transaction history
               String transQuery ="SELECT t.transaction_type, t.amount, " +"IFNULL(t.related_account, 'SELF') AS related_account, " +
                                  "t.transaction_time, " +

                                    "CASE " +"WHEN t.transaction_type = 'TRANSFER' THEN " +"   (SELECT CONCAT(u2.name,' ',u2.surname) " +
                                   "    FROM accounts a2 " +"    JOIN allUsers u2 ON a2.user_id = u2.user_id " +
                                   "    WHERE a2.account_number = t.related_account) " +"ELSE 'SELF' " +"END AS account_holder " +

                                    "FROM transactions t " +"WHERE t.account_id = " + accountId +" ORDER BY t.transaction_time DESC";


                    rs = st.executeQuery(transQuery);
        %>

    <table border="1" cellpadding="8">
        <tr>
            <th>Type</th>
            <th>Amount</th>
            <th>Related Account</th>
            <th>Account Holder</th>
            <th>Date & Time</th>
            

        </tr>

        <%
            while(rs.next()) {
        %>
        <tr>
            <td><%= rs.getString("transaction_type") %></td>
            <td><%= rs.getDouble("amount") %></td>
            <td><%= (rs.getString("related_account") == null ? "-" : rs.getString("related_account")) %></td>
            <td><%= rs.getString("account_holder") %></td>
            <td><%= rs.getTimestamp("transaction_time") %></td>
        </tr>
        <%
            }
        %>
        </table>

        <%
                } 
            else 
                {
                    out.println("Account not found.");
                }

         }
         catch(Exception ex) 
         {
            out.println("Database Error: " + ex);
         } 
       %>

        <br><br>
        <a href="userdashboard.jsp">Back to Dashboard</a>
    </body>
</html>
<%@include file="footer.jsp" %>

