<%-- 
    Document   : categories
    Created on : Feb 23, 2025, 4:46:54 PM
    Author     : LE VAN THUAN
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link rel="stylesheet" href="https://unicons.iconscout.com/release/v4.0.8/css/line.css">
        <link rel="stylesheet" href="../../css/category.css">
        <title>Admin | Categories</title>
        <script type="text/javascript">
            function doDelete(id) {
                if (confirm("Are you sure to delete this category with cid = " + id + " ???")) {
                    window.location = "${pageContext.request.contextPath}/admin/category/delete-cate?cid=" + id;
                }
            }
        </script>
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
                <h2>Categories</h2>
                <a href="/s1912mobile/admin/category/add-cate" class="add-category-btn">Add new category</a>
            </div>
            <div class="category-list">
                <c:forEach items="${requestScope.cate}" var="c">
                    <c:set var="cid" value="${c.cateID}"/>
                    <div class="category-item">
                        <p class="category-id">Category ID: ${cid}</p>
                        <h3>${c.cateName}</h3>
                        <div class="category-actions">
                            <a href="${pageContext.request.contextPath}/admin/category/update-cate?cid=${cid}" class="update-btn">Update</a>
                            <a href="#" onclick="doDelete('${cid}')" class="delete-btn">Delete</a>
                        </div>
                    </div>
                </c:forEach>
            </div>
        </div>
    </body>
</html>