<%-- 
    Document   : admin.jsp
    Created on : Jan 29, 2025, 3:05:54 PM
    Author     : LE VAN THUAN
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link rel="stylesheet" href="https://unicons.iconscout.com/release/v4.0.8/css/line.css">
        <link rel="stylesheet" href="../../css/admin.css">
        <script type="text/javascript">
            function doDelete(id) {
                if (confirm("Are you sure to delete this user with id = " + id + " ???")) {
                    window.location = "${pageContext.request.contextPath}/admin/accounts/delete-acc?id=" + id;
                }
            }
        </script>
        <title>Admin | Accounts</title>
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
        <div class="admin-container">
            <div class="admin-header">
                <h2>Accounts</h2>
            </div>

            <div class="admin-list">
                <table class="admin-table">
                    <thead>
                        <tr>
                            <th>Account ID</th>
                            <th>Username</th>
                            <th>Email</th>
                            <th>Role ID</th>
                            <th>Actions</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:forEach items="${requestScope.listAcc}" var="a">
                            <tr>
                                <td>${a.id}</td>
                                <td>${a.username}</td>
                                <td>${a.email}</td>
                                <td>${a.roleID}</td>
                                <td>
                                    <button class="view-btn" onclick="showDetails('${a.id}', '${a.username}', '${a.email}', '${a.address}', '${a.phoneNumber}', '${a.roleID}')">View</button>
                                    <c:choose>
                                        <c:when test="${a.roleID == 1}">
                                            <a href="#" onclick="return false;" class="delete-btn" disabled style="background-color: #ccc; cursor: not-allowed;">Delete</a>                                </c:when>
                                        <c:otherwise>
                                            <a href="#" onclick="doDelete('${a.id}')" class="delete-btn">Delete</a>
                                        </c:otherwise>
                                    </c:choose>
                                </td>
                            </tr>
                        </c:forEach>
                    </tbody>
                </table>
            </div>
        </div>
        <div id="accountModal" class="modal">
            <div class="modal-content">
                <span class="close-btn" onclick="closeModal()">&times;</span>
                <h2>Account Details</h2>
                <p><strong>ID:</strong> <span id="modal-id"></span></p>
                <p><strong>Username:</strong> <span id="modal-username"></span></p>
                <p><strong>Email:</strong> <span id="modal-email"></span></p>
                <p><strong>Address:</strong> <span id="modal-address"></span></p>
                <p><strong>Phone:</strong> <span id="modal-phone"></span></p>
                <p><strong>Role ID:</strong> <span id="modal-role"></span></p>
            </div>
        </div>

    </body>


    <script>
        function showDetails(id, username, email, address, phone, roleID) {
            document.getElementById("modal-id").textContent = id;
            document.getElementById("modal-username").textContent = username;
            document.getElementById("modal-email").textContent = email;
            document.getElementById("modal-address").textContent = address;
            document.getElementById("modal-phone").textContent = phone;
            document.getElementById("modal-role").textContent = roleID;

            document.getElementById("accountModal").style.display = "flex";
        }

        function closeModal() {
            document.getElementById("accountModal").style.display = "none";
        }

// Đóng modal khi nhấn ra ngoài
        window.onclick = function (event) {
            let modal = document.getElementById("accountModal");
            if (event.target === modal) {
                closeModal();
            }
        };
        document.addEventListener("DOMContentLoaded", function () {
            document.getElementById("accountModal").style.display = "none";
        });

    </script>
</html>
