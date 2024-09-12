/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package ProductControllers;

import SupplierController.*;
import Models.DatabaseConnection;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 *
 * @author iduni
 */
@WebServlet(name = "AddProductController", urlPatterns = {"/AddProductController"})
public class AddProductController extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        PrintWriter out = response.getWriter();
        response.setContentType("text/html;charset=UTF-8");

        String name = request.getParameter("name");
        String ProductName = request.getParameter("ProductName");
        String description = request.getParameter("description");
        String price = request.getParameter("price");
        String quantity = request.getParameter("quantity");
        String sup_id = request.getParameter("supplier_id");

        try (Connection conn = DatabaseConnection.getConnection()) {
            String sql = "INSERT INTO products(supplierid,ProductName,description,price,quantity) VALUES (?,?,?,?,?)";
            PreparedStatement stmt = conn.prepareStatement(sql);

            stmt.setString(1, sup_id);
            stmt.setString(2, ProductName);
            stmt.setString(3, description);
            stmt.setString(4, price);
            stmt.setString(5, quantity);

            int rowsInserted = stmt.executeUpdate();
            if (rowsInserted > 0) {
                request.setAttribute("msg", "Product Added Successfully");
                request.setAttribute("clz", "alert-success");
                request.getRequestDispatcher("/products/AddProduct.jsp").forward(request, response);

            } else {
                request.setAttribute("msg", "SQL ERROR");
                request.setAttribute("clz", "alert-danger");
                request.getRequestDispatcher("/products/AddProduct.jsp").forward(request, response);
            }
            DatabaseConnection.closeConnection(conn);

        } catch (SQLException e) {
            request.setAttribute("msg", "Err 2 - " + e);
            request.setAttribute("clz", "alert-danger");
            request.getRequestDispatcher("/products/AddProduct.jsp").forward(request, response);
        }
    }
}
