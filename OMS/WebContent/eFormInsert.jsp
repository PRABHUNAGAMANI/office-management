<%@ page import="java.sql.*, java.io.*" %>
<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Form Submission Result</title>
</head>
<body>
<%
    Connection con = null;
    PreparedStatement ps = null;

    try {
        // Get form parameters from request
        String attendPersonName = request.getParameter("attendPersonName");
        String formIDStr = request.getParameter("formID");
        String fullName = request.getParameter("fullName");
        String gender = request.getParameter("gender");
        String mobileNumber = request.getParameter("mobileNumber");
        String alternateMobileNumber = request.getParameter("alternateMobileNumber");
        String email = request.getParameter("email");
        String education = request.getParameter("education");
        String passedOutYear = request.getParameter("passedOutYear");
        String street = request.getParameter("street");
        String city = request.getParameter("city");
        String state = request.getParameter("state");
        String currentLivingCity = request.getParameter("currentLivingCity");
        String courseName = request.getParameter("courseName");
        String workingStatus = request.getParameter("workingStatus");

        // Check if formID is null or empty
        if (formIDStr == null || formIDStr.isEmpty()) {
            out.println("<script>alert('Form ID cannot be null. Please try again.'); window.history.back();</script>");
            return; // Prevent further execution
        }

        // Convert formID to integer
        int formID = Integer.parseInt(formIDStr);

        // Database connection setup
        Class.forName("com.mysql.cj.jdbc.Driver");
        con = DriverManager.getConnection("jdbc:mysql://localhost:3306/oms", "root", "PRAbhu@mysql");
        
        // Insert query with 14 parameters
        String query = "INSERT INTO eFormInsert (formID, attendPersonName, fullName, gender, mobileNumber, alternateMobileNumber, email, education, passedOutYear, street, city, state, currentLivingCity, courseName, workingStatus) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?,?)";
        ps = con.prepareStatement(query);
        
        ps.setInt(1, formID); // Set formID as an integer
        ps.setString(2, attendPersonName);
        ps.setString(3, fullName);
        ps.setString(4, gender);
        ps.setString(5, mobileNumber);
        ps.setString(6, alternateMobileNumber);
        ps.setString(7, email);
        ps.setString(8, education);
        ps.setString(9, passedOutYear);
        ps.setString(10, street);
        ps.setString(11, city);
        ps.setString(12, state);
        ps.setString(13, currentLivingCity);
        ps.setString(14, courseName);
        ps.setString(15, workingStatus); // This line is incorrect and should be removed

        // Execute the insert
        int result = ps.executeUpdate();
        if (result > 0) {
            out.println("<script>alert('Form submitted successfully!'); window.location.href='adminhome.jsp';</script>");
        } else {
            out.println("<script>alert('Failed to submit the form. Please try again.'); window.history.back();</script>");
        }
    } catch (SQLException e) {
        e.printStackTrace();
        out.println("<script>alert('Database error: " + e.getMessage() + "'); window.history .back();</script>");
    } catch (ClassNotFoundException e) {
        e.printStackTrace();
        out.println("<script>alert('Database driver not found.'); window.history.back();</script>");
    } finally {
        // Close resources
        try {
            if (ps != null) ps.close();
            if (con != null) con.close();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }
%>
</body>
</html>