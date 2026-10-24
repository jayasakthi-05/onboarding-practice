
<%
Dim username, message, requestMethod

requestMethod = Request.ServerVariables("REQUEST_METHOD")
%>

<!DOCTYPE html>
<html>
<head>
    <title>Feedback Form</title>
    <meta charset="UTF-8">
</head>
<body>

    <h1>Feedback Form</h1>

    <% If requestMethod = "POST" Then %>

        <h2>Feedback Submitted Successfully!</h2>

        <p>
            <strong>Name:</strong>
            <%= Server.HTMLEncode(Request.Form("username")) %>
        </p>

        <p>
            <strong>Message:</strong>
            <%= Server.HTMLEncode(Request.Form("message")) %>
        </p>

        <p>
            <strong>Server Time:</strong>
            <%= Now() %>
        </p>

        <hr>

    <% End If %>

    <form method="POST" action="feedback.asp">

        <label for="username">Your Name:</label><br>
        <input type="text" id="username" name="username" required>
        <br><br>

        <label for="message">Your Feedback:</label><br>
        <textarea id="message" name="message"
                  rows="5" cols="35" required></textarea>
        <br><br>

        <button type="submit">Submit Feedback</button>

    </form>

</body>
</html>