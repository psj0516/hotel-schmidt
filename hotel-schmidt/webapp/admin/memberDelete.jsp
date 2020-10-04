<%@page import="exam.domain.MemberVo"%>
<%@page import="exam.dao.MemberDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
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
	dao.deleteById(memId);
	%>

<script>
	alert("탈퇴시켰습니다.");
	location.href = '/admin/adminMembers.jsp';
</script>