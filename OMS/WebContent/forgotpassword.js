document.getElementById('forgotform').addEventListener('submit', function(event) {
    // Prevent the form from submitting if there are validation errors
    event.preventDefault();

    // Get values from form fields
    var username = document.getElementById('forgot-username').value.trim();
    var password = document.getElementById('forgot-password').value.trim();
    var confirmPassword = document.getElementById('forgot-confirmpassword').value.trim();
    var role = document.getElementById('forgot-role-select').value;

    // Check if any field is empty
    if (username === "") {
        alert("Username is required!");
        return;
    }

    if (password === "") {
        alert("Password is required!");
        return;
    }

    if (confirmPassword === "") {
        alert("Please confirm your password!");
        return;
    }

    if (role === "") {
        alert("Please select a role!");
        return;
    }

    // Check if password meets complexity requirements
    var passwordPattern = /^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[@$!%*?&])[A-Za-z\d@$!%*?&]{8,}$/;
    if (!passwordPattern.test(password)) {
        alert("Password must be at least 8 characters long, include one uppercase letter, one lowercase letter, one number, and one special character.");
        return;
    }

    // Check if password and confirm password match
    if (password !== confirmPassword) {
        alert("Passwords do not match!");
        return;
    }

    // If all validation checks pass, submit the form
    this.submit();
});
