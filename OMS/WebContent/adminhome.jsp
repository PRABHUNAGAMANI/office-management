<%@ page import="javax.servlet.http.HttpSession" %>
<%
    // Get the current session or create a new one if it doesn't exist
    String username = null;
    String role = null;

    // Use the implicit 'session' object to retrieve session data
    if (session != null) {
        username = (String) session.getAttribute("username");  // Retrieve the 'username' from session
        role = (String) session.getAttribute("role");  // Retrieve the 'role' from session
    }

    if (username == null || role == null) {
        // If there is no username or role in session (user is not logged in), redirect to login page
        response.sendRedirect("login.html");
    }
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    
    <!-- fontawesome icon  -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css">
    
    
    <!-- Link to CSS -->
    <link rel="stylesheet" href="CSS/studenthome.css">
     
    <!-- Icons -->
    <link rel="stylesheet" href="https://unicons.iconscout.com/release/v4.0.0/css/line.css">

    <title>ADMIN DASHBOARD PANEL</title>
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
        
       <!--  <li><a href="#">
                 <i class="fa fa-calendar-check"></i>
                <span class="link-name">PROFILE</span>
            </a></li> -->
        
            <li><a href="attendance.jsp">
                 <i class="fa fa-calendar-check"></i>
                <span class="link-name">ATTENDANCE</span>
            </a></li>
            <li><a href="adminattendance.jsp">
                <i class="fa fa-file-alt"></i>
                <span class="link-name"> ATTENDANCE REPORT </span>
            </a></li>
            <li><a href="enquiryForm.jsp">
                <i class="fa fa-question-circle"></i> 
                <span class="link-name">ENQUIRY FORM</span>
            </a></li>
            <li><a href="viewenquiryform.jsp">
                <i class="fa fa-chart-pie"></i>  
                <span class="link-name">ENQUIRY REPORT</span>
            </a></li>
            <li><a href="adminviewstaffleave.jsp">
                  <i class="fa fa-file-alt"></i>
                <span class="link-name">STAFF LEAVE REPORT</span>
            </a></li>
            <li><a href="adminviewallleaveform.jsp">
                 <i class="fa fa-file-alt"></i>
                <span class="link-name">ALL LEAVE REPORT</span>
            </a></li>
            <li><a href="viewsyllabus.jsp">
                 <i class="fa fa-file-alt"></i>
                <span class="link-name">SYLLABUS REPORT</span>
            </a></li>
              <li><a href="admin viewsyllabusreason.jsp">
                 <i class="fa fa-file-alt"></i>
                <span class="link-name">SYLLABUS COMPLETION</span>
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

        <!-- <div class="search-box">
            <i class="uil uil-search"></i>
            <input type="text" placeholder="Search here...">
        </div> -->
        
        <!-- Profile Picture and Name -->
        <div class="profile">
            <img src="CSS/studentprofile.jpg" alt="User Profile">
            <div class="profile-info">
                <span class="profile-name"><%= username.toUpperCase() %></span>  <!-- Display the username stored in session -->
                <span class="profile-role">(<%= role.toUpperCase() %>)</span>  <!-- Display the role stored in session -->
            </div>
        </div>
    </div>

    <div class="dash-content">
        <div class="overview">
            <div class="title">
               <i class="uil uil-building"></i>  <!-- Represents a building icon -->
                <span class="text">ADMIN HOME PAGE</span>
            </div>

            <div class="boxes">
                <div class="box box1">
                    <i class="uil uil-user"></i>
                    <span class="text">SYLLABUS</span>
                    <button type="submit" class="btn" onclick="window.location.href='syllabusform.jsp'">Click</button>
                </div>

               <div class="box box2">
    <i class="uil uil-check-circle"></i>
    <span class="text">ATTENDANCE</span>
    <button type="button" class="btn" onclick="window.location.href='attendance.jsp'">Click</button>
</div>

                <div class="box box3">
                   <i class="uil uil-calendar-alt"></i>
                    <span class="text">VIEW STAFF LEAVE REQUEST</span>
                    <button type="submit" class="btn" onclick="window.location.href='adminviewstaffleave.jsp'">Click</button>
                </div>
            </div>
            
            <br><br>
            
            <div class="boxes">
                <div class="box box1">
                    <i class="uil uil-clipboard-notes"></i>
                    <span class="text">ENQUIRY FORM</span>
                    <button type="submit" class="btn" onclick="window.location.href='enquiryForm.jsp'">Click</button>
                </div>
                <div class="box box2">
                   <i class="uil uil-file-alt"></i>
                    <span class="text">ENQUIRY REPORT</span>
                    <button type="submit" class="btn" onclick="window.location.href='viewenquiryform.jsp'">Click</button>
                </div>
                <div class="box box3">
                  <i class="uil uil-graduation-cap"></i>
                    <span class="text">ALL LEAVE REPORTS</span>
                    <button type="submit" class="btn" onclick="window.location.href='adminviewallleaveform.jsp'">Click</button>
                </div>
                
            </div>
        </div>
    </div>
</section>

<script src="studenthome.js"></script>

</body>
</html>
