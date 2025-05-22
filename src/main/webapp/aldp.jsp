<%@page import="com.klef.ep.services.ParcelService"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"   import="java.sql.*,java.util.List"  %>
<%@page import="com.klef.ep.services.AdminService"%>
<%@page import="javax.naming.InitialContext"%>
<%@page import="com.klef.ep.models.Parcel"%>
<%@page import="com.klef.ep.models.Admin"%>
<%@page import="com.klef.ep.models.Admin"%>
<!DOCTYPE html>
<html>
<head>
<title>Allocate Dispatcher</title>
    <style type="text/css">
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

<h2><u>View All parcels</u></h2>
<table>
<thead>
            <tr>
                <th>Parcel Name</th>
                <th>Sender Name</th>
                <th>Receiver Name</th>
                <th>Shipping Type</th>
                <th>Dispatcher</th>
            </tr>
</thead>
<tbody>
<%
InitialContext context = new InitialContext();
ParcelService parcelService = (ParcelService) context.lookup("java:global/EPProject/ParcelServiceImpl!com.klef.ep.services.ParcelService");

List<Parcel> parcellist = parcelService.viewallParcels();

for(Parcel parcel : parcellist)
{
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
                        <%=shiptype %></td>
                        <td><%= parcel.getDispatcher() %></td>
        </tr>
	  
	  <%
}

%>
</tbody>
</table>


</body>
</html>