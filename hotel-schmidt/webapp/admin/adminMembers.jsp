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
<title>Admin | Members</title>
<link href="/css/default.css" rel="stylesheet" type="text/css" media="all" />
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
.pages {
width: 500px !important;
margin: auto;
}
</style>
</head>
<body>
	<%
	//Admin 사용자 확인
	String id = (String) session.getAttribute("id");
	if (id == null || !id.equals("admin")) {
		response.sendRedirect("/index.jsp");
		return;
	}
	
	// 멤버 목록 가져오기
	MemberDao dao = MemberDao.getInstance();
	int totalCount = dao.getTotalCount();
	
	// 페이지번호
	String strPageNum = request.getParameter("pageNum");
	if (strPageNum == null || strPageNum.equals("")) {
		strPageNum = "1";
	}

	int pageNum = Integer.parseInt(strPageNum);
	int pageSize = 10;
	int startRow = (pageNum-1) * pageSize;
	
	List<MemberVo> list = null;
	if (totalCount > 0) {
		list = dao.getMembers(startRow, pageSize);
	}
	
	%>
	<div id="wrapper">
		<div id="menu" class="container">
			<jsp:include page="/include/menu.jsp" />
		</div>
		<!-- 리뷰 게시판 -->
		<div id="page" class="container">
			<jsp:include page="/include/adminSub.jsp" />
			<div class="column4">
				<h3 class="sub_title">회원 관리</h3>
				<table class="rev_management">
					<tr>
						<th>아이디</th>
						<th>이름</th>
						<th>회원관리</th>
					</tr>
					<%
					if (totalCount > 0) {
						for (MemberVo vo : list) {
						// 날짜 형식 변환
						DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy.MM.dd");
						LocalDateTime dateTime = vo.getRegDate();
						String strRegDate = dateTime.format(formatter);
					%>
					<tr>
						<td><%=vo.getId()%></td>
						<td><%=vo.getName() %></td>
						<td>
						<%
						if (vo.getId().equals("admin")) {
							%>
							관리자
							<%
						} else {
								%>
								<a href="memberInfo.jsp?memId=<%=vo.getId() %>">회원관리</a>
								<%
							}
						}
							%>
						</td>
					</tr>
					<%
					} else {
					%>
					<tr>
					<td colspan="3">가입한 회원이 없습니다.</td>
					</tr>
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
						<p class="pagenum" onclick="location.href='adminMembers.jsp?pageNum=<%=startPage - pageBlock %>'">이전</p>
						<%
					}
					
					for (int i=startPage; i<=endPage; i++) {
						%>
						<p class="pagenum" onclick="location.href='adminMembers.jsp?pageNum=<%=i %>'">
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
						<p class="pagenum" onclick="location.href='adminMembers.jsp?pageNum=<%=startPage + pageBlock %>'">다음</p>
						<%
					}
				}
				%>
				</div>
			</div>
		</div>
	</div>
</body>

</html>