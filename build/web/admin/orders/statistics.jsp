<%-- 
    Document   : statistics
    Created on : Mar 14, 2025, 8:28:32 PM
    Author     : LE VAN THUAN
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
        <link rel="stylesheet" href="https://unicons.iconscout.com/release/v4.0.8/css/line.css">
        <title>Admin | Statistics</title>
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

            /* || BODY */
            .order-container {
                max-width: 70%;
                margin: 20px auto;
                padding: 20px;
                background: #f9f9f9;
                border-radius: 10px;
                box-shadow: 0 2px 10px rgba(0, 0, 0, 0.1);
            }

            .order-header {
                display: flex;
                position: relative;
                align-items: center;
                justify-content: space-between;
                margin-bottom: 20px;
                width: 100%;
            }

            .order-header h2 {
                font-size: 36px;
                flex-grow: 1;
                text-align: center;
                margin-bottom: 20px;
            }

            .order-buttons {
                display: flex;
                justify-content: flex-end;
            }

            .back-btn {
                position: absolute;
                float: left;
                left: 0;
                font-size: 24px;
                color: #333;
                text-decoration: none;
                transition: 0.3s;
            }

            .back-btn:hover {
                color: #555;
            }

            .toggle-btn {
                display: inline-block;
                background-color: #333;
                color: #fff;
                padding: 10px 15px;
                border-radius: 5px;
                text-decoration: none;
                transition: 0.3s;
                white-space: nowrap;
            }

            .toggle-btn:hover {
                background-color: #555;
            }

            /* || TABLE */
            .order-body {
                max-width: 100%;
                overflow-x: auto;
            }

            .order-table {
                width: 100%;
                border-collapse: collapse;
                background: #fff;
                border-radius: 10px;
                overflow: hidden;
                box-shadow: 0 2px 10px rgba(0, 0, 0, 0.1);
            }

            .order-table th, .order-table td {
                padding: 12px 15px;
                border: 1px solid #ddd;
                text-align: left;
            }

            .order-table th {
                background: #555;
                color: #fff;
                font-weight: bold;
            }

            .order-table tr:nth-child(even) {
                background: #f9f9f9;
            }

            .order-table tr:hover {
                background: #f1f1f1;
            }

            #productChart {
                display: none;
            }
        </style>
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
                <a href="${pageContext.request.contextPath}/admin/orders/order" class="back-btn">
                    <i class="uil uil-step-backward"></i>
                </a>
                <h2>Statistics of sold and remaining products</h2>

                <div class="order-buttons">
                    <button id="chartBtn" class="toggle-btn">Chart</button>
                    <button id="tableBtn" class="toggle-btn" style="display: none;">Number</button>
                </div>

            </div>
            <div class="order-body" id="tableView">
                <table class="order-table">
                    <thead>
                        <tr>
                            <th>Prod ID</th>
                            <th>Prod Name</th>
                            <th>Number of units sold</th>
                            <th>Remaining quantity</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:forEach items="${statisticsList}" var="stat">
                            <tr>
                                <td>${stat.prodID}</td>
                                <td>${stat.prodName}</td>
                                <td>${stat.totalSold}</td>
                                <td>
                                    <c:choose>
                                        <c:when test="${stat.quantity == 0}">
                                            <span style="color: white; background: red; padding: 4px;">${stat.quantity}</span>
                                        </c:when>
                                        <c:otherwise>
                                            <span>${stat.quantity}</span>
                                        </c:otherwise>
                                    </c:choose>
                                </td>
                            </tr>
                        </c:forEach>
                    </tbody>
                    <tfoot>
                        <tr>
                            <td colspan="2" style="text-align: right; font-weight: bold;">Total Sold:</td>
                            <td colspan="2" style="font-weight: bold;">${totalSoldSum}</td>
                        </tr>
                    </tfoot>

                </table>
            </div>
            <canvas id="productChart" width="400" height="200" style="display: none;"></canvas>

        </div>

        <script>
            var productNames = [
            <c:forEach items="${prodNames}" var="name" varStatus="loop">
            "${name}"${loop.last ? '' : ','}
            </c:forEach>
            ];
            var totalSoldList = [
            <c:forEach items="${totalSoldList}" var="sold" varStatus="loop">
                ${sold}${loop.last ? '' : ','}
            </c:forEach>
            ];
            var quantities = [
            <c:forEach items="${quantities}" var="qty" varStatus="loop">
                ${qty}${loop.last ? '' : ','}
            </c:forEach>
            ];

            var ctx = document.getElementById('productChart').getContext('2d');
            var chart = new Chart(ctx, {
                type: 'line',
                data: {
                    labels: productNames,
                    datasets: [
                        {
                            label: 'Number of units sold',
                            data: totalSoldList,
                            backgroundColor: 'rgba(75, 192, 192, 0.2)',
                            borderColor: 'rgba(75, 192, 192, 1)',
                            borderWidth: 1
                        },
                        {
                            label: 'Remaining quantity',
                            data: quantities,
                            backgroundColor: 'rgba(255, 99, 132, 0.2)',
                            borderColor: 'rgba(255, 99, 132, 1)',
                            borderWidth: 1
                        }
                    ]
                },
                options: {
                    scales: {
                        y: {
                            beginAtZero: true
                        }
                    }
                }
            });

            const chartBtn = document.getElementById('chartBtn');
            const tableBtn = document.getElementById('tableBtn');
            const tableView = document.getElementById('tableView');
            const chartView = document.getElementById('productChart');

            chartView.style.display = 'none';


            chartBtn.addEventListener('click', () => {
                tableView.style.display = 'none';
                chartView.style.display = 'block';
                chartBtn.style.display = 'none';
                tableBtn.style.display = 'inline-block';
            });

            tableBtn.addEventListener('click', () => {
                tableView.style.display = 'block';
                chartView.style.display = 'none';
                chartBtn.style.display = 'inline-block';
                tableBtn.style.display = 'none';
            });

        </script>
    </body>
</html>
