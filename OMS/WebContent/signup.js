// Form open/close behavior
const formOpenBtn = document.querySelector("#form-open"),
  home = document.querySelector(".home"),
  formContainer = document.querySelector(".form_container"),
  formCloseBtn = document.querySelector(".form_close"),
  signupBtn = document.querySelector("#signup"),
  loginBtn = document.querySelector("#login"),
  pwShowHide = document.querySelectorAll(".pw_hide");

formOpenBtn.addEventListener("click", () => home.classList.add("show"));
formCloseBtn.addEventListener("click", () => home.classList.remove("show"));

pwShowHide.forEach((icon) => {
  icon.addEventListener("click", () => {
    let getPwInput = icon.parentElement.querySelector("input");
    if (getPwInput.type === "password") {
      getPwInput.type = "text";
      icon.classList.replace("uil-eye-slash", "uil-eye");
    } else {
      getPwInput.type = "password";
      icon.classList.replace("uil-eye", "uil-eye-slash");
    }
  });
});

signupBtn.addEventListener("click", (e) => {
  e.preventDefault();
  formContainer.classList.add("active");
});
loginBtn.addEventListener("click", (e) => {
  e.preventDefault();
  formContainer.classList.remove("active");
});


document.getElementById('loginform').addEventListener('submit', function(event) {
    event.preventDefault(); // Prevent form submission

    // Get input values
    const username = document.getElementById('login-username').value.trim();
    const password = document.getElementById('login-password').value.trim();
    const role = document.getElementById('login-role-select').value; // Updated ID to access the select element

    // Initialize an array to hold error messages
    let errorMessages = [];

    // Check if username is empty
    if (username === "") {
        errorMessages.push("Username cannot be blank.");
    }

    // Check if password is empty
    if (password === "") {
        errorMessages.push("Password cannot be blank.");
    } else if (!validatePassword(password)) {
        errorMessages.push("Password must be at least 8 characters long and include one lowercase letter, one uppercase letter, one special character, and one number.");
    }

    // Check if role is selected
    if (role === "") {
        errorMessages.push("Please select a role.");
    }

    // Display error messages or submit the form
    if (errorMessages.length > 0) {
        alert(errorMessages.join("\n"));
    } else {
        // If all validations pass, you can submit the form or perform further actions
        this.submit(); // Uncomment this line to allow form submission
    }
    
});

// Function to validate password strength
function validatePassword(password) {
    const passwordPattern = /^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[@$!%*?&])[A-Za-z\d@$!%*?&]{8,}$/;
    return passwordPattern.test(password);
}







document.getElementById('signupform').addEventListener('submit', function(event) {
    event.preventDefault(); // Prevent form submission

    // Get input values
    const email = document.getElementById('signup-email').value.trim();
    const username = document.getElementById('signup-username').value.trim();  // Get username value
    const password = document.getElementById('signup-password').value.trim();
    const confirmPassword = document.getElementById('signup-confirmpassword').value.trim();
    const role = document.getElementById('signup-role-select').value;

    // Initialize an array to hold error messages
    let errorMessages = [];

    // Check if email is empty
    if (email === "") {
        errorMessages.push("Email cannot be blank.");
    } else if (!validateEmail(email)) {
        errorMessages.push("Please enter a valid email address (must include '@' and end with '.com').");
    }

    // Check if username is empty
    if (username === "") {
        errorMessages.push("Username cannot be blank.");
    }

    // Check if password is empty
    if (password === "") {
        errorMessages.push("Password cannot be blank.");
    } else if (!validatePassword(password)) {
        errorMessages.push("Password must be at least 8 characters long and include one lowercase letter, one uppercase letter, one special character, and one number.");
    }

    // Check if confirm password is empty or does not match
    if (confirmPassword === "") {
        errorMessages.push("Confirm password cannot be blank.");
    } else if (password !== confirmPassword) {
        errorMessages.push("Passwords do not match.");
    }

    // Check if role is selected
    if (role === "") {
        errorMessages.push("Please select a role.");
    }

    // Display error messages or submit the form
    if (errorMessages.length > 0) {
        alert(errorMessages.join("\n"));
    } else {
        // If all validations pass, you can submit the form or perform further actions
        this.submit(); // Uncomment this line to allow form submission
    }
});

// Function to validate email format
function validateEmail(email) {
    const emailPattern = /^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$/;
    return emailPattern.test(email);
}

// Function to validate password strength
function validatePassword(password) {
    const passwordPattern = /^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[@$!%*?&])[A-Za-z\d@$!%*?&]{8,}$/;
    return passwordPattern.test(password);
}

