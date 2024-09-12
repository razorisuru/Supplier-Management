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
@WebServlet(name = "ProductUpdateController", urlPatterns = {"/ProductUpdateController"})
public class ProductUpdateController extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        PrintWriter out = response.getWriter();
        response.setContentType("text/html;charset=UTF-8");

        int ID = Integer.parseInt(request.getParameter("ID"));
        String name = request.getParameter("name");
        String ProductName = request.getParameter("ProductName");
        String description = request.getParameter("description");
        String price = request.getParameter("price");
        String quantity = request.getParameter("quantity");
        String sup_id = "";
        
        try (Connection conn = DatabaseConnection.getConnection()) {

            String checkSql = "SELECT supplierid FROM suppliers WHERE name=?";
            PreparedStatement checkStmt = conn.prepareStatement(checkSql);
            checkStmt.setString(1, name);

            ResultSet checkResult = checkStmt.executeQuery();

            while (checkResult.next()) {
                sup_id = checkResult.getString("supplierid");
            }
        } catch (SQLException ex) {
            request.setAttribute("Reg_msg", "Check ID" + ex);
            request.setAttribute("Reg_clz", "alert-danger");
            request.getRequestDispatcher("/products/AddProduct.jsp").forward(request, response);
        }

        try (Connection conn = DatabaseConnection.getConnection()) {
            String sql = "UPDATE products SET supplierid= ?, ProductName= ?, description= ?, price= ?, quantity= ? WHERE productid = ?";
            PreparedStatement stmt = conn.prepareStatement(sql);

            stmt.setString(1, sup_id);
            stmt.setString(2, ProductName);
            stmt.setString(3, description);
            stmt.setString(4, price);
//            stmt.setString(5, password);
            stmt.setString(5, quantity);
            stmt.setInt(6, ID);

            int rowsInserted = stmt.executeUpdate();
            if (rowsInserted > 0) {
//                out.println("SUCCESS");
//                out.println("{ \"status\": \"ERROR\", \"message\": \"SIGNUP SUCCESSFULL. Now You Can login\" }");
                request.setAttribute("msg", "Update Successfully.");
                request.setAttribute("clz", "alert-success");
                request.getRequestDispatcher("/products/ProductUpdate.jsp?id="+ID).forward(request, response);

            } else {
                request.setAttribute("msg", "SQL ERROR");
                request.setAttribute("clz", "alert-danger");
                request.getRequestDispatcher("/products/ProductUpdate.jsp?id="+ID).forward(request, response);
            }
            DatabaseConnection.closeConnection(conn);

        } catch (SQLException e) {
            request.setAttribute("msg", "" + e);
            request.setAttribute("clz", "alert-danger");
            request.getRequestDispatcher("/products/ProductUpdate.jsp").forward(request, response);
        }
    }
}
