package OMSservlet;

import java.io.*;
import java.sql.*;
import java.text.SimpleDateFormat;
import javax.servlet.*;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

@WebServlet("/SyllabusUploadServlet")
@MultipartConfig(maxFileSize = 16177215) // 16 MB
public class SyllabusUploadServlet extends HttpServlet {
    
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String adminName = request.getParameter("username"); // Get admin name from the request
        Part filePart = request.getPart("csvFile");  // The part containing the CSV file

        if (filePart == null) {
            response.getWriter().println("<script>alert('No file selected'); window.location.href='viewSyllabus.jsp';</script>");
            return;
        }

        // Database connection setup
        String jdbcURL = "jdbc:mysql://localhost:3306/oms"; // Update with your database URL
        String dbUser  = "root"; // Update with your database username
        String dbPassword = "PRAbhu@mysql"; // Update with your database password

        try {
            Class.forName("com.mysql.cj.jdbc.Driver"); // Load JDBC driver
            try (Connection connection = DriverManager.getConnection(jdbcURL, dbUser, dbPassword);
                 BufferedReader reader = new BufferedReader(new InputStreamReader(filePart.getInputStream()))) {

                String line;
                SimpleDateFormat dateFormat = new SimpleDateFormat("dd-MM-yyyy"); // Updated date format
                boolean isFirstLine = true; // Flag to skip the header line

                while ((line = reader.readLine()) != null) {
                    // Skip the header line
                    if (isFirstLine) {
                        isFirstLine = false;
                        continue;
                    }

                    // Trim whitespace and split the line
                    String[] data = line.trim().split(","); // Assuming CSV is comma-separated
                    if (data.length < 3) { // We need at least 3 columns: final date, topic, syllabus
                        response.getWriter().println("<script>alert('Invalid CSV format: " + line + "'); window.location.href='viewSyllabus.jsp';</script>");
                        continue;
                    }

                    String finalDateString = data[0].trim(); // First column: final_date
                    String topic = data[1].trim();           // Second column: topic
                    String syllabusFile = data[2].trim();    // Third column: syllabus (syllabus file path or name)

                    // Parse the final date (if provided)
                    java.sql.Date finalDate = null;
                    if (!finalDateString.isEmpty()) {
                        finalDate = new java.sql.Date(dateFormat.parse(finalDateString).getTime());
                    }

                    // Insert data into the database
                    String sql = "INSERT INTO syllabus_upload (admin_name, final_date, topic, syllabus) VALUES (?, ?, ?, ?)";
                    try (PreparedStatement statement = connection.prepareStatement(sql)) {
                        statement.setString(1, adminName);  // Admin name
                        statement.setDate(2, finalDate);     // Final date (nullable)
                        statement.setString(3, topic);      // Topic
                        statement.setString(4, syllabusFile); // Syllabus file name/path

                        statement.executeUpdate(); // Execute insert query
                    }
                }

                // Successful upload response
                response.getWriter().println("<script>alert('Syllabus uploaded successfully!'); window.location.href='viewsyllabus.jsp';</script>");
            }
        } catch (ClassNotFoundException e) {
            e.printStackTrace();
            response.getWriter().println("<script>alert('JDBC Driver not found: " + e.getMessage() + "'); window.location.href='viewSyllabus.jsp';</script>");
        } catch (SQLException e) {
            e.printStackTrace();
            response.getWriter().println("<script>alert('Database error: " + e.getMessage() + "'); window.location.href='viewSyllabus.jsp';</script>");
        } catch (Exception e) {
            e.printStackTrace();
            response.getWriter().println("<script>alert('Error: " + e.getMessage() + "'); window.location.href='viewSyllabus.jsp';</script>");
        }
    }
}









