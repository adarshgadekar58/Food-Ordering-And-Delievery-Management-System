<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>

<!DOCTYPE html>
<html lang="en">

<head>

<meta charset="UTF-8">

<meta name="viewport" content="width=device-width, initial-scale=1.0">

<title>FoodGo | Dashboard</title>

<style>
* {
	margin: 0;
	padding: 0;
	box-sizing: border-box;
	font-family: Arial, sans-serif;
}

body {
	background: #f5f6fa;
}

/* Navbar */
.navbar {
	height: 70px;
	background: white;
	display: flex;
	justify-content: space-between;
	align-items: center;
	padding: 0 50px;
	box-shadow: 0 3px 15px rgba(0, 0, 0, 0.08);
}

.logo {
	font-size: 28px;
	font-weight: bold;
	color: #ff6b35;
}

.logout {
	text-decoration: none;
	background: #ff6b35;
	color: white;
	padding: 10px 20px;
	border-radius: 8px;
}

/* Main */
.container {
	padding: 50px;
}

.welcome {
	background: linear-gradient(135deg, #ff6b35, #ff9f1c);
	color: white;
	padding: 40px;
	border-radius: 20px;
	margin-bottom: 40px;
}

.welcome h1 {
	font-size: 35px;
	margin-bottom: 10px;
}

.welcome p {
	font-size: 18px;
}

/* Cards */
.cards {
	display: grid;
	grid-template-columns: repeat(auto-fit, minmax(220px, 1fr));
	gap: 25px;
}

.card {
	background: white;
	padding: 30px;
	border-radius: 18px;
	text-align: center;
	box-shadow: 0 5px 20px rgba(0, 0, 0, 0.08);
	transition: 0.3s;
}

.card:hover {
	transform: translateY(-8px);
}

.icon {
	font-size: 45px;
	margin-bottom: 15px;
}

.card h3 {
	margin-bottom: 10px;
}

.card p {
	color: #777;
	margin-bottom: 20px;
}

.card a {
	text-decoration: none;
	display: inline-block;
	background: #ff6b35;
	color: white;
	padding: 10px 20px;
	border-radius: 8px;
}

.inline-form { display: inline; margin: 0; }
.link-btn { border: none; cursor: pointer; font-size: inherit; font-family: inherit; }
</style>

</head>

<body>

	<!-- Navbar -->

	<nav class="navbar">

		<div class="logo">🍔 FoodGo</div>

		<form class="inline-form" action="${pageContext.request.contextPath}/logout" method="post">
			<input type="hidden" name="_csrf" value="${sessionScope.csrfToken}">
			<button type="submit" class="logout link-btn">Logout</button>
		</form>

	</nav>


	<!-- Main -->

	<div class="container">

		<div class="welcome">

			<h1>Welcome, <c:out value="${userName}"/>! 👋</h1>

			<p>Order delicious food from your favorite restaurants.</p>

		</div>


		<div class="cards">

			<!-- Restaurants -->

			<div class="card">

				<div class="icon">🍽️</div>

				<h3>Restaurants</h3>

				<p>Explore restaurants and discover delicious food.</p>

				<a href="${pageContext.request.contextPath}/restaurants">
					Explore </a>

			</div>


			<!-- Food -->

			<div class="card">

				<div class="icon">🍕</div>

				<h3>Food Menu</h3>

				<p>Browse your favorite dishes.</p>

				<a href="${pageContext.request.contextPath}/food/all"> View Menu </a>

			</div>


			<!-- Cart -->

			<div class="card">

				<div class="icon">🛒</div>

				<h3>My Cart</h3>

				<p>View and manage your selected items.</p>

				<a href="${pageContext.request.contextPath}/cart"> View Cart </a>

			</div>


			<!-- Orders -->

			<div class="card">

				<div class="icon">📦</div>

				<h3>My Orders</h3>

				<p>Track your previous and current orders.</p>

				<a href="#"> Orders </a>

			</div>

		</div>

	</div>

</body>

</html>