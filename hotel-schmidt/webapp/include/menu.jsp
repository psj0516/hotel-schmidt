<%@page import="exam.dao.MemberDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%
	//로그인 유지 쿠키값 가져오기
Cookie[] cookies = request.getCookies();
if (cookies != null) {
	for (Cookie cookie : cookies) {
		if (cookie.getName().equals("id")) {
	String id = cookie.getValue();
	session.setAttribute("id", id);
		}
	}
}

//세션값 가져오기
String id = (String) session.getAttribute("id");
String admin = "admin";
%>

<ul>
	<li class="current_page_item"><a href="/index.jsp" accesskey="1" title="">HOME</a></li>
	<li><a href="/about/about.jsp" accesskey="2" title="">About</a></li>
	<li><a href="/review/review.jsp" accesskey="3" title="">Review</a></li>
</ul>
<div class="members">
	<%
		if (id != null) {
			if (id.equals(admin)) {
				%>
				<p>
					<a href="/admin/adminMembers.jsp">Admin Page</a>|
					<a href="/members/logout.jsp">logout</a>
				</p>
				<%
			} else {
				// 아이디와 일치하는 이름 가져오기
				String name = null;
				MemberDao dao = MemberDao.getInstance();
				name = dao.getNameById(id);
				%>
				<p>
					<a href="/members/mypage.jsp"><%=name%>님 반갑습니다.</a>|
					<a href="/members/logout.jsp">logout</a>
				</p>
				<%
			}
	} else {
	%>
	<p>
		<a href="/members/login.jsp">login</a>|
		<a href="/members/join.jsp">Join</a>
	</p>
	<%
		}
	%>
</div>