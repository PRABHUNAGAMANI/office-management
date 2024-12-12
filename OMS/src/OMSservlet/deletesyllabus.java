package OMSservlet;

import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/deletesyllabus")
public class deletesyllabus extends HttpServlet {
    private static final long serialVersionUID = 1L;

    public deletesyllabus() {
        super();
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String id = request.getParameter("id");  // Get the id from the URL parameter
        
        if (id != null && !id.isEmpty()) {
            Connection con = null;
            PreparedStatement ps = null;

            try {
                // Step 1: Load the MySQL driver and establish a connection
                Class.forName("com.mysql.cj.jdbc.Driver");
                con = DriverManager.getConnection("jdbc:mysql://localhost:3306/oms", "root", "PRAbhu@mysql");

                // Step 2: Create SQL DELETE statement
                String sql = "DELETE FROM syllabus_upload WHERE id = ?";
                ps = con.prepareStatement(sql);
                ps.setString(1, id);  // Set the id parameter for the query

                // Step 3: Execute the DELETE statement
                int rowsAffected = ps.executeUpdate();
                
                if (rowsAffected > 0) {
                    // If the deletion was successful, redirect to the syllabus report page
                    response.sendRedirect("viewsyllabus.jsp");  // Change this to the correct page you want to show after deletion
                } else {
                    // If no record was deleted, show a message
                    response.getWriter().println("Error: Record with ID " + id + " not found or could not be deleted.");
                }

            } catch (ClassNotFoundException e) {
                e.printStackTrace();
                response.getWriter().println("Database driver not found: " + e.getMessage());
            } catch (SQLException e) {
                e.printStackTrace();
                response.getWriter().println("SQL Error: " + e.getMessage());
            } finally {
                // Step 4: Close resources
                try {
                    if (ps != null) ps.close();
                    if (con != null) con.close();
                } catch (SQLException e) {
                    e.printStackTrace();
                }
            }
        } else {
            // If no id is provided, show an error message
            response.getWriter().println("Error: No ID provided.");
        }
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Handle POST requests by forwarding to the doGet method
        doGet(request, response);
    }
}
