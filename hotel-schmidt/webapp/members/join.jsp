<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>Sign Up</title>
<link href="/css/default.css" rel="stylesheet" type="text/css" media="all" />
<link href="/css/members.css" rel="stylesheet" type="text/css" media="all" />
</head>
<body>
	<div id="wrapper">
		<div id="menu" class="container">
		<jsp:include page="/include/menu.jsp" />
		</div>
	</div>
	<div id="wrapper">
		<div id="page" class="container">
			<h2>Sign Up</h2>
			<form action="/members/joinPro.jsp" method="post" name="joinForm">
				<table>
					<tr>
						<td><label for="id">아이디</label></td>
						<td><input type="text" class="input" name="id" id="id" required></td>
						<td><span id="idDupMessage"></span></td>
					</tr>
					<tr>
						<td><label for="passwd">비밀번호</label></td>
						<td><input type="password" class="input" name="passwd" id="passwd" required></td>
					</tr>
					<tr>
						<td><label for="passwd2">비밀번호 확인</label></td>
						<td><input type="password" class="input" name="passwd2" id="passwd2" required></td>
						<td><span id="passwdMessage"></span></td>
					</tr>
					<tr>
						<td><label for="name">이름</label></td>
						<td><input type="text" class="input" name="name" id="name" required></td>
					</tr>
					<tr>
						<td><label for="age">나이</label></td>
						<td><input type="number" class="input" name="age" id="age" required></td>
					</tr>
					<tr>
						<td><label for="email">이메일</label></td>
						<td><input type="email" class="input" name="email" id="email" required></td>
					</tr>
					<tr>
						<td><label for="tel">전화번호</label></td>
						<td><input type="tel" class="input" name="tel" id="tel" required></td>
					</tr>
					<tr>
						<td colspan="2" class="buttons"><input type="submit" class="button" value="회원가입"></td>
					</tr>
				</table>
			</form>
		</div>
	</div>
	<jsp:include page="/include/bottom.jsp" />
	
	<script src="/js/jquery-3.5.1.js"></script>
	<script>
	// 패스워드 일치여부 판별
	var passwd = document.getElementById('passwd');
	var passwd2 = document.getElementById('passwd2');
	var spanMessage = document.getElementById('passwdMessage');

	passwd2.onkeyup = function() {
		if (passwd.value != passwd2.value) {
			spanMessage.innerHTML = '* 비밀번호가 일치하지 않습니다.';
		} else {
			spanMessage.innerHTML = '';
		}
	};
	
	// 아이디 중복체크
	$('input[name="id"]').keyup(function(event) {
		var id = $(this).val();

		$.ajax({
			url : '/js/Join_IDCheck.jsp',
			data : {
				id : id
			},
			success : function(data) {
				showIdDupMessage(data);
			}
		});
	});

	function showIdDupMessage(data) {
		if (data.isIdDup) {
			$('span#idDupMessage').html('이미 사용중인 아이디입니다.').css('color','red');
		} else {
			$('span#idDupMessage').html('사용 가능한 아이디입니다.').css('color','green');
		}
	}

	</script>
</body>
</html>