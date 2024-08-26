<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Contact</title>
<style>
    :root {
        --color-black: #000;
    }

    h3 {
        margin-left: 100px;
        font-size: 30px;
    }

    .contact-link1 {
        display: flex;
        align-items: center;
        margin-bottom: 10px;
        margin-left: 100px;
    }

    .contact-link1:hover {
        color: greenyellow;
    }

    .contact-link1 a {
        margin-left: 10px;
        text-decoration: none;
    }

    .contact-link2 {
        display: flex;
        align-items: center;
        margin-bottom: 10px;
        margin-left: 100px;
    }

    .contact-link2:hover {
        color: skyblue;
    }

    .contact-link2 a {
        margin-left: 10px;
        text-decoration: none;
    }

    .me {
        font-size: 36px;
        color: black;
    }

    .m {
        font-size: 36px;
        color: black;
    }

    .fa-whatsapp {
        font-size: 30px;
        color: green;
    }

    .contact-link {
        font-size: 36px;
        color: rgb(255, 255, 255);
    }

    .fa2 {
        font-size: 30px;
    }

    .cont {
        height: 660px;
    }

    .navbar {
        display: flex;
        justify-content: space-between;
        align-items: center;
        position: relative;
        top: -10%;
        animation: navbar 1s forwards;
        animation-delay: 1s;
    }

    @keyframes navbar {
        0% {
            top: -10%;
        }
        100% {
            top: 0;
        }
    }

    .navbar ul {
        display: flex;
        justify-content: center;
        align-items: center;
        gap: 30px;
    }

    .navbar ul li {
        list-style: none;
    }

    .navbar ul li a {
        text-decoration: none;
        font-size: 1.3vw;
        color: var(--color-black);
        font-weight: 600;
        text-transform: uppercase;
    }

    .logo {
        text-decoration: none;
        font-size: 40px;
        font-family: 'Trebuchet MS', 'Lucida Sans Unicode', 'Lucida Grande', 'Lucida Sans', Arial, sans-serif;
        font-weight: bolder;
        letter-spacing: 3px;
        color: var(--color-black);
        font-weight: 400;
    }
</style>
</head>
<body>
    <div>
        <div class="navbar">
            <a href="index.html" class="logo"><img src="images/trolley.ico" height="40px" alt="Logo"/>&nbsp;ShipIt</a>
            <ul>
                <li><a href="index.html">Home</a></li>
                <li><a href="#">Couriers</a></li>
                <li><a href="#">About</a></li>
                <li><a href="contact.jsp">Contact</a></li>
            </ul>
        </div>
        <div class="cont">
            <br><br><br>
            <h3>For any Queries, you can feel free to contact us 😊</h3>

            <div class="contact-link1">
                <a class="me" href="whatsapp://send?phone=9346339305">Contact Us via WhatsApp</a>
                <img src="images/whatsapp.png" alt="WhatsApp" height="30" width="35">
            </div>
            <div class="contact-link2">
                <a class="m" href="mailto:2200030358@kluniversity.in?subject=Your%20Subject&body=Your%20Message%20Here">
                    Contact us via Email 
                    <svg width="35px" height="35px" viewBox="0 0 1024 1024" version="1.1" xmlns="http://www.w3.org/2000/svg">
                        <path d="M512 599.6L107.9 311.1v19.7L512 619.3l404.1-288.6V311L512 599.6z" fill="#E73B37" />
                        <path d="M63.9 187v650h896.2V187H63.9z m852.2 598.5L672.2 611.3l-13.8 9.8L899.1 793H125.5l240.6-171.8-13.8-9.8-244.4 174.5V231h808.2v554.5z" fill="#39393A" />
                        <path d="M512.9 536.7m-10 0a10 10 0 1 0 20 0 10 10 0 1 0-20 0Z" fill="#E73B37" />
                    </svg>
                </a>
            </div>
        </div>
    </div>
</body>
</html>
