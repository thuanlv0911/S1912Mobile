<%-- 
    Document   : orderDetail
    Created on : Mar 11, 2025, 11:28:47 AM
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
                background-color: #333;
            }

            .container {
                max-width: 80%;
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
                font-size: 40px;
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

            input[type="submit"] {
                background: #333;
                color: white;
                border: none;
                padding: 8px 15px;
                font-size: 16px;
                border-radius: 6px;
                cursor: pointer;
                transition: 0.3s;
            }

            input[type="submit"]:hover {
                background: #555;
            }

            /* || BODY */
            .order-container {
                max-width: 70%;
                margin: 20px auto;
                padding: 20px;
                background: #f9f9f9;
                border-radius: 10px;
                box-shadow: 0 2px 10px rgba(0, 0, 0, 0.1);
            }

            .order-container h2 {
                font-size: 36px;
                text-align: left;
                margin-bottom: 20px;
            }


            .order-header {
                display: flex;
                position: relative;
                align-items: center;
                justify-content: center;
                gap: 15px;
                margin-bottom: 20px;
            }

            .order-header h2 {
                font-size: 40px;
            }

            .back-btn {
                position: absolute;
                left: 0;
                font-size: 24px;
                color: #333;
                text-decoration: none;
                transition: 0.3s;
            }

            .back-btn:hover {
                color: #555;
            }

            .order-table {
                background: #fff;
                padding: 20px;
                border-radius: 10px;
                box-shadow: 0 2px 10px rgba(0, 0, 0, 0.1);
                margin-bottom: 20px;
            }

            .order-table h3 {
                font-size: 20px;
                margin-top: 15px;
                margin-bottom: 15px;
                padding-bottom: 5px;
                border-bottom: 2px solid #ddd;
                color: #333;
            }

            .order-table table {
                width: 100%;
                border-collapse: collapse;
                background: #fafafa;
                margin: 12px;
            }

            .order-table th,
            .order-table td {
                padding: 12px;
                text-align: left;
                border-bottom: 1px solid #ddd;
            }

            .order-table th {
                background-color: #f0f0f0;
                font-weight: bold;
                color: #333;
                width: 15%;
            }

            .order-table td {
                width: 60%;
            }

            .order-table-product {
                width: 100%;
                border-collapse: collapse;
                background: #fff;
                margin-top: 10px;
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



        </style>
        <title>Admin | Orders Detail</title>
    </head>
    <body>
        <header>
            <nav>
                <div class="container">
                    <ul class="navbar">
                        <li class="logo"><a href="#">1912 Mobile</a></li>
                        <li class="menu">
                            <ul>
                                <li><a href="/s1912mobile/admin/category/category">Categories</a></li>
                                <li><a href="/s1912mobile/admin/product/product">Products</a></li>
                                <li><a href="/s1912mobile/admin/orders/order">Orders</a></li>
                                <li><a href="/s1912mobile/admin/accounts/admin">Accounts</a></li>
                            </ul>
                        </li>
                        <li class="actions">
                            <ul>
                                <li>
                                    <form action="${pageContext.request.contextPath}/logout" method="post">
                                        <input type="submit" value="Logout">
                                    </form>
                                </li>
                            </ul>
                        </li>
                    </ul>
                </div>
            </nav>
        </header>

        <div class="order-container">

            <div class="order-header">
                <h2>Order Details</h2>
                <a href="/s1912mobile/admin/orders/order" class="back-btn">
                    <i class="uil uil-step-backward" ></i>
                </a>
            </div>
            <div class="order-table">
                <h3>Account Information</h3>
                <table class="order-table-acc">
                    <tr><th>Account ID:</th><td>${account.id}</td></tr>
                    <tr><th>Username:</th><td>${account.username}</td></tr>
                    <tr><th>Email:</th><td>${account.email}</td></tr>
                    <tr><th>Phone:</th><td>${account.phoneNumber}</td></tr>
                    <tr><th>Address:</th><td>${account.address}</td></tr>
                </table>

                <h3>Order Information</h3>
                <table class="order-table-infor">
                    <tr><th>Order ID:</th><td>${order.orderID}</td></tr>
                    <tr><th>Order Date:</th><td>${order.create_At}</td></tr>
                    <tr><th>Address:</th><td>${order.address}</td></tr>
                    <tr><th>Email:</th><td>${order.email}</td></tr>
                    <tr><th>Phone Number:</th><td>${order.phoneNumber}</td></tr>
                    <tr><th>Status:</th><td>${order.status}</td></tr>
                    <tr><th>Receive:</th><td>${order.isReceived ? "Received" : "Not Received"}</td></tr>
                    <tr><th>Total Amount:</th><td>${order.totalAmount}<sup>đ</sup></td></tr>
                </table>

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
            </div>
        </div>                                
    </body>
</html>
