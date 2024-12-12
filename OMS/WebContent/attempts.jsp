
 
  <%@ page import="java.sql.*, javax.servlet.http.*, javax.servlet.ServletException, java.io.IOException" %>
<%@ page import="java.sql.*, javax.servlet.*, javax.servlet.http.*, java.io.*" %>

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



    Connection con = null;
    PreparedStatement ps = null;
    ResultSet rs = null;

    try {
        Class.forName("com.mysql.cj.jdbc.Driver");
        con = DriverManager.getConnection("jdbc:mysql://localhost:3306/oms", "root", "PRAbhu@mysql");

        // Get all data from eFormInsert table
        ps = con.prepareStatement("SELECT * FROM eFormInsert");
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
            padding: 8px;
            text-align: left;
            border: 1px solid #ddd;
        }
        th {
            background-color: #f2f2f2;
        }
        
        .button-save {
            background-color: #4CAF50; /* Green background */
            color: white; /* White text */
            border: none;
            padding: 10px 20px;
            text-align: center;
            font-size: 16px;
            cursor: pointer;
        }

        .button-save:hover {
            background-color: #45a049; /* Darker green on hover */
        }

        .disabled {
            background-color: #f2f2f2;
            color: #ccc;
            cursor: not-allowed;
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
    
    
    // Function to filter the table based on search input
    function filterTable() {
        // Get the search input value
        var searchInput = document.getElementById('searchInput').value.toLowerCase();
        var table = document.getElementById('enquiryTable');
        var rows = table.getElementsByTagName('tr'); // Get all rows in the table
        
        // Loop through all rows, except the first (header row)
        for (var i = 1; i < rows.length; i++) {
            var cells = rows[i].getElementsByTagName('td');
            var fullnameCell = cells[3].textContent.toLowerCase(); // Fullname is in column 4 (index 3)
            var statusCell = cells[7].textContent.toLowerCase(); // Student status is in column 8 (index 7)
            
            // If search term matches fullname or student status, display the row, else hide it
            if (fullnameCell.includes(searchInput) || statusCell.includes(searchInput)) {
                rows[i].style.display = '';
            } else {
                rows[i].style.display = 'none';
            }
        }
    }
     
    
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
                <span class="link-name"> ADMIN ATTENDANCE</span>
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
                <span class="link-name">ENQUIRY FORM</span>
            </a></li>
            <li><a href="viewenquiryform.jsp">
              <i class="uil uil-graduation-cap"></i>
                <span class="link-name">ENQUIRY REPORT</span>
            </a></li>
             <li><a href="viewenquiryreasons.jsp">
              <i class="uil uil-graduation-cap"></i>
                <span class="link-name">FEEDBACK REASONS</span>
            </a></li>
            <li><a href="viewdummyenquiry.jsp">
                 <i class="uil uil-file-alt"></i>
                <span class="link-name">DUMMY ENQUIRY FORM </span>
            </a></li>
              <li><a href="viewdummyreason.jsp">
                 <i class="uil uil-file-alt"></i>
                <span class="link-name">DUMMY ENQUIRY REASONS </span>
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
 <div class="search-box">
        <i class="uil uil-search"></i>
        <input type="text" id="searchInput" placeholder="Search by fullname or student status" oninput="filterTable()" />
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
                <i class="uil uil-tachometer-fast-alt"></i>
                <span class="text">STUDENT ENQUIRY FORM FEEDBACK </span>
            </div>

            <div class="boxes">
                <div class="box box1">
                    <i class="uil uil-user"></i>
                    <span class="text">  ENQUIRY FEEDBACK REASONS</span>
                    <button type="submit" class="btn" onclick="window.location.href='viewenquiryreasons.jsp'">Click</button>
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



             <!--    <div class="box box3">
                   <i class="uil uil-calendar-alt"></i>
                    <span class="text">VIEW FULL ENQUIRY FORM</span>
                    <button type="submit" class="btn" onclick="window.location.href='viewfullenquiryform.jsp'">Click</button>
                </div> -->
            </div>
            
           
        </div>
    </div>
   
    <h2>ENQUIRY REPORT</h2>

    <table id="enquiryTable">
        <thead>
            <tr>
                <th>ID</th>
                <th>ADMIN NAME</th>
                <th>FORMID</th>
                <th>FULLNAME</th>
                <th>ATTEMPT 1</th>
                <th>ATTEMPT 2</th>
                <th>ATTEMPT 3</th>
                <th>STUDENT STATUS</th> <!-- New column for Student Status -->
                <th>REASON</th>
            </tr>
        </thead>
        <tbody>
            <%
                while (rs.next()) {
                    int id = rs.getInt("id");
                    String adminname = rs.getString("attendPersonName");
                    String fullname = rs.getString("fullName");

                    // Fetch attempts for the current form ID
                    PreparedStatement psAttempts = con.prepareStatement("SELECT * FROM attempts WHERE eform_id = ?");
                    psAttempts.setInt(1, id);
                    ResultSet rsAttempts = psAttempts.executeQuery();

                    // Variables to track if an attempt exists for each attempt number
                    boolean attempt1Exists = false;
                    boolean attempt2Exists = false;
                    boolean attempt3Exists = false;
                    String studentStatus = "Not Joined"; // Default status

                   /*  while (rsAttempts.next()) {
                        int attemptNumber = rsAttempts.getInt("attempt_number");
                        if (attemptNumber == 1) {
                            attempt1Exists = true;
                        } else if (attemptNumber == 2) {
                            attempt2Exists = true;
                        } else if (attemptNumber == 3) {
                            attempt3Exists = true;
                            studentStatus = "Course Joined"; // Set status to "Course Joined" when attempt 3 exists
                        }
                    } */
                   
                   
                   
                    while (rsAttempts.next()) {
                        int attemptNumber = rsAttempts.getInt("attempt_number");
                        String reason = rsAttempts.getString("reason");

                        if (attemptNumber == 1) 
                        {
                            attempt1Exists = true;
                         // Check if reason for attempt 3 contains "joined"
                            if (reason != null && reason.toLowerCase().contains("joined")) 
                            {
                                studentStatus = "Course Joined"; // Set to "Course Joined" if "joined" is in the reason
                            }
                        } 
                        else if (attemptNumber == 2) 
                        {
                            attempt2Exists = true;
                         // Check if reason for attempt 3 contains "joined"
                            if (reason != null && reason.toLowerCase().contains("joined")) 
                            {
                                studentStatus = "Course Joined"; // Set to "Course Joined" if "joined" is in the reason
                            }
                        } 
                        else if (attemptNumber == 3) 
                        {
                            attempt3Exists = true;

                            // Check if reason for attempt 3 contains "joined"
                            if (reason != null && reason.toLowerCase().contains("joined")) 
                            {
                                studentStatus = "Course Joined"; // Set to "Course Joined" if "joined" is in the reason
                            }
                           
                        }
                    }
                   
                   
                   

                    // Display the form and check the attempt existence
            %>
            <tr>
                <td><%= id %></td>
                <td><%= adminname %></td>
                <td><%= rs.getString("formid") %></td>
                <td><%= fullname %></td>
                <td><%= attempt1Exists ? "Attempted" : "Not Attempted" %></td>
                <td><%= attempt2Exists ? "Attempted" : "Not Attempted" %></td>
                <td><%= attempt3Exists ? "Attempted" : "Not Attempted" %></td>
                <td><%= studentStatus %></td> <!-- Display the student status -->
                <td>
                    <!-- Form to submit new attempt, disabled options based on existing attempts -->
                    <form action="saveAttempt.jsp" method="post">
                        <input type="hidden" name="eform_id" value="<%= id %>">

                            
                        
                         <label for="attempt_number">Attempt Number: </label>
            <select name="attempt_number" required>
                <option value="1" <%= attempt1Exists ? "class='disabled' disabled" : "" %> 
                    <%= studentStatus.equals("Course Joined") ? "disabled" : "" %>>Attempt 1</option>
                <option value="2" <%= attempt2Exists ? "class='disabled' disabled" : "" %>
                    <%= studentStatus.equals("Course Joined") ? "disabled" : "" %>>Attempt 2</option>
                <option value="3" <%= attempt3Exists ? "class='disabled' disabled" : "" %> 
                    <%= studentStatus.equals("Course Joined") ? "disabled" : "" %>>Attempt 3</option>
            </select><br>

            <label for="reason">Enter Reason: </label><br>
            <textarea name="reason" placeholder="select the attempt number" required></textarea><br>
                        
                        
                        
                        
                        
                        
                           <!-- Add student status -->
   <input type="hidden" name="studentStatus" value="<%= studentStatus %>">
 <!-- This is an example, make sure it's dynamically set if needed -->

                        <input type="submit" value="Save Attempt" class="button-save">
                    </form>
                    
      
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
 