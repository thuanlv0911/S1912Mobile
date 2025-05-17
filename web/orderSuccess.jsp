<%-- 
    Document   : orderSuccess
    Created on : Mar 9, 2025, 9:52:53 AM
    Author     : LE VAN THUAN
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link rel="stylesheet" href="https://unicons.iconscout.com/release/v4.0.8/css/line.css">
        <style>
            * {
                padding: 0;
                margin: 0;
                box-sizing: border-box;
            }

            body {
                background-color: #fff;
            }

            /*|| NAV */
            nav {
                background-color: dodgerblue;
            }

            .container {
                max-width: 90%;
                margin: auto;
            }

            .navbar {
                display: flex;
                justify-content: space-between;
                align-items: center;
                padding: 10px 0;
            }

            .navbar li {
                list-style: none;
            }

            .navbar li a {
                text-decoration: none;
                color: #fff;
            }

            .logo a {
                font-size: 44px;
                font-family: cursive, 'Courier New', Courier, monospace;
            }

            .menu ul,
            .actions ul {
                display: flex;
                align-items: center;
                gap: 20px;
            }

            .menu ul li a,
            .actions ul li a {
                font-size: 18px;
            }

            .actions ul li:nth-child(1) {
                position: relative;
            }

            .actions ul li:nth-child(1) input {
                height: 32px;
                width: 100%;
                border-radius: 5px;
                border: none;
                padding: 0 10px;
            }

            .actions ul li:nth-child(1) i {
                position: absolute;
                font-size: 20px;
                right: 8px;
                color: #ccc;
                line-height: 32px;
                cursor: pointer;
            }

            .actions ul li button {
                background-color: transparent;
                border: none;
                color: #fff;
                font-size: 18px;
                cursor: pointer;
                display: flex;
                align-items: center;
                gap: 5px;
            }

            input[type="submit"] {
                background: #1E90FF;
                color: white;
                border: none;
                padding: 8px 15px;
                font-size: 16px;
                border-radius: 6px;
                cursor: pointer;
                transition: 0.3s;
            }

            input[type="submit"]:hover {
                background: #0cf;
            }

            .actions ul li a i {
                font-size: 28px;
            }

            .navbar-search {
                display: flex;
                align-items: center;
                background: #fff;
                border-radius: 20px;
                padding: 5px 10px;
                width: 250px;
                border: 1px solid #ddd;
            }

            .navbar-search input {
                border: none;
                outline: none;
                flex: 1;
                padding: 8px;
                font-size: 16px;
                border-radius: 20px;
            }

            .navbar-search button {
                background: none;
                border: none;
                cursor: pointer;
                padding: 0;
                display: flex;
                align-items: center;
                justify-content: center;
            }

            .navbar-search button img {
                width: 24px;
                height: 24px;
                opacity: 0.7;
                transition: opacity 0.3s ease-in-out;
            }

            .navbar-search button:hover img {
                opacity: 1;
                transform: scale(1.2);
            }

            /* || BODY */
            .body-container {
                text-align: center;
                padding: 50px 20px;
                max-width: 600px;
                margin: 50px auto;
                background: #f9f9f9;
                border-radius: 10px;
                box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
            }

            .body-container h2 {
                color: dodgerblue;
                font-size: 28px;
                margin-bottom: 15px;
            }

            .body-container p {
                font-size: 16px;
                color: #333;
                margin-bottom: 20px;
            }

            .body-container a {
                display: inline-block;
                background: dodgerblue;
                color: white;
                padding: 10px 20px;
                font-size: 16px;
                border-radius: 6px;
                text-decoration: none;
                transition: 0.3s;
            }

            .body-container a:hover {
                background: #0cf;
            }

            /* || FOOTER */
            footer {
                background-color: dodgerblue;
                color: white;
                padding-top: 36px;
                padding-bottom: 12px;
                text-align: center;
            }

            .footer-container {
                max-width: 86%;
                margin: auto;
                display: flex;
                justify-content: space-between;
                flex-wrap: wrap;
                align-items: flex-start;
                text-align: left;
            }

            .footer-section {
                width: 30%;
            }

            .footer-section h3 {
                font-size: 20px;
                margin-bottom: 15px;
                border-bottom: 2px solid white;
                display: inline-block;
                padding-bottom: 5px;
            }

            .footer-section p {
                font-size: 14px;
                line-height: 1.5;
                margin-bottom: 10px;
            }

            .footer-section ul {
                list-style: none;
                padding: 0;
            }

            .footer-section ul li {
                margin-bottom: 8px;
            }

            .footer-section ul li a {
                text-decoration: none;
                color: white;
                transition: 0.3s;
                font-size: 14px;
            }

            .footer-section ul li a:hover {
                color: lightgray;
            }

            .footer-socials {
                display: flex;
                gap: 15px;
                align-items: center;
                margin-top: 10px;
            }

            .footer-socials a {
                color: white;
                font-size: 24px;
                transition: 0.3s;
                display: flex;
                align-items: center;
                justify-content: center;
                width: 40px;
                height: 40px;
                border: 1px solid white;
                border-radius: 50%;
            }

            .footer-socials a:hover {
                background-color: white;
                color: dodgerblue;
            }

            footer > a {
                text-decoration: none;
                color: #fff;
            }

            html {
                scroll-behavior: smooth;
            }
            html, body {
                height: 100%;
                display: flex;
                flex-direction: column;
            }

            .container {
                flex: 1;
            }


        </style>
        <title>Order Success</title>
    </head>
    <body>
        <header>
            <nav>
                <div class="container">
                    <ul class="navbar">
                        <li class="logo"><a href="#">1912 Mobile</a></li>
                        <li class="menu">
                            <ul>
                                <li><a href="home">Home</a></li>
                                <li><a href="#about">About</a></li>
                                <li><a href="products">Products</a></li>
                                <li><a href="#contact">Contact</a></li>
                                <li><a href="#about">Privacy Policy</a></li>
                            </ul>
                        </li>
                        <li class="actions">
                            <ul>
                                <li>
                                    <div>
                                        <form action="home" class="navbar-search">
                                            <input type="text" placeholder="Search...." name="key">
                                            <button onclick="this.form.submit()">
                                                <img src="img/iconSearch.png" width="16px" height="16px">
                                            </button>
                                        </form>
                                    </div>
                                </li>
                                <li><a href="profile"><i class="uil uil-user-circle"></i></a></li>
                                <li><a href="cart"><button><i class="uil uil-shopping-cart"></i></button></a></li>
                                <li>
                                    <form action="logout" method="post">
                                        <input type="submit" value="Logout">
                                    </form>
                                </li>
                            </ul>
                        </li>
                    </ul>
                </div>
            </nav>
        </header>
        <div class="container">
            <div class="body-container">
                <h2>Order Placed Successfully!</h2>
                <p>Thank you for your purchase. Your order has been placed successfully.</p>
                <a href="home">Continue Shopping</a>
            </div>
        </div>
        <footer>
            <div class="footer-container">
                <div class="footer-section">
                    <h3 id="about">About Us</h3>
                    <p>&copy; 1912 Mobile offers the latest mobile products at reasonable prices.</p>
                    <ul>
                        <li><a href="#">Company Info</a></li>
                        <li><a href="#">Careers</a></li>
                        <li><a href="#">Privacy Policy</a></li>
                    </ul>
                </div>
                <div class="footer-section">
                    <h3 id="contact">Support Center</h3>
                    <p>Call to Order: 1900 232 460 (8:00 - 21:30)</p>
                    <p>Complaints: 1800 1062 (8:00 - 21:30)</p>
                    <p>Warranty Support: 1900 232 464 (8:00 - 21:00)</p>
                </div>
                <div class="footer-section">
                    <h3>Follow Us</h3>
                    <div class="footer-socials">
                        <a href="#"><i class="uil uil-facebook-f"></i></a>
                        <a href="#"><i class="uil uil-instagram"></i></a>
                        <a href="#"><i class="uil uil-youtube"></i></a>
                    </div>
                </div>
            </div>
            <a href="#">&#8593; Back to Top</a>
        </footer>
    </body>
</html>
