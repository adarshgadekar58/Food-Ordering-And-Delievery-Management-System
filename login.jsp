<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>

<!DOCTYPE html>
<html lang="en">

<head>

<meta charset="UTF-8">

<meta name="viewport" content="width=device-width, initial-scale=1.0">

<title>FoodGo | Login</title>

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
	background: linear-gradient(135deg, #ff6b35, #ff9f1c);
}

.login-container {
	width: 400px;
	padding: 40px;
	background: rgba(255, 255, 255, 0.95);
	border-radius: 20px;
	box-shadow: 0 20px 50px rgba(0, 0, 0, 0.2);
}

.logo {
	text-align: center;
	font-size: 32px;
	font-weight: bold;
	color: #ff6b35;
	margin-bottom: 10px;
}

.subtitle {
	text-align: center;
	color: #777;
	margin-bottom: 30px;
}

.form-group {
	margin-bottom: 20px;
}

label {
	display: block;
	margin-bottom: 8px;
	font-weight: bold;
}

input {
	width: 100%;
	padding: 13px;
	border: 1px solid #ddd;
	border-radius: 10px;
	outline: none;
	font-size: 15px;
}

input:focus {
	border-color: #ff6b35;
}

.login-btn {
	width: 100%;
	padding: 14px;
	border: none;
	border-radius: 10px;
	background: #ff6b35;
	color: white;
	font-size: 16px;
	font-weight: bold;
	cursor: pointer;
}

.login-btn:hover {
	background: #e85a2a;
}

.error {
	background: #ffe5e5;
	color: #d60000;
	padding: 12px;
	border-radius: 8px;
	margin-bottom: 20px;
	text-align: center;
}

.register-link {
	text-align: center;
	margin-top: 20px;
}

.register-link a {
	color: #ff6b35;
	text-decoration: none;
	font-weight: bold;
}
</style>

</head>

<body>

	<div class="login-container">

		<div class="logo">🍔 FoodGo</div>

		<div class="subtitle">Login to your account</div>

		<c:if test="${not empty error}"><div class="error"><c:out value="${error}"/></div></c:if>

		<form action="${pageContext.request.contextPath}/login" method="post">
			<input type="hidden" name="_csrf" value="${sessionScope.csrfToken}">

			<div class="form-group">

				<label>Email</label> <input type="email" name="email"
					placeholder="Enter your email" required>

			</div>

			<div class="form-group">

				<label>Password</label> <input type="password" name="password"
					placeholder="Enter your password" required>

			</div>

			<button type="submit" class="login-btn">Login</button>

		</form>

		<div class="register-link">

			Don't have an account? <a
				href="${pageContext.request.contextPath}/register"> Register </a>

		</div>

	</div>

</body>

</html>