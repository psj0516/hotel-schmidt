<%@page import="java.time.LocalDateTime"%>
<%@page import="java.time.format.DateTimeFormatter"%>
<%@page import="exam.domain.ReviewBoardVo"%>
<%@page import="java.util.List"%>
<%@page import="exam.dao.ReviewBoardDao"%>
<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<script src="https://kit.fontawesome.com/f31fb562ea.js" crossorigin="anonymous"></script>
<title>Review</title>
<link href="/css/default.css" rel="stylesheet" type="text/css"
	media="all" />
<link href="/css/board.css" rel="stylesheet" type="text/css" media="all" />
<style>
p {
cursor: pointer;
}
img {
margin-bottom: 0px !important;
}
i {
color: #3a89ff
}
</style>
</head>
<body>
<%
String id = (String) session.getAttribute("id");
ReviewBoardDao dao = ReviewBoardDao.getInstance();

// 검색
String category = request.getParameter("category");
String search = request.getParameter("search");
category = (category == null) ? "" : category;
search = (search == null) ? "" : search;

// 전체 글 갯수
int totalCount = dao.getTotalCount(category, search);

// 페이지번호 파라미터
String strPageNum = request.getParameter("pageNum");
if (strPageNum == null || strPageNum.equals("")) {
	strPageNum = "1";
}

int pageNum = Integer.parseInt(strPageNum);
int pageSize = 10;
int startRow = (pageNum-1) * pageSize;

List<ReviewBoardVo> list = null;
if (totalCount > 0) {
	list = dao.getBoards(startRow, pageSize, category, search);
}
%>
	<div id="wrapper">
		<div id="menu" class="container">
			<jsp:include page="/include/menu.jsp" />
		</div>
		<!-- 리뷰 게시판 -->
		<div id="page" class="container">
		<div id="boardheader">
			<h2>Review</h2>
			<span>방문객들의 후기를 확인하세요.<br><br></span>
		</div>
			<div id="search">
				<form action="review.jsp" method="get">
					<select name="category" class="category">
						<option value="content" <% if (category.equals("content")) { %>selected<% } %>>글내용</option>
						<option value="subject" <% if (category.equals("subject")) { %>selected<% } %>>글제목</option>
						<option value="name" <% if (category.equals("name")) { %>selected<% } %>>작성자</option>
					</select>
					<input type="text" name="search" value="<%=search %>" class="searchbox"> 
					<input type="submit" value="검색" class="button">
				</form>
			</div>
			<form action="adminDelete.jsp" method="post">
			<table>
				<tr>
				<%
				if (id !=null && id.equals("admin")) {
					%>
					<th class="select">선택</th>
					<input type=hidden name="pageNum" value="<%=pageNum %>">
					<%
				}
				%>
					<th class="num">글번호</th>
					<th class="subject">제목</th>
					<th class="name">작성자</th>
					<th class="view">조회수</th>
					<th class="date">작성일</th>
				</tr>
				<%
					if (totalCount > 0) {
							DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yy.MM.dd");
							
							for (ReviewBoardVo vo : list) {
								LocalDateTime dateTime = vo.getRegDate();
								String strRegDate = dateTime.format(formatter);
				%>
						<tr>
						<%
						if (id !=null && id.equals("admin")) {
							%>
							<td><input type="checkbox" name="selected" value="<%=vo.getNum() %>"></td>
							<%
						}
						%>
							<td><%=vo.getNum() %></td>
							<td class=sub onclick="location.href='reviewContent.jsp?num=<%=vo.getNum() %>&pageNum=<%=pageNum %>'"><%
								if (vo.getReLev() > 0) {
							%> <img src="/images/level.gif" width="<%=vo.getReLev() * 10%>" height="13">
							<i class="fab fa-replyd"></i> <%}%>
							<%=vo.getSubject()%>
							</td>
							<td><%=vo.getName() %></td>
							<td><%=vo.getReadCount() %></td>
							<td><%=strRegDate %></td>
						</tr>
						<%
					}
				} else {
					%>
					<tr>
					<td colspan="5">게시글이 존재하지 않습니다.</td>
					<%
				}
				%>
			</table>
			<br>
			<div class="pages">
			<%
			if (totalCount > 0) {
				int pageCount = totalCount/pageSize;
				if (totalCount % pageSize > 0) {
					pageCount += 1;
				}
				int pageBlock = 10;
				
				int startPage = ((pageNum / pageBlock) - (pageNum % pageBlock == 0 ? 1 : 0)) * pageBlock + 1;
				int endPage = startPage + pageBlock - 1;
				if (endPage > pageCount) {
					endPage = pageCount;
				}
				
				if (startPage > pageBlock) {
					%>
					<p class="pagenum" onclick="location.href='review.jsp?pageNum=<%=startPage - pageBlock %>'">이전</p>
					<%
				}
				
				for (int i=startPage; i<=endPage; i++) {
					%>
					<p class="pagenum" onclick="location.href='review.jsp?pageNum=<%=i %>'">
					<%
					if (i == pageNum) {
						%>
						<span style="font-weight: bold;"><%=i %></span>
						<%
					} else {
						%>
						<%=i %>
						<%
					}
					%>
					</p>
					<%
				}
				
				if (endPage < pageCount) {
					%>
					<p class="pagenum" onclick="location.href='review.jsp?pageNum=<%=startPage + pageBlock %>'">다음</p>
					<%
				}
			}
			%>
			</div>
			<input type="button" class="button"
				onclick="location.href='/review/reviewPost.jsp?pageNum=<%=pageNum %>'" value="글쓰기">
			<%
			if (id !=null && id.equals("admin")) {
				%>
				<input type="submit" class="button" style='margin-right: 5px' value="선택 삭제">
				<%
			}
			%>
			</form>
			<div class="clear"></div>
		</div>
	</div>
	<jsp:include page="/include/bottom.jsp" />
</body>

</html>