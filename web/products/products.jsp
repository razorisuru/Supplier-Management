<%-- 
    Document   : index
    Created on : Mar 11, 2024, 9:55:40 PM
    Author     : iduni
--%>

<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="Models.DatabaseConnection"%>
<%@page import="Models.DatabaseConnection"%>
<%@page import="java.sql.Connection"%>
<%@page import="java.sql.Connection"%>
<%@page import="java.sql.SQLException"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    session = request.getSession(false);
    String role = (String) session.getAttribute("ROLE");// Do not create a new session if it doesn't exist

    if (session == null || session.getAttribute("ID") == null) {
        response.sendRedirect("../login.jsp");
    }
%>
<!DOCTYPE html>
<html lang="en">

    <jsp:include page="/includes/IncludeHead.jsp">
        <jsp:param name="title" value="Products" />
    </jsp:include>

    <body class="hold-transition sidebar-mini layout-fixed">
        <div class="wrapper">



            <jsp:include page="/includes/IncludeNav.jsp" />

            <jsp:include page="/includes/IncludeSideBar.jsp" />

            <!-- Content Wrapper. Contains page content -->
            <div class="content-wrapper">
                <jsp:include page="/includes/IncludeBreadCrumb.jsp">
                    <jsp:param name="path" value="Products" />
                    <jsp:param name="name" value="All Products" />
                </jsp:include>
                <!-- /.content-header -->

                <!-- Main content -->
                <section class="content">
                    <div class="container-fluid">
                        <!-- Small boxes (Stat box) -->
                        <div class="row">
                            <!-- ./col -->
                            <div class="col-md-12">
                                <% String msg = (String) request.getAttribute("msg");
                                    String clz = (String) request.getAttribute("clz");
                                    if (msg != null && clz != null) {
                                %>

                                <div class="alert <%= clz%> alert-dismissible fade show mt-4" role="alert">
                                    <strong><%= msg%></strong> 
                                    <button type="button" class="close" data-dismiss="alert" aria-hidden="true">×</button>
                                </div>
                                <%
                                    }
                                %>
                            </div>
                            <div class="col-md-12">
                                <div class="card">

                                    <table class="table table-hover table-head-fixed text-nowrap" id="dataTable">
                                        <thead>
                                            <tr>
                                                <th>ID</th>
                                                <th>Supplier</th>
                                                <th>Product Name</th>
                                                <th>Description</th>
                                                <th>Price</th>
                                                <th>Quantity</th>                                                 
                                                <th>Option</th>
                                            </tr>
                                        </thead>
                                        <tbody>
                                            <%
                                                try (Connection conn = DatabaseConnection.getConnection()) {

                                                    String checkSql = "SELECT p.productid, s.name AS SupName,s.supplierid AS Sid, p.ProductName, p.description, p.price, p.quantity FROM products p JOIN suppliers s ON s.supplierid = p.supplierid;";
                                                    PreparedStatement checkStmt = conn.prepareStatement(checkSql);

                                                    ResultSet checkResult = checkStmt.executeQuery();

                                                    while (checkResult.next()) {
                                                        String pro_id = checkResult.getString("productid");
                                                        String Sid = checkResult.getString("Sid");
                                            %>
                                            <tr>
                                                <td><%= checkResult.getString("productid")%></td>
                                                <td><a class=""  href="${pageContext.request.contextPath}/suppliers/ViewSupplier.jsp?id=<%= Sid%>"><%= checkResult.getString("SupName")%></a></td>
                                                <td><a class=""  href="${pageContext.request.contextPath}/products/ViewProduct.jsp?id=<%= pro_id%>"><%= checkResult.getString("ProductName")%></a></td>
                                                <td><%= checkResult.getString("description")%></td>
                                                <td><%= checkResult.getString("price")%></td>
                                                <td><%= checkResult.getString("quantity")%></td>
                                                <td><a class="btn btn-sm btn-success"  href="${pageContext.request.contextPath}/products/ProductUpdate.jsp?id=<%= pro_id%>">Edit</a>
                                                    <%
                                                        if (role != null && role.equals("admin")) {
                                                    %>
                                                    <a class="btn btn-sm btn-danger" href="${pageContext.request.contextPath}/ProductDeleteController?id=<%=pro_id%>" onclick="return confirm('Are you sure you want to delete?')">Delete</a>
                                                    <%
                                                        }
                                                    %>
                                                </td> 
                                            </tr>

                                            <%
                                                    }
                                                } catch (SQLException ex) {
                                                    System.out.println(ex);
                                                }
                                            %>
                                        </tbody>
                                        <tfoot>
                                            <tr>
                                                <th>ID</th>
                                                <th>Supplier</th>
                                                <th>Product Name</th>
                                                <th>Description</th>
                                                <th>Price</th>
                                                <th>Quantity</th>                                                 
                                                <th>Option</th>
                                            </tr>
                                        </tfoot>
                                    </table>

                                </div>
                            </div>
                        </div>
                        <div class="row">
                            <!-- ./col -->

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
