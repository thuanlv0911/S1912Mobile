<%-- 
    Document   : userOderDetail
    Created on : Mar 15, 2025, 9:39:32 PM
    Author     : LE VAN THUAN
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
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
                background: #187bcd;
            }

            /* || BODY */
            .acc-content {
                display: flex;
                flex-direction: column;
                min-height: 63vh;
            }

            .hello {
                font-size: 28px;
                font-weight: bold;
                background: whitesmoke;
                border-radius: 10px;
                padding: 25px;
            }

            /* || #Order-info */
            .order-form {
                margin: 10px;
            }

            #order-info h2 {
                background: dodgerblue;
                color: white;
                padding: 10px 15px;
                border-radius: 8px;
                margin-bottom: 20px;
            }

            #order-info p {
                padding: 10px;
                font-size: 16px;
                line-height: 1.6;
                background: #f8f9fa;
                border-radius: 6px;
            }

            #order-info .form-group {
                display: flex;
                align-items: center;
                justify-content: space-between;
                margin-bottom: 15px;
                gap: 10px;
                width: 100%;
            }

            #order-info .form-group label {
                font-size: 16px;
                font-weight: bold;
                color: #333;
                width: 15%;
                text-align: left;
            }

            #order-info .form-group input {
                flex: 1;
                padding: 8px;
                font-size: 16px;
                border: 1px solid #007bff;
                background-color: #f8f9fa;
                border-radius: 5px;
                border: none;
            }

            #order-info .form-group input.editable {
                background: #ffffff;
                border: 1px solid #0cf;
                cursor: text;
            }

            #order-info .button-group {
                display: flex;
                gap: 10px;
            }

            #order-info button {
                padding: 10px 15px;
                font-size: 16px;
                border: none;
                border-radius: 6px;
                cursor: pointer;
                transition: 0.3s;
            }

            #order-info #updateBtn {
                background: dodgerblue;
                color: white;
            }

            #order-info #saveBtn {
                background: #28a745;
                color: white;
            }

            #order-info #exitBtn {
                background: #dc3545;
                color: white;
            }

            #order-info #updateBtn:hover {
                background: #1e7cd8;
            }

            #order-info #saveBtn:hover {
                background: #218838;
            }

            #order-info #exitBtn:hover {
                background: #c82333;
            }

            #order-info .hidden {
                display: none;
            }

            a#backOrderBtn {
                margin: 10px;
                padding: 8px 8px;
                font-size: 14px;
                border: none;
                cursor: pointer;
                border-radius: 4px;
                text-decoration: none;
                text-align: center;
            }

            a#backOrderBtn {
                background: dodgerblue;
                color: white;
            }

            .hidden {
                display: none;
            }

            a#backOrderBtn:hover {
                background: #1e7cd8;
            }
            
            .container h3 {
                font-size: 20px;
                margin-top: 20px;
                margin-left: 15px;
                padding-bottom: 5px;
                border-bottom: 2px solid #ddd;
                color: #333;
                border-radius: 8px;

            }
            
            .order-table-product table {
                width: 100%;
                border-collapse: collapse;
                background: #fafafa;
                margin: 20px;
            }

            .order-table-product th,
            .order-table-product td {
                padding: 12px;
                text-align: left;
                border-bottom: 1px solid #ddd;
            }

            .order-table-product th {
                background-color: #f0f0f0;
                font-weight: bold;
                color: #333;
                width: 15%;
            }

            .order-table-product td {
                width: 60%;
            }
            
            .order-table-product {
                width: 100%;
                border-collapse: collapse;
                background: #fff;
                margin: 15px;
            }

            .order-table-product th,
            .order-table-product td {
                padding: 12px;
                border-bottom: 1px solid #ddd;
            }

            .order-table-product th:nth-child(1),
            .order-table-product td:nth-child(1) {
                width: 40%;
            }

            .order-table-product th:nth-child(2),
            .order-table-product td:nth-child(2) {
                width: 15%;
            }

            .order-table-product th:nth-child(3),
            .order-table-product td:nth-child(3) {
                width: 20%;
            }

            .order-table-product th:nth-child(4),
            .order-table-product td:nth-child(4) {
                width: 25%;
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


            @media screen and (min-width: 44541px) {
                .acc-content {
                    min-height: 85vh;
                }
            }

            @media screen and (min-width: 1541px) {
                .acc-content {
                    min-height: 65vh;
                }
            }
        </style>
        <title>Profile | Order Detail</title>
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
        <section>
            <div class="container">
                <c:set var="a" value="${requestScope.a}"/>
                <c:if test="${not empty a}">
                    <div class="hello">
                        Hello ${a.username} ❤️‍🔥
                    </div>
                </c:if>
                <div class="acc-content">
                    <div id="order-info" class="content">
                        <h2>Order Information</h2>
                        <p>Details of your order.</p>

                        <form class="order-form" id="orderForm" action="user-order" method="post">
                            <input type="hidden" name="orderID" value="${order.orderID}">
                            <div class="form-group">
                                <label for="acc-id">Account ID: </label>
                                <input type="text" id="acc-id" value="${order.accID}" readonly>
                            </div>
                            <div class="form-group">
                                <label for="order-id">Order ID: </label>
                                <input type="text" id="order-id" value="${order.orderID}" readonly>
                            </div>

                            <div class="form-group">
                                <label for="order-date">Order Date: </label>
                                <input type="text" id="order-date" value="${order.create_At}" readonly>
                            </div>
                            <div class="form-group">
                                <label for="email">Email: </label>
                                <input type="text" id="email" name="email" value="${order.email}" ${order.status == 'Pending' ? 'readonly' : ''}>
                            </div>
                            <div class="form-group">
                                <label for="phone">Phone Number: </label>
                                <input type="number" id="phone" name="phone" value="${order.phoneNumber}" ${order.status == 'Pending' ? 'readonly' : ''}>
                            </div>
                            <div class="form-group">
                                <label for="address">Address: </label>
                                <input type="text" id="address" name="address" value="${order.address}" ${order.status == 'Pending' ? 'readonly' : ''}>
                            </div>
                            <div class="form-group">
                                <label for="status">Status: </label>
                                <input type="text" id="status" value="${order.status}" readonly>
                            </div>
                            <div class="form-group">
                                <label for="total">Total Amount: </label>
                                <input type="text" id="total" value="${order.totalAmount}đ" readonly>
                            </div>
                            <c:if test="${not empty err}">
                                <p style="color: red;">${err}</p>
                                <c:remove var="err" scope="session"/> 
                            </c:if>
                            <c:if test="${not empty succ}">
                                <p style="color: green;">${succ}</p>
                                <c:remove var="succ" scope="session"/> 
                            </c:if>
                            <c:if test="${order.status == 'Pending'}">
                                <div class="button-group">
                                    <button type="button" id="updateBtn">Update</button>
                                    <button type="submit" id="saveBtn" class="hidden">Save</button>
                                    <button type="button" id="exitBtn" class="hidden">Exit</button>
                                </div>
                            </c:if>
                        </form>
                    </div>
                    <h3>Products in Order</h3>
                    <table class="order-table-product">
                        <thead>
                            <tr>
                                <th>Product Name</th>
                                <th>Quantity</th>
                                <th>Unit Price</th>
                                <th>Subtotal</th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:forEach var="od" items="${requestScope.orderDetails}">
                                <tr>
                                    <td>${od.prodName}</td>
                                    <td>${od.quantity}</td>
                                    <td>${od.unitPrice - (od.unitPrice * 0.15)}<sup>đ</sup></td>
                                    <td>${(od.subTotal - (od.subTotal * 0.15))}<sup>đ</sup></td>
                                </tr>
                            </c:forEach>
                        </tbody>
                    </table>
                    <a id="backOrderBtn" href="profile"
                       style="margin-bottom: 24px;">Back to order</a>
                </div>
            </div>
        </section>
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
        <script>
            document.addEventListener("DOMContentLoaded", function () {
                const updateBtn = document.getElementById("updateBtn");
                const saveBtn = document.getElementById("saveBtn");
                const exitBtn = document.getElementById("exitBtn");

                // Chỉ chọn các input cần chỉnh sửa
                const editableFields = ["email", "phone", "address"];
                const inputs = editableFields.map(id => document.getElementById(id));

                // Khi nhấn "Update"
                updateBtn.addEventListener("click", function () {
                    inputs.forEach(input => {
                        input.removeAttribute("readonly"); // Bỏ readonly để chỉnh sửa
                        input.classList.add("editable"); // Thêm class để hiển thị viền
                    });

                    saveBtn.style.display = "inline-block"; // Hiện nút Save
                    exitBtn.style.display = "inline-block"; // Hiện nút Exit
                    updateBtn.style.display = "none"; // Ẩn nút Update
                });

                // Khi nhấn "Exit"
                exitBtn.addEventListener("click", function () {
                    inputs.forEach(input => {
                        input.setAttribute("readonly", true); // Không cho chỉnh sửa
                        input.classList.remove("editable"); // Ẩn viền input
                    });

                    saveBtn.style.display = "none"; // Ẩn nút Save
                    exitBtn.style.display = "none"; // Ẩn nút Exit
                    updateBtn.style.display = "inline-block"; // Hiện nút Update
                });
            });

        </script>
    </body>
</html>
