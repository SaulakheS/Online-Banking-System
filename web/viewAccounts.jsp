<%-- 
    Document   : viewAccounts
    Created on : 19 Jan, 2026, 9:58:22 AM
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
        <title>JSP Page</title>
    </head>
    <body>
       

<h3>All Accounts</h3>

<table border="1">
<tr>
<th>Account No</th><th>User ID</th><th>Balance</th><th>Status</th><th>Action</th>
</tr>

<%
Statement st = c1.createStatement();
ResultSet rs = st.executeQuery("SELECT * FROM accounts");

while(rs.next()){
String status = rs.getString("status");
String accNo = rs.getString("account_number");
%>
<tr>
<td><%=accNo%></td>
<td><%=rs.getInt("user_id")%></td>
<td><%=rs.getDouble("balance")%></td>
<td><%=status%></td>
<td>
    <% if(status.equals("ACTIVE")){ %>
        <a href="changeStatus.jsp?acc=<%=accNo%>&st=BLOCKED">Block</a>
    <% } else { %>
        <a href="changeStatus.jsp?acc=<%=accNo%>&st=ACTIVE">Unblock</a>
    <% } %>
</td>
</tr>
<% } %>
</table>



    </body>
</html>
<%@include file="footer.jsp"%>