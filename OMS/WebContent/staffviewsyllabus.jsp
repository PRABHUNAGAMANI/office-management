<%@ page import="javax.servlet.http.HttpSession" %>
<%@ page import="java.sql.*, javax.servlet.http.*, javax.servlet.ServletException, java.io.IOException" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
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
    

    // Database connection and data retrieval
    Connection con = null;
    PreparedStatement ps = null;
    ResultSet rs = null;
    
    try {
        Class.forName("com.mysql.cj.jdbc.Driver");
        con = DriverManager.getConnection("jdbc:mysql://localhost:3306/oms", "root", "PRAbhu@mysql");
        ps = con.prepareStatement("SELECT * FROM syllabus_upload");
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

   <title><%= role.toUpperCase() + " DASHBOARD PANEL" %></title>


    
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
        
        /* Backdrop to cover the entire screen */
    #pendingModal {
        position: fixed;
        top: 0;
        left: 0;
        width: 100%;
        height: 100%;
        background: rgba(0, 0, 0, 0.5); /* Semi-transparent background */
        display: flex;
        justify-content: center;
        align-items: center;
        z-index: 9999;
    }

    /* Modal content styling */
    .modal-content {
        background: white;
        padding: 20px;
        width: 400px;
        border-radius: 8px;
        box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
        text-align: center;
        display: flex;
        flex-direction: column;
        gap: 15px;
    }

    /* Title styling */
    .modal-content h2 {
        font-size: 18px;
        color: #333;
    }

    /* Textarea styling */
    #reasonText {
        width: 100%;
        height: 100px;
        padding: 10px;
        font-size: 14px;
        border: 1px solid #ccc;
        border-radius: 5px;
        resize: vertical;
        margin-bottom: 15px;
    }

    /* Button styling */
    .modal-content button {
        padding: 10px 20px;
        font-size: 16px;
        border: none;
        border-radius: 5px;
        cursor: pointer;
        background-color: #4CAF50;
        color: white;
        margin: 5px 0;
    }

    /* Cancel button with different color */
    .modal-content button:nth-child(2) {
        background-color: #f44336;
    }

    /* Hover effect for buttons */
    .modal-content button:hover {
        background-color: #45a049;
    }

    .modal-content button:nth-child(2):hover {
        background-color: #e53935;
    }
        
        
        
          .button-container button {
            padding: 10px 20px;
            border: none;
            cursor: pointer;
            border-radius: 5px;
            font-size: 16px;
            transition: all 0.3s ease;
        }

        .complete-btn {
            background-color: #4CAF50;
            color: white;
        }

        .complete-btn:hover {
            background-color: #f39c12;
        }

        .pending-btn {
           /*  background-color: #f1c40f; */
              background-color: red;
            color: white;
        }

        .pending-btn:hover {
            background-color: #f39c12;
        }
        
    </style>
    
   

<script>
  /*   function approveLeave(requestId) {
        var xhr = new XMLHttpRequest();
        xhr.open("POST", "staffapprovalstudent.jsp", true);
        xhr.setRequestHeader("Content-Type", "application/x-www-form-urlencoded");
        xhr.onreadystatechange = function() {
            if (xhr.readyState == 4 && xhr.status == 200) {
                // If the approval is successful, update the status in the table
                if (xhr.responseText.trim() === "success") {
                    document.getElementById("status-" + requestId).innerText = "Granted";  // Change the status in the table
                } else {
                    alert("Error in approval.");
                }
            }
        };
        xhr.send("requestId=" + requestId);  // Send the request ID to the server for approval
    } */
    
    function filterTable() {
        // Get the search input value
        var searchInput = document.getElementById('searchInput').value.toLowerCase(); // Convert to lowercase for case-insensitive comparison

        // Get the table
        var table = document.querySelector('table');
        
        // Get all table rows
        var rows = table.getElementsByTagName('tr');
        
        // Loop through all rows, and hide the ones that don't match the search query
        for (var i = 1; i < rows.length; i++) {  // Start from 1 to skip the table header row
            var row = rows[i];
            var cells = row.getElementsByTagName('td');
            var username = cells[1].textContent.trim().toLowerCase();  // Assuming username is in the 2nd column (index 1)
            var approvalStatus = cells[6].textContent.trim().toLowerCase();  // Assuming approval status is in the 7th column (index 6)

            // Check if either username or approval status matches the search input
            if (username.indexOf(searchInput) > -1 || approvalStatus.indexOf(searchInput) > -1) {
                row.style.display = '';  // Show the row if there's a match
            } else {
                row.style.display = 'none';  // Hide the row if no match
            }
        }
    }

    
    function updateStatus(id, status) {
        var xhr = new XMLHttpRequest();
        xhr.open("POST", "updateStatus.jsp", true);
        xhr.setRequestHeader("Content-Type", "application/x-www-form-urlencoded");
        xhr.onreadystatechange = function() {
            if (xhr.readyState == 4 && xhr.status == 200) {
                if (xhr.responseText.trim() === "success") {
                    document.getElementById("status-" + id).innerText = status.charAt(0).toUpperCase() + status.slice(1);  // Change status text
                } else {
                    alert("Error in updating status.");
                }
            }
        };
        xhr.send("id=" + id + "&status=" + status);  // Send the request ID and the new status
    }

  
    
    
 // Modify the showPendingModal function
   /*  function showPendingModal(id) {
        // Show the modal and store the ID for the pending action
        document.getElementById('pendingModal').style.display = 'block';
        document.getElementById('pendingModal').setAttribute('data-id', id);

        // Disable the buttons in the table after opening the modal
        disableButtons(id);
    } */
    
   /*  function showPendingModal(id) {
        // Show the modal and store the ID for the pending action
        document.getElementById('pendingModal').style.display = 'block';
        document.getElementById('pendingModal').setAttribute('data-id', id);

        // Disable the buttons in the table after opening the modal
        disableButtons(id);
    } */
    
 // Function to show the modal and store the ID for the pending action
    function showPendingModal(id) {
        // Show the modal and store the ID for the pending action
        document.getElementById('pendingModal').style.display = 'block';
        document.getElementById('pendingModal').setAttribute('data-id', id);

        // Disable the buttons in the table after opening the modal
        disableButtons(id);
    }

    /* function closePendingModal() {
        // Close the modal
        document.getElementById('pendingModal').style.display = 'none';
    } */
    
 // Close the modal when the Cancel button is clicked
  /*   function closePendingModal() {
        document.getElementById('pendingModal').style.display = 'none';
    } */
    
 // Function to close the Pending Modal
   /*  function closePendingModal() {
        // Close the modal
        document.getElementById('pendingModal').style.display = 'none';
        // No need to re-enable buttons here as they are disabled already
    } */
    
 // Function to close the modal when Cancel button is clicked
    function closePendingModal() {
        document.getElementById('pendingModal').style.display = 'none';
        
        // Get the ID from the modal data attribute
        var id = document.getElementById('pendingModal').getAttribute('data-id');
        
        // Re-enable the "Complete" and "Pending" buttons when Cancel is clicked
        enableButtons(id);
    }
    
    
 // Function to disable both "Complete" and "Pending" buttons for a given row
   /*  function disableButtons(id) {
        var completeButton = document.getElementById('complete-button-' + id);
        var pendingButton = document.getElementById('pending-button-' + id);
        
        if (completeButton) {
            completeButton.disabled = true;
        }
        if (pendingButton) {
            pendingButton.disabled = true;
        }
    } */
    
 // Function to disable both "Complete" and "Pending" buttons for a given row
    /* function disableButtons(id) {
        var completeButton = document.getElementById('complete-button-' + id);
        var pendingButton = document.getElementById('pending-button-' + id);
        
        if (completeButton) {
            completeButton.disabled = true;
        }
        if (pendingButton) {
            pendingButton.disabled = true;
        }
    } */
    
    function disableButtons(id) {
        var completeButton = document.getElementById('complete-button-' + id);
        var pendingButton = document.getElementById('pending-button-' + id);
        
        if (completeButton) {
            completeButton.disabled = true;
        }
        if (pendingButton) {
            pendingButton.disabled = true;
        }
    }

   /*  function submitPendingReason() {
        var reason = document.getElementById('reasonText').value;
        var id = document.getElementById('pendingModal').getAttribute('data-id');
        
        var xhr = new XMLHttpRequest();
        xhr.open("POST", "updateStatus.jsp", true);
        xhr.setRequestHeader("Content-Type", "application/x-www-form-urlencoded");
        xhr.onreadystatechange = function() {
            if (xhr.readyState == 4 && xhr.status == 200) {
                if (xhr.responseText.trim() === "success") {
                    document.getElementById("status-" + id).innerText = "Pending";  // Update status in table
                    closePendingModal();
                } else {
                    alert("Error in updating status to Pending.");
                }
            }
        };
        xhr.send("id=" + id + "&status=pending&reason=" + encodeURIComponent(reason));  // Send the reason along with the status
    } */

 // The submitPendingReason function will update the status to "Pending" and close the modal
   /*  function submitPendingReason() {
        var reason = document.getElementById('reasonText').value;
        var id = document.getElementById('pendingModal').getAttribute('data-id');
        
        var xhr = new XMLHttpRequest();
        xhr.open("POST", "updateStatus.jsp", true);
        xhr.setRequestHeader("Content-Type", "application/x-www-form-urlencoded");
        xhr.onreadystatechange = function() {
            if (xhr.readyState == 4 && xhr.status == 200) {
                if (xhr.responseText.trim() === "success") {
                    document.getElementById("status-" + id).innerText = "Pending";  // Update status in table
                    closePendingModal();
                    disableButtons(id);  // Disable buttons after pending
                } else {
                    alert("Error in updating status to Pending.");
                }
            }
        };
        xhr.send("id=" + id + "&status=pending&reason=" + encodeURIComponent(reason));  // Send the reason along with the status
    }
     */
     
  // The submitPendingReason function will update the status to "Pending" and close the modal
   /*   function submitPendingReason() {
         var reason = document.getElementById('reasonText').value;
         var id = document.getElementById('pendingModal').getAttribute('data-id');
         
         var xhr = new XMLHttpRequest();
         xhr.open("POST", "updateStatus.jsp", true);
         xhr.setRequestHeader("Content-Type", "application/x-www-form-urlencoded");
         xhr.onreadystatechange = function() {
             if (xhr.readyState == 4 && xhr.status == 200) {
                 if (xhr.responseText.trim() === "success") {
                     document.getElementById("status-" + id).innerText = "Pending";  // Update status in table
                     closePendingModal();
                     disableButtons(id);  // Disable buttons after pending
                 } else {
                     alert("Error in updating status to Pending.");
                 }
             }
         };
         xhr.send("id=" + id + "&status=pending&reason=" + encodeURIComponent(reason));  // Send the reason along with the status
     } */
     
     
  // The submitPendingReason function will update the status to "Pending" and close the modal
     function submitPendingReason() {
         var reason = document.getElementById('reasonText').value;
         var id = document.getElementById('pendingModal').getAttribute('data-id');
         
         var xhr = new XMLHttpRequest();
         xhr.open("POST", "updateStatus.jsp", true);
         xhr.setRequestHeader("Content-Type", "application/x-www-form-urlencoded");
         xhr.onreadystatechange = function() {
             if (xhr.readyState == 4 && xhr.status == 200) {
                 if (xhr.responseText.trim() === "success") {
                     document.getElementById("status-" + id).innerText = "Pending";  // Update status in table
                     closePendingModal();
                     disableButtons(id);  // Disable buttons after pending
                 } else {
                     alert("Error in updating status to Pending.");
                 }
             }
         };
         xhr.send("id=" + id + "&status=pending&reason=" + encodeURIComponent(reason));  // Send the reason along with the status
     }
     
     
  // Function to enable both "Complete" and "Pending" buttons for a given row
     function enableButtons(id) {
         var completeButton = document.getElementById('complete-button-' + id);
         var pendingButton = document.getElementById('pending-button-' + id);
         
         if (completeButton) {
             completeButton.disabled = false;
         }
         if (pendingButton) {
             pendingButton.disabled = false;
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
            <li><a href="staffhome.jsp">
                <i class="uil uil-estate"></i>
                <span class="link-name"> HOME PAGE </span>
            </a></li>
            <li><a href="#">
               <i class="uil uil-user"></i>
                <span class="link-name">PROFILE</span>
            </a></li>
            <li><a href="attendance.jsp">
               <i class="uil uil-check-circle"></i>
                <span class="link-name">ATTENDANCE</span>
            </a></li>
            <li><a href="staffattendance.jsp">
                <i class="uil uil-calendar-alt"></i>
                <span class="link-name">ATTENDANCE REPORT</span>
            </a></li>
            <li><a href="staffleaverequestform.jsp">
                <i class="uil uil-clipboard-notes"></i>
                <span class="link-name"> LEAVE REQUEST </span>
            </a></li>
            <li><a href="viewstaffleaveform.jsp">
                 <i class="uil uil-file-alt"></i>
                <span class="link-name">LEAVE REPORT</span>
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
    <input type="text" id="searchInput" placeholder="Search by Attendance" />
    <button class="search-btn" type="button" onclick="filterTable()">Search</button>
</div> -->

 <div class="search-box">
    <i class="uil uil-search"></i>
    <input type="text" id="searchInput" placeholder="Search by username or approval status" onkeyup="filterTable()" />
    <button class="search-btn" type="button" onclick="filterTable()">Search</button>
</div>




        
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
                <span class="text">STUDENTS LEAVE REPORT</span>
            </div> 
 
        
        </div>
    </div>
    
    
   <!--   <h2>STUDENTS LEAVE REPORT</h2> -->
<%-- <table>
    <thead>
        <tr>
            <th>ID</th>
            <th>ADMIN NAME</th>
            <th>UPLOAD DATE</th>
            <th>FINAL DATE</th>
            <th>TOPIC</th>
            <th>SYLLABUS </th>
            <th> STATUS</th>
          
        </tr>
    </thead>
    <tbody>
        <%
            // Fetch and display data from the database in table rows
            while (rs.next()) {
                String id = rs.getString(1);
                String adminname = rs.getString(2);
                String uploaddate = rs.getString(3);
                String finaldate = rs.getString(4);
                String topic = rs.getString(5);
                String syllabus = rs.getString(6);
                String status = rs.getString(7);
        %>
        <tr>
            <td><%= id %></td>
            <td><%= adminname %></td>
            <td><%= uploaddate %></td>
            <td><%= finaldate %></td>
            <td><%= topic %></td>
            <td><%= syllabus %></td>
            <td><%= status %></td>
         
          
        </tr>
        <%
            }
        %>
    </tbody>
</table> --%>


<table>
    <thead>
        <tr>
            <th>ID</th>
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
            // Fetch and display data from the database in table rows
            while (rs.next()) {
                String id = rs.getString(1);
                String adminname = rs.getString(2);
                String uploaddate = rs.getString(3);
                String finaldate = rs.getString(4);
                String topic = rs.getString(5);
                String syllabus = rs.getString(6);
                String status = rs.getString(7);
                String reason = rs.getString(8); // Retrieve the reason (if any)
        %>
        <tr>
            <td><%= id %></td>
            <td><%= adminname %></td>
            <td><%= uploaddate %></td>
            <td><%= finaldate %></td>
            <td><%= topic %></td>
            <td><%= syllabus %></td>
            <td id="status-<%= id %>"><%= status %></td>
           <%--  <td>
                <button onclick="updateStatus('<%= id %>', 'completed')">Complete</button>
                <button onclick="showPendingModal('<%= id %>')">Pending</button>
            </td> --%>
            
            <td>
   <%--  <button id="complete-button-<%= id %>" onclick="updateStatus('<%= id %>', 'completed')">Complete</button>
    <button id="pending-button-<%= id %>" onclick="showPendingModal('<%= id %>')">Pending</button> --%>
    
     <div class="button-container">
                        <button id="complete-button-<%= id %>" class="complete-btn" onclick="updateStatus('<%= id %>', 'completed')">Complete</button>
                        <button id="pending-button-<%= id %>" class="pending-btn" onclick="showPendingModal('<%= id %>')">Pending</button>
                    </div>
</td>
            
            
        </tr>
        <%
            }
        %>
    </tbody>
</table>

<!-- Modal for reason input when "Pending" is clicked -->
<div id="pendingModal" style="display:none;">
    <div class="modal-content">
        <h2>Enter Reason for Pending</h2>
        <textarea id="reasonText" placeholder="Please enter the reason here..."></textarea><br>
        <button onclick="submitPendingReason()">Submit</button>
        <button onclick="closePendingModal()">Cancel</button>
    </div>
</div>

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
