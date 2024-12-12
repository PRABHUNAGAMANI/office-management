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
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title><%= role.toUpperCase() + " ATTENDANCE" %></title>

<style>
   /* General Body Styling */
body {
    font-family: Arial, sans-serif;
    background-image: url('CSS/attendance.jpg');
    background-size: cover;
    background-position: center;
    background-attachment: fixed;
    margin: 0;
    padding: 0;
    display: flex;
    justify-content: center;
    align-items: center;
    height: 100vh;
    color: #fff;
}

/* Main container to hold the form */
.container {
    width: 100%;
    max-width: 600px;
    background-color: rgba(255, 255, 255, 0.3);
    border-radius: 8px;
    box-shadow: 0px 4px 8px rgba(0, 0, 0, 0.3);
    padding: 30px;
    box-sizing: border-box;
    margin: 20px;
    display: flex;
    flex-direction: column;
    align-items: center;
    justify-content: center;
}

/* Heading Styling */
h2 {
    text-align: center;
    color: #333;
    margin-bottom: 20px;
    font-size: 28px;
}

/* Form Fields Wrapper */
.form-field {
    margin-bottom: 20px;
    width: 100%;
}

/* Label Styling */
.form-field label {
    display: block;
    font-size: 14px;
    color: #333;
    margin-bottom: 8px;
}

/* Styling for form inputs */
input[type="date"],
input[type="text"],
input[type="number"],
select {
    width: 100%;
    padding: 12px;
    font-size: 16px;
    border: 1px solid #ccc;
    border-radius: 6px;
    background-color: #f9f9f9;
    color: #333;
    box-sizing: border-box;
}

/* Time Input Section Styling */
.time-input {
    width: 100%;
    display: flex;
    justify-content: space-between;
    align-items: center;
    gap: 10px;
}

.time-input input,
.time-input select {
    width: 30%;
    padding: 8px;
    font-size: 16px;
    text-align: center;
}

/* Button Container Styling */
.button-container {
    display: flex;
    justify-content: space-between;
    width: 100%;
    gap: 10px;
}

/* Check-in and Check-out Buttons */
.checkin-button,
.checkout-button,
.submit-button {
    padding: 15px 25px;
    font-size: 16px;
    border: none;
    border-radius: 6px;
    cursor: pointer;
    transition: background-color 0.3s ease;
    width: 48%;
}

.checkin-button {
    background-color: #28a745;
    color: white;
}

.checkin-button:hover {
    background-color: #218838;
}


.submit-button {
    background-color: #28a745;
    color: white;
}

.submit-button:hover {
    background-color: #218838;
}


.checkout-button {
    background-color: #007bff;
    color: white;
}

.checkout-button:hover {
    background-color: #0056b3;
}

/* Disabled Button Style */
button:disabled {
    background-color: #d6d6d6;
    cursor: not-allowed;
}

/* Responsive Design */
@media (max-width: 768px) {
    .container {
        width: 90%;
        padding: 15px;
    }

    .button-container {
        flex-direction: column;
        align-items: center;
    }

    .checkin-button,
    .checkout-button {
        width: 100%;
        margin-bottom: 10px;
    }
}

</style>

    <!-- JavaScript for Time Calculation and AM/PM Handling -->
    <script>
        // Automatically set the date input to today's date
        window.onload = function() {
            const dateInput = document.getElementById('attendance-date');
            const today = new Date().toISOString().split('T')[0]; // Get current date in YYYY-MM-DD format
            dateInput.value = today; // Set the value of the input
        };

        let checkinTime = '';
        let checkoutTime = '';
        // Function to handle the Check-in button click
        function setCheckinTime() {
            var now = new Date();
            var hours = now.getHours();
            var minutes = now.getMinutes();
            var ampm = hours >= 12 ? 'PM' : 'AM';
            hours = hours % 12;
            hours = hours ? hours : 12; // the hour '0' should be '12'
            minutes = minutes < 10 ? '0' + minutes : minutes;
            var checkinTime = hours + ':' + minutes + ' ' + ampm;

            // Set check-in time in the input field
            document.getElementById('checkin_time').value = checkinTime;

            // Show the check-out button and hide the check-in button
            document.getElementById('checkout-button').style.display = 'inline-block';
            document.getElementById('checkin-button').style.display = 'none';
        }

        // Function to handle the Check-out button click
        function setCheckoutTime() {
            var now = new Date();
            var hours = now.getHours();
            var minutes = now.getMinutes();
            var ampm = hours >= 12 ? 'PM' : 'AM';
            hours = hours % 12;
            hours = hours ? hours : 12; // the hour '0' should be '12'
            minutes = minutes < 10 ? '0' + minutes : minutes;
            var checkoutTime = hours + ':' + minutes + ' ' + ampm;

            // Set check-out time in the input field
            document.getElementById('checkout_time').value = checkoutTime;

            // Calculate total hours worked
            calculateTotalHours();

            // Show the submit button and hide the check-out button
            document.getElementById('submit-button').style.display = 'inline-block';
            document.getElementById('checkout-button').style.display = 'none';
        }

        // Function to calculate the total hours worked between check-in and check-out
        function calculateTotalHours() {
            var checkinTime = document.getElementById('checkin_time').value;
            var checkoutTime = document.getElementById('checkout_time').value;

            // Convert the times to 24-hour format for easier calculation
            var checkinDate = convertTo24HourFormat(checkinTime);
            var checkoutDate = convertTo24HourFormat(checkoutTime);

            if (checkoutDate < checkinDate) {
                checkoutDate.setDate(checkoutDate.getDate() + 1); // assume checkout is on the next day
            }

            var difference = (checkoutDate - checkinDate) / 1000 / 60 / 60; // Difference in hours
            difference = difference.toFixed(2); // Round to two decimal places

            // Display total hours in the input field
            document.getElementById('total_hours').value = difference;
        }

        // Helper function to convert a time string to a Date object (24-hour format)
        function convertTo24HourFormat(time) {
            var [timePart, period] = time.split(' ');
            var [hours, minutes] = timePart.split(':');
            hours = parseInt(hours, 10);
            minutes = parseInt(minutes, 10);

            if (period === 'PM' && hours !== 12) hours += 12; // Convert PM hours
            if (period === 'AM' && hours === 12) hours = 0; // Convert AM 12 to 00

            var date = new Date();
            date.setHours(hours);
            date.setMinutes(minutes);
            date.setSeconds(0);
            date.setMilliseconds(0);

            return date;
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

    <div class="container">
        <h2><%= role.toUpperCase() + " ATTENDANCE" %></h2>

        <!-- Attendance form -->
        <form method="POST" action="http://localhost:8080/OMS/AttendanceServlet">
            <div class="form-field">
                <label for="attendance-date"><b>Current Date</b></label>
                <input type="date" id="attendance-date" name="attendance_date" class="date-input" readonly />
            </div>

            <div class="form-field">
                <label for="checkin_time"><b>Check-in Time</b></label>
                <input type="text" id="checkin_time" name="checkin_time" class="time-input" placeholder="hh:mm AM/PM" readonly />
            </div>

            <div class="form-field">
                <label for="checkout_time"><b>Check-out Time</b></label>
                <input type="text" id="checkout_time" name="checkout_time" class="time-input" placeholder="hh:mm AM/PM" readonly />
            </div>

            <div class="form-field">
                <label for="total_hours"><b>Total Hours</b></label>
                <input type="text" id="total_hours" name="total_hours" readonly />
            </div>

            <!-- Button Container -->
            <div class="button-container">
                <!-- Check In Button -->
                <button type="button" id="checkin-button" name="checkin" class="checkin-button btn" onclick="setCheckinTime()">Check In</button>

                <!-- Check Out Button -->
                <button type="button" id="checkout-button" name="checkout" class="checkout-button btn" onclick="setCheckoutTime()" style="display: none;">Check Out</button>
                
                <!-- Submit Button -->
                <button type="submit" id="submit-button" name="submit" class="submit-button btn" style="display: none;">Submit</button>
                
                 <button type="button" id="back" name="checkin" class="back btn" onclick="redirectToHomePage()">BACK </button>
                
            </div>
        </form>
    </div>



</body>
</html>

