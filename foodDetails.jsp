<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt"%>

<!DOCTYPE html>
<html>

<head>

<meta charset="UTF-8">

<title>FoodGo | Food Details</title>

<style>
body {
	font-family: Arial, sans-serif;
	background: #f5f6fa;
}

.container {
	max-width: 700px;
	margin: 70px auto;
}

.card {
	background: white;
	padding: 40px;
	border-radius: 20px;
	box-shadow: 0 10px 30px rgba(0, 0, 0, 0.1);
}

h1 {
	margin-bottom: 10px;
}

.category {
	color: #ff6b35;
	font-weight: bold;
	margin-bottom: 20px;
}

.description {
	color: #666;
	margin-bottom: 20px;
}

.price {
	font-size: 28px;
	font-weight: bold;
	margin-bottom: 20px;
}

.restaurant {
	margin-bottom: 25px;
}

a {
	display: inline-block;
	text-decoration: none;
	background: #ff6b35;
	color: white;
	padding: 12px 20px;
	border-radius: 8px;
}

.add-btn { display: inline-block; background: #ff6b35; color: white; padding: 12px 20px; border: none; border-radius: 8px; font-size: 16px; cursor: pointer; }
.add-btn[disabled] { background: #bbb; cursor: not-allowed; }
</style>

</head>

<body>

	<div class="container">

		<div class="card">

			<h1><c:out value="${foodItem.name}"/></h1>

			<div class="category"><c:out value="${foodItem.category}"/></div>

			<div class="description"><c:out value="${foodItem.description}"/></div>

			<div class="price">₹ <fmt:formatNumber value="${foodItem.price}" minFractionDigits="2" maxFractionDigits="2"/></div>

			<div class="restaurant">

				🍽️ Restaurant: <strong> <c:out value="${foodItem.restaurant.name}"/> </strong>

			</div>

			<p>Status: <c:out value="${foodItem.status}"/></p>

			<br> <a
				href="${pageContext.request.contextPath}/food/restaurant/${foodItem.restaurant.id}">

				← Back to Menu </a> <form action="${pageContext.request.contextPath}/cart/add/${foodItem.id}" method="post" style="display: inline;">
				<input type="hidden" name="_csrf" value="${sessionScope.csrfToken}">
				<button type="submit" class="add-btn" ${foodItem.available ? '' : 'disabled'}>🛒 Add to Cart</button>
			</form>

		</div>

	</div>

</body>

</html>