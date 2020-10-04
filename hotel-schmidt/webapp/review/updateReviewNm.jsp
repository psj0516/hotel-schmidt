<%@page import="exam.domain.AttachfileVo"%>
<%@page import="java.util.List"%>
<%@page import="exam.dao.ReviewBoardDao"%>
<%@page import="exam.domain.ReviewBoardVo"%>
<%@page import="exam.domain.MemberVo"%>
<%@page import="exam.dao.MemberDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Update</title>
<link href="/css/default.css" rel="stylesheet" type="text/css"
	media="all" />
<link href="/css/board.css" rel="stylesheet" type="text/css" media="all" />
<style>
	span.delete-oldfile {
		color: red;
		font-weight: bold;
		margin-left: 10px;
	}
	
	div.file-container {
		display: inline-block;
	}
</style>
</head>
<body>
<%
// 패스워드 확인 없이 강제 접속 시 목록으로 이동
String strRandomNumber = request.getParameter("randomNumber");

if (strRandomNumber == null) {
	response.sendRedirect("review.jsp");
	return;
}

Integer serverNum = (Integer) session.getAttribute("randomNumber");	
int clientNum = Integer.parseInt(strRandomNumber);

if (serverNum == null || serverNum != clientNum) {
	response.sendRedirect("review.jsp");
	return;
}

session.removeAttribute("randomNumber");

//

int num = Integer.parseInt(request.getParameter("num"));
String pageNum = request.getParameter("pageNum");

ReviewBoardDao dao = ReviewBoardDao.getInstance();
ReviewBoardVo vo = dao.getBoardByNum(num);
List<AttachfileVo> attachList = vo.getAttachList();

%>
	<div id="wrapper">
		<div id="menu" class="container">
			<jsp:include page="/include/menu.jsp" />
		</div>
		<!-- 리뷰 게시판 -->
		<div id="page" class="container">
			<h2>Update Review</h2>
			<form action="updateReviewPro.jsp" method="post" enctype="multipart/form-data">
				<input type="hidden" name="num" value="<%=num %>">
				<input type="hidden" name="pageNum" value="<%=pageNum %>">
				<table class="post">
					<tr>
						<td>
						<input type="text" class="small" name="name" value="<%=vo.getName() %>" placeholder="작성자 *" required>
						<input type="password" class="small" name="passwd" placeholder="비밀번호 *" required>
						</td>
					</tr>
					<tr>
						<td><input type="text" name="subject" value="<%=vo.getSubject() %>" placeholder="제목을 입력하세요." required></td>
					</tr>
					<tr>
					<td class="files">
					<%
						for (AttachfileVo attachVo : attachList) {
							%>
							<input type="hidden" class=file name="oldfile" value="<%=attachVo.getUuid() %>">
							<div class="file file-container">
							<%=attachVo.getFilename() %>
							<span class="delete-oldfile">X</span>
							&nbsp;&nbsp;
							</div>
							<%
						}
						for (int i = 0; i < 3-attachList.size(); i++){
							%>
							<div class="file-container">
							<input type="file" class="file" name="filename">
							</div>
							<%
						}
					%>
					<div id="newFileBox" class="file-container"></div>
					</td>
					</tr>
					<tr>
						<td style="text-align: left;">
						<textarea name="content"><%=vo.getContent() %></textarea>
						</td>
					</tr>
					<tr>
						<td class="buttons">
							<input type="button" class="button postbutton2" onclick="location.href='review.jsp?pageNum=<%=pageNum %>'" value="글목록">
							<input type="submit" class="button postbutton" value="수정하기">
							<div class="clear"></div>
						</td>
					</tr>
				</table>
			</form>

			<div class="clear"></div>
		</div>
	</div>
	<jsp:include page="/include/bottom.jsp" />
	<script src="/script/jquery-3.5.1.js"></script>
<script>
var fileCount = <%=attachList.size() %>;

	// 파일 삭제 + 새 파일 첨부 추가
	$('span.delete-oldfile').click(function () {
		$(this).parent().prev().prop('name', 'delfile');
		$(this).parent().remove();
		fileCount--;
		
		var str = '<input type="file" class="file" name="filename">';
		
		$('div#newFileBox').append(str);
		fileCount++;
	});
</script>
</body>
</html>