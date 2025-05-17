<%-- 
    Document   : home
    Created on : Jan 29, 2025, 1:03:04 PM
    Author     : LE VAN THUAN
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link rel="stylesheet" href="https://unicons.iconscout.com/release/v4.0.8/css/line.css">
        <link rel="stylesheet" href="css/home.css">
        <title>1912 Mobile</title>
    </head>
    <body>
        <header>
            <nav>
                <div class="container">
                    <ul class="navbar">
                        <li class="logo"><a href="#">1912 Mobile </a></li>
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
        <section class="slider">
            <div class="container">
                <div class="slider-content">
                    <div class="slider-content-top">
                        <img onclick="redirectToDetail('${"ss1"}')" style="cursor: pointer;" id="img1" src="img/sliderSSS24.png" alt="SamsungS24" class="active">
                        <img onclick="redirectToDetail('${"op1"}')" style="cursor: pointer;" id="img2" src="img/sliderOPPORENO13.jpg" alt="OppoReno13">
                        <img onclick="redirectToDetail('${"ss4"}')" style="cursor: pointer;" id="img3" src="img/sliderSSS25.png" alt="SamsungS25">
                        <img onclick="redirectToDetail('${""}')" style="cursor: pointer;" id="img4" src="img/sliderREDMINOTE14.png" alt="RedmiNote14">
                        <img onclick="redirectToDetail('${""}')" style="cursor: pointer;" id="img5" src="img/sliderIP16PM.png" alt="iPhone16ProMax">
                    </div>
                    <div class="slider-content-bottom">
                        <li class="active" data-img="img1">Samsung Galaxy S24 Ultra</li>
                        <li data-img="img2">Oppo Reno13 F</li>
                        <li data-img="img3">Samsung Galaxy S25 Ultra</li>
                        <li data-img="img4">Redmi Note 14</li>
                        <li data-img="img5">iPhone16 ProMax</li>
                    </div>
                </div>
            </div>
        </section>

        <section class="slider-product-one">
            <div class="container">
                <div class="slider-product-one-content">
                    <div class="slider-product-one-content-title">
                        <h2>New products</h2>
                    </div>
                    <div class="slider-product-one-content-container">
                        <div class="slider-product-one-content-items-container">
                            <div class="slider-product-one-content-items-container">
                                <c:set var="count" value="0"/>
                                <c:forEach items="${neww}" var="p">
                                    <c:if test="${count % 5 == 0}">
                                        <div class="slider-product-one-content-items">
                                        </c:if>
                                        <div class="slider-product-one-content-item" onclick="redirectToDetail('${p.prodID}')" >
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
                                            <div class="slider-product-one-content-item-text">
                                                <li>
                                                    <img src="img/iconSale.png" alt="iconSale">
                                                    <p>Sale online</p>
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
                                        <c:set var="count" value="${count + 1}"/>
                                        <c:if test="${count % 5 == 0 or count == neww.size()}">
                                        </div>
                                    </c:if>
                                </c:forEach>
                            </div>
                        </div>

                        <div class="slider-product-one-content-btn">
                            <i class="uil uil-angle-left-b"></i>
                            <i class="uil uil-angle-right-b"></i>
                        </div>
                    </div>
                </div>
            </div>
        </section>

        <section class="banner-one">
            <div class="container">
                <div class="banner-wrapper">
                    <img src="img/bannerIP16.jpg" alt="banner-iPhone16Series">
                    <img src="img/bannerSSS25.png" alt="banner-SamsungGalaxyS25Ultra">
                </div>
            </div>
        </section>

        <section class="product-one">
            <div class="container">
                <div class="product-one-content">
                    <div id="product-section" class="product-one-content-nav">
                        <c:set var="cate" value="${requestScope.cate}"/>
                        <form class="form-container" action="home">
                            <span>
                                <h2>Categories of Smartphone:</h2>
                            </span>
                            <select name="key2">
                                <option value="0" ${cateID == 0 ? 'selected' : ''}>All</option>
                                <c:forEach items="${cate}" var="c">
                                    <option value="${c.cateID}" ${cateID == c.cateID ? 'selected' : ''}>${c.cateName}</option>
                                </c:forEach>
                            </select>
                            <input type="submit" value="Search"/>
                        </form>
                        <form action="home" method="get">
                            <input type="hidden" name="bestSelling" value="true"/>
                            <input type="submit" value="Best Selling"/>
                        </form>
                    </div>
                    <div class="product-one-content-items">
                        <c:set var="prod" value="${requestScope.prod}"/>
                        <c:if test="${prod!=null}">
                            <c:set var="hasProducts" value="false"/>
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

                        <c:if test="${totalPages > 1 && empty key}">
                            <div class="pagination">
                                <c:if test="${currentPage > 1}">
                                    <a href="home?key2=${cateID}&page=${currentPage - 1}">Previous</a>
                                </c:if>
                                <c:forEach begin="1" end="${totalPages}" var="i">
                                    <a href="home?key2=${cateID}&page=${i}" class="${i == currentPage ? 'active' : ''}">${i}</a>
                                </c:forEach>

                                <c:if test="${currentPage < totalPages}">
                                    <a href="home?key2=${cateID}&page=${currentPage + 1}">Next</a>            
                                </c:if>
                            </div>
                        </c:if>
                        <c:if test="${not empty outOfStock}">
                            <div class="product-one-content-right-title" style="width: 100%; padding: 12px; margin-top: 12px;">
                                <h2>Out of Stock Products</h2>
                            </div>
                            <c:forEach items="${requestScope.outOfStock}" var="p">
                                <div class="product-one-content-item">
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

        <script src="js/script.js"></script>
        <script>
                                    document.addEventListener("DOMContentLoaded", function () {
                                        var key = "${key}";
                                        var key2 = "${cateID}";
                                        var urlParams = new URLSearchParams(window.location.search);
                                        var page = urlParams.get("page") || "0";
                                        var bestSelling = urlParams.get("bestSelling");

                                        if ((key && key.trim() !== "") || (key2 && key2 !== "0") || page !== "0" || bestSelling) {
                                            document.getElementById("product-section").scrollIntoView({behavior: "smooth"});
                                        }
                                    });
        </script>

        <script>
            function redirectToDetail(prodID) {
                window.location.href = "detail?prodID=" + prodID;
            }
        </script>

    </body>
</html>
