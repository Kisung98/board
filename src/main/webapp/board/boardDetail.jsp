<%@page import="java.util.HashMap"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>게시판 상세</title>

<style>
/*테이블*/
table {
	margin: 10px 50px;
	width: calc(100% - 500px);
	margin-left: auto;
	margin-right: auto;
	border-collapse: collapse;
	border-radius: 15px;
	overflow: hidden;
	font-size: 18px;
	font: bold;
}

th, td {
	padding: 12px;
	text-align: center;
	color: #333;
	border-bottom: 2px solid #ddd;
}

tr:hover {
	background-color: #ffeb3b;
}

input {
	border-radius: 5px;
}

.rounded-button {
	background-color: #e3dac9;
	color: #000000;
	border: none;
	border-radius: 20px;
	padding: 10px 20px;
	font-size: 18px;
	box-shadow: 0 2px 5px rgba(0, 0, 0, 0.2);
	cursor: pointer;
}

.rounded-button:hover {
	background-color: #edd09b;
}

h3 {
	font-weight: bold;
}

.label-cell {
	border-right: 2px solid #ddd;
	padding: 12px;
	text-align: center;
	font-weight: bold;
	background-color: #f7f7f7;
	color: #333;
}

.value-cell {
	padding: 12px;
	font-weight: bold;
	background-color: #f7f7f7;
	color: #333;
}

/*댓글*/
.comment {
	border: 1px solid #ccc;
	padding: 10px;
	margin: 0 auto;
	background-color: #f5f5f5;
	border-radius: 5px;
	width: 35%;
}

.comment-header {
	justify-content: space-between;
	align-items: center;
	margin-bottom: 5px;
	font-weight: bold;
}

.author {
	color: #007bff;
}

.date {
	color: #6c757d;
	margin-left: 50px;
}

.comment-body {
	padding: 5px 0;
}

.profile-picture {
	width: 50px;
	height: 50px;
	border-radius: 50%;
	overflow: hidden;
	margin-right: 10px;
}

.delete-button {
	background-color: #dc3545;
	color: #fff;
	border: none;
	padding: 5px 10px;
	border-radius: 3px;
	cursor: pointer;
	margin-left: 30px;
}

.profile-picture img {
	width: 100%;
	height: 100%;
	object-fit: cover;
}

/*댓글작성*/
.comment-form {
	border: 1px solid #ccc;
	padding: 10px;
	background-color: #f5f5f5;
	border-radius: 5px;
	margin-bottom: 15px;
	width: 50%;
	margin: 0 auto;
}

.comment-form textarea {
	width: 98%;
	height: 50%;
	padding: 5px;
	border: 1px solid #ccc;
	border-radius: 3px;
	margin: 0 auto;
}

.comment-form button {
	background-color: #007bff;
	color: #fff;
	border: none;
	padding: 5px 10px;
	border-radius: 3px;
	cursor: pointer;
}

.comment-form button:hover {
	background-color: #0056b3;
}

.search-button {
	background-color: #007bff;
	color: #fff;
	border: none;
	padding: 10px 15px;
	cursor: pointer;
	transition: background-color 0.3s ease;
}

.center-box {
	text-align: center;
	padding: 20px;
	border-radius: 5px;
	background-color: #fff;
	box-shadow: 0px 2px 5px rgba(0, 0, 0, 0.1);
}
</style>

<%
List<Map<String, Object>> bList = (List<Map<String, Object>>) request.getAttribute("bList");

Map<String, Object> member2 = (Map) session.getAttribute("member");

if (member2 == null)
{
	member2 = new HashMap<String, Object>();
}
%>

</head>


<body>
	<%@include file="/include/header.jsp"%>
	<br>
	<br>
	<br>

	<div style="margin-left: 100px;">
		<a href="/board/boardList">
			<button type="button" style="border-radius: 10px;" class="search-button">글목록</button>
		</a>
	</div>


	<h2 style="margin-left: 250px;">게시판 상세</h2>



	<!--게시판 본문 내용  -->
	<%
	for (int i = 0; i < 1; i++)
	{
		Map<String, Object> bMap = bList.get(i);
	%>
	<form action="/board/boardUpdate">
		<input type="hidden" name="board_no" value=<%=bMap.get("BOARD_NO")%>>
		
		<table>
			<tr>
				<th class="label-cell">제목</th>
				<th class="value-cell"><p><%=bMap.get("BOARD_TITLE")%></p></th>
			</tr>

			<tr>
				<th class="label-cell">글쓴이</th>
				<th class="value-cell"><p><%=bMap.get("MEMBER_ID")%></p></th>
			</tr>

			<tr>
				<th class="label-cell">생성날짜</th>
				<th class="value-cell"><p><%=bMap.get("BOARD_DATE")%></p></th>
			</tr>

			<tr>
				<th class="label-cell">조회수</th>
				<th class="value-cell"><p><%=bMap.get("BOARD_COUNT")%></p></th>
			</tr>


			<tr>

				<%
				if (member2.isEmpty() || !member2.get("MEMBER_ID").toString().equals(bMap.get("MEMBER_ID")))
				{
				%>
				<td class="label-cell">내용</td>
				<td class="value-cell">
					<textarea aria-label="With textarea" readonly="readonly" style="width: 600px; height: 400px;"><%=bMap.get("BOARD_CONTENT")%></textarea>
				</td>

				<%
				} else if (member2.get("MEMBER_ID").toString().equals(bMap.get("MEMBER_ID")))
				{
				%>
				<td class="label-cell">내용</td>
				<td class="value-cell">
					<textarea aria-label="With textarea" style="width: 600px; height: 400px;" name="board_content"><%=bMap.get("BOARD_CONTENT")%></textarea>
				</td>
				<%
				}
				%>


			</tr>

			<tr>
				<th class="label-cell">첨부파일</th>
				<th class="value-cell"><a href="/board/boardFileDownload?board_content_file=<%=bMap.get("BOARD_CONTENT_FILE")%>"><%=((String) bMap.get("BOARD_CONTENT_FILE"))
		.substring(((String) bMap.get("BOARD_CONTENT_FILE")).lastIndexOf('/') + 1)%></a></th>
			</tr>
		</table>



		<%
		if (member2.isEmpty())
		{
		%>

		<p></p>

		<%
		} else if (member2.get("MEMBER_ID").toString().equals(bMap.get("MEMBER_ID").toString()))
		{
		%>

		<div style="margin-left: 1300px;">
			<input type="submit" class="btn btn-outline-success" value="수정">
			<a href="/board/boardDelete?board_no=<%=bMap.get("BOARD_NO")%>">
				<input type="button" class="btn btn-outline-success" value="삭제">
			</a>
		</div>
		<%
		}
		%>
	</form>


	<br>


	<hr>
	<br>


	<!--댓글작성-->
	<form action="/board/boardReplyInsert">
		<input type="hidden" name="board_count" value=1>
		<input type="hidden" name="board_no" value=<%=bMap.get("BOARD_NO")%>>
		<input type="hidden" name="board_reply_member_id" value=<%=member2.get("MEMBER_ID")%>>
		<%
		if (member2.isEmpty())
		{
		%>
		<div class="comment-form">
			<textarea rows="4" placeholder="로그인 후 사용해주세요" readonly="readonly" name="board_reply_content"></textarea>
		</div>
		<%
		} else
		{
		%>

		<div class="comment-form">
			<textarea rows="4" placeholder="댓글을 입력하세요..." name="board_reply_content"></textarea>
			<button type="submit">댓글 작성</button>
		</div>
		<%
		}
		%>
	</form>
	<%
	}
	%>
	<br>


	<!--달린댓글-->



	<%
	for (Map<String, Object> bMap : bList)
	{
		if (bMap.get("BOARD_REPLY_CONTENT") != null)
		{
	%>
	<div class="comment">
		<div class="comment-header">
			<div class="profile-picture">
				<img src="<%=bMap.get("MEMBER_PROFILEIMAGE")%>" alt="프로필 사진">
			</div>
			<span class="author"><%=bMap.get("BOARD_REPLY_MEMBER_ID")%></span> <span class="date"><%=bMap.get("BOARD_REPLY_DATE")%></span>

			<%
			if (member2.isEmpty())
			{
			%>
			<p></p>
			<%
			} else if (member2.get("MEMBER_ID").toString().equals(bMap.get("BOARD_REPLY_MEMBER_ID").toString()))
			{
			%>
			<a href="/board/boardReplyDelete?board_reply_no=<%=bMap.get("BOARD_REPLY_NO")%>&board_no=<%=bMap.get("BOARD_NO")%>&board_count=1">
				<button class="delete-button">삭제</button>
			</a>
			<%
			}
			%>
		</div>
		<!-- 댓글 내용 -->
		<div class="comment-body"><%=bMap.get("BOARD_REPLY_CONTENT")%></div>
	</div>
	<br>
	<%
	}

	else if (bMap.get("BOARD_REPLY_CONTENT") == null)
	{
	%>
	<div class="center-box">
		<p>댓글이 없습니다.</p>
	</div>
	<%
	}
	}
	%>




	<!--댓글 반복 끝  -->


</body>
</html>
