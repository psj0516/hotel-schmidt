<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>Sign In</title>
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
			<h2>Sign in</h2>
			<form action="loginPro.jsp">
				<table>
					<tr>
						<td><label for="id">아이디</label></td>
						<td><input type="text" class="input" name="id" id="id"></td>
					</tr>
					<tr>
						<td><label for="passwd">비밀번호</label></td>
						<td><input type="password" class="input" name="passwd" id="passwd"></td>
					</tr>
					<tr>
					<td>
					</td>
					<td>
					&nbsp;&nbsp; <input type="checkbox" id="keepLogin">
					<label for="keepLogin">로그인 유지</label>
					</td>
					</tr>
					<tr>
						<td colspan="2" class="buttons">
						<input type="submit" class="button" value="로그인">
						<input type="button" onclick="location.href='/members/join.jsp'" class="button" value="회원가입"></td>
					</tr>
				</table>
				<input type="hidden" name="pageUrl" value="<%=request.getHeader("REFERER") %>">
			</form>
		</div>
	</div>
	<jsp:include page="/include/bottom.jsp" />
</body>
</html>