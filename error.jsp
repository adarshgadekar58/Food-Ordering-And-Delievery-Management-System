<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>FoodGo | Error</title>
<style>
* { margin: 0; padding: 0; box-sizing: border-box; font-family: Arial, sans-serif; }
body { min-height: 100vh; display: flex; justify-content: center; align-items: center;
	background: linear-gradient(135deg, #ff6b35, #ff9f1c); padding: 20px; }
.box { width: 480px; max-width: 100%; padding: 45px; text-align: center; background: white;
	border-radius: 22px; box-shadow: 0 20px 60px rgba(0, 0, 0, 0.25); }
.code { font-size: 64px; font-weight: bold; color: #ff6b35; }
h1 { margin: 10px 0 12px; }
p { color: #666; margin-bottom: 28px; }
a { display: inline-block; text-decoration: none; background: #ff6b35; color: white;
	padding: 12px 22px; border-radius: 8px; margin: 4px; }
</style>
</head>
<body>
	<div class="box">
		<div class="code"><c:out value="${status}" default="Oops" /></div>
		<c:choose>
			<c:when test="${status == 404}">
				<h1>Page not found</h1>
				<p>The page or item you are looking for doesn't exist.</p>
			</c:when>
			<c:when test="${status == 403}">
				<h1>Not allowed</h1>
				<p>You don't have permission to do that, or your form expired. Go back, reload the page and try again.</p>
			</c:when>
			<c:otherwise>
				<h1>Something went wrong</h1>
				<p>An unexpected error occurred. Please try again.</p>
			</c:otherwise>
		</c:choose>
		<a href="${pageContext.request.contextPath}/dashboard">Dashboard</a>
		<a href="${pageContext.request.contextPath}/">Home</a>
	</div>
</body>
</html>
