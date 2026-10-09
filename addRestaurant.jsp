<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>

<!DOCTYPE html>
<html lang="en">

<head>

<meta charset="UTF-8">

<meta name="viewport" content="width=device-width, initial-scale=1.0">

<title>FoodGo | Add Restaurant</title>

<style>
* {
	margin: 0;
	padding: 0;
	box-sizing: border-box;
	font-family: Arial, sans-serif;
}

body {
	min-height: 100vh;
	background: linear-gradient(135deg, #fff3ed, #fff);
	display: flex;
	justify-content: center;
	align-items: center;
	padding: 30px;
}

.container {
	width: 600px;
	background: white;
	padding: 40px;
	border-radius: 20px;
	box-shadow: 0 10px 40px rgba(0, 0, 0, 0.1);
}

.title {
	text-align: center;
	margin-bottom: 30px;
}

.title h1 {
	color: #ff6b35;
	margin-bottom: 8px;
}

.title p {
	color: #777;
}

.form-group {
	margin-bottom: 20px;
}

label {
	display: block;
	font-weight: bold;
	margin-bottom: 8px;
}

input, select {
	width: 100%;
	padding: 13px;
	border: 1px solid #ddd;
	border-radius: 9px;
	outline: none;
	font-size: 15px;
}

input:focus, select:focus {
	border-color: #ff6b35;
}

.buttons {
	display: flex;
	gap: 12px;
	margin-top: 25px;
}

button, .back {
	flex: 1;
	padding: 13px;
	border-radius: 9px;
	font-size: 15px;
	text-align: center;
	text-decoration: none;
	cursor: pointer;
}

button {
	border: none;
	background: #ff6b35;
	color: white;
}

.back {
	background: #eee;
	color: #333;
}

.error { background: #ffe5e5; color: #d60000; padding: 12px; border-radius: 8px; margin-bottom: 20px; text-align: center; }
</style>

</head>

<body>

	<div class="container">

		<div class="title">

			<h1>🍽️ Add Restaurant</h1>

			<p>Add a new restaurant to FoodGo</p>

		</div>


		<c:if test="${not empty error}"><div class="error"><c:out value="${error}"/></div></c:if>
		<form action="${pageContext.request.contextPath}/restaurants/save"
			method="post">
			<input type="hidden" name="_csrf" value="${sessionScope.csrfToken}">


			<div class="form-group">

				<label>Restaurant Name</label> <input type="text" name="name" value="<c:out value='${restaurant.name}'/>"
					placeholder="Enter restaurant name" required>

			</div>


			<div class="form-group">

				<label>Location</label> <input type="text" name="location" value="<c:out value='${restaurant.location}'/>"
					placeholder="Enter location" required>

			</div>


			<div class="form-group">

				<label>Cuisine</label> <input type="text" name="cuisine" value="<c:out value='${restaurant.cuisine}'/>"
					placeholder="e.g. Indian, Chinese, Italian" required>

			</div>


			<div class="form-group">

				<label>Phone</label> <input type="text" name="phone" value="<c:out value='${restaurant.phone}'/>"
					placeholder="Enter restaurant phone">

			</div>


			<div class="form-group">

				<label>Image URL</label> <input type="text" name="image" value="<c:out value='${restaurant.image}'/>"
					placeholder="Paste image URL">

			</div>


			<div class="form-group">

				<label>Status</label> <select name="status">

					<option value="ACTIVE">Active</option>

					<option value="INACTIVE">Inactive</option>

				</select>

			</div>


			<div class="buttons">

				<a class="back"
					href="${pageContext.request.contextPath}/restaurants"> Back </a>

				<button type="submit">Save Restaurant</button>

			</div>

		</form>

	</div>

</body>

</html>