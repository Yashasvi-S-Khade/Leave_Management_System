<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Add Employee</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background-image: url('images/background1.jpg'); /* replace with your image path */
            background-size: cover;
            margin: 0;
            padding: 0;
            color: #fff; /* Set text color to white */
        }

        h1 {
            text-align: center;
            color: #000;
        }

        form {
            max-width: 400px;
            max-height : 800px;
            margin: 50px auto;
            background: rgba(255, 255, 255, 0.8); /* semi-transparent white background */
            padding: 20px;
            border-radius: 5px;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
        }

        label {
            display: block;
            margin-bottom: 8px;
            color: #333;
        }

        input {
            width: 100%;
            padding: 8px;
            margin-bottom: 15px;
            box-sizing: border-box;
            border: 1px solid #ccc;
            border-radius: 4px;
        }

        input[type="submit"] {
            background-color: #4caf50;
            color: #fff;
            cursor: pointer;
        }

        input[type="submit"]:hover {
            background-color: #45a049;
        }
    </style>
</head>
<body>

    

    <form action="AddEmployeeServlet" method="post">
    <h1>Add Employee</h1>

        <!-- Employee Name -->
        <label for="employeeName">Employee Name:</label>
        <input type="text" id="employeeName" name="employeeName" required><br>

        <!-- Date of Birth -->
        <label for="dob">Date of Birth:</label>
        <input type="date" id="dob" name="dob" required><br>

        <!-- Date of Joining -->
        <label for="doj">Date of Joining:</label>
        <input type="date" id="doj" name="doj" required><br>

        <!-- Position -->
        <label for="position">Position:</label>
        <input type="text" id="position" name="position" required><br>

        <!-- Salary per Month -->
        <label for="salary">Salary per Month:</label>
        <input type="number" id="salary" name="salary" required><br>

        <!-- Total Leaves Count -->
        <label for="leaves">Total Leaves Count:</label>
        <input type="number" id="leaves" name="leaves" required><br>

        <!-- Username -->
        <label for="username">Username:</label>
        <input type="text" id="username" name="username" required><br>

        <!-- Email -->
        <label for="email">Email:</label>
        <input type="email" id="email" name="email" required><br>

        <input type="submit" value="Add Employee">
    </form>

</body>
</html>
