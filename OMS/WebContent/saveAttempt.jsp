<%@ page import="java.sql.*, javax.servlet.http.*, javax.servlet.ServletException, java.io.IOException" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    Connection con = null;
    PreparedStatement ps = null;
    ResultSet rs = null;
    String studentStatus = "Not Course Joined";  // Default status
    String reason = request.getParameter("reason");  // Get reason from the form submission
    int attemptNumber = Integer.parseInt(request.getParameter("attempt_number"));  // Get the attempt number
    int eformId = Integer.parseInt(request.getParameter("eform_id")); // Get eform_id

    try {
        Class.forName("com.mysql.cj.jdbc.Driver");
        con = DriverManager.getConnection("jdbc:mysql://localhost:3306/oms", "root", "PRAbhu@mysql");

        // Check if this is attempt 3 and reason contains "joined"
        if ((attemptNumber == 1 || attemptNumber == 2 || attemptNumber == 3) && reason != null && reason.toLowerCase().contains("joined")) {
            studentStatus = "Course Joined";  // Update status if reason contains "joined"
        }

        // Save attempt in the attempts table
        ps = con.prepareStatement("INSERT INTO attempts (eform_id, attempt_number, reason, student_status) VALUES (?, ?, ?, ?)");
        ps.setInt(1, eformId);  // Set eform_id
        ps.setInt(2, attemptNumber);  // Set attempt_number
        ps.setString(3, reason);  // Set reason
        ps.setString(4, studentStatus);  // Save the student status
        ps.executeUpdate();

        // Check if the attempt is attempt 3 and student status is not "Course Joined"
        if (attemptNumber == 3 && !studentStatus.equals("Course Joined")) {

            // Insert the data into the dummy_attempts table
             ps = con.prepareStatement("INSERT INTO dummy_attempts (eform_id, attempt_number, reason, student_status) SELECT eform_id, attempt_number, reason, student_status FROM attempts WHERE eform_id = ?");
            ps.setInt(1, eformId);
            ps.executeUpdate(); 
            
          
            // Delete the data from the attempts table
            ps = con.prepareStatement("DELETE FROM attempts WHERE eform_id = ?");
            ps.setInt(1, eformId);
            ps.executeUpdate();

            // Move the record from eforminsert to dummy_eforminsert table
            ps = con.prepareStatement("INSERT INTO dummy_eforminsert (id, attendPersonName, formID, fullName, gender, mobileNumber, alternateMobileNumber, email, education, passedOutYear, street, city, state, currentLivingCity, courseName, workingStatus) SELECT id, attendPersonName, formID, fullName, gender, mobileNumber, alternateMobileNumber, email, education, passedOutYear, street, city, state, currentLivingCity, courseName, workingStatus FROM eforminsert WHERE id = ?");
            ps.setInt(1, eformId);
            ps.executeUpdate();

            // Delete the record from eforminsert table after moving to dummy_eforminsert
            ps = con.prepareStatement("DELETE FROM eforminsert WHERE id = ?");
            ps.setInt(1, eformId);
            ps.executeUpdate();
        }

        // After saving, redirect to the dashboard or another page
        response.sendRedirect("attempts.jsp");  // Redirect to a different page after saving
    } catch (ClassNotFoundException | SQLException e) {
        e.printStackTrace();
        // Handle exceptions, maybe redirect to an error page
    } finally {
        try {
            if (rs != null) rs.close();
            if (ps != null) ps.close();
            if (con != null) con.close();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }
%>
 