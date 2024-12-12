<%@ page import="java.sql.*" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    // Initialize variables
    String id = request.getParameter("id");
    String attendpersonname = "";
    String formid = "";
    String fullname = "";
    String gender = "";
    String mobilenumber = "";
    String alternatemobilenumber = "";
    String email = "";
    String education = "";
    String passedoutyear = "";
    String street = "";
    String city = "";
    String state = "";
    String currentlivingcity = "";
    String coursename = "";
    String workingstatus = "";
    Connection con = null;
    PreparedStatement ps = null;
    ResultSet rs = null;

    // Check if form is submitted (POST request)
    if ("POST".equalsIgnoreCase(request.getMethod())) {
        // Get parameters from form submission
        attendpersonname = request.getParameter("attendPersonName");
        formid = request.getParameter("formID");
        fullname = request.getParameter("fullName");
        gender = request.getParameter("gender");
        mobilenumber = request.getParameter("mobileNumber");
        alternatemobilenumber = request.getParameter("alternateMobileNumber");
        email = request.getParameter("email");
        education = request.getParameter("education");
        passedoutyear = request.getParameter("passedOutYear");
        street = request.getParameter("street");
        city = request.getParameter("city");
        state = request.getParameter("state");
        currentlivingcity = request.getParameter("currentLivingCity");
        coursename = request.getParameter("courseName");
        workingstatus = request.getParameter("workingStatus");

        // Update record in the database
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            con = DriverManager.getConnection("jdbc:mysql://localhost:3306/oms", "root", "PRAbhu@mysql");
            
            String updateQuery = "UPDATE eFormInsert SET attendPersonName=?, formID=?, fullName=?, gender=?, mobileNumber=?, alternateMobileNumber=?, email=?, education=?, passedOutYear=?, street=?, city=?, state=?, currentLivingCity=?, courseName=?, workingStatus=? WHERE id=?";
            ps = con.prepareStatement(updateQuery);
            
            ps.setString(1, attendpersonname);
            ps.setString(2, formid);
            ps.setString(3, fullname);
            ps.setString(4, gender);
            ps.setString(5, mobilenumber);
            ps.setString(6, alternatemobilenumber);
            ps.setString(7, email);
            ps.setString(8, education);
            ps.setString(9, passedoutyear);
            ps.setString(10, street);
            ps.setString(11, city);
            ps.setString(12, state);
            ps.setString(13, currentlivingcity);
            ps.setString(14, coursename);
            ps.setString(15, workingstatus);
            ps.setString(16, id); // Update the record based on id
            
            int result = ps.executeUpdate();

            if (result > 0) {
               /*  out.println("<h3>Record updated successfully!</h3>"); */
            	out.println("<script>alert('Record updated successfully!'); window.location.href='viewenquiryform.jsp';</script>");
            } else {
                out.println("<h3>Error updating the record.</h3>");
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            try {
                if (rs != null) rs.close();
                if (ps != null) ps.close();
                if (con != null) con.close();
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
    } else {
        // If not POST, show existing data in form
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            con = DriverManager.getConnection("jdbc:mysql://localhost:3306/oms", "root", "PRAbhu@mysql");

            // Query to get the record from the database
            String query = "SELECT * FROM eFormInsert WHERE id = ?";
            ps = con.prepareStatement(query);
            ps.setString(1, id);
            rs = ps.executeQuery();

            if (rs.next()) {
                attendpersonname = rs.getString("attendPersonName");
                formid = rs.getString("formID");
                fullname = rs.getString("fullName");
                gender = rs.getString("gender");
                mobilenumber = rs.getString("mobileNumber");
                alternatemobilenumber = rs.getString("alternateMobileNumber");
                email = rs.getString("email");
                education = rs.getString("education");
                passedoutyear = rs.getString("passedOutYear");
                street = rs.getString("street");
                city = rs.getString("city");
                state = rs.getString("state");
                currentlivingcity = rs.getString("currentLivingCity");
                coursename = rs.getString("courseName");
                workingstatus = rs.getString("workingStatus");
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            try {
                if (rs != null) rs.close();
                if (ps != null) ps.close();
                if (con != null) con.close();
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
    }
%>


<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Update Form</title>

    <!-- Link to external or inline CSS -->
    <style>
        /* General Styles */
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
            font-family: 'Poppins', sans-serif;
        }

        body {
            background-color: #f5f7fa;
            padding: 30px;
        }

        .container {
            max-width: 1200px;
            margin: auto;
            background-color: #fff;
            padding: 20px;
            box-shadow: 0 5px 15px rgba(0, 0, 0, 0.1);
            border-radius: 8px;
        }

        header {
            text-align: center;
            font-size: 24px;
            font-weight: 600;
            margin-bottom: 30px;
            color: #333;
        }

        form {
            display: grid;
            grid-template-columns: repeat(3, 1fr);
            gap: 20px;
        }

        .form-group {
            display: flex;
            flex-direction: column;
        }

        .form-group label {
            font-size: 14px;
            font-weight: 500;
            color: #333;
            margin-bottom: 5px;
        }

        .form-group input {
            padding: 10px;
            border-radius: 5px;
            border: 1px solid #ccc;
            font-size: 14px;
            color: #333;
        }

        .form-group input:focus {
            border-color: #4070f4;
            outline: none;
        }

        input[type="submit"] {
            grid-column: span 3;
            padding: 15px;
            border-radius: 5px;
            background-color: #4070f4;
            color: white;
            font-weight: 600;
            font-size: 16px;
            border: none;
            cursor: pointer;
            transition: background-color 0.3s ease;
        }

        input[type="submit"]:hover {
            background-color: #265df2;
        }

        /* Responsive Design */
        @media (max-width: 1024px) {
            form {
                grid-template-columns: repeat(2, 1fr);
            }
        }

        @media (max-width: 768px) {
            form {
                grid-template-columns: 1fr;
            }

            .form-group input {
                width: 100%;
            }
        }
    </style>
</head>
<body>

<div class="container">
    <header>Update Form Details</header>
    <form method="post" action="updateForm.jsp">
        <input type="hidden" name="id" value="<%= id %>">

        <div class="form-group">
            <label for="attendPersonName">Attend Person Name:</label>
            <input type="text" name="attendPersonName" value="<%= attendpersonname %>">
        </div>
        
        <div class="form-group">
            <label for="formID">Form ID:</label>
            <input type="text" name="formID" value="<%= formid %>">
        </div>

        <div class="form-group">
            <label for="fullName">Full Name:</label>
            <input type="text" name="fullName" value="<%= fullname %>">
        </div>

        <div class="form-group">
            <label for="gender">Gender:</label>
            <input type="text" name="gender" value="<%= gender %>">
        </div>

        <div class="form-group">
            <label for="mobileNumber">Mobile Number:</label>
            <input type="text" name="mobileNumber" value="<%= mobilenumber %>">
        </div>

        <div class="form-group">
            <label for="alternateMobileNumber">Alternate Mobile Number:</label>
            <input type="text" name="alternateMobileNumber" value="<%= alternatemobilenumber %>">
        </div>

        <div class="form-group">
            <label for="email">Email:</label>
            <input type="text" name="email" value="<%= email %>">
        </div>

        <div class="form-group">
            <label for="education">Education:</label>
            <input type="text" name="education" value="<%= education %>">
        </div>

        <div class="form-group">
            <label for="passedOutYear">Passed Out Year:</label>
            <input type="text" name="passedOutYear" value="<%= passedoutyear %>">
        </div>

        <div class="form-group">
            <label for="street">Street:</label>
            <input type="text" name="street" value="<%= street %>">
        </div>

        <div class="form-group">
            <label for="city">City:</label>
            <input type="text" name="city" value="<%= city %>">
        </div>

        <div class="form-group">
            <label for="state">State:</label>
            <input type="text" name="state" value="<%= state %>">
        </div>

        <div class="form-group">
            <label for="currentLivingCity">Current Living City:</label>
            <input type="text" name="currentLivingCity" value="<%= currentlivingcity %>">
        </div>

        <div class="form-group">
            <label for="courseName">Course Name:</label>
            <input type="text" name="courseName" value="<%= coursename %>">
        </div>

        <div class="form-group">
            <label for="workingStatus">Working Status:</label>
            <input type="text" name="workingStatus" value="<%= workingstatus %>">
        </div>

        <input type="submit" value="Update">
    </form>
</div>

</body>
</html>
