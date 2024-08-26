<%@page import="com.klef.ep.models.Dispatcher"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
Dispatcher dispatcher = (Dispatcher) session.getAttribute("dispatcher");

if (dispatcher == null) {
    response.sendRedirect("sessionexpiry.html");
    return;
}
%>
<!DOCTYPE html>
<html>
<head>
    <title>My Profile</title>
</head>
<body bgcolor="lightgrey">
    <h3 align='center'>My Profile</h3>
    <br/><br/>
    <center>
        Username: <%=dispatcher.getUsername()%><br/>
        Contact: <%=dispatcher.getContact()%><br/>
        Email: <%=dispatcher.getEmail()%><br/>
        Address: <%=dispatcher.getAddress()%><br/>
        City: <%=dispatcher.getCity()%><br/>
        Pincode: <%=dispatcher.getPincode()%><br/>
    </center>
</body>
</html>
