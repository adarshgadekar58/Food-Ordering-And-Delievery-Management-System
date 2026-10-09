<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%@ taglib prefix="c" uri="jakarta.tags.core"%>

<!DOCTYPE html>
<html lang="en">

<head>

<meta charset="UTF-8">

<meta name="viewport" content="width=device-width, initial-scale=1.0">

<title>FoodGo | Restaurants</title>

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

.navbar {
	height: 70px;
	background: white;
	display: flex;
	align-items: center;
	justify-content: space-between;
	padding: 0 50px;
	box-shadow: 0 3px 15px rgba(0, 0, 0, 0.08);
}

.logo {
	font-size: 28px;
	font-weight: bold;
	color: #ff6b35;
}

.nav-links {
	display: flex;
	gap: 15px;
}

.nav-links a {
	text-decoration: none;
	padding: 10px 18px;
	border-radius: 8px;
}

.dashboard {
	color: #333;
	background: #eee;
}

.add-btn {
	color: white;
	background: #ff6b35;
}

.container {
	padding: 45px 50px;
}

.heading {
	display: flex;
	justify-content: space-between;
	align-items: center;
	margin-bottom: 30px;
}

.heading h1 {
	font-size: 32px;
}

.heading p {
	color: #777;
	margin-top: 7px;
}

.restaurant-grid {
	display: grid;
	grid-template-columns: repeat(auto-fit, minmax(280px, 1fr));
	gap: 25px;
}

.card {
	background: white;
	border-radius: 18px;
	overflow: hidden;
	box-shadow: 0 5px 20px rgba(0, 0, 0, 0.08);
	transition: 0.3s;
}

.card:hover {
	transform: translateY(-7px);
}

.restaurant-image {
	height: 190px;
	background: linear-gradient(135deg, #ff6b35, #ff9f1c);
	display: flex;
	justify-content: center;
	align-items: center;
	font-size: 70px;
}

.restaurant-image img {
	width: 100%;
	height: 100%;
	object-fit: cover;
}

.content {
	padding: 22px;
}

.content h2 {
	margin-bottom: 8px;
}

.cuisine {
	color: #ff6b35;
	font-weight: bold;
	margin-bottom: 12px;
}

.location {
	color: #777;
	margin-bottom: 8px;
}

.phone {
	color: #777;
	margin-bottom: 15px;
}

.status {
	display: inline-block;
	padding: 6px 12px;
	background: #dff7e7;
	color: #15803d;
	border-radius: 20px;
	font-size: 13px;
	margin-bottom: 15px;
}

.actions {
	display: flex;
	gap: 10px;
}

.view-btn, .delete-btn {
	text-decoration: none;
	padding: 9px 15px;
	border-radius: 7px;
	font-size: 14px;
}

.view-btn {
	background: #ff6b35;
	color: white;
}

.delete-btn {
	background: #ffe5e5;
	color: #d60000;
}

.empty {
	background: white;
	padding: 60px;
	text-align: center;
	border-radius: 15px;
	color: #777;
}

.inline-form { display: inline; margin: 0; }
.link-btn { border: none; cursor: pointer; font-size: inherit; font-family: inherit; }
</style>

</head>

<body>

	<nav class="navbar">

		<div class="logo">🍔 FoodGo</div>

		<div class="nav-links">

			<a class="dashboard"
				href="${pageContext.request.contextPath}/dashboard"> Dashboard </a>

			<a class="dashboard" href="${pageContext.request.contextPath}/cart"> 🛒 Cart </a>

			<c:if test="${sessionScope.userRole == 'ADMIN'}">
			<a class="add-btn"
				href="${pageContext.request.contextPath}/restaurants/add"> + Add
				Restaurant </a>
			</c:if>

		</div>

	</nav>


	<div class="container">

		<div class="heading">

			<div>

				<h1>🍽️ Restaurants</h1>

				<p>Discover your favorite restaurants</p>

			</div>

		</div>


		<c:choose>

			<c:when test="${empty restaurants}">

				<div class="empty">

					<h2>No Restaurants Found</h2>

					<p>Add your first restaurant to get started.</p>

				</div>

			</c:when>


			<c:otherwise>

				<div class="restaurant-grid">

					<c:forEach var="restaurant" items="${restaurants}">

						<div class="card">

							<div class="restaurant-image">

								<c:choose>

									<c:when test="${not empty restaurant.image}">

										<img src="<c:out value="${restaurant.image}"/>" alt="<c:out value="${restaurant.name}"/>">

									</c:when>

									<c:otherwise>

                                    🍽️

                                </c:otherwise>

								</c:choose>

							</div>


							<div class="content">

								<h2><c:out value="${restaurant.name}"/></h2>

								<div class="cuisine"><c:out value="${restaurant.cuisine}"/></div>

								<div class="location">📍 <c:out value="${restaurant.location}"/></div>

								<div class="phone">📞 <c:out value="${restaurant.phone}"/></div>

								<div class="status"><c:out value="${restaurant.status}"/></div>

								<div class="actions">

									<a class="view-btn"
										href="${pageContext.request.contextPath}/restaurants/${restaurant.id}">
										View </a> <c:if test="${sessionScope.userRole == 'ADMIN'}">
									<form class="inline-form" action="${pageContext.request.contextPath}/restaurants/delete/${restaurant.id}" method="post"
										onsubmit="return confirm('Delete this restaurant and all of its menu items?');">
										<input type="hidden" name="_csrf" value="${sessionScope.csrfToken}">
										<button type="submit" class="delete-btn link-btn">Delete</button>
									</form>
									</c:if>

								</div>

							</div>

						</div>

					</c:forEach>

				</div>

			</c:otherwise>

		</c:choose>

	</div>

</body>

</html>