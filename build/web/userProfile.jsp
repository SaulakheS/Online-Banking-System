<%-- 
    Document   : userProfile
    Created on : 20 Jan, 2026, 6:45:04 PM
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
        <title>User Profile</title>
    </head>
    <body>
     

<%
 userId = (Integer) session.getAttribute("user_id");
if(userId == null){
    response.sendRedirect("index.jsp");
}

Statement st = c1.createStatement();
ResultSet rs = st.executeQuery("SELECT * FROM allUsers WHERE user_id=" + userId);
rs.next();
%>

<h3>Update Profile</h3>

<form action="updateUser.jsp" method="post">
<div>
Surname:
<input type="text" name="surname" value="<%=rs.getString("surname")%>" required><br><br>

Name:
<input type="text" name="name" value="<%=rs.getString("name")%>" required><br><br>

Father Name:
<input type="text" name="father_name" value="<%=rs.getString("father_name")%>" required><br><br>

Aadhaar No:
<input type="text" name="adhar_no" value="<%=rs.getString("adhar_no")%>" readonly><br><br>

PAN No:
<input type="text" name="pan_no" value="<%=rs.getString("pan_no")%>" readonly><br><br>

Email:
<input type="email" name="email" value="<%=rs.getString("email")%>" required><br><br>

Address:
<input type="text" name="address" value="<%=rs.getString("address")%>"><br><br>

Mobile No:
<input type="text" name="mobile_no" value="<%=rs.getString("mobile_no")%>" required><br><br>

New Password:
<input type="password" name="password_hash" placeholder="Enter new password"><br>
<input type="submit" value="Update Profile">
</div>
</form>
    


    </body>
</html>
<%@include file="footer.jsp"%>