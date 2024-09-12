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
        response.sendRedirect("../login.jsp");
    }
%>
<!DOCTYPE html>
<html lang="en">

    <jsp:include page="/includes/IncludeHead.jsp">
        <jsp:param name="title" value="Supplier Update" />
    </jsp:include>

    <body class="hold-transition sidebar-mini layout-fixed">
        <div class="wrapper">


            <jsp:include page="/includes/IncludeNav.jsp" />

            <jsp:include page="/includes/IncludeSideBar.jsp" />

            <!-- Content Wrapper. Contains page content -->
            <div class="content-wrapper">
                <!-- Content Header (Page header) -->
                <jsp:include page="/includes/IncludeBreadCrumb.jsp">
                    <jsp:param name="path" value="Supplier Update" />
                </jsp:include>

                <!-- Main content -->
                <section class="content">
                    <div class="container-fluid">
                        <!-- Small boxes (Stat box) -->
                        <div class="row">
                            <!-- ./col -->
                            <div class="col-md-12">
                                <% String Reg_msg = (String) request.getAttribute("msg");
                                    String Reg_clz = (String) request.getAttribute("clz");
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
                                <!-- general form elements -->
                                <div class="card card-primary">
                                    <div class="card-header">
                                        <h3 class="card-title">Edit Supplier</h3>
                                    </div>
                                    <!-- /.card-header -->
                                    <!-- form start -->
                                    <form action="${pageContext.request.contextPath}/SupplierUpdateController" method="POST">
                                        <%
                                            try (Connection conn = DatabaseConnection.getConnection()) {

                                                String sup_id = request.getParameter("id");
                                                String checkSql = "SELECT * FROM suppliers WHERE supplierid = ?";
                                                PreparedStatement checkStmt = conn.prepareStatement(checkSql);

                                                checkStmt.setString(1, sup_id);

                                                ResultSet checkResult = checkStmt.executeQuery();

                                                while (checkResult.next()) {

                                        %>
                                        <div class="card-body">

                                            <div class="form-group">
                                                <input type="text" name="ID" value="<%= sup_id%>" hidden>
                                                <div class="row">
                                                    <div class="col-6">
                                                        <label for="exampleInputFirstName">Company</label>
                                                        <input type="text" class="form-control" name="company" value="<%= checkResult.getString("name")%>" placeholder="Company Name">
                                                    </div>
                                                    <div class="col-6">
                                                        <label for="exampleInputlastName">Contact Name</label>
                                                        <input type="text" class="form-control" name="ContactPerson" value="<%= checkResult.getString("contactperson")%>" placeholder="Contact Name">
                                                    </div>
                                                </div>
                                            </div>
                                            <div class="form-group">
                                                <label for="exampleInputUsername">Email</label>
                                                <input type="email" class="form-control" name="email" value="<%= checkResult.getString("email")%>" id="exampleInputUsername" placeholder="Enter Email">
                                            </div>
                                            <div class="form-group">
                                                <label for="exampleInputEmail1">Phone</label>
                                                <input type="text" class="form-control" name="phone" value="<%= checkResult.getString("phone")%>" id="exampleInputEmail1" placeholder="Enter Phone">
                                            </div>
                                            <div class="form-group">
                                                <label for="exampleInputUsername">Address</label>
                                                <input type="text" class="form-control" name="address" value="<%= checkResult.getString("address")%>" id="exampleInputUsername" placeholder="Enter Address">
                                            </div>
                                            <div class="form-group">
                                                <label for="exampleInputEmail1">City</label>
                                                <input type="text" class="form-control" name="city" value="<%= checkResult.getString("city")%>" id="exampleInputEmail1" placeholder="Enter City">
                                            </div>
                                            <div class="form-group">
                                                <label for="exampleInputEmail1">Code</label>
                                                <input type="text" class="form-control" name="code" value="<%= checkResult.getString("postalcode")%>" id="exampleInputEmail1" placeholder="Enter postal code">
                                            </div>
                                            <div class="form-group">
                                                <label for="exampleInputEmail1">Country</label>
                                                <input type="text" class="form-control" name="country" value="<%= checkResult.getString("country")%>" id="exampleInputEmail1" placeholder="Enter country">
                                            </div>


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
    </body>

</html>
