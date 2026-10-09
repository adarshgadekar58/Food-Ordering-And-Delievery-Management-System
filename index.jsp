<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<!DOCTYPE html>

<html>

<head>

<meta charset="UTF-8">

<meta name="viewport" content="width=device-width, initial-scale=1.0">

<title>FoodGo</title>

<style>
* {
	margin: 0;
	padding: 0;
	box-sizing: border-box;
	font-family: Arial, sans-serif;
}

body {
	min-height: 100vh;
	display: flex;
	justify-content: center;
	align-items: center;
	background: linear-gradient(135deg, #ff512f, #f09819);
}

.container {
	width: 500px;
	padding: 50px;
	text-align: center;
	background: rgba(255, 255, 255, 0.95);
	border-radius: 25px;
	box-shadow: 0 20px 60px rgba(0, 0, 0, 0.25);
}

h1 {
	font-size: 42px;
	color: #ff5722;
	margin-bottom: 15px;
}

p {
	color: #666;
	margin-bottom: 30px;
}

.btn {
	display: inline-block;
	padding: 13px 25px;
	margin: 5px;
	border-radius: 10px;
	text-decoration: none;
	font-weight: bold;
}

.login {
	background: #ff5722;
	color: white;
}

.register {
	border: 2px solid #ff5722;
	color: #ff5722;
}

.btn:hover {
	transform: translateY(-2px);
}
</style>

</head>

<body>

	<div class="container">

		<h1>🍔 FoodGo</h1>

		<p>Food Ordering & Delivery Management System</p>

		<a href="${pageContext.request.contextPath}/login" class="btn login">

			Login </a> <a href="${pageContext.request.contextPath}/register"
			class="btn register"> Register </a>

	</div>

</body>

</html>