<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<title>회원가입</title>
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>

<style>
body {
	font-family: 'Noto Sans KR', sans-serif;
	margin: 0;
	padding: 0;
}

.container {
	max-width: 500px;
	margin: 0 auto;
	padding: 20px;
	background-color: #f9f0cc;
	border-radius: 10px;
	box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
}

h1 {
	text-align: center;
	margin-bottom: 20px;
}

form {
	display: flex;
	flex-direction: column;
}

label {
	font-weight: bold;
	margin-bottom: 5px;
}

input[type="text"], input[type="email"], input[type="tel"], input[type="date"],
	input[type="password"] {
	padding: 10px;
	margin-bottom: 15px;
	border: 1px solid #ccc;
	border-radius: 5px;
}

input[type="submit"] {
	background-color: #e3dac9;
	color: #000;
	padding: 10px;
	border: none;
	border-radius: 5px;
	cursor: pointer;
}

input[type="submit"]:hover {
	background-color: #e3dac9;
}

input[type="button"] {
	background-color: #edd09b;
	color: #000;
	padding: 10px;
	border: none;
	border-radius: 5px;
	cursor: pointer;
}

input[type="button"]:hover {
	background-color: #45a049;
}

.email_ok {
	color: #008000;
	display: none;
}

.email_already {
	color: #6A82FB;
	display: none;
}

.id_ok {
	color: #008000;
	display: none;
}

.id_already {
	color: #6A82FB;
	display: none;
}

.id_short {
	color: #6A82FB;
	display: none;
}

.password_ok {
	color: #008000;
	display: none;
}

.password_short {
	color: #6A82FB;
	display: none;
}
</style>





</head>

<body>

	<div class="container" style="margin-top: 100px">
		<h1>회원가입</h1>

		<form action="/signup/signupInsert" method="post" enctype="multipart/form-data">

			<label for="username">아이디</label>
			<input type="text" id="member_id" name="member_id" placeholder="4자이상" oninput="checkId()" required />
			<!-- id ajax 중복체크 -->
			<span class="id_ok">사용 가능한 아이디입니다.</span> <span class="id_already">누군가 이 아이디를 사용하고 있어요.</span> <span class="id_short" style="display: none;">아이디는 4자 이상이어야 합니다.</span> 


            <label for="password">비밀번호</label> 
			<input type="password" id="member_pw" name="member_pw" placeholder="6자이상" oninput="checkPasswordLength()" required />
			<span class="password_ok" style="display: none;">비밀번호 길이가 적절합니다.</span> <span class="password_short" style="display: none;">비밀번호는 6자 이상이어야 합니다.</span>
			
			<label for="username">이름</label>
			<input type="text"  name="member_name"  required />


			<label for="email">이메일</label>
			<input type="email" name="member_email" id="member_email" oninput="checkEmail()" required />
			<!-- id ajax 중복체크 -->
			<span class="email_ok">사용 가능한 이메일입니다.</span> <span class="email_already">누군가 이 이메일을 사용하고 있어요.</span> 
			
			
			<label for="email">프로필 사진</label>
			<input type="file" name="member_profileimage">
			<br>

			<input type="submit" id="submit" value="가입하기" />
		</form>
	</div>





	<script>
		function checkIdLength() {
			var member_id = $('#member_id').val();

			// 아이디가 4자 미만일 경우 메시지 표시
			if (member_id.length < 4) {
				$('.id_ok').css("display", "none");
				$('.id_already').css("display", "none");
				$('.id_short').css("display", "inline-block");
			} else {
				$('.id_short').css("display", "none");
				// 아이디 길이가 4 이상일 경우 중복 체크 수행
				checkId(member_id);
			}
		}

		// 아이디 입력란 값 변경 시 실시간으로 길이 체크
		$('#member_id').on('keyup', function() {
			checkIdLength();
		});

		function checkId() {
			var member_id = $('#member_id').val(); //id값이 "id"인 입력란의 값을 저장
			$.ajax({
				url : '/signup/member_idCheck', //Controller에서 요청 받을 주소
				type : 'post', //POST 방식으로 전달
				data : {
					member_id : member_id
				},
				success : function(cnt) { //컨트롤러에서 넘어온 cnt값을 받는다 
					if (cnt == 0) { //cnt가 1이 아니면(=0일 경우) -> 사용 가능한 아이디 
						$('.id_ok').css("display", "inline-block");
						$('.id_already').css("display", "none");
					}

					else { // cnt가 1일 경우 -> 이미 존재하는 아이디
						$('.id_already').css("display", "inline-block");
						$('.id_ok').css("display", "none");
					}
				},
				error : function() {
					alert("에러입니다");
				}
			});
		};

		function checkPasswordLength() {
			var password = $('#member_pw').val();

			// 비밀번호가 6자 미만일 경우 메시지 표시
			if (password.length < 6) {
				$('.password_ok').css("display", "none");
				$('.password_short').css("display", "inline-block");
			} else {
				$('.password_short').css("display", "none");
				$('.password_ok').css("display", "inline-block");
			}
		}

		// 비밀번호 입력란 값 변경 시 실시간으로 길이 체크
		$('#password').on('keyup', function() {
			checkPasswordLength();
		});

		function checkEmail() {
			var member_email = $('#member_email').val(); //id값이 "id"인 입력란의 값을 저장
			$.ajax({
				url : '/signup/member_emailCheck', //Controller에서 요청 받을 주소
				type : 'post', //POST 방식으로 전달
				data : {
					member_email : member_email
				},
				success : function(cnt) { //컨트롤러에서 넘어온 cnt값을 받는다 
					if (cnt == 0) { //cnt가 1이 아니면(=0일 경우) -> 사용 가능한 아이디 
						$('.email_ok').css("display", "inline-block");
						$('.email_already').css("display", "none");
					}

					else { // cnt가 1일 경우 -> 이미 존재하는 아이디
						$('.email_already').css("display", "inline-block");
						$('.email_ok').css("display", "none");
					}
				},
				error : function() {
					alert("에러입니다");
				}
			});
		};
	</script>


</body>
</html>











