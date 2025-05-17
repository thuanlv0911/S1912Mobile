<%-- 
    Document   : update
    Created on : Feb 27, 2025, 7:01:00 PM
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

            /* || Product */
            .product-container {
                max-width: 70%;
                margin: 20px auto;
                padding: 20px;
                background: #f9f9f9;
                border-radius: 10px;
                box-shadow: 0 2px 10px rgba(0, 0, 0, 0.1);
                text-align: center;
            }

            .product-header {
                display: flex;
                position: relative;
                align-items: center;
                justify-content: center;
                gap: 15px;
                margin-bottom: 20px;
            }

            .product-header h2 {
                font-size: 36px;
                margin-bottom: 20px;
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

            .product-form {
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

            .form-group input,
            .form-group textarea,
            .form-group select {
                width: 100%;
                padding: 8px;
                border: 1px solid #ccc;
                border-radius: 5px;
                font-size: 16px;
            }

            .form-group textarea {
                resize: vertical;
                min-height: 100px;
            }

            button {
                background-color: #333;
                color: white;
                padding: 10px 15px;
                border-radius: 5px;
                font-size: 16px;
                border: none;
                cursor: pointer;
                transition: 0.3s;
            }

            button:hover {
                background-color: #555;
            }

        </style>
        <title>Update Product</title>
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
        <div class="product-container">
            <div class="product-header">
                <a href="${pageContext.request.contextPath}/admin/product/product" class="back-btn">
                    <i class="uil uil-step-backward"></i>
                </a>
                <h2>Update product</h2>
            </div>
            <c:if test="${not empty requestScope.error}">
                <p style="color: red; font-weight: bold;">${requestScope.error}</p>
            </c:if>

            <c:choose>
                <c:when test="${not empty requestScope.prod}">
                    <c:set var="p" value="${requestScope.prod}"/>
                    <form action="${pageContext.request.contextPath}/admin/product/update-prod" method="post" enctype="multipart/form-data">
                        <div class="form-group">
                            <label for="productID">Product ID:</label>
                            <input type="text" id="productID" readonly name="pid" value="${p.prodID}">
                        </div>
                        <div class="form-group">
                            <label for="pname">Product Name:</label>
                            <input type="text" id="pname" name="pname" required value="${p.prodName}">
                        </div>
                        <div class="form-group">
                            <label for="imageFile">Upload Image:</label>
                            <input type="file" id="imageFile" name="imageFile" >
                        </div>
                        <div class="form-group">
                            <label for="imagePath">Enter image URL:</label>
                            <input type="text" id="imagePath" name="imagePath" value="${p.image}">
                        </div>
                        <div class="form-group">
                            <label for="quantity">Quantity:</label>
                            <input type="number" id="quantity" name="quantity" min="0" required value="${p.quantity}">
                        </div>
                        <div class="form-group">
                            <label for="price">Price:</label>
                            <input type="number" id="price" name="price" min="1" required value="${p.price}">
                        </div>
                        <div class="form-group">
                            <label for="description">Description:</label>
                            <textarea id="description" name="description" required>${p.describe}</textarea>
                        </div>
                        <div class="form-group">
                            <label for="cateID">Category:</label>
                            <select id="cateID" name="cateID" required>
                                <c:forEach var="c" items="${requestScope.cate}">
                                    <option value="${c.cateID}" ${c.cateID == p.category.cateID ? 'selected' : ''}>${c.cateID} - ${c.cateName}</option>
                                </c:forEach>
                            </select>
                        </div>
                        <button type="submit">Update</button>
                    </form>
                </c:when>
                <c:otherwise>
                    <p>Product not found or invalid data.</p>
                </c:otherwise>
            </c:choose>
        </div>
</html>


