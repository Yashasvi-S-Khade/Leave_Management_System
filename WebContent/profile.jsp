profile.jsp



<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ page import="java.util.Date" %>
<%@ page import="com.mongodb.client.MongoClients" %>
<%@ page import="com.mongodb.client.MongoClient" %>
<%@ page import="com.mongodb.client.MongoDatabase" %>
<%@ page import="com.mongodb.client.MongoCollection" %>
<%@ page import="org.bson.Document" %>
<%@ page import="java.util.List" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="javax.servlet.http.HttpSession" %>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>User Profile</title>
    <link rel="icon" type="image/x-icon" href="/images/favicon.ico">
    <style type="text/css">
        body {
            font-family: Arial, sans-serif;
            margin: 0;
            padding: 0;
            background-image: url('images/background1.jpg'); /* Replace with your image path */
            background-size: cover;
            background-position: center;
            color: #fff;
        }

        .container {
            max-width: 400px;
            height: 550px;
            margin: 50px auto;
            background: rgba(255, 255, 255, 0.8); /* Semi-transparent white background */
            padding: 20px;
            border-radius: 5px;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
            text-align: center;
        }

        h1 {
            color: #333;
            text-align: center;
        }

        h3 {
            color: #333;
            text-align: left;
        }

        label {
            display: inline-block;
            margin-bottom: 8px;
            color: #333;
            width: 100px; /* Adjust the width as needed */
        }

        /* Add your specific styles for this page below this line */
       
        input, textarea {
            width: calc(100% - 120px); /* Adjust the width to leave space for labels */
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

        p {
            color: #000;
            text-align: left;
        }
    </style>
</head>
<body>
    <%@ include file="navbar.jsp" %>
    <div class="container">
        <h1>User Profile</h1>
        <%
            String connectionString = "MongoDB connection URL";
            String databaseName = "LMS";
            String collectionName = "employee";
            String username = (String) session.getAttribute("username");
            if (username == null) {
                response.sendRedirect(request.getContextPath() + "/index.jsp");
                return;
             }

            try (MongoClient mongoClient = MongoClients.create(connectionString)) {
                MongoDatabase database = mongoClient.getDatabase(databaseName);
                MongoCollection<Document> collection = database.getCollection(collectionName);

                Document query = new Document("username", username);
                List<Document> users = collection.find(query).into(new ArrayList<>());

                for (Document user : users) {
                    // Compare usernames
                    String userUsername = user.getString("username");
                    if (username.equals(userUsername)) {
                    String username1 =user.getString("username");
                    String name=user.getString("name");
                    String email=user.getString("email");
                    String pos=user.getString("position");
                    String doj=user.getString("doj");
                    String dob=user.getString("dob");
                    Double sal=user.getDouble("salary");

                    // Use Number class to handle both Integer and Long values
                         Number leavesNumber = (Number) user.get("leaves");
                         long leaves = leavesNumber.longValue();
                    request.setAttribute("employeeName", name);
                    request.setAttribute("username", username1);
                    request.setAttribute("salary", sal);
                    request.setAttribute("dob", dob);
                        request.setAttribute("doj", doj);
                        request.setAttribute("email", email);
                        request.setAttribute("position", pos);
                        request.setAttribute("leaves", leaves);

                        // Break the loop once a match is found
                        break;
                    }
                }
            } catch (Exception e) {
                e.printStackTrace();
                // Handle exceptions as needed
            }
        %>

        <!-- Display user profile information -->
        <h3>Profile Information:</h3>
        <form action="UpdateProfileServlet" method="post">
        <input type="hidden" name="username" value="<%= session.getAttribute("username") %>"><p>Username: <%= session.getAttribute("username") %></p>
            <p>Name: <%= request.getAttribute("employeeName") %></p>
            <p>Leaves Remaining: <%= request.getAttribute("leaves") %></p>
            <p>Salary: <%= request.getAttribute("salary") %></p>
            <p>Date of Joining: <%= request.getAttribute("doj") %></p>
            <p>Position: <%= request.getAttribute("position") %></p>
            <label for="dob">Date of Birth:</label>
            <input type="text" id="dob" name="dob" value="<%= request.getAttribute("dob") %>" required><br>
           
            <label for="email">Email:</label>
            <input type="text" id="email" name="email" value="<%= request.getAttribute("email") %>" required><br>
           
            <input type="submit" value="Update">
        </form>
    </div>
</body>
</html>