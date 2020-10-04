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
<title>Admin | Members</title>
<link href="/css/default.css" rel="stylesheet" type="text/css" media="all" />
<link href="/css/board.css" rel="stylesheet" type="text/css" media="all" />
<style>
a {
	cursor: pointer;
	text-decoration: underline;
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
	
	// 멤버 정보 가져오기
	String memId = request.getParameter("memId");
	
	MemberDao dao = MemberDao.getInstance();
	MemberVo vo = dao.getMemberById(memId);
	
	// 날짜 형식 변환
	DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy.MM.dd");
	LocalDateTime dateTime = vo.getRegDate();
	String strRegDate = dateTime.format(formatter);	
	
	// 작성글
	ReviewBoardDao bDao = ReviewBoardDao.getInstance();
	List<ReviewBoardVo> list = null;
	list = bDao.getBoardsById(memId);	
	
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
						<th>나이</th>
						<th>메일</th>
						<th>전화번호</th>
						<th>가입일자</th>
						<th>회원관리</th>
					</tr>
					<tr>
						<td><%=vo.getId()%></td>
						<td><%=vo.getName() %></td>
						<td><%=vo.getAge() %></td>
						<td><%=vo.getEmail()%></td>
						<td><%=vo.getTel()%></td>
						<td><%=strRegDate%></td>
						<td><a onclick="remove()">강제탈퇴</a></td>
					</tr>
					<tr>
					<th colspan="7">작성글</th>
					</tr>
				<%
				if (list.size() > 0) {					
					for (ReviewBoardVo bVo : list) {
						LocalDateTime writeTime = bVo.getRegDate();
						String writeRegDate = writeTime.format(formatter);	
						%>
						<tr>
							<td colspan="6" class="sub" onclick="location.href='/review/reviewContent.jsp?num=<%=bVo.getNum() %>&pageNum=1'">
							<%=bVo.getSubject() %>
							</td>
							<td>
							<%=writeRegDate %>
							</td>
						</tr>
						<%
					}
				} else {
					%>
					<tr>
					<td colspan="7">작성한 게시글이 없습니다.</td>
					</tr>
					<%
				}
				%>
				</table>
			</div>
		</div>
	</div>
	<script>
	function remove() {
		var result = confirm('<%=vo.getName()%>님을 탈퇴시키겠습니까?');
		if (result) {
			location.href="memberDelete.jsp?memId=<%=vo.getId() %>";
			}
		}
	</script>
</body>

</html>