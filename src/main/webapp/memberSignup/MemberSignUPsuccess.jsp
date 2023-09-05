<%@ page language="java"		pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<title>회원가입성공</title>
<link rel="stylesheet" href="/css/notice.css">
<script type="text/javascript"></script>
<style>
body {
    font: bold 18px "malgun gothic";
	text-align: center;
}

hr {
	margin-top: 50px;
	margin-bottom: 100px;
	border: none;
	border-top: 2px solid #000;
}

.success-message {
	text-align: center;
	font-size: 24px;
	margin-bottom: 50px;
}

.btn-container {
	display: flex;
	justify-content: center;
	margin-bottom: 30px;
}

.btn {
	display: inline-block;
	padding: 10px 20px;
	background-color: #f9efac;
	color: #001C30;
	text-decoration: none;
	border-radius: 4px;
	transition: background-color 0.3s ease;
	margin: 0 10px;
}

.btn:hover {
	background-color: #ffd978;
}
</style>
</head>
<body>
	<div>
		<hr>
		<div class="success-message">
			<p>회원가입이 성공적으로 완료되었습니다!</p>
		</div>

		<div class="btn-container">
			<a class="btn" href="/memberSignin/MemberSignIn.jsp">로그인</a> 
		</div>
		<hr>
	</div>
</body>
</html>