<%-- 
    Document   : login
    Created on : 14 Jan, 2026, 11:43:34 PM
    Author     : PC
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.sql.*"%>
<%@include file="dbconnect.jsp" %>
<%@ include file="header.jsp" %>

<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Login</title>
        
    </head>
    <body>
       
<%
    
String role = request.getParameter("role");
String emailOrUser = request.getParameter("email");
String pass = request.getParameter("pass");

Statement st = c1.createStatement();
ResultSet rs;

// ===== ADMIN LOGIN =====
if(role.equals("admin")){

    String adminQuery = "SELECT * FROM admin WHERE username='"+emailOrUser+"' AND password='"+pass+"'";
    rs = st.executeQuery(adminQuery);

    if(rs.next()){
        session.setAttribute("admin", emailOrUser);
        response.sendRedirect("adminDashboard.jsp");
    } else {
        out.println("<script>alert('Invalid Admin Login');location.href='index.jsp';</script>");
    }

}

// ===== USER LOGIN =====
else {

    String userQuery = "SELECT user_id, password_hash, status FROM allUsers " +
                       "WHERE LOWER(email)=LOWER('"+emailOrUser+"')";

    rs = st.executeQuery(userQuery);

    if(rs.next()){

        userId = rs.getInt("user_id");
        String db = rs.getString("password_hash");
        String status = rs.getString("status");

        // ❌ BLOCK if not approved
        if(!status.equals("Approved")){
            out.println("<script>alert('Your account is not approved by admin yet');location.href='index.jsp';</script>");
            return;
        }

        // ✅ Password check
        if(db.equals(pass)){

            ResultSet rsAcc = st.executeQuery(
                "SELECT account_number FROM accounts WHERE user_id="+userId
            );

            if(rsAcc.next()){
                String accNo = rsAcc.getString("account_number");

                session.setAttribute("user_id", userId);
                session.setAttribute("account_number", accNo);

                response.sendRedirect("userdashboard.jsp");
            }
            else{
                out.println("<script>alert('Account not generated yet');location.href='index.jsp';</script>");
            }

        }
        else{
            out.println("<script>alert('Invalid Password');location.href='index.jsp';</script>");
        }

    }
    else{
        out.println("<script>alert('Invalid Email');location.href='index.jsp';</script>");
    }
}
%>

    </body>
</html>
<%@ include file="footer.jsp" %>

