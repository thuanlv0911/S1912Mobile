<%-- 
    Document   : products
    Created on : Feb 23, 2025, 6:33:26 PM
    Author     : LE VAN THUAN
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link rel="stylesheet" href="https://unicons.iconscout.com/release/v4.0.8/css/line.css">
        <link rel="stylesheet" href="../../css/product.css">
        <script type="text/javascript">
            function doDelete(id) {
                if (confirm("Are you sure to delete this product with pid = " + id + " ???")) {
                    window.location = "${pageContext.request.contextPath}/admin/product/delete-prod?pid=" + id;
                }
            }
        </script>
        <title>Admin | Products</title>
    </head>
    <body>
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
                <h2>Products</h2>
                <a href="/s1912mobile/admin/product/add-prod" class="add-product-btn">Add new product</a>
            </div>
            <c:forEach items="${requestScope.cate}" var="c">
                <div class="category-section">
                    <div class="category-header">
                        <h2 class="category-title">${c.cateName}</h2> | <h2 class="category-title-id">Category ID: ${c.cateID}</h2>
                    </div>
                    <div class="product-list">
                        <c:set var="hasProducts" value="false"/>
                        <c:forEach items="${requestScope.prod}" var="p">
                            <c:if test="${p.category.cateID == c.cateID}">
                                <c:set var="hasProducts" value="true" />
                                <div class="product-item">
                                    <p class="product-id">Product ID: ${p.prodID}</p>
                                    <h3>${p.prodName}</h3>
                                    <img src="../../${p.image}" alt="${p.prodName}" class="product-image" width="120">
                                    <p>Quantity: ${p.quantity}</p>
                                    <p>Price: $${p.price}</p>
                                    <div class="product-actions">
                                        <a href="${pageContext.request.contextPath}/admin/product/update-prod?pid=${p.prodID}" class="update-btn">Update</a>
                                        <a href="#" onclick="doDelete('${p.prodID}')" class="delete-btn">Delete</a>
                                    </div>
                                </div>
                            </c:if>
                        </c:forEach>
                        <c:if test="${not hasProducts}">
                            <p class="no-products-message">There are currently no products in this category.</p>
                        </c:if>
                    </div>
                </div>
            </c:forEach>
        </div>                                  
    </body>
</html>
