<%-- 
    Document   : detail
    Created on : Mar 5, 2025, 4:21:22 PM
    Author     : LE VAN THUAN
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link rel="stylesheet" href="https://unicons.iconscout.com/release/v4.0.8/css/line.css">
        <link rel="stylesheet" href="css/detail.css">
        <title>Detail product</title>
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

        <section class="body-detail">
            <div class="product-name">
                <i class="uil uil-pricetag-alt"></i>
                Buy old products at high prices, upgrade to new products at super cheap prices
            </div>
            <div class="container">
                <c:set var="p" value="${requestScope.p}"/>
                <div class="detail-items">
                    <div class="detail-items-left">
                        <img src="${p.image}" alt="${p.prodName}" width="100%">  
                    </div>
                    <div class="detail-items-right">
                        <h1>${p.prodName}</h1>
                        <p class="category">Category: ${p.category.cateName}</p>
                        <div class="divider"></div> 

                        <div class="price">
                            <span class="discount-price">${p.price - (p.price * 0.15)}<sup>đ</sup></span>
                            <span class="original-price"><a href="">${p.price}<sup>đ</sup></a></span>
                            <span class="discount-percent">15% OFF</span>
                        </div>
                        <div class="divider"></div>

                        <ul class="warranty">
                            <li><i class="uil uil-check-circle"></i> 1-Year Official Warranty</li>
                            <li><i class="uil uil-check-circle"></i> Free Returns Within 30 Days</li>
                            <li><i class="uil uil-check-circle"></i> Cash on Delivery Available</li>
                        </ul>
                        <div class="divider"></div> 

                        <form action="cart" method="post">
                            <input type="hidden" name="action" value="add">
                            <input type="hidden" name="prodID" value="${p.prodID}">

                            <div class="quantity">
                                <label for="quantity">Quantity:</label>
                                <input type="number" name="quantity" min="0" max="${p.quantity}" value="1">
                                <p style="margin: 8px; color: crimson;">${p.quantity} Items in Stock</p>
                            </div>

                            <c:choose>
                                <c:when test="${p.quantity == 0}">
                                    <button type="submit" class="add-to-cart" disabled style="background-color: #ccc; cursor: not-allowed;">Add to Cart</button>
                                </c:when>
                                <c:otherwise>
                                    <button type="submit" class="add-to-cart">Add to Cart</button>
                                </c:otherwise>
                            </c:choose>
                        </form>

                        <div class="divider"></div> 

                        <div class="product-description">
                            <h2>Description</h2>
                            <p>${p.describe}</p>
                        </div>
                        <div class="divider"></div>
                        <div class="product-info">
                            <p><strong>Tags:</strong> Smartphone, ${p.category.cateName}, 4G, 5G</p>
                            <p><strong>Availability:</strong> ${p.quantity} Items in Stock</p>
                            <p><strong>Created At:</strong> ${p.create_At}</p>
                        </div>
                    </div>

                </div>

                <div class="product-info-container">
                    <div class="product-commitment">
                        <h2>Our Commitment</h2>
                        <p><i class="uil uil-award-alt"></i> Guaranteed quality</p>
                        <p><i class="uil uil-truck"></i> Fast shipping</p>
                        <p><i class="uil uil-headphones"></i> Dedicated customer support</p>
                        <p><i class="uil uil-refresh"></i> Hassle-free returns</p>
                        <p><i class="uil uil-lock"></i> Secure payments</p>
                    </div>

                    <div class="product-created-at">
                        <p><strong>Created At:</strong> ${p.create_At}</p>
                    </div>
                </div>

                <div class="customer-reviews">
                    <h2>User Reviews</h2>
                    <div class="review-summary">
                        <p class="average-rating"><i class="uil uil-star"></i> 4.8 out of 5</p>
                        <p class="total-reviews">Based on <strong>125 reviews</strong></p>
                    </div>

                    <div class="divider"></div>

                    <div class="reviews-list">
                        <div class="review">
                            <p class="review-author"><strong>John Doe</strong> <span class="review-date">| Feb 15, 2025</span></p>
                            <p class="review-rating">
                                <i class="uil uil-star"></i> <i class="uil uil-star"></i> <i class="uil uil-star"></i> <i class="uil uil-star"></i> <i class="uil uil-star-half-alt"></i>
                            </p>
                            <p class="review-text">Absolutely love this product! The quality is top-notch, and the shipping was super fast. Highly recommend!</p>
                        </div>

                        <div class="divider"></div>

                        <div class="review">
                            <p class="review-author"><strong>Emily Smith</strong> <span class="review-date">| Jan 28, 2025</span></p>
                            <p class="review-rating">
                                <i class="uil uil-star"></i> <i class="uil uil-star"></i> <i class="uil uil-star"></i> <i class="uil uil-star"></i> <i class="uil uil-star"></i>
                            </p>
                            <p class="review-text">Exceeded my expectations! The customer support was very responsive when I had a question. Would buy again.</p>
                        </div>
                    </div>

                    <div class="divider"></div>

                    <div class="leave-review">
                        <h3>Leave a Review</h3>
                        <p>We value your feedback! Share your thoughts on this product.</p>
                        <button class="review-btn">Write a Review</button>
                    </div>
                </div>

                <div class="related-products">
                    <h2 style="font-weight: bolder;">Related products</h2>
                    <div class="product-one-content">
                        <div class="product-one-content-items">
                            <c:forEach items="${requestScope.relatedProducts}" var="p">
                                <div class="product-one-content-item"  onclick="redirectToDetail('${p.prodID}')">
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
