<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>View page</title>

<style type="text/css">
table {
	font-family: arial, sans-serif;
	border: 2; border-collapse : collapse;
	width: 100%;
	border-collapse: collapse;
}

td, th {
	border: 1px solid #dddddd;
	text-align: left;
	padding: 8px;
}

tr:nth-child(even) {
	background-color: #dddddd;
}
</style>
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
<script>
	$(document).ready(
			function() {
				$("#myInput").on(
						"keyup",
						function() {
							var value = $(this).val().toLowerCase();
							$("#table tr").filter(
									function() {
										$(this).toggle(
												$(this).text().toLowerCase()
														.indexOf(value) > -1)
									});
						});
			});
</script>

</head>
<body>
	<input id="myInput" type="text" placeholder="Search..">
	<br>
	<br>
	<center>

		<table id="table" border="2">

			<tr>

				<th>id</th>

				<th>Place</th>

				<th>District</th>

				<th>State</th>

				<th>Country</th>

				<th>Lattitude</th>

				<th>Longitude</th>
				
				<th> Edit col</th>


			</tr>

			<c:forEach var="data" items="${data}">

				<tr class="success">

					<td>${data.id}</td>

					<td>${data.addr}</td>

					<td>${data.dis}</td>

					<td>${data.state}</td>

					<td>${data.cont}</td>

					<td>${data.lattitude}</td>

					<td>${data.longitude}</td>

					<td><a href ="/edit?id=${data.id}">Edit</a></td>
					
			</c:forEach>

			</tr>
		</table>
	</center>
</body>
</html>