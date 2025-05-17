<%-- 
    Document   : product
    Created on : Jan 31, 2025, 10:21:02 PM
    Author     : LE VAN THUAN
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html lang="en">

    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <link rel="stylesheet" href="https://unicons.iconscout.com/release/v4.0.8/css/line.css">
        <link rel="stylesheet" href="css/products.css"/>
        <title>Products</title>

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
                                        <form action="search" class="navbar-search">
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

        <section class="menu-nav">
            <div class="container">
                <c:set var="cate" value="${requestScope.cate}"/>
                <c:set var="cID" value="${requestScope.cID}"/>

                <ul class="menu">
                    <li><a class="${cID==0?'active':''}" href="search?cID=${0}">All</a>
                        <c:forEach items="${cate}" var="c">
                        <li><a class="${c.cateID==cID?"active":""}" href="search?cID=${c.cateID}">${c.cateName}</a></li>
                        </c:forEach>
                    </li>
                </ul>
            </div>
        </section>

        <section class="product-one">
            <div class="container">
                <div class="product-one-content">
                    <div class="product-one-content-left">
                        <form id="sortForm" action="sidebar" method="get">
                            <div class="sort-container">
                                <h3>Sort by Price</h3>
                                <select name="sortByPrice" onchange="this.form.submit()">
                                    <option value="" <c:if test="${param.sortByPrice == null || param.sortByPrice == ''}">selected</c:if>>
                                            No Sorting
                                        </option>
                                        <option value="asc" <c:if test="${param.sortByPrice == 'asc'}">selected</c:if>>
                                            Price: Low to High
                                        </option>
                                        <option value="desc" <c:if test="${param.sortByPrice == 'desc'}">selected</c:if>>
                                            Price: High to Low
                                        </option>
                                    </select>
                                <c:forEach items="${paramValues.cateID}" var="cate">
                                    <input type="hidden" name="cateID" value="${cate}"/>
                                </c:forEach>
                                <c:forEach items="${paramValues.priceRange}" var="range">
                                    <input type="hidden" name="priceRange" value="${range}"/>
                                </c:forEach>
                        </form>
                    </div>
                    <form id="fl" action="sidebar" method="get">
                        <h3>Categories</h3>
                        <c:forEach items="${requestScope.cate}" var="c">
                            <c:set var="checked" value="false"/>
                            <c:forEach items="${paramValues.cateID}" var="selectedCate">
                                <c:if test="${selectedCate == c.cateID}">
                                    <c:set var="checked" value="true"/>
                                </c:if>
                            </c:forEach>
                            <input type="checkbox" name="cateID" value="${c.cateID}" ${checked ? 'checked' : ''} />
                            ${c.cateName} <br>
                        </c:forEach>

                        <h3>Prices</h3>
                        <c:set var="priceRanges" value="${paramValues.priceRange}"/>
                        <input type="checkbox" name="priceRange" value="0-1000" 
                               <c:forEach items="${priceRanges}" var="range">
                                   <c:if test="${range == '0-1000'}">checked</c:if>
                               </c:forEach> /> Under 1000.0 <br>
                        <input type="checkbox" name="priceRange" value="1000-2500" 
                               <c:forEach items="${priceRanges}" var="range">
                                   <c:if test="${range == '1000-2500'}">checked</c:if>
                               </c:forEach> /> From 1000.0 to 2500.0 <br>
                        <input type="checkbox" name="priceRange" value="2500-5000" 
                               <c:forEach items="${priceRanges}" var="range">
                                   <c:if test="${range == '2500-5000'}">checked</c:if>
                               </c:forEach> /> From 2500.0 to 5000.0 <br>
                        <input type="checkbox" name="priceRange" value="5000-10000" 
                               <c:forEach items="${priceRanges}" var="range">
                                   <c:if test="${range == '5000-10000'}">checked</c:if>
                               </c:forEach> /> From 5000.0 to 10000.0 <br>
                        <input type="checkbox" name="priceRange" value="10000-20000" 
                               <c:forEach items="${priceRanges}" var="range">
                                   <c:if test="${range == '10000-20000'}">checked</c:if>
                               </c:forEach> /> From 10000.0 to 20000.0 <br>
                        <input type="checkbox" name="priceRange" value="20000-9999999" 
                               <c:forEach items="${priceRanges}" var="range">
                                   <c:if test="${range == '20000-9999999'}">checked</c:if>
                               </c:forEach> /> Over 20000.0 <br>
                        <input type="submit" value="Search"/>
                    </form>
                </div>
                <div class="product-one-content-right">
                    <div class="product-one-content-right-items">
                        <c:if test="${not empty neww}">
                            <c:set var="neww" value="${requestScope.neww}"/>
                            <div class="product-one-content-right-title">
                                <h2>Number of featured products is ${neww.size()}</h2>
                            </div>
                            <c:forEach items="${neww}" var="p">
                                <c:set var="hasProducts" value="true"/>
                                <div class="product-one-content-item" onclick="redirectToDetail('${p.prodID}')">
                                    <c:choose>
                                        <c:when test="${p.quantity == 0}">
                                            <p style="
                                               position: absolute;
                                               background-color: rgba(255, 0, 0, 0.8);
                                               color: white;
                                               padding: 8px 12px;
                                               font-size: 18px;
                                               font-weight: bold;
                                               border-radius: 5px;
                                               z-index: 10;">
                                                Out of stock
                                            </p>
                                            <img src="${p.image}" alt="${p.prodName}" style="z-index: 1; opacity: 0.5; background-color: #ccc; cursor: not-allowed;">
                                        </c:when>
                                        <c:otherwise>
                                            <img src="${p.image}" alt="${p.prodName}">                                                
                                        </c:otherwise>
                                    </c:choose>
                                    <div class="product-one-content-item-text">
                                        <li>
                                            <img src="img/iconGift.png" alt="iconSale">
                                            <p>Discount off</p>
                                        </li>
                                        <li class="li2">${p.prodName}</li>
                                        <li><a href="">${p.price}<sup>đ</sup></a><span>-15%</span></li>
                                        <li>${p.price - (p.price * 0.15)}<sup>đ</sup></li>
                                        <li>Gift 300.0<sup>đ</sup></li>
                                        <li>
                                            <i class="uil uil-star"></i>
                                            <i class="uil uil-star"></i>
                                            <i class="uil uil-star"></i>
                                            <i class="uil uil-star"></i>
                                            <i class="uil uil-star"></i>
                                        </li>
                                    </div>
                                </div>
                            </c:forEach>
                        </c:if>

                        <c:set var="prod" value="${requestScope.prod}"/>
                        <c:if test="${prod!=null}">
                            <div class="product-one-content-right-title">
                                <h2>The number of phones is ${prod.size()}</h2>
                            </div>
                            <c:forEach items="${prod}" var="p">
                                <c:set var="hasProducts" value="true"/>
                                <div class="product-one-content-item" onclick="redirectToDetail('${p.prodID}')">
                                    <c:choose>
                                        <c:when test="${p.quantity == 0}">
                                            <p style="
                                               position: absolute;
                                               background-color: rgba(255, 0, 0, 0.8);
                                               color: white;
                                               padding: 8px 12px;
                                               font-size: 18px;
                                               font-weight: bold;
                                               border-radius: 5px;
                                               z-index: 10;">
                                                Out of stock
                                            </p>
                                            <img src="${p.image}" alt="${p.prodName}" style="z-index: 1; opacity: 0.5; background-color: #ccc; cursor: not-allowed;">
                                        </c:when>
                                        <c:otherwise>
                                            <img src="${p.image}" alt="${p.prodName}">                                                
                                        </c:otherwise>
                                    </c:choose>
                                    <div class="product-one-content-item-text">
                                        <li>
                                            <img src="img/iconGift.png" alt="iconSale">
                                            <p>Discount off</p>
                                        </li>
                                        <li class="li2">${p.prodName}</li>
                                        <li><a href="">${p.price}<sup>đ</sup></a><span>-15%</span></li>
                                        <li>${p.price - (p.price * 0.15)}<sup>đ</sup></li>
                                        <li>Gift 300.0<sup>đ</sup></li>
                                        <li>
                                            <i class="uil uil-star"></i>
                                            <i class="uil uil-star"></i>
                                            <i class="uil uil-star"></i>
                                            <i class="uil uil-star"></i>
                                            <i class="uil uil-star"></i>
                                        </li>
                                    </div>
                                </div>
                            </c:forEach>
                        </c:if>
                        <c:if test="${not hasProducts}">
                            <p class="no-products-message">There are currently no products.</p>
                        </c:if>
                        <c:if test="${not empty outOfStock}">
                            <div class="product-one-content-right-title" style="margin-top: 12px;">
                                <h2>Out of Stock Products</h2>
                            </div>
                            <c:forEach items="${outOfStock}" var="p">
                                <div class="product-one-content-item out-of-stock">
                                    <img src="${p.image}" alt="${p.prodName}" style="opacity: 0.5;">
                                    <div class="product-one-content-item-text">
                                        <li>
                                            <img src="img/iconGift.png" alt="iconSale">
                                            <p>Discount off</p>
                                        </li>
                                        <li class="li2">${p.prodName}</li>
                                        <li><a href="">${p.price}<sup>đ</sup></a><span>-15%</span></li>
                                        <li>${p.price - (p.price * 0.15)}<sup>đ</sup></li>
                                        <li>Gift 300.0<sup>đ</sup></li>
                                        <li>
                                            <i class="uil uil-star"></i>
                                            <i class="uil uil-star"></i>
                                            <i class="uil uil-star"></i>
                                            <i class="uil uil-star"></i>
                                            <i class="uil uil-star"></i>
                                        </li>
                                    </div>
                                </div>
                            </c:forEach>
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
        function redirectToDetail(prodID) {
            window.location.href = "detail?prodID=" + prodID;
        }
    </script>
</body>

</html>
