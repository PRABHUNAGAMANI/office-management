<%@ page import="java.sql.*" %>
<%
    int nextFormID = 0; // Initialize form ID
    Connection con = null;
    Statement stmt = null;
    ResultSet rs = null;

    try {
        // Database connection setup
        Class.forName("com.mysql.cj.jdbc.Driver");
        con = DriverManager.getConnection("jdbc:mysql://localhost:3306/oms", "root", "PRAbhu@mysql");
        
        // Query to get the next available form ID
        stmt = con.createStatement();
        String sql = "SELECT MAX(formID) AS maxID FROM eFormInsert"; // Adjust table name as needed
        rs = stmt.executeQuery(sql);

        if (rs.next()) {
            nextFormID = rs.getInt("maxID") + 1; // Increment the max ID by 1
        } else {
            nextFormID = 1; // If no records exist, start from 1
        }

        out.print(nextFormID); // Output the next form ID
    } catch (SQLException e) {
        e.printStackTrace();
        out.print("Error fetching form ID: " + e.getMessage());
    } catch (ClassNotFoundException e) {
        e.printStackTrace();
        out.print("Database driver not found.");
    } finally {
        // Close resources
        try {
            if (rs != null) rs.close();
            if (stmt != null) stmt.close();
            if (con != null) con.close();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }
%>