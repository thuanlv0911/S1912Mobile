<%-- 
    Document   : order
    Created on : Mar 9, 2025, 12:01:42 PM
    Author     : LE VAN THUAN
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link rel="stylesheet" href="https://unicons.iconscout.com/release/v4.0.8/css/line.css">
        <link rel="stylesheet" href="../../css/order.css">
        <title>Admin | Orders</title>
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
                <h2>Orders</h2>
                <a href="statistics" class="statistics-btn">Statistics</a>
            </div>
            <div class="order-list">
                <c:choose>
                    <c:when test="${empty orders}">
                        <p>You have no orders yet.</p>
                    </c:when>
                    <c:otherwise>
                        <table class="order-table">
                            <thead>
                                <tr>
                                    <th>Order ID</th>
                                    <th>Acc ID</th>
                                    <th>Order date</th>
                                    <th>Total amount</th>
                                    <th>Status</th>
                                    <th>Receive</th>
                                    <th>Action</th>
                                </tr>
                            </thead>
                            <tbody>
                                <c:forEach var="o" items="${requestScope.orders}">
                                    <tr>
                                        <td>${o.orderID}</td>
                                        <td>${o.accID}</td>
                                        <td>${o.create_At}</td>
                                        <td>${o.totalAmount}<sup>đ</sup></td>
                                        <td>
                                            <form class="status-form" action="order" method="post">
                                                <input type="hidden" name="orderID" value="${o.orderID}">
                                                <select name="status" ${o.status == 'Canceled' ? 'disabled' : ''}>
                                                    <option value="Pending" ${o.status == 'Pending' ? 'selected' : ''}>Pending</option>
                                                    <option value="Processing" ${o.status == 'Processing' ? 'selected' : ''}>Processing</option>
                                                    <option value="Completed" ${o.status == 'Completed' ? 'selected' : ''}>Completed</option>
                                                    <option value="Canceled" ${o.status == 'Canceled' ? 'selected' : ''}>Canceled</option>
                                                </select>
                                                <c:choose>
                                                    <c:when test="${o.isReceived || o.status == 'Canceled'}">
                                                        <button disabled style="background-color: #ccc; cursor: not-allowed;" class="update-btn" type="submit">Update</button>
                                                    </c:when>
                                                    <c:otherwise>
                                                        <button class="update-btn" type="submit">Update</button>
                                                    </c:otherwise>
                                                </c:choose>
                                            </form>
                                            <c:if test="${not empty error}">
                                                <p style="color: red;">${error}</p>
                                            </c:if>
                                        </td>

                                        <td>
                                            <c:choose>
                                                <c:when test="${o.status == 'Canceled'}">
                                                    <span style="color: white; background: red; padding: 4px;">Canceled</span>
                                                </c:when>
                                                <c:when test="${o.isReceived}">
                                                    <span style="color: green;">Received</span>
                                                </c:when>
                                                <c:otherwise>
                                                    <span style="color: red;">Not Received</span>
                                                </c:otherwise>
                                            </c:choose>
                                        </td>
                                        <td>
                                            <form action="order-detail" method="get">
                                                <input type="hidden" name="orderID" value="${o.orderID}">
                                                <button type="submit" class="view-btn">View</button>
                                            </form>
                                        </td>

                                    </tr>
                                </c:forEach>
                            </tbody>
                            <tfoot>
                                <tr>
                                    <td colspan="3" style="text-align: right; font-weight: bold;">Total:</td>
                                    <td style="font-weight: bold;">${totalAmountSum}<sup>đ</sup></td>
                                    <td colspan="3"></td> 
                                </tr>
                                <tr>
                                    <td colspan="3" style="text-align: right; font-weight: bold; color: #31b0d5;">Highest Order:</td>
                                    <td style="font-weight: bold; color: #31b0d5;">${highestOrderAmount}<sup>đ</sup></td>
                                    <td colspan="3"></td> 
                                </tr>
<!--                                <tr>
                                    <td colspan="3" style="text-align: right; font-weight: bold; color: green;">Lowest Order:</td>
                                    <td style="font-weight: bold; color: green;">${lowestOrderAmount}<sup>đ</sup></td>
                                    <td colspan="3"></td> 
                                </tr>-->
                            </tfoot>
                        </table>
                    </c:otherwise>
                </c:choose>
            </div>
        </div>
    </body>
</html>
