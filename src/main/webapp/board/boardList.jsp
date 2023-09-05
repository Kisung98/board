<%@page import="java.util.HashMap"%>
<%@page import="java.util.Map"%>
<%@page import="java.util.List"%>
<%@page import="com.example.demo.BSPageBar"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>게시판 목록</title>

<style>
/*테이블디자인*/
/* 기본 테이블 스타일 */
table {
	width: 80%;
	border-collapse: collapse;
	border: 1px solid #ddd;
	margin: 20px auto;
	font-size: 14px;
}

/* 테이블 헤더 스타일 */
th {
	background-color: #f2f2f2;
	border: 1px solid #ddd;
	padding: 8px;
	text-align: left;
}

/* 테이블 데이터 행 스타일 */
tr {
	border: 1px solid #ddd;
}

/* 짝수 번호 행 배경색 변경 */
tr:nth-child(even) {
	background-color: #f2f2f2;
}

/* 테이블 데이터 셀 스타일 */
td {
	padding: 8px;
	border: 1px solid #ddd;
}

/* 마우스 호버 시 배경색 변경 */
tr:hover {
	background-color: #e0e0e0;
}

/*검색기 디자인  */
.search-container {
	background-color: #fff;
	border-radius: 5px;
	box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
	display: flex;
	overflow: hidden;
	width: 600px;
	margin-left: 190px;
}

.search-input {
	flex: 1;
	border: none;
	padding: 10px;
	font-size: 16px;
}

.search-option {
	padding: 10px;
	font-size: 16px;
	border: none;
	background-color: #f5f5f5;
	cursor: pointer;
}

.search-button {
	background-color: #007bff;
	color: #fff;
	border: none;
	padding: 10px 15px;
	cursor: pointer;
	transition: background-color 0.3s ease;
}

.search-button:hover {
	background-color: #0056b3;
}
</style>

<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">

<%
int size = 0;
List<Map<String, Object>> bList = (List<Map<String, Object>>) request.getAttribute("bList");

if (bList != null) {
	size = bList.size(); //4
}
int numPerPage = 10;
int nowPage = 0;
if (request.getParameter("nowPage") != null) {
	nowPage = Integer.parseInt(request.getParameter("nowPage"));
}
%>




</head>

<body>


	<%@include file="/include/header.jsp"%>
	<br>
	<br>
	<br>

	<!--헤더넣고 검색기넣고 페이징처리  -->


	<form action="/board/boardSearch">
		<div class="search-container">
			<select class="search-option" name="searchOption">
				<option value="member_id">작성자</option>
				<option value="board_title">제목</option>
			</select>
			<input type="text" name="board_search" class="search-input" id="searchInput" placeholder="검색어를 입력하세요">
			<button type="submit" class="search-button">검색</button>
			<a href="/board/boardList" style="border-left: solid 1px black;">
				<button type="button" class="search-button">전체검색</button>
			</a>
		</div>
	</form>






	<table>

		<tr>
			<th width="10%">번호</th>
			<th width="20%">작성자</th>
			<th width="30%">제목</th>
			<th width="20%">작성날짜</th>
			<th width="20%">조회수</th>
		</tr>

		<%
		if (bList.isEmpty()) {
		%>
		<tr>
			<td colspan="5" style="text-align: center;">조회결과가 없습니다.</td>
		</tr>
		<%
		}
		%>


		<%
		for (int i = nowPage * numPerPage; i < (nowPage * numPerPage) + numPerPage; i++) {
			if (size == i)
				break;
			Map<String, Object> bMap = bList.get(i);
		%>
		
		<tr>
			<td><%=bMap.get("BOARD_NO")%></td>
			<td><%=bMap.get("MEMBER_ID")%></td>
			<td>
				<a href="/board/boardDetail?board_no=<%=bMap.get("BOARD_NO")%>"><%=bMap.get("BOARD_TITLE")%></a>
			</td>
			<td><%=bMap.get("BOARD_DATE")%></td>
			<td><%=bMap.get("BOARD_COUNT")%></td>
		</tr>
		
		<%
		} //end of for
		%>


	</table>

	<!-- [[ Bootstrap 페이징 처리  구간 3 ]] -->
	<div style="display: flex; justify-content: center;">
		<ul class="pagination">
			<%
			String pagePath = "/board/boardList";
			BSPageBar bspb = new BSPageBar(numPerPage, size, nowPage, pagePath);
			out.print(bspb.getPageBar());
			%>
		</ul>

	</div>
	<hr>
	<%
	if (member == null) {
	%>

	<div style="margin-left: 1500px;">
		<button type="button" style="border-radius: 10px; margin-right: -300px;" class="search-button" onclick="needLogin()">글쓰기</button>
	</div>

	<%
	} else {
	%>

	<div style="margin-left: 1500px;">
		<a href="/board/boardInsert.jsp">
			<button type="button" style="border-radius: 10px; margin-right: -300px;" class="search-button">글쓰기</button>
		</a>
	</div>

	<%
	}
	%>

	<script>
		function needLogin() {
			alert('로그인이 필요합니다');
		}
	</script>





</body>
</html>