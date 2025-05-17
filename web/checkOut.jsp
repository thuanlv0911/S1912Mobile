<%-- 
    Document   : checkOut
    Created on : Mar 8, 2025, 8:21:54 PM
    Author     : LE VAN THUAN
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link rel="stylesheet" href="https://unicons.iconscout.com/release/v4.0.8/css/line.css">
        <link rel="stylesheet" href="css/checkOut.css">
        <title>Check Out</title>
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

        <section class="body-checkout">
            <div class="container">
                <div class="body-check-out">
                    <div class="body-check-out-left">
                        <h3>Billing Details 💸</h3>
                        <c:set var="a" value="${requestScope.a}"/>
                        <form action="check-out" method="post">
                            <label for="username">Account ID</label>
                            <input type="text" id="username" name="username" value="${a.id}" required readonly>

                            <label for="address">Address</label>
                            <input type="text" id="address" name="address" value="${a.address}" required>

                            <label for="phoneNumber">Phone Number</label>
                            <input type="text" id="phoneNumber" name="phoneNumber" value="${a.phoneNumber}" required>

                            <label for="email">Email</label>
                            <input type="text" id="email" name="email" value="${a.email}" required>

                            <label for=""><i class="uil uil-bill"></i> Cash on delivery</label>

                            <button type="submit" class="place-order-btn">Place Order</button>
                        </form>
                        <c:if test="${not empty error}">
                            <p style="color: red;">${error}</p>
                        </c:if>

                    </div>
                    <div class="body-check-out-right">
                        <h3>Order Summary</h3>
                        <table class="order-summary">
                            <thead>
                                <tr>
                                    <th>Image</th>
                                    <th>Product Name</th>
                                    <th>Quantity</th>
                                    <th>Price</th>
                                    <th>Subtotal</th>
                                </tr>
                            </thead>
                            <tbody>
                                <c:forEach var="item" items="${cartItems}">
                                    <tr>
                                        <td><img src="${item.product.image}" alt="Product" width="92"></td>
                                        <td>${item.product.prodName}</td>
                                        <td>${item.quantity}</td>
                                        <td>${item.product.price - (item.product.price * 0.15)}<sup>đ</sup></td>
                                        <td>${item.quantity * (item.product.price - (item.product.price * 0.15))}<sup>đ</sup></td>
                                    </tr>
                                </c:forEach>
                            </tbody>
                        </table>

                        <div class="cart-totals">
                            <h3>Cart Totals</h3>
                            <table>
                                <tr>
                                    <td>Subtotal</td>
                                    <td>${subtotal}<sup>đ</sup></td>
                                </tr>
                                <tr>
                                    <td>Shipping</td>
                                    <td>${shippingFee}<sup>đ</sup></td>
                                </tr>
                                <tr>
                                    <td><strong>Total Amount</strong></td>
                                    <td><strong>${totalAmount}<sup>đ</sup></strong></td>
                                </tr>
                            </table>
                        </div>
                    </div>

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
    </body>
</html>
