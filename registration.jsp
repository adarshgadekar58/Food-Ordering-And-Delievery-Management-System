<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>

<!DOCTYPE html>

<html>

<head>

<meta charset="UTF-8">

<meta name="viewport" content="width=device-width, initial-scale=1.0">

<title>FoodGo | Create Account</title>


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
	padding: 20px;
	background: linear-gradient(135deg, #ff512f, #f09819);
}

.container {
	width: 430px;
	padding: 40px;
	background: rgba(255, 255, 255, 0.96);
	border-radius: 22px;
	box-shadow: 0 20px 60px rgba(0, 0, 0, 0.25);
}

.logo {
	width: 65px;
	height: 65px;
	margin: 0 auto 15px;
	display: flex;
	justify-content: center;
	align-items: center;
	border-radius: 50%;
	background: #ff5722;
	color: white;
	font-size: 25px;
	font-weight: bold;
}

h1 {
	text-align: center;
	color: #222;
	margin-bottom: 8px;
}

.subtitle {
	text-align: center;
	color: #777;
	font-size: 14px;
	margin-bottom: 28px;
}

.error {
	background: #ffe6e6;
	color: #c62828;
	padding: 12px;
	border-radius: 8px;
	margin-bottom: 18px;
	text-align: center;
	font-size: 14px;
}

.form-group {
	margin-bottom: 18px;
}

label {
	display: block;
	margin-bottom: 7px;
	color: #333;
	font-size: 14px;
	font-weight: bold;
}

input {
	width: 100%;
	padding: 13px 15px;
	border: 1px solid #ddd;
	border-radius: 10px;
	outline: none;
	font-size: 15px;
}

input:focus {
	border-color: #ff5722;
	box-shadow: 0 0 0 3px rgba(255, 87, 34, 0.12);
}

.register-btn {
	width: 100%;
	padding: 14px;
	border: none;
	border-radius: 10px;
	background: #ff5722;
	color: white;
	font-size: 16px;
	font-weight: bold;
	cursor: pointer;
}

.register-btn:hover {
	background: #e64a19;
}

.login-link {
	text-align: center;
	margin-top: 22px;
	color: #777;
	font-size: 14px;
}

.login-link a {
	color: #ff5722;
	text-decoration: none;
	font-weight: bold;
}
</style>

</head>


<body>


	<div class="container">


		<div class="logo">F</div>


		<h1>Create Account</h1>


		<p class="subtitle">Join FoodGo and order your favourite food</p>


		<!-- ERROR -->

		<c:if test="${not empty error}"><div class="error"><c:out value="${error}"/></div></c:if>


		<!-- REGISTRATION FORM -->

		<form action="${pageContext.request.contextPath}/register"
			method="post">
			<input type="hidden" name="_csrf" value="${sessionScope.csrfToken}">


			<!-- NAME -->

			<div class="form-group">

				<label for="name"> Full Name </label> <input type="text" id="name"
					name="name" value="<c:out value='${user.name}'/>" placeholder="Enter your full name" required>

			</div>


			<!-- EMAIL -->

			<div class="form-group">

				<label for="email"> Email Address </label> <input type="email"
					id="email" name="email" value="<c:out value='${user.email}'/>" placeholder="Enter your email" required>

			</div>


			<!-- PASSWORD -->

			<div class="form-group">

				<label for="password"> Password </label> <input type="password"
					id="password" name="password" placeholder="Create a password"
					minlength="8" maxlength="72" required>

			</div>


			<!-- PHONE -->

			<div class="form-group">

				<label for="phone"> Phone Number </label> <input type="tel"
					id="phone" name="phone" value="<c:out value='${user.phone}'/>" placeholder="Enter 10 digit phone number"
					pattern="[0-9]{10}" maxlength="10" required>

			</div>


			<!-- SUBMIT -->

			<button type="submit" class="register-btn">Create Account</button>


		</form>


		<!-- LOGIN -->

		<div class="login-link">

			Already have an account? <a
				href="${pageContext.request.contextPath}/login"> Login </a>

		</div>


	</div>


</body>

</html>