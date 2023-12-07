<%@ page import="java.text.SimpleDateFormat" %>
<%@ page import="java.util.List" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="com.mongodb.client.MongoClients" %>
<%@ page import="com.mongodb.client.MongoClient" %>
<%@ page import="com.mongodb.client.MongoDatabase" %>
<%@ page import="com.mongodb.client.MongoCollection" %>
<%@ page import="org.bson.Document" %>

<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Employee Leave Records</title>
    <link rel="icon" type="image/x-icon" href="/images/favicon.ico">
    <style>
        body {
            font-family: Arial, sans-serif;
            margin: 0;
            padding: 0;
            background-image: url('images/background1.jpg'); /* Replace with your image path */
            background-size: cover;
            background-position: center;
        }

        .container {
            max-width: 80%;
            margin: 50px auto;
            background: rgba(255, 255, 255, 0.8); /* Semi-transparent white background */
            padding: 20px;
            border-radius: 5px;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
            text-align: center;
        }

        table {
            width: 100%;
            border-collapse: collapse;
            margin-top: 20px;
        }

        th, td {
            border: 1px solid #ddd;
            padding: 8px;
            text-align: left;
        }

        th {
            background-color: #4CAF50;
            color: white;
        }
        h2{
        	text-align:center;
        	
        }
    </style>
</head>
<body>

<%
    // Set up MongoDB connection
    MongoClient mongoClient = MongoClients.create("MongoDB connection URL");
    MongoDatabase database = mongoClient.getDatabase("LMS");
    MongoCollection<Document> leavesCollection = database.getCollection("leaves");

    // Fetch all documents from the "leaves" collection
    List<Document> leaves = new ArrayList<>();
    leavesCollection.find().iterator().forEachRemaining(leaves::add);
%>

<%
    SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
%>


<div class="container">
<h2>All Leave Records</h2>
<table border="1">
    <thead>
        <tr>
            <th>name</th>
            <th>Start Date</th>
            <th>End Date</th>
            <th>Reason</th>
            <th>Status</th>
            <th>Action</th>
        </tr>
    </thead>
    <tbody>
        <% for (Document leave : leaves) { %>
            <tr>
                <td><%= leave.getString("username") %></td>
                <td><%= dateFormat.format(leave.getDate("startDate")) %></td>
                <td><%= dateFormat.format(leave.getDate("endDate")) %></td>
                <td><%= leave.getString("reason") %></td>
                <td><%= leave.getString("status") %></td>
                <td>
                    <% if ("applied".equals(leave.getString("status"))) { %>
                        <form action="ApproveLeaveServlet" method="post">
                            <input type="hidden" name="leaveId" value="<%= leave.getObjectId("_id").toString() %>">
                            <input type="submit" value="Approve">
                        </form>
                    <% } else { %>
                        <!-- Display nothing for non-applied leaves -->
                    <% } %>
                </td>
            </tr>
        <% } %>
    </tbody>
</table>

</div>

<%
    // Close MongoDB connection
    mongoClient.close();
%>

</body>
</html>
