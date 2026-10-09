<%@ page language="java"
    contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt"%>

<%@ taglib prefix="c"
    uri="jakarta.tags.core" %>

<!DOCTYPE html>
<html>

<head>

    <meta charset="UTF-8">

    <title>FoodGo | All Food</title>

    <style>

        body {
            font-family: Arial, sans-serif;
            background: #f5f6fa;
            margin: 0;
        }

        .container {
            padding: 40px;
        }

        h1 {
            color: #ff6b35;
        }

        .grid {
            display: grid;
            grid-template-columns:
                repeat(auto-fit, minmax(250px, 1fr));
            gap: 25px;
        }

        .card {
            background: white;
            padding: 25px;
            border-radius: 15px;
            box-shadow: 0 5px 20px rgba(0,0,0,0.08);
        }

        .category {
            color: #ff6b35;
            font-weight: bold;
        }

        .price {
            font-size: 20px;
            font-weight: bold;
            margin: 15px 0;
        }

    </style>

</head>

<body>

<div class="container">
    <p><a href="${pageContext.request.contextPath}/dashboard">← Dashboard</a></p>

    <h1>🍕 All Food Items</h1>

    <div class="grid">

        <c:forEach
            var="food"
            items="${foodItems}">

            <div class="card">

                <h2>
                    <c:out value="${food.name}"/>
                </h2>

                <p class="category">
                    <c:out value="${food.category}"/>
                </p>

                <p>
                    <c:out value="${food.description}"/>
                </p>

                <div class="price">
                    ₹ <fmt:formatNumber value="${food.price}" minFractionDigits="2" maxFractionDigits="2"/>
                </div>

                <p>
                    Restaurant:
                    <strong>
                        <c:out value="${food.restaurant.name}"/>
                    </strong>
                </p>
                <a href="${pageContext.request.contextPath}/food/${food.id}">View</a>

            </div>

        </c:forEach>

    </div>

</div>

</body>

</html>