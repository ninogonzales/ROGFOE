<%@ page import="java.sql.*" %>
<%@ page import="java.text.NumberFormat" %>
<%@ page import="java.util.HashMap" %>
<%@ page import="java.util.Iterator" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="java.util.Map" %>
<%@page import="dbTransactions.FetchData"%> 
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF8"%>
<!DOCTYPE html>
<html lang="en">

<head>
	<title>Profile</title>
	<meta charset="utf-8">
	<meta name="viewport" content="width=device-width, initial-scale=1">
	<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
	<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.1.1/jquery.min.js"></script>
	<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
	<link rel="stylesheet" type="text/css" href="stylesheet.css">
</head>

<body>

<%@include file="navbar.jsp" %>

<div class="container text-center">
  <div class="row content">
   <div class="col-sm-2">
   </div>
    <div class="col-sm-8 text-left" style="text-align:center">
      <h1 style="font-family: 'Lucida Sans Unicode', 'Lucida Grande', sans-serif;">Profile Saved!</h1><p>&nbsp;</p>
      <p>&nbsp;</p>
          
<% 
	
FetchData data = new FetchData();
//Try to connect to db
try (Connection con = data.connect();){
	PreparedStatement pst;
		
	//Gather User information from request	
	String fname = request.getParameter("fname");
	String mname = request.getParameter("mname");
	String lname = request.getParameter("lname");
	String street = request.getParameter("street");
	String city = request.getParameter("city");
	String country = request.getParameter("country");
	String state = request.getParameter("state");
	String postal = request.getParameter("postal");
	String hphone = request.getParameter("hphone");
	String wphone = request.getParameter("wphone");
	String cphone = request.getParameter("cphone");
	String email = request.getParameter("email");
	String pw = request.getParameter("pw");

	//Try to connect to db
	//Prepared statements to insert into User table
	String insertUserSQL = ("INSERT INTO User (AccType, fName, mName, lName, UphoneH, UphoneC, UphoneW, Uemail, Password) VALUES ('Customer', ?, ?, ?, ?, ?, ?, ?, ?);");
	pst = con.prepareStatement(insertUserSQL,Statement.RETURN_GENERATED_KEYS);
	pst.setString(1, fname);
	pst.setString(2, mname);
	pst.setString(3, lname);
	pst.setString(4, hphone);
	pst.setString(5, cphone);
	pst.setString(6, wphone);
	pst.setString(7, email);
	pst.setString(8, pw);

	//Execute Query
	pst.executeUpdate();
	
	//Get UID of user that was just inserted to be used in Address insert
	ResultSet keys = pst.getGeneratedKeys();
	keys.next();
	int createdUID = keys.getInt(1);
	
	//Prepared statements to insert into Address table
	String insertAddressSQL = ("INSERT INTO Address (UID, AddressType, Street, City, State, Country, PostalCode) VALUES (?, 'Home', ?, ?, ?, ?, ?);");
	pst = con.prepareStatement(insertAddressSQL);
	pst.setInt(1, createdUID);
	pst.setString(2, street);
	pst.setString(3, city);
	pst.setString(4, state);
	pst.setString(5, country);
	pst.setString(6, postal);
	
	//Execute
	pst.executeUpdate();
} catch (SQLException ex) {
	System.out.println(ex);
}

%>
      <hr>
      
    </div>
	<div class="col-sm-2">
   </div>
  </div>
</div>


<%@include file="footer.jsp" %>

</body>

</html>