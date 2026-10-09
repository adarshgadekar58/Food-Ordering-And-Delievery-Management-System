<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>

<!DOCTYPE html>
<html lang="en">

<head>

<meta charset="UTF-8">

<meta name="viewport" content="width=device-width, initial-scale=1.0">

<title>FoodGo | Restaurant</title>

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

.container {
	max-width: 900px;
	margin: 60px auto;
	padding: 30px;
}

.card {
	background: white;
	border-radius: 20px;
	overflow: hidden;
	box-shadow: 0 10px 35px rgba(0, 0, 0, 0.1);
}

.image {
	height: 300px;
	background: linear-gradient(135deg, #ff6b35, #ff9f1c);
	display: flex;
	justify-content: center;
	align-items: center;
	font-size: 100px;
}

.image img {
	width: 100%;
	height: 100%;
	object-fit: cover;
}

.content {
	padding: 35px;
}

h1 {
	margin-bottom: 15px;
}

.cuisine {
	color: #ff6b35;
	font-weight: bold;
	font-size: 18px;
	margin-bottom: 20px;
}

.info {
	margin: 15px 0;
	color: #555;
	font-size: 17px;
}

.buttons {
	margin-top: 30px;
	display: flex;
	gap: 15px;
}

.btn {
	text-decoration: none;
	padding: 12px 20px;
	border-radius: 8px;
}

.back {
	background: #eee;
	color: #333;
}

.menu {
	background: #ff6b35;
	color: white;
}
</style>

</head>

<body>

	<div class="container">

		<div class="card">

			<div class="image">

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

				<h1><c:out value="${restaurant.name}"/></h1>

				<div class="cuisine"><c:out value="${restaurant.cuisine}"/></div>

				<div class="info">
					📍 <strong>Location:</strong> <c:out value="${restaurant.location}"/>
				</div>

				<div class="info">
					📞 <strong>Phone:</strong> <c:out value="${restaurant.phone}"/>
				</div>

				<div class="info">
					🟢 <strong>Status:</strong> <c:out value="${restaurant.status}"/>
				</div>


				<div class="buttons">

					<a class="btn back"
						href="${pageContext.request.contextPath}/restaurants"> ← Back

					</a> <a class="btn menu" href="${pageContext.request.contextPath}/food/restaurant/${restaurant.id}"> View Menu → </a>

				</div>

			</div>

		</div>

	</div>

</body>

</html>