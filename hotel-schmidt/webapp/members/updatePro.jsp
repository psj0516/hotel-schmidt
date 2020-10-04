<%@page import="exam.dao.MemberDao"%>
<%@page import="exam.domain.MemberVo"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	// 세션값 가져오기
	String id = (String) session.getAttribute("id");

	if (id == null) {
		response.sendRedirect("/index.jsp");
		return;
	}
	
	request.setCharacterEncoding("utf-8");
%>

	<jsp:useBean id="vo" class="exam.domain.MemberVo" />
	<jsp:setProperty property="*" name="vo"/>
	
	<%
	MemberDao dao = MemberDao.getInstance();
	
	int rowCount = dao.update(vo);
	if (rowCount > 0) {
		%>
		<script>
			alert('수정하였습니다.');
			location.href = '/members/mypage.jsp';
		</script>
		<%
	} else {
		%>
		<script>
			alert('수정 실패\n다시 시도해주세요.');
			history.back();
		</script>
		<%
	}
%>

