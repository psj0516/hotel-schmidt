<%@page import="exam.domain.MemberVo"%>
<%@page import="exam.dao.MemberDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Review</title>
<link href="/css/default.css" rel="stylesheet" type="text/css"
	media="all" />
<link href="/css/board.css" rel="stylesheet" type="text/css" media="all" />
</head>
<body>
<%
// 로그인 여부 확인, 정보 가져오기
String id = (String) session.getAttribute("id");
MemberDao memberDao = MemberDao.getInstance();
MemberVo mVo = memberDao.getMemberById(id);

String reRef = request.getParameter("reRef");
String reLev = request.getParameter("reLev");
String reSeq = request.getParameter("reSeq");
String pageNum = request.getParameter("pageNum");
%>

	<div id="wrapper">
		<div id="menu" class="container">
			<jsp:include page="/include/menu.jsp" />
		</div>
		<!-- 리뷰 게시판 -->
		<div id="page" class="container">
			<h2>Review</h2>
			<form action="replyPostPro.jsp" method="post" enctype="multipart/form-data">
				<table class="post">
				<%
				if (id != null) {
					%>
					<tr>
						<td>
						<input type="hidden" name="id" value="<%=id %>">
						<input type="hidden" name="name" value="<%=mVo.getName() %>">
						</td>
					</tr>
					<%
				} else {
					%>
					<tr>
						<td>
						<input type="text" class="small" name="name" placeholder="작성자 *" required>
						<input type="password" class="small" name="passwd" placeholder="비밀번호 *" required>
						</td>
					</tr>
					<%
				}
				%>
					<tr>
						<td><input type="text" name="subject" placeholder="제목을 입력하세요." required></td>
					</tr>
					<tr>
					<td class="files">
						<input type="file" class="file" name="filename">
						<input type="file" class="file" name="filename">
						<input type="file" class="file" name="filename">
					</td>
					</tr>
					<tr>
						<td><textarea name="content"></textarea></td>
						<td>
						<input type="hidden" name="reRef" value="<%=reRef %>">
						<input type="hidden" name="reLev" value="<%=reLev %>">
						<input type="hidden" name="reSeq" value="<%=reSeq %>">
						<input type="hidden" name="pageNum" value="<%=pageNum %>">
						</td>
					</tr>
					<tr>
						<td class="buttons">
							<input type="button" class="button postbutton2" onclick="location.href='review.jsp?pageNum=<%=pageNum %>'" value="글목록">
							<input type="reset" class="button postbutton2" value="다시쓰기">
							<input type="submit" class="button postbutton" value="글쓰기">
							<div class="clear"></div>
						</td>
					</tr>
				</table>
			</form>

			<div class="clear"></div>
		</div>
	</div>
	<jsp:include page="/include/bottom.jsp" />
</body>

</html>