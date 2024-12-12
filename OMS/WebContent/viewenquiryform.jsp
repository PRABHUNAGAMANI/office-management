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
              <li><a href="viewdummyenquiry.jsp">
                 <i class="uil uil-file-alt"></i>
                <span class="link-name">DUMMY ENQUIRY FORM </span>
            </a></li>
              <li><a href="viewdummyreason.jsp">
                 <i class="uil uil-file-alt"></i>
                <span class="link-name">DUMMY ENQUIRY REASONS </span>
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
<div class="search-box">
    <i class="uil uil-search"></i>
    <input type="text" id="searchInput" placeholder="Search by fullname or course name" oninput="filterTable()" />
    <button class="search-btn" type="button" onclick="filterTable()">Search</button>
</div>

        
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

            <div class="boxes">
                <div class="box box1">
                    <i class="uil uil-user"></i>
                    <span class="text"> ENQUIRY FEEDBACK</span>
                    <button type="submit" class="btn" onclick="window.location.href='attempts.jsp'">Click</button>
                </div>

             <!--   <div class="box box2">
    <i class="uil uil-check-circle"></i>
    <span class="text"> HOME PAGE</span>
    <button type="button" class="btn" onclick="window.location.href='studenthome.jsp'">Click</button>
</div> -->

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
            </div>
            
           
        </div>
    </div>
    
    
      <h2>ENQUIRY REPORT</h2>
    
    <table>
        <thead>
            <tr>
                <th>ID</th> 
                <th>ADMIN NAME</th>
                <th>FORMID</th>
                <th>FULLNAME</th>
               <!--  <th>GENDER</th>
                <th>MOBILE NUMBER</th>
                <th>ALTERNATE MOBILE NUMBER</th>
                <th>EMAIL</th>
                <th>EDUCATION</th>
                 <th>PASSED OUT YEAR</th>
                <th>STREET</th>
                <th>CITY</th>
                <th>STATE</th>
                <th>CURRENT LIVING CITY</th> -->
                 <th>COURSE NAME</th>
              <!--   <th>WORKING STATUS</th> -->
                 <th>ACTION</th>
                
                 
               
            </tr>
        </thead>
        <tbody>
            <%
                // Fetch and display data in table rows
                while (rs.next()) {
                     String id = rs.getString(1); 
                    String adminname = rs.getString(2);
                    String formid = rs.getString(3);
                    String fullname = rs.getString(4);
                   /*  String gender = rs.getString(5);
                    String mobilenumber = rs.getString(6);
                    String alternatemobilenumber = rs.getString(7);
                    String email=rs.getString(8);
                    String education=rs.getString(9);
                    String passedoutyear = rs.getString(10);
                    String street = rs.getString(11);
                    String city = rs.getString(12);
                    String state = rs.getString(13);
                    String currentlivingcity = rs.getString(14); */
                    String coursename = rs.getString(15);
                  /*   String workingstatus = rs.getString(16); */
            %>
                <tr>
                     <td><%= id %></td> 
                    <td><%= adminname %></td>
                    <td><%= formid %></td>
                    <td><%= fullname %></td>
                   <%--  <td><%= gender %></td>
                    <td><%= mobilenumber %></td>
                    <td><%= alternatemobilenumber %></td>
                    <td><%= email %></td>
                    <td><%= education %></td>
                    <td><%= passedoutyear %></td>
                    <td><%= street %></td>
                    <td><%= city %></td>
                    <td><%= state %></td>
                    <td><%= currentlivingcity %></td> --%>
                    <td><%= coursename %></td>
                  <%--   <td><%= workingstatus %></td> --%>
                    
                      <!-- Add Update and Delete Buttons -->
        <td>
            <!-- Update Button -->
            <a href="updateForm.jsp?id=<%= id %>" class="update-btn">Update</a>
            
            <!-- Delete Button -->
           <%--  <a href="deleteForm.jsp?id=<%= id %>" class="delete-btn" onclick="return confirm('Are you sure you want to delete this record?')">Delete</a> --%>
            <a href="deleteForm.jsp?id=<%= id %>" class="delete-btn">Delete</a>
        </td>
                    
                </tr>
            <%
                }
            %>
        </tbody>
    </table>

   <!--  <form action="staffhome.jsp" method="get" style="margin-top: 20px;">
        <input type="submit" value="Back"/>
    </form> -->
    
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