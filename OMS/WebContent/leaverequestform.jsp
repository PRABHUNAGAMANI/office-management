<%@ page import="javax.servlet.http.HttpSession" %>
<%@ page import="java.sql.*" %>
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
    
    <!-- Link to CSS -->
    <link rel="stylesheet" href="CSS/studenthome.css">
     
    <!-- Icons -->
    <link rel="stylesheet" href="https://unicons.iconscout.com/release/v4.0.0/css/line.css">

    <title>STUDENT LEAVE REQUEST</title>
    
      <style>
        /* Reset margin and padding */
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }

        /* Body styling */
       /*  body {
            font-family: Arial, sans-serif;
            display: flex;
            justify-content: center;
            align-items: center;
            height: 100vh; /* Full viewport height */
            background-color: #f4f4f9;
            margin: 0;
            overflow: hidden; /* Hide any overflow to prevent scrollbars */
        } */

       /* Reset margin and padding */
* {
    margin: 0;
    padding: 0;
    box-sizing: border-box;
}

/* Body and HTML to take full height and prevent scrolling */
/* html, body {
    height: 100%;
    overflow: hidden; /* Prevents scrollbars */
    font-family: Arial, sans-serif;
}
 */
/* Body styling */
/* body {
    display: flex;
    justify-content: center;
    align-items: center;
    background-color: #f4f4f9;
} */

/* Container styling */
.container {
    width: 100%;
    max-width: 500px; /* Adjust as needed for larger forms */
    background-color: #ffffff;
    border-radius: 8px;
    padding: 30px;
    box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
    overflow: hidden; /* Ensure the content fits inside */
}

/* Heading styling */
h2 {
    text-align: center;
    color: #333;
    margin-bottom: 20px;
}

/* Form field styling */
.form-field {
    margin-bottom: 20px;
}

.form-field label {
    font-size: 14px;
    color: #555;
    margin-bottom: 5px;
    display: block;
}

.form-field input, .form-field textarea {
    width: 100%;
    padding: 10px;
    border: 1px solid #ccc;
    border-radius: 5px;
    font-size: 14px;
    color: #333;
}

.form-field input:focus, .form-field textarea:focus {
    border-color: #0056b3;
    outline: none;
}

/* Button container */
.button-container {
    display: flex;
    justify-content: center;
}

.btn {
    padding: 10px 20px;
    font-size: 14px;
    border: none;
    border-radius: 5px;
    cursor: pointer;
    transition: background-color 0.3s ease;
}

/* Submit button style */
.submit-button {
    background-color: #007bff;
    color: white;
}

.submit-button:hover {
    background-color: #0056b3;
}

/* For responsiveness */
@media (max-width: 600px) {
    .container {
        padding: 20px;
    }

    .button-container {
        flex-direction: column;
        gap: 10px;
    }

    .btn {
        width: 100%;
    }
}

/* Form field styling for textarea */
.form-field textarea {
    height: 70px; /* Set a default height, adjust as needed */
    resize: vertical; /* Allow vertical resizing only */
}

/* Focus styling for textarea */
.form-field textarea:focus {
    border-color: #0056b3;
    outline: none;
}

        
        
    </style>
    
    
    <script>
    
    
     function calculateDays() {
        var startDate = document.getElementById('leave-start-date').value;
        var endDate = document.getElementById('leave-end-date').value;

        if (startDate && endDate) {
            var start = new Date(startDate);
            var end = new Date(endDate);

            // Calculate difference in time (in milliseconds)
            var timeDiff = end - start;

            // Convert time difference from milliseconds to days
            var daysDiff = timeDiff / (1000 * 3600 * 24);

            // Ensure daysDiff is not negative
            if (daysDiff < 0) {
                alert("End Date must be after Start Date.");
                document.getElementById('leave-days').value = '';
            } else {
                // Display the number of leave days
                document.getElementById('leave-days').value = daysDiff + 1;  // Adding 1 to include both start and end dates
            }
        }
    }
     
    
     function redirectToHomePage() 
     {
         // Get the user's role from the session (retrieved via JSP)
         var role = '<%= role %>';  // This will contain either 'staff' or 'admin'

         // Redirect based on the user's role
         if (role === 'staff') 
         {
             window.location.href = 'staffhome.jsp';  // Redirect to staff home page
         } 
         else if (role === 'admin') 
         {
             window.location.href = 'adminhome.jsp';  // Redirect to admin home page
         }
         else if(role === 'student')
         {
         	 window.location.href = 'studenthome.jsp';  // Redirect to admin home page
         }
         else 
         {
             alert('Role not found or invalid. Please log in first.');
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
            <!--  <li><a href="studenthome.jsp">
                <i class="uil uil-estate"></i>
                <span class="link-name"> HOME PAGE</span>
            </a></li> -->
            
              <li><a href="javascript:void(0);" onclick="redirectToHomePage()">
    <i class="uil uil-estate"></i>
    <span class="link-name">HOME PAGE</span>
</a></li>
            
            
            <li><a href="attendance.jsp">
               <i class="uil uil-user"></i>
                <span class="link-name">ATTENDANCE</span>
            </a></li>
            <li><a href="staffviewattendance.jsp">
               <i class="uil uil-check-circle"></i>
                <span class="link-name">ATTENDANCE REPORT</span>
            </a></li>
            <!-- <li><a href="leaverequestform.jsp">
                <i class="uil uil-calendar-alt"></i>
                <span class="link-name">ONLINE TEST</span>
            </a></li> -->
            <li><a href="viewstudentleaveform.jsp">
                <i class="uil uil-clipboard-notes"></i>
                <span class="link-name">LEAVE REPORT </span>
            </a></li>
            <li><a href="#">
                 <i class="uil uil-file-alt"></i>
                <span class="link-name">RESUME</span>
            </a></li>
            <li><a href="#">
              <i class="uil uil-graduation-cap"></i>
                <span class="link-name">COURSE DETAILS</span>
            </a></li>
        </ul>
        
        <ul class="logout-mode">
            <li><a href="signup.html">
                <i class="uil uil-signout"></i>
                <span class="link-name">Logout</span>
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

       <!--  <div class="search-box">
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
                <i class="uil uil-tachometer-fast-alt"></i>
                <span class="text"><%= role.toUpperCase() %> LEAVE REQUEST FORM</span>
            </div>

          <!--   <div class="boxes">
                <div class="box box1">
                    <i class="uil uil-user"></i>
                    <span class="text">PROFILE</span>
                    <button type="submit" class="btn">Click</button>
                </div>

               <div class="box box2">
    <i class="uil uil-check-circle"></i>
    <span class="text">HOME PAGE</span>
    <button type="button" class="btn" onclick="window.location.href='studenthome.jsp'">Click</button>
</div>

                <div class="box box3">
                   <i class="uil uil-calendar-alt"></i>
                    <span class="text">LEAVE RECORDS</span>
                    <button type="submit" class="btn">Click</button>
                </div>
            </div> -->
            
            <br><br>
            
          <!--   <div class="boxes">
                <div class="box box1">
                    <i class="uil uil-clipboard-notes"></i>
                    <span class="text">ONLINE TEST</span>
                    <button type="submit" class="btn">Click</button>
                </div>
                <div class="box box2">
                   <i class="uil uil-file-alt"></i>
                    <span class="text">RESUME</span>
                    <button type="submit" class="btn">Click</button>
                </div>
                <div class="box box3">
                  <i class="uil uil-graduation-cap"></i>
                    <span class="text">COURSE DETAILS</span>
                    <button type="submit" class="btn">Click</button>
                </div>
            </div> -->
        </div>
    </div>
    
    
   <%--  <div class="container">
    <h2><%= username.toUpperCase() + " LEAVE REQUEST FORM" %></h2>

    <form method="POST" action="http://localhost:8080/OMS/AttendanceServlet">

        <div class="form-field">
            <label for="leave-start-date"><b>LEAVE START DATE</b></label>
            <input type="date" id="leave-start-date" name="leave-start-date" class="date-input"/>
        </div>

        <div class="form-field">
            <label for="leave-end-date"><b>LEAVE END DATE</b></label>
            <input type="date" id="leave-end-date" name="leave-end-date" class="date-input"/>
        </div>
        
         <div class="form-field">
            <label for="reason"><b>REASONS</b></label>
            <textarea id="reason" name="reason"></textarea>
        </div>
        

        <div class="button-container">
            <button type="submit" id="submit-button" name="submit" class="submit-button btn">Submit</button>
            <button type="button" id="checkin-button" name="checkin" class="checkin-button btn">Check In</button>
            <button type="button" id="checkout-button" name="checkout" class="checkout-button btn">Check Out</button>
        </div>
    </form>
</div> --%>

<div class="container">
    <h2><%= username.toUpperCase() + " LEAVE REQUEST FORM" %></h2>
    <div class="form-field">
        <label for="student-name"><b>STUDENT NAME</b></label>
        <input type="text" id="student-name" name="student-name" value="<%= session.getAttribute("username") %>" readonly/>
    </div>

    <form method="POST" action="saveleaveform.jsp">
        <div class="form-field">
            <label for="leave-start-date"><b>LEAVE START DATE</b></label>
            <input type="date" id="leave-start-date" name="leave-start-date" class="date-input" onchange="calculateDays()"/>
        </div>

        <div class="form-field">
            <label for="leave-end-date"><b>LEAVE END DATE</b></label>
            <input type="date" id="leave-end-date" name="leave-end-date" class="date-input" onchange="calculateDays()"/>
        </div>
        
        <div class="form-field">
            <label for="reason"><b>REASONS</b></label>
            <textarea id="reason" name="reason"></textarea>
        </div>

        <div class="form-field">
            <label for="leave-days"><b>NUMBER OF LEAVE DAYS</b></label>
            <input type="text" id="leave-days" name="leave-days" readonly/>
        </div>

        <!-- Hidden input for approval-status (auto-set to 'Pending') -->
        <input type="hidden" id="approval-status" name="approval-status" value="Pending"/>

        <div class="button-container">
            <button type="submit" id="submit-button" name="submit" class="submit-button btn">Submit</button>
        </div>
    </form>
</div>


    
</section>

<script src="studenthome.js"></script>

</body>
</html>
