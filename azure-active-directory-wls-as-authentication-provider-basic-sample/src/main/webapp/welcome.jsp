<html>

<head>
  <title>Integrate Azure Active Directofy with WebLogic Server Welcome Page</title>
</head>

<body>
  <h1> Secure WebLogic Server with Azure Active Directory</h1>
  <br>
  <p> Welcome <%= request.getRemoteUser() %></p>
  <%
  if(request.isUserInRole("webuser"))
  {
  %>
  <p>Your role is webuser.</p>
  <%
  }
  %>
</body>

</html>