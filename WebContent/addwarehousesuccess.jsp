<%@ page import="java.sql.*" %>
<%@ page import="java.text.NumberFormat" %>
<%@ page import="java.util.HashMap" %>
<%@ page import="java.util.Iterator" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="java.util.Map" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF8"%>
<!DOCTYPE html>
<html lang="en">

<head>
	<title>Add Warehouse Success</title>
	<meta charset="utf-8">
	<meta name="viewport" content="width=device-width, initial-scale=1">
	<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
	<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.1.1/jquery.min.js"></script>
	<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
	<link rel="stylesheet" type="text/css" href="stylesheet.css">
</head>

<body style="font-family: 'Lucida Sans Unicode', 'Lucida Grande', sans-serif;">
<%@include file="navbar.jsp" %>
<%@include file="auth.jsp" %>
<h1>Your warehouse has been added!</h1>
<h3>Click <a href="addremovewarehouse.jsp">here</a> to go back.</h3>

<%


			//Gather User information from request			
			String name = request.getParameter("warehousename");
			String phone = request.getParameter("number");


			FetchData data = new FetchData();
			//Try to connect to db
			try (Connection con = data.connect();){
				
				//Prepared statements to insert into Organ table
				String insertOrganSQL = ("INSERT INTO Warehouse (`WName`, `WPhone`) VALUES (?, ?);");
				PreparedStatement pst = con.prepareStatement(insertOrganSQL, Statement.RETURN_GENERATED_KEYS);
				pst.setString(1, name);
				pst.setString(2, phone);

			
				//Execute Query
				pst.executeUpdate();
				con.close();
			} catch (SQLException ex){
				System.out.println(ex);
			}

%>
<%@include file="footer.jsp" %>

</body>

</html>