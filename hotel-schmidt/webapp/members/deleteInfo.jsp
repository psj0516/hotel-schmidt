<%@page import="exam.dao.MemberDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
	// 멤버 정보 가져오기
	String memId = request.getParameter("memId");
	MemberDao dao = MemberDao.getInstance();
	
	
	// 사용자 확인
	String id = (String) session.getAttribute("id");
	if (id != null || !id.equals(memId)) {
		dao.deleteById(memId);
	} else {
		response.sendRedirect("/index.jsp");
		return;
	}
%>

<script>
	alert("탈퇴하였습니다.");
	location.href = '/index.jsp';
</script>