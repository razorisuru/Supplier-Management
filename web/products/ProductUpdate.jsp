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
                                    <form action="${pageContext.request.contextPath}/ProductUpdateController" method="POST">
                                        <%
                                            try (Connection conn = DatabaseConnection.getConnection()) {

                                                String pro_id = request.getParameter("id");
//                                                encrypt the id

                                                String checkSql = "SELECT p.productid, s.name AS SupName, p.ProductName, p.description, p.price, p.quantity FROM products p JOIN suppliers s ON s.supplierid = p.supplierid WHERE productid = ?";
                                                PreparedStatement checkStmt = conn.prepareStatement(checkSql);

                                                checkStmt.setString(1, pro_id);

                                                ResultSet checkResult = checkStmt.executeQuery();

                                                while (checkResult.next()) {

                                        %>
                                        <div class="card-body">
                                            <input type="text" name="ID" value="<%= pro_id%>" hidden>
                                            <div class="form-group">
                                                <label for="inputStatus">Select Supplier Name</label>
                                                <select name="name" id="inputStatus" class="form-control custom-select" required>
                                                    <option value="<%= checkResult.getString("SupName")%>"><%= checkResult.getString("SupName")%></option>
                                                    <%
                                                        // Fetch all supplier names
                                                        try (PreparedStatement stmt = conn.prepareStatement("SELECT name FROM suppliers")) {
                                                            ResultSet rs = stmt.executeQuery();
                                                            while (rs.next()) {
                                                                String supplierName = rs.getString("name");
                                                    %>
                                                    <option value="<%= supplierName%>"><%= supplierName%></option>
                                                    <%
                                                            }
                                                        } catch (SQLException ex) {
                                                            out.println(ex);
                                                        }
                                                    %>
                                                </select>
                                            </div>
                                            <div class="form-group">
                                                <label for="inputDescription">Product Name</label>
                                                <input type="text" value="<%= checkResult.getString("ProductName")%>" name="ProductName" class="form-control" id="exampleInputEmail1" placeholder="Enter Product Name" required>
                                            </div>
                                            <div class="form-group">
                                                <label for="inputDescription">Product Description</label>
                                                <textarea id="inputDescription"  name="description" class="form-control" rows="4" style="height: 63px;" placeholder="Enter Product Description" required><%= checkResult.getString("description")%></textarea>
                                            </div>
                                            <div class="form-group">
                                                <label for="exampleInputEmail1">Price</label>
                                                <input type="text" value="<%= checkResult.getString("price")%>" name="price" class="form-control" id="exampleInputEmail1" placeholder="Enter Price" required>
                                            </div>
                                            <div class="form-group">
                                                <label for="exampleInputUsername">Quantity</label>
                                                <input type="text" value="<%= checkResult.getString("quantity")%>" name="quantity" class="form-control" id="exampleInputUsername" placeholder="Enter Quantity" required>
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
