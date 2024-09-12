<%@page import="java.sql.SQLException"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="Models.DatabaseConnection"%>
<%@page import="java.sql.Connection"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>

<!-- Main Sidebar Container -->
<aside class="main-sidebar sidebar-dark-primary elevation-4">
    <!-- Brand Logo -->
    <a href="${pageContext.request.contextPath}/index.jsp" class="brand-link">
        <img src="${pageContext.request.contextPath}/dist/img/AdminLTELogo.png" alt="AdminLTE Logo" class="brand-image elevation-3"
             style="opacity: .8">
        <span class="brand-text"><b>ABC</b> Suppliers</span>
    </a>

    <!-- Sidebar -->
    <%
        String dp_name = (String) session.getAttribute("DP_NAME");
        String role = (String) session.getAttribute("ROLE");
        String dp = (String) session.getAttribute("DP");
    %>
    <div class="sidebar">
        <!-- Sidebar user panel (optional) -->
        <div class="user-panel mt-3 pb-3 mb-3 d-flex">
            <div class="image">
                <img src="${pageContext.request.contextPath}/dist/img/dp/<%= dp%>" class="img-circle elevation-2" alt="User Image">
            </div>

            <div class="info">
                <a href="${pageContext.request.contextPath}/users/ProfileUpdate.jsp" class="d-block"><%= dp_name%></a>
            </div>
        </div>

        <!-- SidebarSearch Form -->
        <div class="form-inline">
            <div class="input-group" data-widget="sidebar-search">
                <input class="form-control form-control-sidebar" type="search" placeholder="Search" aria-label="Search">
                <div class="input-group-append">
                    <button class="btn btn-sidebar">
                        <i class="fas fa-search fa-fw"></i>
                    </button>
                </div>
            </div>
        </div>

        <!-- Sidebar Menu -->
        <nav class="mt-2">
            <ul class="nav nav-pills nav-sidebar flex-column" data-widget="treeview" role="menu" data-accordion="false">
                <!-- Add icons to the links using the .nav-icon class
                   with font-awesome or any other icon font library -->
                <li class="nav-item menu-open">
                    <a href="#" class="nav-link active">
                        <i class="nav-icon fas fa-users"></i>
                        <p>
                            Users
                            <i class="right fas fa-angle-left"></i>
                        </p>
                    </a>
                    <ul class="nav nav-treeview">
                        <%
                            if (role != null && role.equals("admin")) {
                        %>
                        <li class="nav-item">
                            <a href="${pageContext.request.contextPath}/users/users.jsp" class="nav-link">
                                <i class="fas fa-users-cog nav-icon"></i>
                                <p>Manage Users</p>
                            </a>
                        </li>

                        <li class="nav-item">
                            <a href="${pageContext.request.contextPath}/users/AddUser.jsp" class="nav-link">
                                <i class="fas fa-user-plus nav-icon"></i>
                                <p>Add User</p>
                            </a>
                        </li>
                        <%
                            }
                        %>
                        <li class="nav-item">
                            <a href="${pageContext.request.contextPath}/customers/customers.jsp" class="nav-link">
                                <i class="fas fa-user-injured nav-icon"></i>
                                <p>Customers</p>
                            </a>
                        </li>

                    </ul>
                </li>

                <li class="nav-item menu-open">
                    <a href="#" class="nav-link active">
                        <i class="nav-icon fas fa-parachute-box"></i>
                        <p>
                            Suppliers
                            <i class="right fas fa-angle-left"></i>
                        </p>
                    </a>
                    
                    <ul class="nav nav-treeview">
                        <li class="nav-item">
                            <a href="${pageContext.request.contextPath}/suppliers/suppliers.jsp" class="nav-link">
                                <i class="fas fa-eye nav-icon"></i>
                                <p>View Suppliers</p>
                                <span class="right badge badge-danger"></span>
                            </a>
                        </li>
                        <li class="nav-item">
                            <a href="${pageContext.request.contextPath}/suppliers/AddSupplier.jsp" class="nav-link">
                                <i class="fas fa-plus-square nav-icon"></i>
                                <p>Add Supplier</p>
                            </a>
                        </li>


                    </ul>
                </li>

                <li class="nav-item menu-open">
                    <a href="#" class="nav-link active">
                        <i class="nav-icon fas fa-th"></i>
                        <p>
                            Products
                            <i class="right fas fa-angle-left"></i>
                        </p>
                    </a>
                    <ul class="nav nav-treeview">
                        <li class="nav-item">
                            <a href="${pageContext.request.contextPath}/products/products.jsp" class="nav-link">
                                <i class="fas fa-eye nav-icon"></i>
                                <p>View Product</p>
                            </a>
                        </li>

                        <li class="nav-item">
                            <a href="${pageContext.request.contextPath}/products/AddProduct.jsp" class="nav-link">
                                <i class="fas fa-plus-square nav-icon"></i>
                                <p>Add Product</p>
                            </a>
                        </li>

                    </ul>
                </li>

                <li class="nav-item menu-open">
                    <a href="#" class="nav-link active">
                        <i class="nav-icon fas fa-shopping-bag"></i>
                        <p>
                            Orders
                            <i class="right fas fa-angle-left"></i>
                        </p>
                    </a>
                    
                    <ul class="nav nav-treeview">
                        <li class="nav-item">
                            <a href="${pageContext.request.contextPath}/customers/orders.jsp" class="nav-link">
                                <i class="fas fa-eye nav-icon"></i>
                                <p>View Orders</p>
                                <span class="right badge badge-danger"></span>
                            </a>
                        </li>

                    </ul>
                </li>

                <%
                    if (role != null && role.equals("admin")) {
                %>
                <li class="nav-item menu-open">
                    <a href="#" class="nav-link active">
                        <i class="nav-icon fas fa-clipboard-list"></i>
                        <p>
                            Audit Log
                            <i class="right fas fa-angle-left"></i>
                        </p>
                    </a>
                    <ul class="nav nav-treeview">
                        <li class="nav-item">
                            <a href="${pageContext.request.contextPath}/logs/UsersLog.jsp" class="nav-link">
                                <i class="fas fa-clipboard-list nav-icon"></i>
                                <p>Users Log</p>
                            </a>
                        </li>

                        <li class="nav-item">
                            <a href="${pageContext.request.contextPath}/logs/SuppliersLog.jsp" class="nav-link">
                                <i class="fas fa-clipboard-list nav-icon"></i>
                                <p>Suppliers Log</p>
                            </a>
                        </li>
                        <li class="nav-item">
                            <a href="${pageContext.request.contextPath}/logs/ProductsLog.jsp" class="nav-link">
                                <i class="fas fa-clipboard-list nav-icon"></i>
                                <p>Products Log</p>
                            </a>
                        </li>

                    </ul>
                </li>
                <%
                    }
                %>
            </ul>
        </nav>
        <!-- /.sidebar-menu -->
    </div>
    <!-- /.sidebar -->
</aside>