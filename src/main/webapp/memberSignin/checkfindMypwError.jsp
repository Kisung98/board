<%@page import="java.util.Map"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>찾은 아이디 보기</title>
<style>
body {
	font-family: Arial, sans-serif;
	margin: 0;
	padding: 0;
	display: flex;
	align-items: center;
	justify-content: center;
	min-height: 100vh;
}

.container {
	text-align: center;
	padding: 40px;
	background-color: white;
	border-radius: 10px;
	box-shadow: 0px 2px 10px rgba(0, 0, 0, 0.1);
}

h2 {
	font-size: 24px;
	margin: 10px 0;
	color: #333;
}

.home-button {
	display: inline-block;
	padding: 10px 20px;
	font-size: 16px;
	background-color: #3498db;
	color: white;
	border: none;
	border-radius: 5px;
	cursor: pointer;
	text-decoration: none;
	transition: background-color 0.3s;
}

.home-button:hover {
	background-color: #2980b9;
}
</style>
</head>
<body>

	<div class="container">
		<h1>없는 아이디입니다</h1>
		<a class="home-button" href="/memberSignin/MemberSignIn.jsp">로그인</a>
	</div>








</body>
</html>
