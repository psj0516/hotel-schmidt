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
// 로그인 여부 확인, 정보 가져오기
String id = (String) session.getAttribute("id");
MemberDao memberDao = MemberDao.getInstance();
MemberVo mVo = memberDao.getMemberById(id);

String pageNum = request.getParameter("pageNum");
int num = Integer.parseInt(request.getParameter("num"));

ReviewBoardDao dao = ReviewBoardDao.getInstance();
ReviewBoardVo vo = dao.getBoardByNum(num);
List<AttachfileVo> attachList = vo.getAttachList();

// 작성자 id 가져오기
String bId = vo.getId();

if (bId != null) {
	if (id == null || !bId.equals(id) ) {
		response.sendRedirect("review.jsp");
		return;
	}
}

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
				<%
				if (id != null) {
					%>
					<tr>
						<td>
						<input type="hidden" name="id" value="<%=bId %>">
						<input type="hidden" name="name" value="<%=mVo.getName() %>">
						</td>
					</tr>
					<%
				} else {
					%>
					<tr>
						<td>
						<input type="text" class="small" name="name" value="<%=vo.getName() %>" placeholder="작성자 *" required>
						<input type="password" class="small" name="passwd" placeholder="비밀번호 *" required>
						</td>
					</tr>
					<%
				}
				%>
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