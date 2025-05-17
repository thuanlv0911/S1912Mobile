<%-- 
    Document   : forgot
    Created on : Mar 4, 2025, 11:44:24 PM
    Author     : LE VAN THUAN
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Forgot Password</title>
        <link rel="stylesheet" href="https://unicons.iconscout.com/release/v4.0.8/css/line.css">
        <link rel="stylesheet" href="css/forgot.css"/>
    </head>
    <!--    <body>
            <h2>Forgot Password</h2>
            <form action="forgot-pass" method="post">
                <label>Email:</label>
                <input type="email" name="email" required><br>
                <button type="submit">Reset Password</button>
            </form>
    <c:if test="${not empty message}">
        <p style="color: green;">${message}</p>
    </c:if>
    <c:if test="${not empty error}">
        <p style="color: red;">${error}</p>
    </c:if>
</body>-->
    <body>
        <div class="container">
            <div class="forms">
                <div class="form forgot-password">
                    <span class="title">Forgot Password</span>
                    <c:if test="${not empty error}">
                        <h3 style="color: red;">${error}</h3>
                    </c:if>

                    <c:if test="${not empty success}">
                        <h3 style="color: green;">${success}</h3>
                    </c:if>
                    <c:if test="${empty step}">
                        <form action="forgot-pass" method="post">
                            <div class="input-field">
                                <i class="uil uil-envelope icon"></i>
                                <input type="email" name="email" placeholder="Enter your email" required>
                            </div>
                            <div class="button">
                                <input type="submit" value="Send Code">
                            </div>
                        </form>
                    </c:if>

                    <c:if test="${step == 'verify'}">
                        <form action="forgot-pass" method="post">
                            <div class="input-field">
                                <i class="uil uil-list-ol-alt"></i>
                                <input type="text" name="code" placeholder="Enter verification code" required>
                            </div>
                            <div class="input-field">
                                <i class="uil uil-lock-open-alt"></i>
                                <input type="password" name="newPassword" placeholder="Enter new password" required>
                            </div>
                            <input type="hidden" name="email" value="${email}">
                            <div class="button">
                                <input type="submit" value="Reset Password">
                            </div>
                        </form>
                    </c:if>
                    <div class="login-signup">
                        <span class="text">Remember your password?
                            <a href="login" class="text login-link">Login Now</a>
                        </span>
                    </div>
                </div>
            </div>
        </div>
    </body>
</html>
