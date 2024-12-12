
<%--  <%@ page import="java.sql.*, javax.servlet.*" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    // Get the 'id' parameter from the URL
    String id = request.getParameter("id");

    if (id != null) {
        // Database connection setup
        Connection con = null;
        PreparedStatement ps = null;

        try {
            // Load JDBC driver
            Class.forName("com.mysql.cj.jdbc.Driver");

            // Establish a connection to the database
            con = DriverManager.getConnection("jdbc:mysql://localhost:3306/oms", "root", "PRAbhu@mysql");

            // SQL query to delete the record based on 'id'
            String sql = "DELETE FROM eFormInsert WHERE id = ?";
            ps = con.prepareStatement(sql);

            // Set the 'id' in the prepared statement
            ps.setString(1, id);

            // Execute the delete operation
            int rowsAffected = ps.executeUpdate();

            if (rowsAffected > 0) {
                // If deletion was successful, redirect to the main page with a success message
                out.println("<script>alert('Record deleted successfully!'); window.location.href='viewenquiryform.jsp';</script>");
            } else {
                // If no rows were affected, show an error message
                out.println("<script>alert('Record not found or deletion failed.'); window.location.href='viewenquiryform.jsp';</script>");
            }
        } catch (ClassNotFoundException | SQLException e) {
            e.printStackTrace();
            out.println("<script>alert('Error occurred during deletion.'); window.location.href='viewenquiryform.jsp';</script>");
        } finally {
            // Close resources
            try {
                if (ps != null) ps.close();
                if (con != null) con.close();
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
    } else {
        // If 'id' is null, show an error and redirect to the main page
        out.println("<script>alert('Invalid record ID.'); window.location.href='viewenquiryform.jsp';</script>");
    }
%>
 
  --%>
 
 
 
 <%@ page import="java.sql.*, javax.servlet.*" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    // Get the 'id' parameter from the URL
    String id = request.getParameter("id");

    if (id != null) {
        // Database connection setup
        Connection con = null;
        PreparedStatement ps = null;

        try {
            // Load JDBC driver
            Class.forName("com.mysql.cj.jdbc.Driver");

            // Establish a connection to the database
            con = DriverManager.getConnection("jdbc:mysql://localhost:3306/oms", "root", "PRAbhu@mysql");

            // Step 1: Delete dependent records from 'attempts' table
            String deleteAttemptsSql = "DELETE FROM attempts WHERE eform_id = ?";
            ps = con.prepareStatement(deleteAttemptsSql);
            ps.setString(1, id);
            ps.executeUpdate();

            // Step 2: Now delete the record from 'eFormInsert' table
            String deleteEformSql = "DELETE FROM eFormInsert WHERE id = ?";
            ps = con.prepareStatement(deleteEformSql);
            ps.setString(1, id);
            int rowsAffected = ps.executeUpdate();

            if (rowsAffected > 0) {
                // If deletion was successful, redirect to the main page with a success message
                out.println("<script>alert('Record deleted successfully!'); window.location.href='viewenquiryform.jsp';</script>");
            } else {
                // If no rows were affected, show an error message
                out.println("<script>alert('Record not found or deletion failed.'); window.location.href='viewenquiryform.jsp';</script>");
            }
        } catch (ClassNotFoundException | SQLException e) {
            e.printStackTrace();
            out.println("<script>alert('Error occurred during deletion.'); window.location.href='viewenquiryform.jsp';</script>");
        } finally {
            // Close resources
            try {
                if (ps != null) ps.close();
                if (con != null) con.close();
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
    } else {
        // If 'id' is null, show an error and redirect to the main page
        out.println("<script>alert('Invalid record ID.'); window.location.href='viewenquiryform.jsp';</script>");
    }
%>
 
 
 
 
 
 
 
 