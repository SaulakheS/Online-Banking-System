<%-- 
    Document   : viewTransactions
    Created on : 19 Jan, 2026, 10:01:58 AM
    Author     : PC
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.sql.*"%>
<%@include file="header.jsp"%>
<%@include file="dbconnect.jsp"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>View Transactions</title>
    </head>
    <body>
        <h3>All Transactions</h3>

<table border="1">
<tr>
<th>ID</th><th>Account ID</th><th>Type</th><th>Amount</th><th>Related Acc</th><th>Date</th>
</tr>

<%
Statement st = c1.createStatement();
ResultSet rs = st.executeQuery("SELECT * FROM transactions ORDER BY transaction_time DESC");

while(rs.next()){
%>
<tr>
<td><%=rs.getInt("transaction_id")%></td>
<td><%=rs.getInt("account_id")%></td>
<td><%=rs.getString("transaction_type")%></td>
<td><%=rs.getDouble("amount")%></td>
<td><%=rs.getString("related_account")%></td>
<td><%=rs.getTimestamp("transaction_time")%></td>
</tr>
<% } %>
</table>
    </body>
</html>

<%@include file="footer.jsp"%>
