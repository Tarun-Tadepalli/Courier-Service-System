<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" href="./style.css">
    <link rel="icon" type="image/x-icon" href="images/trolley.ico">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.12.0-2/css/all.min.css">
    <title>ShipIt</title>
</head>
<body>
    <div class="container">
        <div class="main">
            <div class="navbar">
                <a href="index.jsp" class="logo"><img src="images/trolley.ico" height="40px"/>&nbsp;ShipIt</a>
                <ul>
                    <li><a href="index.html">home</a></li>
                    <li><a href="#">Couriers</a></li>
                    <li><a href="#">about</a></li>
                    <li><a href="contact.jsp">contact</a></li>
                </ul>
                <div class="dropdown">
                    <a href="#" class="btn">Register</a>
                    <div class="dropdown-content">
                        <a href="adminln.jsf">Admin</a>
                        <a href="dispatcherlogin.jsf">Dispatcher</a>
                        <a href="clientlogin.jsf">Client</a>
                    </div>
                </div>
            </div>
            <div class="content">
                <div class="text">
                    <h2>Deliver The</h2>
                    <h1>Future</h1>
                    <p>Fastest & Safest shippings via &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Air, Sea, Land.</p>
                    <a href="#" class="btn btn-primary">Get Started</a><br><br>
                    <p style="margin-left: 20px;margin-top: 10%;">Connect with us via</p>  
                    <ul class="social">
                        <li class="socialcls"><a href="https://www.facebook.com/medam.kowsik/"><i class="fab fa-facebook" aria-hidden="true"></i></a></li>
                        <li class="socialcls"><a href="https://x.com/Medam_Kowsik"><i class="fab fa-twitter" aria-hidden="true"></i></a></li>
                        <li class="socialcls"><a href="https://www.linkedin.com/in/medam-kowsik-975479282/"><i class="fab fa-linkedin" aria-hidden="true"></i></a></li>
                        <li class="socialcls"><a href="https://www.instagram.com/haa_nenele._._/"><i class="fab fa-instagram" aria-hidden="true"></i></a></li>
                        </ul>
                </div>
                <div class="image">
                    <img src="images/truck.png">
                    <div class="specification">
                        <span>1000+ <br>Deliveries</span>
                        <span>2000+<br>service providers</span>
                        <span>10+<br>shipping ways</span>
                    </div>
                </div>
            </div>
        </div>
        <div class="sidebar">
            <div class="top">
                <span>F</span>
                <span>A</span>
                <span>S</span>
                <span>T</span>
                <span>E</span>
                <span>S</span>
                <span>T</span>
            </div>
            <div class="bottom">
                <span>S</span>
                <span>A</span>
                <span>F</span>
                <span>E</span>
                <span>S</span>
                <span>T</span>
            </div>

        </div>

    </div>
</body>
</html>