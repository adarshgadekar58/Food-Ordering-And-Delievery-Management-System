<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt"%>

<%@ taglib prefix="c" uri="jakarta.tags.core"%>

<!DOCTYPE html>
<html lang="en">

<head>

<meta charset="UTF-8">

<meta name="viewport" content="width=device-width, initial-scale=1.0">

<title>FoodGo | My Cart</title>

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

.nav-links {
	display: flex;
	gap: 12px;
}

.nav-links a {
	text-decoration: none;
	padding: 10px 18px;
	border-radius: 8px;
}

.dashboard {
	background: #eee;
	color: #333;
}

.restaurants {
	background: #ff6b35;
	color: white;
}

.container {
	max-width: 1100px;
	margin: 45px auto;
	padding: 0 25px;
}

.title {
	margin-bottom: 30px;
}

.title h1 {
	font-size: 32px;
}

.title p {
	color: #777;
	margin-top: 7px;
}

.cart-layout {
	display: grid;
	grid-template-columns: 2fr 1fr;
	gap: 25px;
}

.cart-items {
	display: flex;
	flex-direction: column;
	gap: 18px;
}

.cart-item {
	background: white;
	padding: 22px;
	border-radius: 15px;
	box-shadow: 0 5px 20px rgba(0, 0, 0, 0.07);
	display: flex;
	align-items: center;
	justify-content: space-between;
	gap: 20px;
}

.food-info h2 {
	margin-bottom: 8px;
}

.food-info p {
	color: #777;
	margin-bottom: 8px;
}

.price {
	font-weight: bold;
	color: #ff6b35;
}

.quantity {
	display: flex;
	align-items: center;
	gap: 10px;
}

.quantity a {
	width: 32px;
	height: 32px;
	border-radius: 7px;
	display: flex;
	justify-content: center;
	align-items: center;
	text-decoration: none;
	background: #eee;
	color: #333;
	font-size: 20px;
}

.quantity span {
	min-width: 25px;
	text-align: center;
	font-weight: bold;
}

.remove {
	text-decoration: none;
	color: #d60000;
	background: #ffe5e5;
	padding: 8px 12px;
	border-radius: 7px;
}

.summary {
	background: white;
	padding: 28px;
	border-radius: 15px;
	height: fit-content;
	box-shadow: 0 5px 20px rgba(0, 0, 0, 0.07);
}

.summary h2 {
	margin-bottom: 25px;
}

.row {
	display: flex;
	justify-content: space-between;
	margin-bottom: 15px;
	color: #555;
}

.total {
	border-top: 1px solid #ddd;
	padding-top: 20px;
	margin-top: 20px;
	font-size: 22px;
	font-weight: bold;
}

.checkout {
	display: block;
	width: 100%;
	text-align: center;
	text-decoration: none;
	background: #ff6b35;
	color: white;
	padding: 14px 0;
	border-radius: 9px;
	margin-top: 25px;
}

.empty {
	background: white;
	text-align: center;
	padding: 70px 30px;
	border-radius: 18px;
	box-shadow: 0 5px 20px rgba(0, 0, 0, 0.07);
}

.empty-icon {
	font-size: 70px;
	margin-bottom: 15px;
}

.empty h2 {
	margin-bottom: 10px;
}

.empty p {
	color: #777;
	margin-bottom: 25px;
}

.browse {
	display: inline-block;
	text-decoration: none;
	background: #ff6b35;
	color: white;
	padding: 12px 22px;
	border-radius: 8px;
}

@media ( max-width : 800px) {
	.cart-layout {
		grid-template-columns: 1fr;
	}
	.cart-item {
		flex-direction: column;
		align-items: flex-start;
	}
	.navbar {
		padding: 0 20px;
	}
}

.inline-form { display: inline; margin: 0; }
.link-btn { border: none; cursor: pointer; font-size: inherit; font-family: inherit; }
.qty-btn { width: 32px; height: 32px; border-radius: 7px; border: none; background: #eee; color: #333; font-size: 20px; cursor: pointer; }
.error { background: #ffe5e5; color: #d60000; padding: 12px; border-radius: 8px; margin-bottom: 20px; text-align: center; }
</style>

</head>

<body>

	<nav class="navbar">

		<div class="logo">🍔 FoodGo</div>

		<div class="nav-links">

			<a class="dashboard"
				href="${pageContext.request.contextPath}/dashboard"> Dashboard </a>

			<a class="restaurants"
				href="${pageContext.request.contextPath}/restaurants">
				Restaurants </a>

		</div>

	</nav>


	<div class="container">

		<div class="title">

			<h1>🛒 My Cart</h1>

			<p>Review your selected food items</p>

		</div>


		<c:if test="${not empty error}"><div class="error"><c:out value="${error}"/></div></c:if>
		<c:choose>

			<c:when test="${empty cartItems}">

				<div class="empty">

					<div class="empty-icon">🛒</div>

					<h2>Your Cart is Empty</h2>

					<p>Add some delicious food to get started.</p>

					<a class="browse"
						href="${pageContext.request.contextPath}/restaurants"> Browse
						Restaurants </a>

				</div>

			</c:when>


			<c:otherwise>

				<div class="cart-layout">


					<!-- CART ITEMS -->

					<div class="cart-items">

						<c:forEach var="item" items="${cartItems}">

							<div class="cart-item">


								<div class="food-info">

									<h2><c:out value="${item.foodItem.name}"/></h2>

									<p><c:out value="${item.foodItem.category}"/></p>

									<div class="price">₹ <fmt:formatNumber value="${item.foodItem.price}" minFractionDigits="2" maxFractionDigits="2"/></div>

								</div>


								<div class="quantity">

									<form class="inline-form" action="${pageContext.request.contextPath}/cart/decrease/${item.id}" method="post"><input type="hidden" name="_csrf" value="${sessionScope.csrfToken}"><button type="submit" class="qty-btn">−</button></form> <span> ${item.quantity} </span> <form class="inline-form" action="${pageContext.request.contextPath}/cart/increase/${item.id}" method="post"><input type="hidden" name="_csrf" value="${sessionScope.csrfToken}"><button type="submit" class="qty-btn">+</button></form>

								</div>


								<form class="inline-form" action="${pageContext.request.contextPath}/cart/remove/${item.id}" method="post"
									onsubmit="return confirm('Remove this item from cart?');">
									<input type="hidden" name="_csrf" value="${sessionScope.csrfToken}">
									<button type="submit" class="remove link-btn">Remove</button>
								</form>

							</div>

						</c:forEach>

					</div>


					<!-- SUMMARY -->

					<div class="summary">

						<h2>Order Summary</h2>

						<div class="row">

							<span> Subtotal </span> <span> ₹ <fmt:formatNumber value="${total}" minFractionDigits="2" maxFractionDigits="2"/> </span>

						</div>

						<div class="row">

							<span> Delivery Fee </span> <span> ₹ 0 </span>

						</div>

						<div class="row total">

							<span> Total </span> <span> ₹ <fmt:formatNumber value="${total}" minFractionDigits="2" maxFractionDigits="2"/> </span>

						</div>

						<a class="checkout" href="#"> Proceed to Checkout </a>

					</div>

				</div>

			</c:otherwise>

		</c:choose>

	</div>

</body>

</html>