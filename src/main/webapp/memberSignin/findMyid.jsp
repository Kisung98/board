<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>



<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>아이디찾기</title>
<style>
* {
	font-weight: bold;
}

body {
	font-family: 'Noto Sans KR', sans-serif;
	margin: 0;
	padding: 0;
	display: flex;
	justify-content: center;
	align-items: center;
	height: 100vh;
}

.login-form {
	background-color: #fff;
	border-radius: 10px;
	box-shadow: 0px 0px 10px rgba(0, 0, 0, 0.1);
	padding: 30px;
	width: 300px;
}

.login-form h2 {
	text-align: center;
	margin-bottom: 20px;
	color: #333;
}

.login-form label {
	display: block;
	margin-bottom: 5px;
	color: #333;
}

.login-form input[type="text"], .login-form input[type="password"] {
	width: 100%;
	padding: 10px;
	margin-bottom: 15px;
	border: 1px solid #ccc;
	border-radius: 5px;
}

.login-form input[type="submit"] {
	width: 100%;
	padding: 10px;
	background-color: #e3dac9;
	color: #000000;
	border: none;
	border-radius: 5px;
	cursor: pointer;
}

.login-form input[type="submit"]:hover {
	background-color: #edd09b;
}

.login-form p {
	text-align: center;
	margin-top: 15px;
}
</style>
</head>
<body>
	<div class="login-form">
		<h2>ID 찾기</h2>
		<form action="/login/findMyid">
			<label for="username">이름</label>
			<input type="text" id="username" name="member_name"  required>

			<label for="password">이메일</label>
			<input type="text" id="password" name="member_email" required>

			<input type="submit" value="ID 찾기">
		</form>
	</div>

</body>
</html>
