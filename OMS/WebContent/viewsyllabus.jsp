<%@ page import="javax.servlet.http.HttpSession" %>
<%@ page import="java.sql.*, javax.servlet.http.*, javax.servlet.ServletException, java.io.IOException" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<%
    // Retrieve session data for username and role
    String username = (String) session.getAttribute("username");
    String role = (String) session.getAttribute("role");

    // If no username or role found in session, redirect to login page
    if (username == null || role == null) {
        response.sendRedirect("login.html");
    }

    // Establishing database connection
    Connection con = null;
    PreparedStatement ps = null;
    ResultSet rs = null;

    try {
        Class.forName("com.mysql.cj.jdbc.Driver");
        con = DriverManager.getConnection("jdbc:mysql://localhost:3306/oms", "root", "PRAbhu@mysql");

        // Get the search query parameter from request (if any)
        String searchQuery = request.getParameter("searchQuery");

        // Base SQL query
        String sql = "SELECT * FROM syllabus_upload WHERE 1=1"; // "WHERE 1=1" is a simple trick to avoid checking for null in SQL

        // If search query is not empty, add conditions to search for Topic or Syllabus
        if (searchQuery != null && !searchQuery.isEmpty()) {
            sql += " AND (topic LIKE ? OR syllabus LIKE ?)";
        }

        // Prepare statement with the dynamic SQL query
        ps = con.prepareStatement(sql);

        // Bind the search parameter if searchQuery exists
        if (searchQuery != null && !searchQuery.isEmpty()) {
            ps.setString(1, "%" + searchQuery + "%"); // Search for topic
            ps.setString(2, "%" + searchQuery + "%"); // Search for syllabus
        }

        // Execute the query
        rs = ps.executeQuery();
%>


<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    
    <!-- Link to CSS -->
    <link rel="stylesheet" href="CSS/studenthome.css">
     
    <!-- Icons -->
    <link rel="stylesheet" href="https://unicons.iconscout.com/release/v4.0.0/css/line.css">

    <title>STUDENT DASHBOARD PANEL</title>
    
     <style>
        table {
            width: 100%;
            border-collapse: collapse;
        }
        th, td {
            padding: 10px;
            text-align: left;
            border: 1px solid #ddd;
        }
        th {
            background-color: #f2f2f2;
        }
        input[type='submit'] {
            padding: 15px 30px;
            font-size: 16px;
            background-color: #4CAF50;
            color: white;
            border: none;
            border-radius: 5px;
            cursor: pointer;
        }
        input[type='submit']:hover {
            background-color: #45a049;
        }
        
        
       
    /* General button styling */
    .btn-edit, .btn-delete {
        display: inline-block;
        padding: 10px 20px;
        margin: 5px;  /* Space between buttons */
        text-align: center;
        text-decoration: none;
        font-size: 16px;
        border-radius: 5px;
        cursor: pointer;
        transition: background-color 0.3s, transform 0.3s;
    }

    /* Edit button specific styles */
    .btn-edit {
        background-color: #4CAF50;  /* Green */
        color: white;
        border: 1px solid #4CAF50;
    }

    .btn-edit:hover {
        background-color: #45a049;  /* Darker green on hover */
        transform: scale(1.05);  /* Slight zoom effect */
    }

    /* Delete button specific styles */
    .btn-delete {
        background-color: #f44336;  /* Red */
        color: white;
        border: 1px solid #f44336;
    }

    .btn-delete:hover {
        background-color: #e53935;  /* Darker red on hover */
        transform: scale(1.05);  /* Slight zoom effect */
    }

    /* Responsive Design: Buttons stacked on smaller screens */
    @media (max-width: 600px) {
        .btn-edit, .btn-delete {
            display: block;
            width: 100%;
            margin-bottom: 10px;  /* More space between buttons on mobile */
        }
    }

        
        
    </style>
    
    
    <script>
    function redirectToHomePage() {
        // Get the user's role from the session (using JSP)
        var role = '<%= role %>';  // Fetch the 'role' stored in session (either 'staff' or 'admin')

        // Redirect based on role
        if (role === 'staff') {
            window.location.href = 'staffhome.jsp';  // Redirect to staff home page
        } else if (role === 'admin') {
            window.location.href = 'adminhome.jsp';  // Redirect to admin home page
        } else {
            alert('Role not found or invalid. Please log in first.');  // If role is not found or invalid
        }
    }
    
    /* search bar java script start */
    
    /* search bar java script end */
    
    
</script>
    
    
    
</head>
<body>

<nav>
    <div class="logo-name">
        <div class="logo-image">
            <img src="CSS/logo.png" alt="">
        </div>
        <span class="logo_name">OMS</span>
    </div>

    <div class="menu-items">
        <ul class="nav-links">
            <li><a href="adminhome.jsp">
                <i class="uil uil-estate"></i>
                <span class="link-name">HOME PAGE</span>
            </a></li>
            <li><a href="viewstaffattendance.jsp">
               <i class="uil uil-user"></i>
                <span class="link-name">STAFF ATTENDANCE </span>
            </a></li>
            
             <li><a href="staffleaverequestform.jsp">
               <i class="uil uil-check-circle"></i>
                <span class="link-name">ADMIN ATTENDANCE</span>
            </a></li>
            
            <li><a href="enquiryForm.jsp">
               <i class="uil uil-check-circle"></i>
                <span class="link-name">ENQUIRY FORM</span>
            </a></li>
            <li><a href="viewenquiryform.jsp">
                <i class="uil uil-calendar-alt"></i>
                <span class="link-name">ENQUIRY REPORT</span>
            </a></li>
            <li><a href="viewenquiryreasons.jsp">
                <i class="uil uil-clipboard-notes"></i>
                <span class="link-name">ENQUIRY REASONS</span>
            </a></li>
           <!--  <li><a href="#">
                 <i class="uil uil-file-alt"></i>
                <span class="link-name">RESUME</span>
            </a></li> -->
            <li><a href="#">
              <i class="uil uil-graduation-cap"></i>
                <span class="link-name">COURSE DETAILS</span>
            </a></li>
        </ul>
        
        <ul class="logout-mode">
            <li><a href="signup.html">
                <i class="uil uil-signout" style="color: red;"></i>
                <span class="link-name" style="color: red;">Logout</span>
            </a></li>

            <li class="mode">
                <a href="#">
                    <i class="uil uil-moon"></i>
                <span class="link-name">Dark Mode</span>
            </a>

            <div class="mode-toggle">
              <span class="switch"></span>
            </div>
        </li>
        </ul>
    </div>
</nav>

<section class="dashboard">
    <div class="top">
        <i class="uil uil-bars sidebar-toggle"></i>

        <!-- Search Box -->

        <!-- Profile Picture and Name -->
        <div class="profile">
            <img src="CSS/studentprofile.jpg" alt="User Profile">
            <div class="profile-info">
                 <span class="profile-name"><%= username.toUpperCase() %></span>   <!-- Display the username stored in session -->
                 <span class="profile-role">(<%= role.toUpperCase() %>)</span>   <!-- Display the role stored in session -->
            </div>
        </div>
    </div>

    <div class="dash-content">
         <div class="overview">
            <div class="title">
               <i class="uil uil-book-reader"></i>  <!-- Represents a book/education icon -->
                <span class="text">SYLLABUS REPORT</span>
            </div>

       
        </div>
    </div>
    
    
    <table>
            <thead>
                <tr>
                    <th> ID</th>
                    <th>ADMIN NAME</th>
                    <th>UPLOAD DATE</th>
                    <th>FINAL DATE</th>
                    <th>TOPIC</th>
                    <th>SYLLABUS</th>
                     <th>STATUS</th>
                    <th>ACTION</th>
                </tr>
            </thead>
            <tbody>
                <%
                    // Fetch and display data in table rows
                    while (rs.next()) {
                        String id = rs.getString(1);
                        String adminname = rs.getString(2);
                        String uploaddate = rs.getString(3);
                        String finaldate = rs.getString(4);
                        String topic = rs.getString(5);
                        String syllabus = rs.getString(6);
                        String status = rs.getString(7);
                        String reason = rs.getString("reason");  // Assuming reason is a column in your table
                %>
                <tr>
                    <td><%= id %></td>
                    <td><%= adminname %></td>
                    <td><%= uploaddate %></td>
                    <td><%= finaldate %></td>
                    <td><%= topic %></td>
                    <td><%= syllabus %></td>
                     <td><%= status %></td>
                    <td>
                        <% 
                            // Check if reason is not null, and disable the buttons if it is not null
                            if (reason != null && !reason.isEmpty() || status.equalsIgnoreCase("completed")) {
                        %>
                            <!-- Buttons are disabled if reason is not null -->
                            <a href="#" class="btn-edit" style="background-color: gray; cursor: not-allowed;" onclick="return false;">Edit</a>
                            <a href="#" class="btn-delete" style="background-color: gray; cursor: not-allowed;" onclick="return false;">Delete</a>
                        <% 
                            } else {
                        %>
                            <!-- Enable Edit and Delete buttons -->
                            <a href="editSyllabus.jsp?id=<%= id %>" class="btn-edit">Edit</a> 
                            <a href="http://localhost:8080/OMS/deletesyllabus?id=<%= id %>" class="btn-delete" onclick="return confirm('Are you sure you want to delete this record?')">Delete</a>
                        <% 
                            }
                        %>
                    </td>
                </tr>
                <% 
                    }
                %>
            </tbody>
        </table>
   
    
</section>

<script src="studenthome.js"></script>

</body>
</html>
<%
    } catch (ClassNotFoundException e) {
        e.printStackTrace();
    } catch (SQLException e) {
        e.printStackTrace();
    } finally {
        // Close resources
        try {
            if (rs != null) rs.close();
            if (ps != null) ps.close();
            if (con != null) con.close();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }
%>