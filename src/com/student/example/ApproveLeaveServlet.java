package com.student.example;

import com.mongodb.client.MongoClients;
import com.mongodb.client.MongoClient;
import com.mongodb.client.MongoDatabase;
import com.mongodb.client.MongoCollection;
import org.bson.Document;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import org.bson.types.ObjectId;

@WebServlet("/ApproveLeaveServlet")
public class ApproveLeaveServlet extends HttpServlet {
    /**
	 * 
	 */
	private static final long serialVersionUID = 1L;

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Retrieve leaveId from the form
        String leaveId = request.getParameter("leaveId");

        // Set up MongoDB connection
        try (MongoClient mongoClient = MongoClients.create("MongoDB connection URL")) {
            MongoDatabase database = mongoClient.getDatabase("LMS");
            MongoCollection<Document> leavesCollection = database.getCollection("leaves");

            // Update the status of the leave to "approved"
            leavesCollection.updateOne(new Document("_id", new ObjectId(leaveId)),
                    new Document("$set", new Document("status", "approved")));
        }

        // Redirect back to the employee records page after approval
        response.sendRedirect(request.getContextPath() + "/leaveRecordEmployee.jsp");
    }
}
