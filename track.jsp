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
    parcelBean = (ParcelBean) ctx.lookup("java:global/EPPROJECT/ParcelBean!com.klef.ep.beans.ParcelBean");
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
    <title>Track & Parcel History</title>
    <link rel="stylesheet" type="text/css" href="track.css">
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
<body bgcolor="mistyrose">
    <div class="navbar">
        <a href="index.jsp" class="logo"><img src="images/trolley.ico" height="40px"/>&nbsp;ShipIt</a>
        <ul>
            <li><a href="index.jsp">home</a></li>
            <li><a href="#">about</a></li>
            <li><a href="contact.jsp">contact</a></li>
            <li><a href="clientlogout.jsp">Logout</a></li>
        </ul>
    </div>

    <nav class="navMenu" align="center">
        <a href="#" onclick="showTrackContainer()">Track my Orders</a>
        <a href="#" onclick="showHistory()">My Delivers</a>
        <div class="dot"></div>
    </nav>
  
    <div class="trackContainer" id="trackContainer">
        <h2>Track my order</h2>
        <form action="deliverystatus.jsp" method="get">
            <div class="button-container">
                <button type="button" class="button" onclick="changePlaceholder('Enter your mobile number', 'rcontact')">Mobile</button>
                <button type="button" class="button" onclick="changePlaceholder('Enter your AWB', 'awbNo')">AWB</button>
                <button type="button" class="button" onclick="changePlaceholder('Enter your Order Id', 'pid')">Order Id</button>
                <button type="button" class="button" onclick="changePlaceholder('Enter your LRN', 'lrn')">LRN</button>
            </div>
            <input type="hidden" id="searchType" name="searchType" value="rcontact">
            <input type="text" id="trackstat" class="input-field" name="trackstatus" placeholder="Enter your mobile number">
            <button type="submit" class="get-otp-button">Check status</button>
        </form>
    </div>
  
    <div id="historyContainer" style="display:none;">
    <br/><br/><br/><br/>
    <section class="table__body">
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
                        <td>
                            <p class="status <%= parcel.getStatus().toLowerCase() %>"><%= parcel.getStatus() %></p>
                        </td>
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
        </section>
    </div>

    <script>
    function showTrackContainer() {
        document.getElementById('trackContainer').style.display = 'block';
        document.getElementById('historyContainer').style.display = 'none';
    }
  
    function showHistory() {
        document.getElementById('historyContainer').style.display = 'block';
        document.getElementById('trackContainer').style.display = 'none';
    }
    
    function changePlaceholder(placeholderText, searchType) {
        var buttons = document.getElementsByClassName('button');
        for (var i = 0; i < buttons.length; i++) {
            buttons[i].classList.remove('active'); 
        }
        event.target.classList.add('active');
  
        document.getElementById('trackstat').setAttribute('placeholder', placeholderText);
        document.getElementById('searchType').value = searchType;
    }
    </script>
  
</body>
</html>
