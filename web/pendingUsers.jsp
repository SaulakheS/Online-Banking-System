<%-- 
    Document   : pendingUsers.jsp
    Created on : 21 Feb, 2026, 9:06:54 PM
    Author     : PC
--%>
<%@page import="java.sql.*"%>
<%@include file="dbconnect.jsp"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>



<!DOCTYPE html>
<html>
<head>
    <title>Pending User Approvals</title>
</head>
<body>

<h2>Pending User Requests</h2>

<table border="1" cellpadding="10">
<tr>
    <th>Name</th>
    <th>Email</th>
    <th>Mobile</th>
    <th>Aadhaar</th>
    <th>PAN</th>
    <th>Action</th>
</tr>

<%
Statement st = c1.createStatement();
ResultSet rs = st.executeQuery("SELECT * FROM allUsers WHERE status='PENDING'");

while(rs.next()){
%>

<tr>
<td><%=rs.getString("name")+" "+rs.getString("surname")%></td>
<td><%=rs.getString("email")%></td>
<td><%=rs.getString("mobile_no")%></td>
<td><%=rs.getString("adhar_no")%></td>
<td><%=rs.getString("pan_no")%></td>

<td>
<a href="approveUser.jsp?uid=<%=rs.getInt("user_id")%>">
Approve
</a>
</td>

</tr>

<% } %>

</table>

</body>
</html>
