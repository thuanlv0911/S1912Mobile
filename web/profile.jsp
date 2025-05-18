<%-- 
    Document   : profile
    Created on : Mar 3, 2025, 4:59:19 PM
    Author     : LE VAN THUAN
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link rel="stylesheet" href="https://unicons.iconscout.com/release/v4.0.8/css/line.css">
        <link rel="stylesheet" href="css/profile.css">
        <title>Profile</title>
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
            <c:set var="a" value="${requestScope.a}"/>
            <div class="container">
                <div class="hello">
                    Hello ${requestScope.a.username} ❤️‍🔥
                </div>
                <div class="acc-content">
                    <div class="left">
                        <ul>
                            <li><i class="uil uil-sliders-v-alt"></i>Dashboard</li>
                            <li><i class="uil uil-shopping-bag"></i>Orders</li>
<!--                            <li><i class="uil uil-bill"></i>Orders Detail</li>-->
                            <li><i class="uil uil-user-check"></i>My account</li>
                            <li><i class="uil uil-map-marker"></i>My address</li>
                            <li><i class="uil uil-keyhole-circle"></i>Change password</li>
                            <li class="logout">
                                <form action="logout" method="post">
                                    <i class="uil uil-sign-out-alt"></i>
                                    <input type="submit" value="Logout">
                                </form>
                            </li>
                        </ul>
                    </div>
                    <div class="right">
                        <div id="settings" class="content active">
                            <h2>Dashboard</h2>
                            <p>From your account dashboard. you can easily check & view your recent order, manage your
                                shipping and billing addresses and edit your password and account details.</p>
                        </div>
                        <div id="orders" class="content">
                            <h2>Orders</h2>
                            <p>Your orders information.</p>
                            <c:choose>
                                <c:when test="${empty orders}">
                                    <p>You have no orders yet.</p>
                                </c:when>
                                <c:otherwise>
                                    <table>
                                        <thead>
                                            <tr>
                                                <th>Order ID</th>
                                                <th>Order date</th>
                                                <th>Total amount</th>
                                                <th>Status</th>
                                                <th>Receive</th>
                                                <th>Actions</th>
                                            </tr>
                                        </thead>
                                        <tbody>
                                            <c:forEach var="o" items="${requestScope.orders}">
                                                <tr>
                                                    <td>${o.orderID}</td>
                                                    <td>${o.create_At}</td>
                                                    <td>${o.totalAmount}<sup>đ</sup></td>
                                                    <td>${o.status}</td>
                                                    <td>
                                                        <c:choose>
                                                            <c:when test="${o.status == 'Completed'}">
                                                                <c:choose>
                                                                    <c:when test="${o.isReceived}">
                                                                        <span style="color: green;">Received</span>
                                                                    </c:when>
                                                                    <c:otherwise>
                                                                        <div class="order-actions">
                                                                            <form action="profile" method="post">
                                                                                <input type="hidden" name="orderID" value="${o.orderID}">
                                                                                <button type="submit" class="receive-btn">Received</button>
                                                                            </form>
                                                                            <form action="cancel" method="post">
                                                                                <input type="hidden" name="orderID" value="${o.orderID}">
                                                                                <input type="hidden" name="cancel" value="true">
                                                                                <button type="submit" class="cancel-btn">Cancel</button>
                                                                            </form>
                                                                        </div>
                                                                    </c:otherwise>
                                                                </c:choose>
                                                            </c:when>
                                                            <c:when test="${o.status == 'Canceled'}">
                                                                <span style="color: red;">Canceled</span>
                                                            </c:when>
                                                            <c:otherwise>
                                                                <span style="color: gray;">Waiting for completion</span>
                                                            </c:otherwise>
                                                        </c:choose>
                                                    </td>
                                                    <td><a class="view-order-btn" href="user-order?orderID=${o.orderID}">View</a></td>
                                                </tr>
                                            </c:forEach>
                                        </tbody>
                                    </table>
                                </c:otherwise>
                            </c:choose>
                        </div>

                        <div id="profile" class="content">
                            <h2>Profile</h2>
                            <p>Your personal information.</p>
                            <table>
                                <tr>
                                    <th>Account ID: </th>
                                    <td>${a.id}</td>
                                </tr>
                                <tr>
                                    <th>Name: </th>
                                    <td>${a.username}</td>
                                </tr>
                                <tr>
                                    <th>Email: </th>
                                    <td>${a.email}</td>
                                </tr>
                                <tr>
                                    <th>Phone number: </th>
                                    <td>${a.phoneNumber}</td>
                                </tr>
                                <tr>
                                    <th>Address: </th>
                                    <td>${a.address}</td>
                                </tr>
                            </table>
                        </div>

                        <div id="address" class="content">
                            <h2>Address</h2>
                            <p>Your shipping address.</p>

                            <form class="address-form" id="profileForm" action="profile" method="post">
                                <div class="form-group">
                                    <label for="email">Email: </label>
                                    <input type="text" id="email" name="email" value="${a.email}" readonly>
                                </div>
                                <div class="form-group">
                                    <label for="phone">Phone number: </label>
                                    <input type="number" id="phone" name="phone" value="${a.phoneNumber}" readonly>
                                </div>
                                <div class="form-group">
                                    <label for="address">Address: </label>
                                    <input type="text" id="address-input" name="address" value="${a.address}" readonly>
                                </div>
                                <c:if test="${not empty err}">
                                    <p style="color: red;">${err}</p>
                                    <c:remove var="err" scope="session"/> 
                                </c:if>
                                <c:if test="${not empty succ}">
                                    <p style="color: green;">${succ}</p>
                                    <c:remove var="succ" scope="session"/> 
                                </c:if>
                                <div class="button-group">
                                    <button type="button" id="updateBtn">Update</button>
                                    <button type="submit" id="saveBtn" class="hidden">Save</button>
                                    <button type="button" id="exitBtn" class="hidden">Exit</button>
                                </div>
                            </form>
                        </div>


                        <div id="security" class="content">
                            <h2>Change Password</h2>
                            <form action="change-pass" method="post">
                                <div class="form-group">
                                    <label>Current Password:</label>
                                    <input type="password" name="currentPassword" required><br>
                                </div>
                                <div class="form-group">
                                    <label>New Password:</label>
                                    <input type="password" name="newPassword" required><br>
                                </div>
                                <div class="form-group">
                                    <label>Confirm New Password:</label>
                                    <input type="password" name="confirmPassword" required><br>
                                </div>
                                <input type="submit" value="Change Password">
                            </form>
                            <c:if test="${not empty error}">
                                <p style="color: red;">${error}</p>
                                <c:remove var="error" scope="session"/> 
                            </c:if>
                            <c:if test="${not empty success}">
                                <p style="color: green;">${success}</p>
                                <c:remove var="success" scope="session"/> 
                            </c:if>
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

        <script>
            document.addEventListener("DOMContentLoaded", function () {
                const menuItems = document.querySelectorAll(".left ul li");
                const contents = document.querySelectorAll(".right .content");

                menuItems.forEach((item, index) => {
                    item.addEventListener("click", function () {
                        // Xóa class active khỏi tất cả
                        menuItems.forEach(el => el.classList.remove("active"));
                        contents.forEach(content => content.classList.remove("active"));

                        // Thêm class active vào mục được chọn
                        this.classList.add("active");
                        contents[index].classList.add("active");
                    });
                });
            });
            document.addEventListener("DOMContentLoaded", function () {
                document.querySelector(".logout").addEventListener("click", function () {
                    this.querySelector("form").submit();
                });
            });
        </script>

        <script>
            document.addEventListener("DOMContentLoaded", function () {
                const updateBtn = document.getElementById("updateBtn");
                const saveBtn = document.getElementById("saveBtn");
                const exitBtn = document.getElementById("exitBtn");
                const inputs = document.querySelectorAll("#profileForm input");

                // Khi nhấn "Update"
                updateBtn.addEventListener("click", function () {
                    inputs.forEach(input => {
                        input.removeAttribute("readonly"); // Bỏ readonly để chỉnh sửa
                        input.classList.add("editable"); // Thêm class để hiển thị viền
                    });
                    saveBtn.classList.remove("hidden");
                    exitBtn.classList.remove("hidden");
                    updateBtn.classList.add("hidden");
                });

                // Khi nhấn "Exit"
                exitBtn.addEventListener("click", function () {
                    inputs.forEach(input => {
                        input.setAttribute("readonly", true); // Không cho chỉnh sửa
                        input.classList.remove("editable"); // Ẩn viền input
                    });
                    saveBtn.classList.add("hidden");
                    exitBtn.classList.add("hidden");
                    updateBtn.classList.remove("hidden");
                });
            });
        </script>
        <script>
            document.addEventListener("DOMContentLoaded", function () {
                // Lấy tab hiện tại từ localStorage
                const activeTab = localStorage.getItem("activeTab");

                // Nếu có tab được lưu, đặt nó làm tab active
                if (activeTab) {
                    document.querySelectorAll(".content").forEach(tab => {
                        tab.classList.remove("active");
                    });
                    document.getElementById(activeTab).classList.add("active");
                }

                // Khi nhấn vào tab, lưu ID của tab vào localStorage
                document.querySelectorAll(".content").forEach(tab => {
                    tab.addEventListener("click", function () {
                        localStorage.setItem("activeTab", this.id);
                    });
                });
            });
        </script>

    </body>
</html>
