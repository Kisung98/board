<%@page import="java.util.Map"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style>
.custom-header {
	background-color: #f5f5f5;
	padding: 10px;
	display: flex;
	justify-content: space-between;
	align-items: center;
}

.custom-logo {
	font-size: 24px;
	font-weight: bold;
	text-decoration: none;
	color: #333;
}

.custom-nav {
	list-style: none;
	margin: 0;
	padding: 0;
	display: flex;
}

.custom-nav-item {
	margin-right: 20px;
}

.custom-nav-link {
	text-decoration: none;
	color: #555;
}

.custom-login-button {
	padding: 8px 16px;
	background-color: #007bff;
	border: none;
	color: white;
	border-radius: 4px;
	cursor: pointer;
}
</style>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">

<%
Map<String, Object> member = (Map) session.getAttribute("member");
%>

</head>
<body>


	<div class="custom-header">
		<ul class="custom-nav">
			<li class="custom-nav-item"><a class="custom-nav-link" href="/board/boardList">홈</a></li>
			<li class="custom-nav-item"><a class="custom-nav-link" href="#">마이페이지</a></li>
		</ul>
		<%
		if (member == null)
		{
		%>
		<a href="/memberSignin/MemberSignIn.jsp">
			<button class="custom-login-button">로그인</button>
		</a>
		<%
		} else
		{
		%>
		<p style="margin-left: 1450px; margin-top: 20px;"><%=member.get("MEMBER_ID")%>님 환영합니다.
		</p>
		<a href="/login/logout">
			<button class="custom-login-button">로그아웃</button>
		</a>
		<%
		}
		%>

	</div>





</body>
</html>