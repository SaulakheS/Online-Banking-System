<%-- 
    Document   : update
    Created on : 20 Jan, 2026, 6:40:51 PM
    Author     : PC
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.sql.*"%>
<%@include file="dbconnect.jsp"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Update User Information</title>
    </head>
    <body>
        

<%
Integer userId = (Integer) session.getAttribute("user_id");
if(userId == null){
    response.sendRedirect("index.jsp");
}

String surname = request.getParameter("surname");
String name = request.getParameter("name");
String fatherName = request.getParameter("father_name");
String email = request.getParameter("email");
String address = request.getParameter("address");
String mobileNo = request.getParameter("mobile_no");
String password = request.getParameter("password_hash");

Statement st = c1.createStatement();

// If password field left empty → don’t change password
String query;

if(password == null || password.trim().equals(""))
{
    query = "UPDATE allUsers SET " +"surname='"+surname+"', " +"name='"+name+"', " +"father_name='"+fatherName+"', " +
            "email='"+email+"', " +"address='"+address+"', " +"mobile_no='"+mobileNo+"' " +"WHERE user_id="+userId;
} 
else 
{
    query = "UPDATE allUsers SET " +"surname='"+surname+"', " +"name='"+name+"', " +"father_name='"+fatherName+"', " +"email='"+email+"', " +
            "address='"+address+"', " +"mobile_no='"+mobileNo+"', " +"password_hash='"+password+"' " +"WHERE user_id="+userId;
}

int r = st.executeUpdate(query);

if(r>0){
    out.println("<script>alert('Profile Updated Successfully');location.href='userdashboard.jsp';</script>");
}else{
    out.println("<script>alert('Update Failed');location.href='userProfile.jsp';</script>");
}
%>

    </body>
</html>
