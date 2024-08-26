<%@page import="javax.naming.NamingException"%>
<%@page import="java.util.List"%>
<%@page import="javax.naming.Context"%>
<%@page import="javax.naming.InitialContext"%>
<%@page import="com.klef.ep.models.Client"%>
<%@page import="com.klef.ep.beans.ParcelBean"%>
<%@page import="com.klef.ep.models.Parcel"%>
<%@page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>

<%
Client cli = (Client) session.getAttribute("client");
if(cli == null) {
  response.sendRedirect("sessionexpiry.html");
  return;
}

String phn = cli.getContact();

ParcelBean parcelBean = null;
try {
    Context ctx = new InitialContext();
    parcelBean = (ParcelBean) ctx.lookup("java:global/EPProject/ParcelBean!com.klef.ep.beans.ParcelBean");
} catch (NamingException e) {
    out.println("Error looking up ParcelBean: " + e.getMessage());
    return;
}

List<Parcel> parcels = parcelBean != null ? parcelBean.viewParcelsByContact(phn) : null;
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta http-equiv="X-UA-Compatible" content="ie=edge">
    <title>Parcel History</title>
    <link rel="stylesheet" type="text/css" href="style.css">
</head>
<body>
    <h2>Parcel History</h2>
    <table>
        <thead>
            <tr>
                <th>Parcel Name</th>
                <th>Sender Name</th>
                <th>Receiver Name</th>
                <th>Shipping Type</th>
                <th>Status</th>
            </tr>
        </thead>
        <tbody>
            <%
            if (parcels != null && !parcels.isEmpty()) {
                for (Parcel parcel : parcels) {
            %>
                    <tr>
                        <td><%= parcel.getPname() %></td>
                        <td><%= parcel.getSname() %></td>
                        <td><%= parcel.getRname() %></td>
                        <td><%= parcel.getShipping_type() %></td>
                        <td><%= parcel.getStatus() %></td>
                    </tr>
            <%
                }
            } else {
            %>
                <tr>
                    <td colspan="5">No Parcels Found</td>
                </tr>
            <%
            }
            %>
        </tbody>
    </table>
</body>
</html>
