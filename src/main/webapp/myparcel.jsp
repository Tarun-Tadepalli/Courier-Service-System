<%@page import="javax.ejb.EJB"%>
<%@ page import="com.klef.ep.services.ParcelService" %>
<%@ page import="javax.naming.InitialContext" %>
<%@ page import="com.klef.ep.models.Parcel" %>
<%@ page import="javax.servlet.http.HttpSession" %>
<%@ page import="com.klef.ep.models.Dispatcher" %>
<%@ page import="java.util.List" %>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml" lang="en">
<head>
    <meta charset="UTF-8"/>
    <meta name="viewport" content="width=device-width, initial-scale=1.0"/>
    <title></title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css"/>
    <style>
        body {
            font-family: 'DM Sans', sans-serif;
            display: flex;
            margin: 0;
            background-color: #f8f9fa;
            color: #333;
        }
        .sidebar {
            width: 250px;
            background-color: #343a40;
            color: #fff;
            display: flex;
            flex-direction: column;
            justify-content: space-between;
            height: 100vh;
            position: fixed;
        }
        .sidebar .logo {
            text-align: center;
            padding: 20px;
            font-size: 24px;
            background-color: #212529;
            border-bottom: 1px solid #495057;
        }
        .sidebar ul {
            list-style-type: none;
            padding: 0;
            margin: 0;
        }
        .sidebar li {
            padding: 15px 20px;
            cursor: pointer;
            transition: background-color 0.3s;
        }
        .sidebar li:hover {
            background-color: #495057;
        }
        .sidebar li i {
            margin-right: 10px;
        }
        .dropdown {
            display: none;
            list-style-type: none;
            padding-left: 20px;
            background-color: #495057;
        }
        .dropdown li {
            padding: 10px 20px;
            cursor: pointer;
        }
        .dropdown-toggle:hover .dropdown,
        .dropdown-toggle:focus .dropdown {
            display: block;
        }
        .dropdown li:hover {
            background-color: #6c757d;
        }
        .logout {
            padding: 20px;
            text-align: center;
            cursor: pointer;
            background-color: #212529;
            border-top: 1px solid #495057;
        }
        .logout:hover {
            background-color: #495057;
        }
        .main-content {
            margin-left: 250px;
            padding: 20px;
            flex: 1;
            display: flex;
            flex-direction: column;
        }
        .dashboard {
            padding: 20px;
            background-color: #ffffff;
            border-radius: 10px;
            box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
            margin-bottom: 20px;
        }
        .dashboard-metrics {
            display: flex;
            justify-content: space-around;
            margin-bottom: 20px;
        }
        .dashboard-metrics div {
            background-color: #eee;
            padding: 20px;
            border-radius: 10px;
            flex: 1;
            margin: 0 10px;
            text-align: center;
            transition: background-color 0.3s;
        }
        .dashboard-metrics div:hover {
            background-color: #ddd;
        }
 	        table {
            width: 100%;
        }
        td img {
            width: 36px;
            height: 36px;
            margin-right: .5rem;
            border-radius: 50%;
            vertical-align: middle;
        }
        table, th, td {
        align:right;
            border-collapse: collapse;
            padding: 1rem;
            text-align: left;
        }
        thead th {
            position: sticky;
            top: 0;
            left: 0;
            background-color: #d5d1defe;
            cursor: pointer;
            text-transform: capitalize;
        }
        tbody tr:nth-child(even) {
            background-color: #0000000b;
        }
        tbody tr {
            --delay: .1s;
            transition: .5s ease-in-out var(--delay), background-color 0s;
        }
        tbody tr.hide {
            opacity: 0;
            transform: translateX(100%);
        }
        tbody tr:hover {
            background-color: #fff6 !important;
        }
        tbody tr td,
        tbody tr td p,
        tbody tr td img {
            transition: .2s ease-in-out;
        }
        tbody tr.hide td,
        tbody tr.hide td p {
            padding: 0;
            font: 0 / 0 sans-serif;
            transition: .2s ease-in-out .5s;
        }
        tbody tr.hide td img {
            width: 0;
            height: 0;
            transition: .2s ease-in-out .5s;
        }
        .status {
            padding: .4rem 0;
            border-radius: 2rem;
            text-align: center;
        }
        .status.godown {
            background-color: red;
            color: #fff;
        }
        .status.dispatching {
            background-color: yellow;
            color: #000;
        }
        .status.delivered {
            background-color: green;
            color: #fff;
        }
        @media (max-width: 1000px) {
            td:not(:first-of-type) {
                min-width: 12.1rem;
            }
        }
        thead th span.icon-arrow {
            display: inline-block;
            width: 1.3rem;
            height: 1.3rem;
            border-radius: 50%;
            border: 1.4px solid transparent;
            text-align: center;
            font-size: 1rem;
            margin-left: .5rem;
            transition: .2s ease-in-out;
        }
        thead th:hover span.icon-arrow {
            border: 1.4px solid #6c00bd;
        }
        thead th:hover {
            color: #6c00bd;
        }
        thead th.active span.icon-arrow {
            background-color: #6c00bd;
            color: #fff;
        }
        thead th.asc span.icon-arrow {
            transform: rotate(180deg);
        }
        thead th.active, tbody td.active {
            color: #6c00bd;
        }

    </style>
</head>
<body>
    <div class="sidebar">
        <div>
            <div class="logo">ShipIt <i class="fas fa-shipping-fast"></i></div>
            <ul>
             <li class="dropdown-toggle"><i class="fas fa-box"></i><a style="color: white;text-decoration: none;" href="myparcel.jsf"> My Couriers</a></li>
            <li><i class="fas fa-user-shield"></i><a style="color: white;text-decoration: none;" href="dispatcherprofile.jsp">Dispatcher Profile</a></li>
            
            </ul>
        </div>
        <div class="logout">
            <a href="index.jsp"><i class="fas fa-sign-out-alt"></i> Logout</a>
        </div>
    </div>
    <div class="main-content">
    <div class="dashboard">
    	
    
        
    <h2><u>View All Parcels</u></h2>
<table>
<thead>
    <tr>
        <th>Parcel Name</th>
        <th>Sender Name</th>
        <th>Receiver Name</th>
        <th>Shipping Type</th>
        <th>Status</th>
        <th>Action</th>
    </tr>
</thead>
<tbody>
<%
    HttpSession sion = request.getSession();
    Dispatcher dispatcher = (Dispatcher) sion.getAttribute("dispatcher");
    if (dispatcher != null) {
        InitialContext context = new InitialContext();
        ParcelService parcelService = (ParcelService) context.lookup("java:global/EPProject/ParcelServiceImpl!com.klef.ep.services.ParcelService");

        List<Parcel> parcellist = parcelService.viewallParcels();
        for (Parcel parcel : parcellist) {
            if (parcel.getDispatcher().equals(dispatcher.getUsername())) {
%>
    <tr>
        <td><%= parcel.getPname() %></td>
        <td><%= parcel.getSname() %></td>
        <td><%= parcel.getRname() %></td>
        <td>
                        <%! String shiptype = ""; %>
                        <% if(parcel.getShipping_type().contains("SDC")){
                        		shiptype="Standard Delivery Service";
                        	}else if(parcel.getShipping_type().contains("LCS")){
                        		shiptype="Local Courier Services";
                        	}else if(parcel.getShipping_type().contains("GCS")){
                        		shiptype="Global Courier Services";
                        	}else if(parcel.getShipping_type().contains("SAMEDC")){
                        		shiptype="Same-Day Couriers";
                        	}else if(parcel.getShipping_type().contains("OS")){
                        		shiptype="Overnight Shipping";
                        	}else if(parcel.getShipping_type().contains("ROD")){
                        		shiptype="Rush and On-Demand Deliveries";
                        	}else if(parcel.getShipping_type().contains("SD")){
                        		shiptype="Scheduled Deliveries";
                        	}
                        %>
                        <%=shiptype %>
            </td>
        <td><p class="status <%= parcel.getStatus().toLowerCase() %>"><%= parcel.getStatus() %></p></td>
        <td><a href="updateParcel.jsp?pid=<%= parcel.getPid() %>">Update</a></td>
    </tr>
<%
            }
        }
    } else {
        out.println("Please login as a dispatcher.");
    }
%>
</tbody>
</table>
    </div>
    </div>
    <script>
        document.addEventListener('DOMContentLoaded', function() {
            var dropdownToggles = document.querySelectorAll('.dropdown-toggle');
            dropdownToggles.forEach(function(toggle) {
                toggle.addEventListener('mouseenter', function() {
                    var dropdown = this.querySelector('.dropdown');
                    dropdown.style.display = 'block';
                });
                toggle.addEventListener('mouseleave', function() {
                    var dropdown = this.querySelector('.dropdown');
                    dropdown.style.display = 'none';
                });
            });
        });
    </script>
</body>
</html>