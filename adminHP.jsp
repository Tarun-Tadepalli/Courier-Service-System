<%@page import="com.klef.ep.models.Admin"%>
<%@page import="javax.naming.InitialContext"%>
<%@page import="java.util.List"%>
<%@page import="javax.ejb.EJB"%>
<%
Admin admin = (Admin) session.getAttribute("admin");
if(admin==null)
{
  response.sendRedirect("sessionexpiryadmin.html");
}
%>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml" lang="en">
<head>
    <meta charset="UTF-8"/>
    <meta name="viewport" content="width=device-width, initial-scale=1.0"/>
    <title>Courier Service Management - Admin Page</title>
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
        .header {
            padding: 20px;
            display: flex;
            justify-content: space-between;
            align-items: center;
            background-color: #ffffff;
            box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
            margin-bottom: 20px;
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
        .recent-orders {
            background-color: #ffffff;
            padding: 20px;
            border-radius: 10px;
            box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
        }
        .right-bar {
            width: 250px;
            background-color: #f4f4f4;
            padding: 20px;
            display: flex;
            flex-direction: column;
            position: fixed;
            right: 0;
            height: 100vh;
        }.admin-profile {
            display: flex;
            align-items: center;
        }
        .admin-profile img {
            width: 50px;
            height: 50px;
            border-radius: 50%;
            margin-right: 10px;
        }
        .recent-updates {
            margin-top: 20px;
            flex: 1;
            overflow-y: auto;
        }
        .recent-updates ul {
            list-style-type: none;
            padding: 0;
            margin: 0;
        }
        .recent-updates li {
            padding: 10px;
            background-color: #ffffff;
            border-radius: 5px;
            margin-bottom: 10px;
            box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
            transition: background-color 0.3s;
        }
        .recent-updates li:hover {
            background-color: #f8f9fa;
        }
        .recent-updates h2 {
            margin-bottom: 10px;
        }
        .date-picker input[type="date"] {
            padding: 10px;
            border: 1px solid #ddd;
            border-radius: 5px;
        }
    </style>
</head>
<body>
    <div class="sidebar">
        <div>
            <div class="logo">ShipIt <i class="fas fa-shipping-fast"></i></div>
            <ul>
                <li><i class="fas fa-tachometer-alt"></i> Dashboard</li>
                <li><i class="fas fa-user-shield"></i> Admin Profile</li>
                
                 <li class="dropdown-toggle"><i class="fas fa-box"></i> Manage Couriers
                    <ul class="dropdown">
                        <li><a style="color: white;text-decoration: none;" href="parcel.jsf">Add Courier</a></li>
                        <li>All Couriers</li>
                        <li>Allocate Dispatcher</li>
                    </ul>
                </li>
                <li class="dropdown-toggle"><i class="fas fa-users"></i> Staff List
                    <ul class="dropdown">
                         
                         <li><a href="dispatcher.xhtml">Dispatcher</a></li>
                    </ul>

               </li>
               
                
            </ul>
        </div>
        <div class="logout">
            <a href="emplogout.jsp"><i class="fas fa-sign-out-alt"></i> Logout</a>
        </div>
    </div>
    <div class="main-content">
        <div class="header">
            <div class="date-picker">
                <input type="date" id="dashboard-date" name="dashboard-date"/>
            </div>
        </div>
        <div class="dashboard">
            <div class="dashboard-metrics">
                <div>Total Deliveries: <span id="total-deliveries">0</span></div>
                <div>Total Income: <span id="total-income">$0</span></div>
                <div>Total Employees: <span id="total-employees">0</span></div>
            </div>
            <div class="recent-orders">
                <h2>Recent Orders</h2>
                <ul id="recent-orders-list">
                    <!-- Orders will be populated here -->
                </ul>
            </div>
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