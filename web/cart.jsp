<%-- 
    Document   : cart
    Created on : Mar 8, 2025, 4:50:56 PM
    Author     : LE VAN THUAN
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link rel="stylesheet" href="https://unicons.iconscout.com/release/v4.0.8/css/line.css">
        <link rel="stylesheet" href="css/cart.css">
        <title>Cart</title>
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
                                <li><a href="cart.jsp"><button><i class="uil uil-shopping-cart"></i></button></a></li>
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

        <section class="body-cart">
            <div class="container">
                <div class="hello">
                    Shopping Cart 🍎
                </div>
                <table class="cart-table">
                    <thead>
                        <tr>
<!--                            <th>Item ID</th>-->
                            <th>Image</th>
                            <th>Product Name</th>
                            <th>Price</th>
                            <th>Quantity</th>
                            <th>Amount</th>
                            <th>Delete</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:forEach var="item" items="${cartItems}">
                            <tr class="table-divider"><td colspan="7"></td></tr>
                            <tr>
<!--                                <td>${item.itemID}</td>-->
                                <td><img style="cursor: pointer" src="${item.product.image}" alt="${item.product.prodName}" width="92" onclick="redirectToDetail('${item.product.prodID}')"></td>
                                <td>${item.product.prodName}</td>
                                <td>${item.product.price - (item.product.price * 0.15)}<sup>đ</sup></td>
                                <td>
                                    <form  class="quantity-control" action="cart" method="post">
                                        <input type="hidden" name="action" value="update">
                                        <input type="hidden" name="itemID" value="${item.itemID}">
                                        <input type="number" name="quantity" value="${item.quantity}" min="1" max="${item.product.quantity}" onchange="this.form.submit()">
                                    </form>
                                </td>
                                <td class="amount">${(item.product.price - (item.product.price * 0.15)) * item.quantity}<sup>đ</sup></td>
                                <td>
                                    <form action="cart" method="post">
                                        <input type="hidden" name="action" value="delete">
                                        <input type="hidden" name="itemID" value="${item.itemID}">
                                        <button class="delete-btn" type="submit"><i class="uil uil-trash-alt"></i></button>
                                    </form>
                                </td>
                            </tr>
                        </c:forEach>
                    </tbody>
                </table>
                <div class="cart-buttons">
                    <button class="continue-shopping"><a href="home">Continue Shopping</a></button>
                </div>
                <div class="cart-divider">
                    <hr><i class="uil uil-shop"></i><hr>
                </div>
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
                    <c:choose>
                        <c:when test="${empty cartItems}">
                            <button class="checkout-btn" disabled style="background-color: #ccc; cursor: not-allowed;">Proceed to Checkout</button>
                        </c:when>
                        <c:otherwise>
                            <button class="checkout-btn"><a href="check-out">Proceed to Checkout</a></button>
                        </c:otherwise>
                    </c:choose>

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
            function updateQuantity(button, change) {
                let quantityInput = button.parentElement.querySelector('input');
                let currentQuantity = parseInt(quantityInput.value);
                let newQuantity = currentQuantity + change;
                if (newQuantity < 1)
                    newQuantity = 1;
                quantityInput.value = newQuantity;
                updateCartAmount(button, newQuantity);
            }

            function updateCartAmount(button, quantity) {
                let row = button.closest('tr');
                let price = parseFloat(row.cells[3].innerText.replace('$', ''));
                let amountCell = row.querySelector('.amount');
                let newAmount = price * quantity;
                amountCell.innerText = `$${newAmount}`;
                updateCartTotals();
            }

            function updateCartTotals() {
                let subtotal = 0;
                document.querySelectorAll('.amount').forEach(amountCell => {
                    subtotal += parseFloat(amountCell.innerText.replace('$', ''));
                });
                document.querySelector('.subtotal').innerText = `$${subtotal}`;
                let shipping = 10;
                document.querySelector('.total-amount').innerText = `$${subtotal + shipping}`;
            }
        </script>
        <script>
            function updateQuantity(itemID, change) {
                let input = document.querySelector(`input[name='quantity-${itemID}']`);
                let newQuantity = parseInt(input.value) + change;
                if (newQuantity < 1)
                    newQuantity = 1;
                input.value = newQuantity;

                // Gửi request cập nhật số lượng
                fetch('cart', {
                    method: 'POST',
                    headers: {'Content-Type': 'application/x-www-form-urlencoded'},
                    body: `action=update&itemID=${itemID}&quantity=${newQuantity}`
                }).then(() => location.reload());
            }
        </script>
        <script>
            function redirectToDetail(prodID) {
                window.location.href = "detail?prodID=" + prodID;
            }
        </script>
    </body>
</html>
