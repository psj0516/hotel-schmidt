<%@page import="exam.domain.AttachfileVo"%>
<%@page import="exam.domain.ReviewBoardVo"%>
<%@page import="exam.dao.ReviewBoardDao"%>
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
<title>Review</title>
<link href="/css/default.css" rel="stylesheet" type="text/css" media="all" />
<link href="/css/board.css" rel="stylesheet" type="text/css" media="all" />
</head>
<body>
<%
String id = (String) session.getAttribute("id");

int num = Integer.parseInt(request.getParameter("num"));
String pageNum = request.getParameter("pageNum");

ReviewBoardDao dao = ReviewBoardDao.getInstance();

// 조회수 증가
dao.updateReadcount(num);

// 글 가져오기
ReviewBoardVo vo = dao.getBoardByNum(num);

// 첨부파일 가져오기
List<AttachfileVo> attachList = vo.getAttachList();

String content = "";
if (vo.getContent() != null) {
	content = vo.getContent().replace("\r\n", "<br>");
}

DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yy.MM.dd");
LocalDateTime dateTime = vo.getRegDate();
String strRegDate = dateTime.format(formatter);
%>
<div id="wrapper">
	<div id="menu" class="container">
		<jsp:include page="/include/menu.jsp" />
	</div>
	<!-- 리뷰 게시판 -->
	<div id="page" class="container">
		<h3 class="sub_title">review</h3>
		<table class="rev_board">
			<tr>
				<th colspan="3"><%=vo.getSubject()%></th>
			</tr>
			<tr>
				<td colspan="3" style="white-space:pre;"><%=vo.getContent()%></td>
			</tr>
			<tr>
				<td>
				<%
					if (attachList != null && attachList.size() > 0) {
						for (AttachfileVo attachVo : attachList) {
						%>
						<a href="download.jsp?uuid=<%=attachVo.getUuid() %>">
						<%=attachVo.getFilename() %>
						</a>&nbsp;&nbsp;
						<%
						}
					} else {
						%>
						<span> 첨부파일 없음 </span>
						<%
				}
				%>
				</td>
				<td class="small"><%=vo.getName() %></td>
				<td class="small"><%=strRegDate %></td>
			</tr>
			<tr>
			<td colspan="3" class="blank">
					<%
						String bId = vo.getId();
						if (id != null) { // 로그인 했을때
							if (id.equals(bId)) { // 본인이 작성한 글
								%>
								<input type="button" class="button lmargin" value="글목록" onclick="location.href='review.jsp?pageNum=<%=pageNum%>'">
								<input type="button" class="button lmargin" value="답글쓰기" onclick="location.href='replyPost.jsp?reRef=<%=vo.getReRef() %>&reLev=<%=vo.getReLev() %>&reSeq=<%=vo.getReSeq() %>&pageNum=<%=pageNum %>'">
								<input type="reset" class="button lmargin" value="수정하기" onclick="location.href='updateReview.jsp?num=<%=vo.getNum() %>&pageNum=<%=pageNum%>'">
								<input type="submit" class="button" value="삭제하기" onclick="remove()">
								<%
							 	} else if (id.equals("admin")) {
							 	%>
								<input type="button" class="button lmargin" value="글목록" onclick="location.href='review.jsp?pageNum=<%=pageNum%>'">
								<input type="button" class="button lmargin" value="답글쓰기" onclick="location.href='replyPost.jsp?reRef=<%=vo.getReRef() %>&reLev=<%=vo.getReLev() %>&reSeq=<%=vo.getReSeq() %>&pageNum=<%=pageNum %>'">
								<input type="submit" class="button" value="삭제하기" onclick="remove()">
								<%
								} else {
		 						%>
		 						<input type="button" class="button lmargin" value="글목록" onclick="location.href='review.jsp?pageNum=<%=pageNum%>'">
		 						<input type="button" class="button lmargin" value="답글쓰기" onclick="location.href='replyPost.jsp?reRef=<%=vo.getReRef() %>&reLev=<%=vo.getReLev() %>&reSeq=<%=vo.getReSeq() %>&pageNum=<%=pageNum %>'">
		 						<%
		 						}
							} else { // 로그인 아닐때
								if (bId != null) {
									%>
									<input type="button" class="button lmargin" value="글목록" onclick="location.href='review.jsp?pageNum=<%=pageNum%>'">
									<input type="button" class="button lmargin" value="답글쓰기" onclick="location.href='replyPost.jsp?reRef=<%=vo.getReRef() %>&reLev=<%=vo.getReLev() %>&reSeq=<%=vo.getReSeq() %>&pageNum=<%=pageNum %>'">
									<%
								} else {
		 							%>
		 							<input type="button" class="button lmargin" value="글목록" onclick="location.href='review.jsp?pageNum=<%=pageNum%>'">
		 							<input type="button" class="button lmargin" value="답글쓰기" onclick="location.href='replyPost.jsp?reRef=<%=vo.getReRef() %>&reLev=<%=vo.getReLev() %>&reSeq=<%=vo.getReSeq() %>&pageNum=<%=pageNum %>'">
		 							<input type="reset" class="button lmargin" value="수정하기" onclick="location.href='updateCheck.jsp?num=<%=vo.getNum() %>&pageNum=<%=pageNum%>'">
		 							<input type="submit" class="button" value="삭제하기" onclick="removeNm()">
		 							<%
								}
					 	}
						 %>
				</td>
			</tr>
		</table>
	</div>
</div>
	<script>
	function remove() {
		var result = confirm('삭제하시겠습니까?');
		if (result) {
			location.href = 'deleteReview.jsp?num=<%=vo.getNum() %>&pageNum=<%=pageNum %>';
		}
	}
	function removeNm() {
		var result = confirm('삭제하시겠습니까?');
		if (result) {
			location.href = 'deleteCheck.jsp?num=<%=vo.getNum() %>&pageNum=<%=pageNum %>';
		}
	}
	</script>
</body>

</html>