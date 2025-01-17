<%@ page import="java.sql.*, javax.servlet.http.*, javax.servlet.ServletException, java.io.IOException" %>
<%@ page import="java.sql.*, javax.servlet.*, javax.servlet.http.*, java.io.*" %>

<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%


//Get the current session or create a new one if it doesn't exist
String username = null;  
String role = null; 

//Use the implicit 'session' object to retrieve session data
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

        // Query to perform RIGHT JOIN between eFormInsert and attempts tables
    String sql = "SELECT e.id, e.formid, e.attendPersonName, e.fullName, e.passedOutYear, e.education, e.courseName, " +
             "a.attempt_number, a.reason, a.student_status " +
             "FROM eFormInsert e " +
             "RIGHT JOIN attempts a ON e.id = a.eform_id";



        ps = con.prepareStatement(sql);
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
    
    
    <title>Combined Data from eFormInsert and Attempts</title>
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
    
    
    function filterTable() {
        var searchInput = document.getElementById('searchInput').value.toLowerCase();
        var table = document.getElementById('enquiryTable'); // Make sure the table has this id
        var rows = table.getElementsByTagName('tr');
        
        // Loop through all table rows
        for (var i = 1; i < rows.length; i++) { // Start from 1 to skip the header row
            var cells = rows[i].getElementsByTagName('td');
            var fullnameCell = cells[3] ? cells[3].textContent.toLowerCase() : ''; // Column for fullname
            var courseNameCell = cells[5] ? cells[5].textContent.toLowerCase() : ''; // Column for course name
            
            // If either fullname or courseName contains the search input, show the row
            if (fullnameCell.includes(searchInput) || courseNameCell.includes(searchInput)) {
                rows[i].style.display = ''; // Show row
            } else {
                rows[i].style.display = 'none'; // Hide row
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
                <span class="link-name">HOME PAGE</span>
            </a></li>
              <li><a href="attendance.jsp">
               <i class="uil uil-check-circle"></i>
                <span class="link-name">ATTENDANCE</span>
            </a></li>
              <li><a href="staffviewattendance.jsp">
               <i class="uil uil-check-circle"></i>
                <span class="link-name">ADMIN ATTENDANCE</span>
            </a></li>
              <li><a href="viewstudentattendance.jsp">
               <i class="uil uil-check-circle"></i>
                <span class="link-name">STUDENT ATTENDANCE</span>
            </a></li>
              <li><a href="viewstaffattendance.jsp">
               <i class="uil uil-check-circle"></i>
                <span class="link-name">STAFF ATTENDANCE</span>
            </a></li>
            <li><a href="enquiryForm.jsp">
               <i class="uil uil-user"></i>
                <span class="link-name">ENQUIRY FORM</span>
            </a></li>
           <!--  <li><a href="attendance.jsp">
               <i class="uil uil-check-circle"></i>
                <span class="link-name">ATTENDANCE</span>
            </a></li> -->
            <li><a href="viewenquiryform.jsp">
                <i class="uil uil-calendar-alt"></i>
                <span class="link-name">ENQUIRY REPORT</span>
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
                <i class="uil uil-clipboard-notes"></i>
                <span class="link-name">ONLINE TEST</span>
            </a></li> -->
           <!--  <li><a href="#">
                 <i class="uil uil-file-alt"></i>
                <span class="link-name">RESUME</span>
            </a></li> -->
           <!--  <li><a href="#">
              <i class="uil uil-graduation-cap"></i>
                <span class="link-name">COURSE DETAILS</span>
            </a></li> -->
        </ul>
        
        <ul class="logout-mode">
            <li><a href="signup.html">
                <i class="uil uil-signout" style="color: red;"></i>
                <span class="link-name" style="color: red;"> Logout</span>
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
        <input type="text" id="searchInput" placeholder="Search by fullname or student status" oninput="filterTable()" />
        <button class="search-btn" type="button" onclick="filterTable()">Search</button>
    </div> -->
    
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
                <i class="uil uil-tachometer-fast-alt"></i>
                <span class="text">STUDENT ENQUIRY REPORT</span>
            </div>

          <!--   <div class="boxes">
                <div class="box box1">
                    <i class="uil uil-user"></i>
                    <span class="text"> ENQUIRY FEEDBACK</span>
                    <button type="submit" class="btn" onclick="window.location.href='viewenquiryreasons.jsp'">Click</button>
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



    <h2>ENQUIRY FEEDBACK REASONS</h2>

    <table>
        <thead>
            <tr>
                <th>ID</th>
                <th>Form ID</th>
                <th>Admin Name</th>
                <th>Full Name</th>
                <!-- <th>passedOutYear</th> -->
                 <th>education</th>
                  <th>courseName</th>
                <th>Attempt Number</th>
                <th>Reason</th>
                 <th>STUDENT STATUS </th>
            </tr>
        </thead>
        <tbody>
            <%
                while (rs.next()) {
                    int id = rs.getInt("id");
                    String formid = rs.getString("formid");
                    String attendPersonName = rs.getString("attendPersonName");
                    String fullName = rs.getString("fullName");
                   /*  String passedOutYear = rs.getString("passedOutYear"); */
                    String education = rs.getString("education");
                    String courseName = rs.getString("courseName");
                    int attemptNumber = rs.getInt("attempt_number");
                    String reason = rs.getString("reason");
                    String studentstatus = rs.getString("student_status");

            %>
            <tr>
                <td><%= id != 0 ? id : "No ID" %></td>
                <td><%= formid != null ? formid : "No Form ID" %></td>
                <td><%= attendPersonName != null ? attendPersonName : "No Admin Name" %></td>
                <td><%= fullName != null ? fullName : "No Full Name" %></td>
                
               <%--   <td><%= passedOutYear != null ? passedOutYear : "No passedoutyear" %></td> --%>
                 
                 <td><%= education != null ? education : "No education" %></td>
                 
                 <td><%= courseName != null ? courseName : "No courseName" %></td>
                
                <td><%= (attemptNumber != 0) ? attemptNumber : "No Attempt" %></td>
                <td><%= (reason != null) ? reason : "No Reason Provided" %></td>
                <td><%= (studentstatus != null) ? studentstatus : "No student status" %></td>
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
