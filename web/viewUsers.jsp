<%-- 
    Document   : viewUsers
    Created on : 19 Jan, 2026, 9:56:05 AM
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
        <title>View Users</title>
    </head>
    <body>
       

<h3>All Registered Users</h3>

<table border="1">
<tr>
<th>ID</th><th>Name</th><th>Email</th><th>Mobile</th>
</tr>

<%
Statement st = c1.createStatement();
ResultSet rs = st.executeQuery("SELECT * FROM allUsers");

while(rs.next()){
%>
<tr>
<td><%=rs.getInt("user_id")%></td>
<td><%=rs.getString("name")%> <%=rs.getString("surname")%></td>
<td><%=rs.getString("email")%></td>
<td><%=rs.getString("mobile_no")%></td>
</tr>
<% } %>
</table>



    </body>
</html>
<%@include file="footer.jsp"%>
