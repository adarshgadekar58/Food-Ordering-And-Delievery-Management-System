<%@ page language="java"
    contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>

<!DOCTYPE html>
<html lang="en">

<head>

    <meta charset="UTF-8">

    <meta name="viewport"
          content="width=device-width, initial-scale=1.0">

    <title>FoodGo | Add Food</title>

    <style>

        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
            font-family: Arial, sans-serif;
        }

        body {
            min-height: 100vh;
            background:
                linear-gradient(135deg, #fff3ed, #fff);
            display: flex;
            justify-content: center;
            align-items: center;
            padding: 30px;
        }

        .container {
            width: 600px;
            background: white;
            padding: 40px;
            border-radius: 20px;
            box-shadow: 0 10px 40px rgba(0,0,0,0.1);
        }

        h1 {
            text-align: center;
            color: #ff6b35;
            margin-bottom: 10px;
        }

        .restaurant-name {
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

        input,
        textarea,
        select {
            width: 100%;
            padding: 13px;
            border: 1px solid #ddd;
            border-radius: 9px;
            outline: none;
            font-size: 15px;
        }

        textarea {
            height: 100px;
            resize: vertical;
        }

        input:focus,
        textarea:focus,
        select:focus {
            border-color: #ff6b35;
        }

        .buttons {
            display: flex;
            gap: 12px;
            margin-top: 25px;
        }

        button,
        .back {
            flex: 1;
            padding: 13px;
            border-radius: 9px;
            text-align: center;
            text-decoration: none;
            font-size: 15px;
        }

        button {
            border: none;
            background: #ff6b35;
            color: white;
            cursor: pointer;
        }

        .back {
            background: #eee;
            color: #333;
        }

    
.error { background: #ffe5e5; color: #d60000; padding: 12px; border-radius: 8px; margin-bottom: 20px; text-align: center; }
</style>

</head>

<body>

<div class="container">

    <h1>🍕 Add Food Item</h1>

    <div class="restaurant-name">

        Restaurant:
        <strong><c:out value="${restaurant.name}"/></strong>

    </div>


    <c:if test="${not empty error}"><div class="error"><c:out value="${error}"/></div></c:if>
    <form
        action="${pageContext.request.contextPath}/food/save"
        method="post">
        <input type="hidden" name="_csrf" value="${sessionScope.csrfToken}">

        <input type="hidden"
               name="restaurantId"
               value="${restaurant.id}">


        <div class="form-group">

            <label>Food Name</label>

            <input type="text"
                   name="name" value="<c:out value='${foodItem.name}'/>"
                   placeholder="e.g. Chicken Biryani"
                   required>

        </div>


        <div class="form-group">

            <label>Description</label>

            <textarea
                name="description"
                placeholder="Describe the food item"
                required><c:out value="${foodItem.description}"/></textarea>

        </div>


        <div class="form-group">

            <label>Price</label>

            <input type="number"
                   name="price" value="<c:out value='${foodItem.price}'/>"
                   step="0.01"
                   min="0"
                   placeholder="Enter price"
                   required>

        </div>


        <div class="form-group">

            <label>Category</label>

            <select name="category">

                <option value="STARTER">
                    Starter
                </option>

                <option value="MAIN COURSE">
                    Main Course
                </option>

                <option value="BIRYANI">
                    Biryani
                </option>

                <option value="PIZZA">
                    Pizza
                </option>

                <option value="BURGER">
                    Burger
                </option>

                <option value="DESSERT">
                    Dessert
                </option>

                <option value="BEVERAGE">
                    Beverage
                </option>

            </select>

        </div>


        <div class="form-group">

            <label>Image URL</label>

            <input type="text"
                   name="image" value="<c:out value='${foodItem.image}'/>"
                   placeholder="Paste food image URL">

        </div>


        <div class="form-group">

            <label>Status</label>

            <select name="status">

                <option value="AVAILABLE">
                    Available
                </option>

                <option value="UNAVAILABLE">
                    Unavailable
                </option>

            </select>

        </div>


        <div class="buttons">

            <a class="back"
               href="${pageContext.request.contextPath}/food/restaurant/${restaurant.id}">

                Back

            </a>

            <button type="submit">

                Save Food

            </button>

        </div>

    </form>

</div>

</body>

</html>