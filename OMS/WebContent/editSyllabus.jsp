<%@ page import="java.sql.*, javax.servlet.*, javax.servlet.http.*, java.io.IOException" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
//Get the current session or create a new one if it doesn't exist
String username = null;  
String role = null; 

// Use the implicit 'session' object to retrieve session data
if (session != null) { 
     username = (String) session.getAttribute("username");    // Retrieve the 'username' from session
    role = (String) session.getAttribute("role");  // Retrieve the 'role' from session
} 

if (username == null || role == null) { 
   // If there is no username or role in session (user is not logged in), redirect to login page
    response.sendRedirect("login.html");
}  

    String id = request.getParameter("id");  // Get the syllabus ID to edit
    Connection con = null;
    PreparedStatement ps = null;
    ResultSet rs = null;

    String finaldate = "";
    String topic = "";
    String syllabus = "";

    try {
        // Load MySQL JDBC driver
        Class.forName("com.mysql.cj.jdbc.Driver");
        con = DriverManager.getConnection("jdbc:mysql://localhost:3306/oms", "root", "PRAbhu@mysql");
        
        // Query to get the syllabus details for the specific ID
        ps = con.prepareStatement("SELECT * FROM syllabus_upload WHERE id = ?");
        ps.setString(1, id);
        rs = ps.executeQuery();
        
        if (rs.next()) {
            finaldate = rs.getString("final_date");
            topic = rs.getString("topic");
            syllabus = rs.getString("syllabus");
        }
    } catch (ClassNotFoundException | SQLException e) {
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
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
      <!-- Link to CSS -->
    <link rel="stylesheet" href="CSS/studenthome.css">
     
    <!-- Icons -->
    <link rel="stylesheet" href="https://unicons.iconscout.com/release/v4.0.0/css/line.css">
    <title>Edit Syllabus</title>
    
      <!-- <style>
        table {
            width: 100%;
            border-collapse: collapse;
        }
        th, td {
            padding: 5px;
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
        
        
        /* update and delete button start */
        
        
        .update-btn, .delete-btn {
    padding: 5px 10px;
    margin-bottom:10px;
    text-decoration: none;
    color: white;
    border-radius: 5px;
}

.update-btn {
    background-color: #4CAF50;
}

.update-btn:hover {
    background-color: #45a049;
}

.delete-btn {
    background-color: #f44336;
}

.delete-btn:hover {
    background-color: #da190b;
}
        
        
          /* update and delete button end */
        
        
    </style> -->
    
     <style>
        /* Body styling to ensure full screen coverage and background */
        body {
            margin: 0;
            padding: 0;
            height: 100vh;
            display: flex;
            justify-content: center;
            align-items: center;
            background-color: #f4f4f4;
            font-family: Arial, sans-serif;
        }

        /* Form container styling */
        .form-container {
            background-color: white;
            padding: 20px;
            border-radius: 8px;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
            width: 500px;
            max-width: 100%;
            text-align: center;
        }

        /* Heading styling */
        .form-container h2 {
            margin-bottom: 20px;
            font-size: 24px;
            font-weight: bold;
            color: #333;
        }

        /* Label styling */
        label {
            font-size: 16px;
            color: #333;
            display: block;
            margin-bottom: 8px;
            text-align: left;
        }

        /* Input fields and textarea styling */
        input[type="date"],
        input[type="text"],
        textarea {
            width: 100%;
            padding: 10px;
            margin: 8px 0 20px 0;
            border: 1px solid #ccc;
            border-radius: 4px;
            font-size: 16px;
            box-sizing: border-box;
        }

        /* Submit button styling */
        input[type="submit"] {
            padding: 12px 25px;
            font-size: 18px;
            background-color: #4CAF50;
            color: white;
            border: none;
            border-radius: 5px;
            cursor: pointer;
            transition: background-color 0.3s;
        }

        input[type="submit"]:hover {
            background-color: #45a049;
        }

        /* Optional link to go back */
        .back-link {
            margin-top: 20px;
            font-size: 16px;
            color: #007BFF;
            text-decoration: none;
        }

        .back-link:hover {
            text-decoration: underline;
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
    
    function filterTable() {
        var input = document.getElementById("searchInput").value.toLowerCase();  // Get search input
        var table = document.querySelector("table tbody");  // Get table body
        var rows = table.getElementsByTagName("tr");  // Get all rows in the table body

        // Loop through each row and hide or show it based on the input
        for (var i = 0; i < rows.length; i++) {
            var cols = rows[i].getElementsByTagName("td");  // Get all columns in the row
            var found = false;  // Assume the row should be hidden

            // Loop through each column in the row
            for (var j = 0; j < cols.length; j++) {
                if (cols[j].textContent.toLowerCase().includes(input)) {
                    found = true;  // Show the row if a match is found
                    break;
                }
            }

            // Display the row if a match was found, otherwise hide it
            rows[i].style.display = found ? "" : "none";
        }
    }


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
                <span class="link-name"> HOME PAGE </span>
            </a></li>
           
            <li><a href="attendance.jsp">
               <i class="uil uil-check-circle"></i>
                <span class="link-name">ATTENDANCE</span>
            </a></li>
             <li><a href="staffviewattendance.jsp">
               <i class="uil uil-user"></i>
                <span class="link-name"> ADMIN ATTENDANCE </span>
            </a></li>
            <li><a href="viewstaffattendance.jsp">
                <i class="uil uil-calendar-alt"></i>
                <span class="link-name">STAFF ATTENDANCE</span>
            </a></li>
            <li><a href="viewstudentattendance.jsp">
                <i class="uil uil-clipboard-notes"></i>
                <span class="link-name">STUDENT ATTENDANCE</span>
            </a></li>
            <li><a href="enquiryForm.jsp">
                 <i class="uil uil-file-alt"></i>
                <span class="link-name">ENQUIRY FORM </span>
            </a></li>
           <!--  <li><a href="#">
              <i class="uil uil-graduation-cap"></i>
                <span class="link-name">COURSE DETAILS</span>
            </a></li> -->
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
<!-- <div class="search-box">
    <i class="uil uil-search"></i>
    <input type="text" id="searchInput" placeholder="Search by fullname or course name" oninput="filterTable()" />
    <button class="search-btn" type="button" onclick="filterTable()">Search</button>
</div> -->

        
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
                  <i class="uil uil-comment-question"></i>
                <span class="text">ENQUIRY REPORT</span>
            </div>

           <!--  <div class="boxes">
                <div class="box box1">
                    <i class="uil uil-user"></i>
                    <span class="text"> ENQUIRY FEEDBACK</span>
                    <button type="submit" class="btn" onclick="window.location.href='attempts.jsp'">Click</button>
                </div>

               <div class="box box2">
    <i class="uil uil-check-circle"></i>
    <span class="text"> HOME PAGE</span>
    <button type="button" class="btn" onclick="window.location.href='studenthome.jsp'">Click</button>
</div>

<div class="box box2">
    <i class="uil uil-check-circle"></i>
    <span class="text">HOME PAGE</span>
    <button type="button" class="btn" onclick="redirectToHomePage()">Click</button>
</div>



                <div class="box box3">
                   <i class="uil uil-calendar-alt"></i>
                    <span class="text">VIEW FULL ENQUIRY FORM</span>
                    <button type="submit" class="btn" onclick="window.location.href='viewfullenquiryform.jsp'">Click</button>
                </div>
            </div> -->
            
           
        </div>
    </div>
    <!-- <h2>Edit Syllabus</h2> -->
   <div class="form-container">
    <h2>Edit Syllabus</h2>
    <form action="http://localhost:8080/OMS/updateSyllabusServlet" method="post">
        <input type="hidden" name="id" value="<%= id %>">  <!-- Pass the ID in a hidden input field -->

        <label for="finaldate">Final Date:</label>
        <input type="date" id="finaldate" name="finaldate" value="<%= finaldate %>"><br>

        <label for="topic">Topic:</label>
        <input type="text" id="topic" name="topic" value="<%= topic %>"><br>

        <label for="syllabus">Syllabus:</label>
        <textarea id="syllabus" name="syllabus"><%= syllabus %></textarea><br>

        <input type="submit" value="Update Syllabus">
    </form>
    <a href="viewsyllabus.jsp" class="back-link">Back to Syllabus List</a>
</div>
   <!--  <a href="viewSyllabus.jsp">Back to Syllabus List</a> -->
    
    </section>

<script src="studenthome.js"></script>
</body>
</html>
