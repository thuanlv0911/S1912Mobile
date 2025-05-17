<%-- 
    Document   : register
    Created on : Jan 31, 2025, 12:16:24 PM
    Author     : LE VAN THUAN
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link rel="stylesheet" href="https://unicons.iconscout.com/release/v4.0.8/css/line.css">
        <title>Register</title>
        <link rel="stylesheet" href="css/register.css"/>
    </head>
    <body>
        <div class="container">
            <div class="forms">
                <div class="form signup">
                    <span class="title">Registration</span>
                    <c:if test="${not empty requestScope.error}">
                        <h3 style="color: red">${requestScope.error}</h3>
                    </c:if>
                    <c:if test="${not empty requestScope.success}">
                        <h3 style="color: greenyellow">${requestScope.success}</h3>
                    </c:if>
                    <form action="register" method="post">
                        <div class="input-field">
                            <input type="text" name="username" placeholder="Enter username" required />
                            <i class="uil uil-user"></i>
                        </div>
                        <div class="input-field">
                            <input type="email" name="email" placeholder="Enter your email" required />
                            <i class="uil uil-envelope icon"></i>
                        </div>
                        <div class="input-field">
                            <input type="text" name="address" placeholder="Enter your address" required />
                            <i class="uil uil-map-marker"></i>
                        </div>
                        <div class="input-field">
                            <input type="number" name="phone" placeholder="Enter your phone number" required />
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
                            <a href="login.jsp" class="text login-link">Login Now</a>
                        </span>
                    </div>
                </div>
            </div>
        </div>
        <script>
            const pwShowHide = document.querySelectorAll(".showHidePw"),
                    pwFields = document.querySelectorAll(".password");

            // Hiển thị/ẩn mật khẩu và thay đổi icon
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
        </script>
    </body>
</html>
