<%@page import="exam.dao.MemberDao"%>
<%@page import="java.time.LocalDateTime"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%-- 한글처리 --%> 
<% request.setCharacterEncoding("utf-8"); %>

<%
// 2차 아이디 중복체크
String formId = request.getParameter("id");
MemberDao dao = MemberDao.getInstance();

if (dao.dupIdCheck(formId)) {
%>
<script>
	alert('사용할 수 없는 아이디입니다.')
	history.back();
</script>
<%
	return;
}
%>

<jsp:useBean id="vo" class="exam.domain.MemberVo" />
<jsp:setProperty property="*" name="vo"/>

<%-- regDate 날짜 생성 --%>
<% vo.setRegDate(LocalDateTime.now());
dao.insert(vo);
%>

<script>
	alert('가입되었습니다.');
	location.href = '/members/login.jsp';
</script>