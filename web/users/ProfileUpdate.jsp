<%-- 
    Document   : index
    Created on : Mar 11, 2024, 9:55:40 PM
    Author     : iduni
--%>

<%@page import="java.sql.SQLException"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="Models.DatabaseConnection"%>
<%@page import="java.sql.Connection"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    session = request.getSession(false); // Do not create a new session if it doesn't exist

    if (session == null || session.getAttribute("ID") == null) {
        response.sendRedirect("login.jsp");
    }
    String dp_name = (String) session.getAttribute("DP_NAME");
    String role = (String) session.getAttribute("ROLE");
    String dp = (String) session.getAttribute("DP");
%>
<!DOCTYPE html>
<html lang="en">

    <jsp:include page="/includes/IncludeHead.jsp">
        <jsp:param name="title" value="Profile Update" />
    </jsp:include>

    <body class="hold-transition sidebar-mini layout-fixed">
        <div class="wrapper">


            <jsp:include page="/includes/IncludeNav.jsp" />

            <jsp:include page="/includes/IncludeSideBar.jsp" />

            <!-- Content Wrapper. Contains page content -->
            <div class="content-wrapper">
                <!-- Content Header (Page header) -->
                <jsp:include page="/includes/IncludeBreadCrumb.jsp">
                    <jsp:param name="path" value="Profile Update" />
                </jsp:include>

                <!-- Main content -->
                <section class="content">
                    <div class="container-fluid">
                        <!-- Small boxes (Stat box) -->
                        <div class="row">
                            <!-- ./col -->
                            <div class="col-md-12">
                                <% String Reg_msg = (String) request.getAttribute("Reg_msg");
                                    String Reg_clz = (String) request.getAttribute("Reg_clz");
                                    if (Reg_msg != null && Reg_clz != null) {
                                %>

                                <div class="alert <%= Reg_clz%> alert-dismissible fade show mt-4" role="alert">
                                    <strong><%= Reg_msg%></strong> 
                                    <button type="button" class="close" data-dismiss="alert" aria-hidden="true">×</button>
                                </div>

                                <%
                                    }
                                %>
                            </div>
                        </div>
                        <div class="row">
                            <!-- ./col -->
                            <div class="col-md-12">

                                <!-- Widget: user widget style 1 -->
                                <div class="card card-widget widget-user">
                                    <!-- Add the bg color to the header using any of the bg-* classes -->
                                    <div class="widget-user-header bg-info">
                                        <h3 class="widget-user-username"><%= dp_name %></h3>
                                        <h5 class="widget-user-desc"><%= role %></h5>
                                    </div>
                                    <div class="widget-user-image">
                                        <img class="img-circle elevation-2" src="${pageContext.request.contextPath}/dist/img/dp/<%= dp %>" alt="User Avatar">
                                    </div>
                                    <div class="card-footer">
                                        <div class="row">
                                            <div class="col-sm-4 border-right">
                                                <div class="description-block">
                                                    <h5 class="description-header">3,200</h5>
                                                    <span class="description-text">SALES</span>
                                                </div>
                                                <!-- /.description-block -->
                                            </div>
                                            <!-- /.col -->
                                            <div class="col-sm-4 border-right">
                                                <div class="description-block">
                                                    <h5 class="description-header">13,000</h5>
                                                    <span class="description-text">FOLLOWERS</span>
                                                </div>
                                                <!-- /.description-block -->
                                            </div>
                                            <!-- /.col -->
                                            <div class="col-sm-4">
                                                <div class="description-block">
                                                    <h5 class="description-header">35</h5>
                                                    <span class="description-text">PRODUCTS</span>
                                                </div>
                                                <!-- /.description-block -->
                                            </div>
                                            <!-- /.col -->
                                        </div>
                                        <!-- /.row -->
                                    </div>
                                </div>

                                <!-- general form elements -->
                                <div class="card card-primary">
                                    <div class="card-header">
                                        <h3 class="card-title">Edit Profile</h3>
                                    </div>
                                    <!-- /.card-header -->
                                    <!-- form start -->
                                    <form action="${pageContext.request.contextPath}/ProfileUpdateController" method="POST" id="passwordForm">
                                        <%
                                            try (Connection conn = DatabaseConnection.getConnection()) {

                                                int ID = (Integer) session.getAttribute("ID");
                                                String checkSql = "SELECT * FROM users WHERE id = ?";
                                                PreparedStatement checkStmt = conn.prepareStatement(checkSql);

                                                checkStmt.setInt(1, ID);

                                                ResultSet checkResult = checkStmt.executeQuery();

                                                while (checkResult.next()) {

                                        %>
                                        <div class="card-body">

                                            <div class="form-group">
                                                <input type="text" name="ID" value="<%= ID%>" hidden>
                                                <div class="row">
                                                    <div class="col-6">
                                                        <label for="exampleInputFirstName">First Name</label>
                                                        <input type="text" class="form-control" name="fname" value="<%= checkResult.getString("fname")%>" placeholder="First Name">
                                                    </div>
                                                    <div class="col-6">
                                                        <label for="exampleInputlastName">Last Name</label>
                                                        <input type="text" class="form-control" name="lname" value="<%= checkResult.getString("lname")%>" placeholder="Last Name">
                                                    </div>
                                                </div>
                                            </div>
                                            <div class="form-group">
                                                <label for="exampleInputUsername">Username</label>
                                                <input type="text" class="form-control" name="username" value="<%= checkResult.getString("username")%>" id="exampleInputUsername" placeholder="Enter Username">
                                            </div>
                                            <div class="form-group">
                                                <label for="exampleInputEmail1">Email address</label>
                                                <input type="email" class="form-control" name="email" value="<%= checkResult.getString("email")%>" id="exampleInputEmail1" placeholder="Enter email">
                                            </div>
                                            <div class="form-group">
                                                <label for="exampleInputPassword1">New Password</label>
                                                <input type="password" class="form-control" name="password"  id="password" placeholder="Password" required>
                                            </div>
                                            <!--                                            <div class="form-group">
                                                                                            <label>Role</label>
                                                                                            <select class="form-control" name="role">
                                                                                                <option value="admin">Admin</option>
                                                                                                <option value="employee">Employee</option>
                                                                                                <option selected name="user">User</option>                                       
                                                                                            </select>
                                                                                        </div>-->
                                            <div class="form-group">
                                                <label for="exampleInputFile">Profile Picture</label>
                                                <div class="input-group">
                                                    <div class="custom-file">

                                                        <input type="file" class="custom-file-input" name="dp" id="exampleInputFile">
                                                        <label class="custom-file-label" for="exampleInputFile">Choose file</label>
                                                    </div>

                                                </div>
                                            </div>
                                            <input type="text" name="dp_txt" value="<%= checkResult.getString("dp")%>" hidden>

                                        </div>
                                        <!-- /.card-body -->


                                        <div class="card-footer">
                                            <button type="submit" class="btn btn-primary">Update</button>
                                        </div>
                                        <%                                }
                                            } catch (SQLException ex) {
                                                out.println(ex);
                                            }
                                        %>
                                    </form>
                                </div>
                                <!-- /.card -->
                            </div>
                            <!-- /.row -->
                            <!-- Main row -->
                            <div class="row">

                                <!-- /.row (main row) -->
                            </div><!-- /.container-fluid -->
                        </div>
                </section>
                <!-- /.content -->
            </div>
            <!-- /.content-wrapper -->
            <footer class="main-footer">
                <strong>Copyright &copy; 2021-2024 <a href="https://razorisuru.com">RaZoR ISURU</a>.</strong>
                All rights reserved.
                <div class="float-right d-none d-sm-inline-block">

                </div>
            </footer>

            <!-- Control Sidebar -->
            <aside class="control-sidebar control-sidebar-dark">
                <!-- Control sidebar content goes here -->
            </aside>
            <!-- /.control-sidebar -->
        </div>
        <!-- ./wrapper -->

        <jsp:include page="/includes/IncludeFooter.jsp" />
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