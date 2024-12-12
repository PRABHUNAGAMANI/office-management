
<%@ page import="javax.servlet.http.HttpSession" %>
<%@ page import="java.sql.*, javax.servlet.http.*, javax.servlet.ServletException, java.io.IOException" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
     // Get the current session or create a new one if it doesn't exist
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
    

    // Database connection and data retrieval
    Connection con = null;
    PreparedStatement ps = null;
    ResultSet rs = null;
    
    try {
        Class.forName("com.mysql.cj.jdbc.Driver");
        con = DriverManager.getConnection("jdbc:mysql://localhost:3306/oms", "root", "PRAbhu@mysql");
         ps = con.prepareStatement("SELECT id, attendPersonName,formID,fullName,courseName FROM eFormInsert"); 
      /*  ps = con.prepareStatement("SELECT * FROM studentattendance WHERE role = ?");
            ps.setString(1, role);  // Dynamically set the role from session */

      /*   ps.setString(1, username);  */
        /* ps.setString(1, role); */
        
        rs = ps.executeQuery();
        
        
        
/* search bar query start */
        
        // Get search query from request
           String searchQuery = request.getParameter("searchQuery");

           // Modify SQL query to filter by search term
           String sql = "SELECT * FROM eFormInsert";  // Default query

           if (searchQuery != null && !searchQuery.isEmpty()) {
               sql += " AND (fullName LIKE ? OR courseName LIKE ?)";  // Add condition to search by username
           }

           ps = con.prepareStatement(sql);

           // Bind parameters if search query exists
           if (searchQuery != null && !searchQuery.isEmpty()) {
               ps.setString(1, "%" + searchQuery + "%");
           }

           rs = ps.executeQuery();


           /* search bar query end */
        
   
        
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

    <title>ADMIN PANEL</title>
    
     <style>
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
          
          
          /* Center the form */
form {
    width: 400px; /* Form width */
    margin: 0 auto; /* Center the form horizontally */
    padding: 30px;
    border-radius: 10px;
    background-color: #fff;
    box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
    display: flex;
    flex-direction: column;
    align-items: center;
    justify-content: center;
    margin-top: 50px; /* Space from the top */
}

/* Input Fields Style */
input[type="text"], input[type="file"], button {
    width: 100%;
    padding: 10px;
    margin: 10px 0;
    border-radius: 5px;
    border: 1px solid #ddd;
    font-size: 16px;
}

/* Add hover effect to the button */
button {
    background-color: #4CAF50;
    color: white;
    font-size: 18px;
    cursor: pointer;
}

button:hover {
    background-color: #45a049;
}

/* Label Style */
label {
    font-size: 16px;
    margin-bottom: 8px;
    text-align: left;
    width: 100%;
}

/* Input fields focus effect */
input[type="text"]:focus, input[type="file"]:focus {
    border-color: #4CAF50;
    outline: none;
}

/* Optional: Style for the form container to center it vertically */
body {
    display: flex;
    justify-content: center;
    align-items: center;
    min-height: 100vh;
    background-color: #f4f7fc;
    margin: 0;
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
            
             <li><a href="viewsyllabus.jsp">
                <i class="uil uil-estate"></i>
                <span class="link-name">SYLLABUS REPORT</span>
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
                <span class="text">SYLLABUS REPORT</span>
            </div>

          
            
           
        </div>
    </div>
    
    
   <!--  <h1>Upload Syllabus Excel File</h1> -->

   <form action="http://localhost:8080/OMS/SyllabusUploadServlet" method="post" enctype="multipart/form-data">
    <label for="username">ADMIN NAME</label><br>
    <input type="text" id="username" name="username" value="<%= session.getAttribute("username") %>" readonly required><br>
    
    <label for="syllabusfile">SYLLABUS FILE </label><br>
    <input type="file" id="syllabusfile" name="csvFile" required><br>
    
    <button type="submit">Upload Syllabus</button>
</form>

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
