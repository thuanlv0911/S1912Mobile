<%-- 
    Document   : login
    Created on : Jan 28, 2025, 5:23:01 PM
    Author     : LE VAN THUAN
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Login</title>
        <link rel="stylesheet" href="https://unicons.iconscout.com/release/v4.0.8/css/line.css">
        <link rel="stylesheet" href="css/login.css"/>
    </head>
    <body>
        <div class="container">
            <div class="forms">
                <div class="form login">
                    <span class="title">Login</span>
                    <h3 style="color: red">${requestScope.err}</h3>
                    <form action="login" method="post">
                        <c:set var="cookie" value="${pageContext.request.cookies}"/>
                        <div class="input-field">
                            <input type="text" value="${cookie.CookieU.value}" placeholder="Enter username" name="user" required />
                            <i class="uil uil-user"></i>
                        </div>
                        <div class="input-field">
                            <input type="password" value="${cookie.CookieP.value}" class="password" placeholder="Enter password" name="pass" required />
                            <i class="uil uil-lock icon"></i>
                            <i class="uil uil-eye-slash showHidePw"></i>
                        </div>

                        <div class="checkbox-text">
                            <div class="checkbox-content">
                                <input type="checkbox" ${cookie.CookieR!=null?'checked':''} name="re" id="logCheck" value="on"/>
                                <label for="logCheck" class="text">Remember me</label>
                            </div>
                            <a href="forgot-pass" class="text">Forgot password?</a>
                        </div>

                        <div class="input-field button">
                            <input type="submit" value="Login" />
                        </div>
                    </form>

                    <div class="login-signup">
                        <span class="text">Don't have an account?
                            <a href="register" class="text signup-link">Register</a>
                        </span>
                    </div>
                </div>

                <!-- Registration Form -->
<!--                <div class="form signup">
                    <span class="title">Registration</span>
                    <h3 style="color: red">${requestScope.error}</h3>
                    <h3 style="color: green">${requestScope.success}</h3>
                    <form action="register" method="post">
                        <div class="input-field">
                            <input type="text" name="username" placeholder="Enter username" required />
                            <i class="uil uil-user"></i>
                        </div>
                        <div class="input-field">
                            <input type="text" name="email" placeholder="Enter your email" required />
                            <i class="uil uil-envelope icon"></i>
                        </div>
                        <div class="input-field">
                            <input type="text" name="address" placeholder="Enter your address" required />
                            <i class="uil uil-map-marker"></i>
                        </div>
                        <div class="input-field">
                            <input type="number" name="phone" class="password" placeholder="Enter your phone number" required />
                            <i class="uil uil-phone"></i>
                        </div>
                        <div class="input-field">
                            <input type="password" name="password" class="password" placeholder="Create a password" required />
                            <i class="uil uil-lock icon"></i>
                            <i class="uil uil-eye-slash showHidePw"></i>
                        </div>

                        <div class="input-field button">
                            <input type="submit" value="Signup" />
                        </div>
                    </form>

                    <div class="login-signup">
                        <span class="text">Already an account?
                            <a href="#" class="text login-link">Login Now</a>
                        </span>
                    </div>
                </div>-->
            </div>
        </div>

        <script>
            const container = document.querySelector(".container"),
                    pwShowHide = document.querySelectorAll(".showHidePw"),
                    pwFields = document.querySelectorAll(".password");
//                    signUp = document.querySelector(".signup-link"),
//                    login = document.querySelector(".login-link");

            // js code to show/hide password and change icon
            pwShowHide.forEach((eyeIcon) => {
                eyeIcon.addEventListener("click", () => {
                    pwFields.forEach((pwField) => {
                        if (pwField.type === "password") {
                            pwField.type = "text";

                            pwShowHide.forEach((icon) => {
                                icon.classList.replace("uil-eye-slash", "uil-eye");
                            });
                        } else {
                            pwField.type = "password";

                            pwShowHide.forEach((icon) => {
                                icon.classList.replace("uil-eye", "uil-eye-slash");
                            });
                        }
                    });
                });
            });

            // js code to appear signup and login form
//            signUp.addEventListener("click", (e) => {
//                e.preventDefault();
//                container.classList.add("active");
//            });
//
//            login.addEventListener("click", (e) => {
//                e.preventDefault();
//                container.classList.remove("active");
//            });

        </script>
    </body>
</html>
