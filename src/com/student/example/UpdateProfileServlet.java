package com.student.example;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.mongodb.client.MongoClients;
import com.mongodb.client.MongoClient;
import com.mongodb.client.MongoDatabase;
import java.util.*;
import com.mongodb.client.MongoCollection;
import org.bson.Document;

@WebServlet("/UpdateProfileServlet")
public class UpdateProfileServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String connectionString = "MongoDB connection URL";
        String databaseName = "LMS";
        String collectionName = "employee";

        String username = request.getParameter("username");
        String salaryStr = request.getParameter("salary");
        String dob = request.getParameter("dob");
        String doj = request.getParameter("doj");
        String email = request.getParameter("email");
        String position = request.getParameter("position");
        PrintWriter out = response.getWriter();

        try (MongoClient mongoClient = MongoClients.create(connectionString)) {
            MongoDatabase database = mongoClient.getDatabase(databaseName);
            MongoCollection<Document> collection = database.getCollection(collectionName);

            // Find the document to update
            Document query = new Document("username", new Document("$regex", "^" + username + "$").append("$options", "i"));
            List<Document> users = collection.find(query).into(new ArrayList<>());

            for (Document user : users) {
                // Compare usernames
                String userUsername = user.getString("username");
                if (username.equals(userUsername)) {
                     user.put("dob", dob);
                     user.put("email", email);


                // Update the document in the collection
                collection.replaceOne(query, user);

                // Redirect back to the profile page with updated information
                out.println("<script>");
                out.println("alert('Data Updated successfully');");
                out.println("window.location.href='profile.jsp';");
                out.println("</script>");
                return;
            }
        }
            response.getWriter().println("User not found.");
        } catch (Exception e) {
            e.printStackTrace();
            // Handle exceptions as needed
        }
}
}
