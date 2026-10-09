<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt"%>

<%@ taglib prefix="c" uri="jakarta.tags.core"%>

<!DOCTYPE html>
<html lang="en">

<head>

<meta charset="UTF-8">

<meta name="viewport" content="width=device-width, initial-scale=1.0">

<title>FoodGo | Menu</title>

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

.back {
	text-decoration: none;
	color: #333;
	background: #eee;
	padding: 10px 18px;
	border-radius: 8px;
}

.container {
	padding: 45px 50px;
}

.header {
	background: linear-gradient(135deg, #ff6b35, #ff9f1c);
	color: white;
	padding: 35px;
	border-radius: 18px;
	margin-bottom: 35px;
}

.header h1 {
	font-size: 34px;
	margin-bottom: 8px;
}

.header p {
	font-size: 17px;
}

.actions {
	margin-bottom: 25px;
}

.add-btn {
	text-decoration: none;
	background: #ff6b35;
	color: white;
	padding: 12px 20px;
	border-radius: 8px;
}

.food-grid {
	display: grid;
	grid-template-columns: repeat(auto-fit, minmax(280px, 1fr));
	gap: 25px;
}

.food-card {
	background: white;
	border-radius: 18px;
	overflow: hidden;
	box-shadow: 0 5px 20px rgba(0, 0, 0, 0.08);
	transition: 0.3s;
}

.food-card:hover {
	transform: translateY(-7px);
}

.food-image {
	height: 190px;
	background: linear-gradient(135deg, #ff6b35, #ff9f1c);
	display: flex;
	justify-content: center;
	align-items: center;
	font-size: 65px;
}

.food-image img {
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

.category {
	color: #ff6b35;
	font-weight: bold;
	margin-bottom: 10px;
}

.description {
	color: #777;
	min-height: 45px;
	margin-bottom: 15px;
}

.price {
	font-size: 22px;
	font-weight: bold;
	margin-bottom: 12px;
}

.status {
	display: inline-block;
	background: #dff7e7;
	color: #15803d;
	padding: 6px 12px;
	border-radius: 20px;
	font-size: 13px;
	margin-bottom: 15px;
}

.view-btn {
	display: block;
	text-align: center;
	text-decoration: none;
	background: #ff6b35;
	color: white;
	padding: 10px;
	border-radius: 8px;
}

.empty {
	background: white;
	text-align: center;
	padding: 60px;
	border-radius: 15px;
}

.inline-form { display: inline; margin: 0; }
.link-btn { border: none; cursor: pointer; font-size: inherit; font-family: inherit; }
</style>

</head>

<body>

	<nav class="navbar">

		<div class="logo">🍔 FoodGo</div>

		<a class="back" href="${pageContext.request.contextPath}/restaurants">

			← Restaurants </a>

	</nav>


	<div class="container">

		<div class="header">

			<h1><c:out value="${restaurant.name}"/></h1>

			<p>📍 <c:out value="${restaurant.location}"/> &nbsp;&nbsp; | &nbsp;&nbsp; 🍴
				<c:out value="${restaurant.cuisine}"/></p>

		</div>


		<div class="actions">

			<c:if test="${sessionScope.userRole == 'ADMIN'}">
			<a class="add-btn"
				href="${pageContext.request.contextPath}/food/add/${restaurant.id}">

				+ Add Food Item </a>
			</c:if>

		</div>


		<c:choose>

			<c:when test="${empty foodItems}">

				<div class="empty">

					<h2>No Food Items</h2>

					<p>This restaurant has no menu items yet.</p>

				</div>

			</c:when>


			<c:otherwise>

				<div class="food-grid">

					<c:forEach var="food" items="${foodItems}">

						<div class="food-card">

							<div class="food-image">

								<c:choose>

									<c:when test="${not empty food.image}">

										<img src="<c:out value="${food.image}"/>" alt="<c:out value="${food.name}"/>">

									</c:when>

									<c:otherwise>
                                    🍕
                                </c:otherwise>

								</c:choose>

							</div>


							<div class="content">

								<h2><c:out value="${food.name}"/></h2>

								<div class="category"><c:out value="${food.category}"/></div>

								<div class="description"><c:out value="${food.description}"/></div>

								<div class="price">₹ <fmt:formatNumber value="${food.price}" minFractionDigits="2" maxFractionDigits="2"/></div>

								<div class="status"><c:out value="${food.status}"/></div>

								<div style="display: flex; gap: 10px;">

									<a class="view-btn"
										href="${pageContext.request.contextPath}/food/${food.id}">

										View </a> <form action="${pageContext.request.contextPath}/cart/add/${food.id}" method="post" style="flex: 1; margin: 0;">
										<input type="hidden" name="_csrf" value="${sessionScope.csrfToken}">
										<button type="submit" class="view-btn link-btn" style="width: 100%;"
											${food.available ? '' : 'disabled'}>🛒 Add</button>
									</form>
								</div>

								<c:if test="${sessionScope.userRole == 'ADMIN'}">
									<form action="${pageContext.request.contextPath}/food/delete/${food.id}" method="post" style="margin-top: 10px;"
										onsubmit="return confirm('Delete this food item?');">
										<input type="hidden" name="_csrf" value="${sessionScope.csrfToken}">
										<button type="submit" class="view-btn link-btn"
											style="width: 100%; background: #ffe5e5; color: #d60000;">Delete</button>
									</form>
								</c:if>

							</div>

						</div>

					</c:forEach>

				</div>

			</c:otherwise>

		</c:choose>

	</div>

</body>

</html>