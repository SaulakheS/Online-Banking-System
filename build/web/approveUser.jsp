<%-- 
    Document   : approveUser
    Created on : 21 Feb, 2026, 9:08:58 PM
    Author     : PC
--%>
<%@page import="java.sql.*"%>
<%@include file="dbconnect.jsp"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <title>Approve User</title>
</head>
<body>

<%
String uid = request.getParameter("uid");

if(uid == null){
    out.println("<script>alert('Invalid Request');location='pendingUsers.jsp';</script>");
    return;
}

int userId = Integer.parseInt(uid);

Statement st = null;
ResultSet rs = null;

try {

    st = c1.createStatement();
    c1.setAutoCommit(false);

    // 1️⃣ Approve user
    st.executeUpdate("UPDATE allUsers SET status='APPROVED' WHERE user_id=" + userId);

    // 2️⃣ Get name & surname
    rs = st.executeQuery("SELECT name, surname FROM allUsers WHERE user_id=" + userId);
    rs.next();

    String name = rs.getString("name");
    String surname = rs.getString("surname");

    // 3️⃣ Generate account number
    String prefix = (name.substring(0,2) + surname.substring(0,2)).toUpperCase();

    ResultSet rs2 = st.executeQuery("SELECT COUNT(*) FROM accounts");
    rs2.next();

    int seq = rs2.getInt(1) + 1;

    String accNo = prefix + "000000" + seq;

    // 4️⃣ Insert into accounts table
    String accQuery = "INSERT INTO accounts(user_id, account_number, balance) " +
                      "VALUES(" + userId + ", '" + accNo + "', 0.00)";

    st.executeUpdate(accQuery);

    // ✅ Commit
    c1.commit();

    out.println("<script>alert('User Approved! Account Number: " + accNo + "');location='pendingUsers.jsp';</script>");

}
catch(Exception ex){

    c1.rollback();
    out.println("Error: " + ex);

}
%>

</body>
</html>