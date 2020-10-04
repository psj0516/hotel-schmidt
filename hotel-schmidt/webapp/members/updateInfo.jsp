<%@page import="java.time.LocalDateTime"%>
<%@page import="java.time.format.DateTimeFormatter"%>
<%@page import="exam.domain.MemberVo"%>
<%@page import="java.util.List"%>
<%@page import="exam.dao.MemberDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>My Page</title>
<link href="/css/default.css" rel="stylesheet" type="text/css" media="all" />
<link href="/css/members.css" rel="stylesheet" type="text/css" media="all" />
<style>
.sub_title {
	margin-top: 5px;
	 font-weight: 700;
	color: #3a89ff;
}
</style>
</head>
<body>
	<%
	// 사용자 확인
	String id = (String) session.getAttribute("id");
	
	if (id == null) {
		response.sendRedirect("/index.jsp");
		return;
	}
	
	// 멤버 정보 가져오기
	MemberDao dao = MemberDao.getInstance();
	MemberVo vo = dao.getMemberById(id);
	
	// 날짜 형식 변환
	DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy.MM.dd");
	LocalDateTime dateTime = vo.getRegDate();
	String strRegDate = dateTime.format(formatter);
	%>

	<div id="wrapper">
		<div id="menu" class="container">
			<jsp:include page="/include/menu.jsp" />
		</div>
		<!-- 리뷰 게시판 -->
		<div id="page" class="container">
			<h3 class="sub_title">update</h3>
			<form action="/members/updatePro.jsp" method="post">
			<table class="rev_management">
				<tr>
					<td><label for="id">아이디</label></td>
					<td><input type="text" class="input" name="id" id="id" value="<%=vo.getId()%>" readonly></td>
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
					<td><input type="text" class="input" name="name" id="name" value="<%=vo.getName() %>" required></td>
				</tr>
				<tr>
					<td><label for="age">나이</label></td>
					<td><input type="number" class="input" name="age" id="age" value="<%=vo.getAge() %>" required></td>
				</tr>
				<tr>
					<td><label for="email">이메일</label></td>
					<td><input type="email" class="input" name="email" id="email" value="<%=vo.getEmail()%>" required></td>
				</tr>
				<tr>
					<td><label for="tel">전화번호</label></td>
					<td><input type="tel" class="input" name="tel" id="tel" value="<%=vo.getTel()%>" required></td>
				</tr>
				<tr>
					<td colspan="2" class="buttons"><input type="submit" class="button" value="수정하기"></td>
				</tr>
			</table>
			</form>
		</div>
	</div>
	<script>
	// 패스워드 일치여부 판별
	var passwd = document.getElementById('passwd');
	var passwd2 = document.getElementById('passwd2');
	var spanMessage = document.getElementById('passwdMessage');

	passwd2.onkeyup = function() {
		console.log('키 눌렀다 떼어짐..');

		if (passwd.value != passwd2.value) {
			spanMessage.innerHTML = '* 비밀번호가 일치하지 않습니다.';
		} else {
			spanMessage.innerHTML = '';
		}
	};
	</script>
</body>

</html>