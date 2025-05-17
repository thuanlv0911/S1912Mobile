<%-- 
    Document   : update
    Created on : Feb 23, 2025, 5:04:57 PM
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

            .category-container {
                max-width: 70%;
                margin: 20px auto;
                padding: 20px;
                background: #f9f9f9;
                border-radius: 10px;
                box-shadow: 0 2px 10px rgba(0, 0, 0, 0.1);
                text-align: center;
            }

            .category-header {
                display: flex;
                align-items: center;
                justify-content: center;
                gap: 15px;
                margin-bottom: 20px;
                position: relative;
            }
            
            .category-header h2 {
                font-size: 36px;
                margin-bottom: 20px;
            }

            .back-btn {
                font-size: 24px;
                color: #333;
                text-decoration: none;
                transition: 0.3s;
                position: absolute;
                float: left;
                left: 0;
            }

            .back-btn:hover {
                color: #555;
            }

            .category-form {
                display: flex;
                flex-direction: column;
                align-items: center;
            }

            .form-group {
                display: flex;
                flex-direction: column;
                align-items: flex-start;
                width: 100%;
                margin-bottom: 15px;
            }

            .form-group label {
                font-weight: bold;
                margin-bottom: 5px;
            }
            .category-form {
                display: flex;
                flex-direction: column;
                align-items: center;
            }
            .form-group input {
                width: 100%;
                padding: 8px;
                border: 1px solid #ccc;
                border-radius: 5px;
                font-size: 16px;
            }

            .add-category-btn {
                background-color: #333;
                color: white;
                padding: 10px 15px;
                border-radius: 5px;
                font-size: 16px;
                text-decoration: none;
                transition: 0.3s;
                border: none;
                cursor: pointer;
            }

            .add-category-btn:hover {
                background-color: #555;
            }

        </style>
        <title>Update Category</title>
    </head>
    <body>
        <header>
            <nav>
                <div class="container">
                    <ul class="navbar">
                        <li class="logo"><a href="#">1912 Mobile</a></li>
                        <li class="menu">
                            <ul>
                                <li><a href="category">Categories</a></li>
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
        <div class="category-container">
            <div class="category-header">
                <a href="${pageContext.request.contextPath}/admin/category/category" class="back-btn">
                    <i class="uil uil-step-backward"></i>
                </a>
                <h2>Update category</h2>
            </div>

            <c:set var="c" value="${requestScope.cate}"/>

            <form action="update-cate" method="post" class="category-form"> 
                <div class="form-group">
                    <label for="cid">Category ID:</label>
                    <input type="number" id="cid" name="cid" readonly value="${c.cateID}">
                </div>

                <div class="form-group">
                    <label for="cname">Enter category name:</label>
                    <input type="text" id="cname" name="cname" value="${c.cateName}" required>
                </div>

                <button type="submit" class="add-category-btn">Update</button>
            </form>
        </div>
    </body>
</html>
