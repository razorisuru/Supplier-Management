<%-- 
    Document   : register
    Created on : Apr 2, 2024, 11:15:45 PM
    Author     : iduni
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="utf-8">
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <title>Log in</title>
        <link href="${pageContext.request.contextPath}/dist/img/AdminLTELogo.png" rel="icon">
        <link href="${pageContext.request.contextPath}/dist/img/AdminLTELogo.png" rel="apple-touch-icon">

        <!-- Google Font: Source Sans Pro -->
        <link rel="stylesheet" href="https://fonts.googleapis.com/css?family=Source+Sans+Pro:300,400,400i,700&display=fallback">
        <!-- Font Awesome -->
        <link rel="stylesheet" href="${pageContext.request.contextPath}/plugins/fontawesome-free/css/all.min.css">
        <!-- icheck bootstrap -->
        <link rel="stylesheet" href="${pageContext.request.contextPath}/plugins/icheck-bootstrap/icheck-bootstrap.min.css">
        <!-- Theme style -->
        <link rel="stylesheet" href="${pageContext.request.contextPath}/dist/css/adminlte.min.css">
    </head>
    <body class="hold-transition login-page">
        <div class="login-box">
            <!-- /.login-logo -->
            <div class="card card-outline card-primary">
                <div class="card-header text-center">
                    <a href="#" class="h1"><b>ABC</b> Suppliers</a>
                </div>
                <div class="card-body">
                    <p class="login-box-msg">Register to start your session</p>

                    <form action="${pageContext.request.contextPath}/RegisterController" method="post" id="passwordForm">
                        <div class="input-group mb-3">
                            <input type="text" class="form-control" placeholder="First Name" name="fname" required>
                            <div class="input-group-append">
                                <div class="input-group-text">
                                    <span class="fas fa-user"></span>
                                </div>
                            </div>
                        </div>
                        <div class="input-group mb-3">
                            <input type="text" class="form-control" placeholder="Last Name" name="lname" required>
                            <div class="input-group-append">
                                <div class="input-group-text">
                                    <span class="fas fa-user"></span>
                                </div>
                            </div>
                        </div>
                        <div class="input-group mb-3">
                            <input type="text" class="form-control" placeholder="Username" name="username" required>
                            <div class="input-group-append">
                                <div class="input-group-text">
                                    <span class="fas fa-user"></span>
                                </div>
                            </div>
                        </div>
                        <div class="input-group mb-3">
                            <input type="email" class="form-control" placeholder="Email" name="email" required>
                            <div class="input-group-append">
                                <div class="input-group-text">
                                    <span class="fas fa-envelope"></span>
                                </div>
                            </div>
                        </div>
                        <div class="input-group mb-3">
                            <input type="password" class="form-control" placeholder="Password" name="password" id="password" required>
                            <div class="input-group-append">
                                <div class="input-group-text">
                                    <span class="fas fa-lock"></span>
                                </div>
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-8">
                                <div class="icheck-primary">
                                    <input type="checkbox" id="agreeTerms" name="agreeTerms" required>
                                    <label for="agreeTerms">
                                        I agree to the <a href="#">terms</a>
                                    </label>
                                </div>
                            </div>
                            <!-- /.col -->
                            <div class="col-4">
                                <button type="submit" class="btn btn-primary btn-block">Register</button>
                            </div>
                            <!-- /.col -->
                        </div>
                    </form>
                    <% String Login_msg = (String) request.getAttribute("Login_msg");
                        String Login_clz = (String) request.getAttribute("Login_clz");
                        if (Login_msg != null && Login_clz != null) {
                    %>

                    <div class="alert <%= Login_clz%> alert-dismissible fade show mt-4" role="alert">
                        <strong><%= Login_msg%></strong> 
                        <button type="button" class="close" data-dismiss="alert" aria-hidden="true">×</button>
                    </div>

                    <%
                        }
                    %>

                    <div class="social-auth-links text-center mt-2 mb-3">
                        <a href="#" class="btn btn-block btn-primary">
                            <i class="fab fa-facebook mr-2"></i> Sign in using Facebook
                        </a>
                        <a href="#" class="btn btn-block btn-danger">
                            <i class="fab fa-google-plus mr-2"></i> Sign in using Google+
                        </a>
                    </div>
                    <!-- /.social-auth-links -->

                    <p class="mb-0">
                        <a href="${pageContext.request.contextPath}/login.jsp" class="text-center">I already have a membership</a>
                    </p>
                </div>
                <!-- /.card-body -->
            </div>
            <!-- /.card -->
        </div>
        <!-- /.login-box -->

        <!-- jQuery -->
        <script src="${pageContext.request.contextPath}/plugins/jquery/jquery.min.js"></script>
        <!-- Bootstrap 4 -->
        <script src="${pageContext.request.contextPath}/plugins/bootstrap/js/bootstrap.bundle.min.js"></script>
        <!-- AdminLTE App -->
        <script src="${pageContext.request.contextPath}/dist/js/adminlte.min.js"></script>

        <script>
            document.getElementById("passwordForm").addEventListener("submit", function (event) {
                event.preventDefault(); // Prevent form submission

                var passwordInput = document.getElementById("password").value;

                if (validatePassword(passwordInput)) { 
                    this.submit();
                } else {
                    alert("Password must be 8 characters long, contain at least one special character and one uppercase letter.");
                }
            });

            function validatePassword(password) {
                // Regular expressions to check for requirements
                var lengthRegex = /.{8,}/;
                var specialCharRegex = /[!@#$%^&*(),.?":{}|<>]/;
                var uppercaseRegex = /[A-Z]/;

                // Check if all requirements are met
                return lengthRegex.test(password) && specialCharRegex.test(password) && uppercaseRegex.test(password);
            }
        </script>
    </body>
</html>