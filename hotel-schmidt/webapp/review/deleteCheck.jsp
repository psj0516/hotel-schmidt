<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Check Writer</title>
<link href="/css/default.css" rel="stylesheet" type="text/css"
	media="all" />
<link href="/css/board.css" rel="stylesheet" type="text/css" media="all" />
<style>
.post {
width: 450px;
margin-right: 0;
}
.checkform {
display: inline-block;
width: 420px;
height: 50px;
}
input {
vertical-align: middle;
}
div.space {
height: 20px;
}
</style>
</head>
<body>
	<%
	String num = request.getParameter("num");
	String pageNum = request.getParameter("pageNum");
	%>
	<div class="space"></div>
	<div id="wrapper">
	<div id="page" class="container">
		<h2>작성자 확인</h2>
		<div class="post">
			<form action="deleteCheckPro.jsp" class="checkform" method="post">
			<input type="hidden" name="pageNum" value="<%=pageNum%>">
			<input type="hidden" name="num" value="<%=num%>">
			비밀번호 <input type="password" class="small" name="passwd">
			<input type="submit" class="button checkbutton" value="비밀번호 확인">
		</form>
		</div>
	</div>
	</div>
</body>
</html>