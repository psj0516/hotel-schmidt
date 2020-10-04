<%@page import="exam.dao.MemberDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
// 파라미터 가져오기
String id = request.getParameter("id");
String passwd = request.getParameter("passwd");
String url = request.getParameter("pageUrl");

boolean keepLogin = false;
String strKeepLogin = request.getParameter("keepLogin");
if(strKeepLogin != null) {
	keepLogin = Boolean.parseBoolean(strKeepLogin);
}


MemberDao dao = MemberDao.getInstance();
int check = dao.userCheck(id, passwd);

if (check == 1) { // 로그인 성공
	session.setAttribute("id", id);
	// 로그인 유지
	if (keepLogin) {
		Cookie loginCookie = new Cookie("id", id);
		loginCookie.setMaxAge(60*30);
		loginCookie.setPath("/");
		response.addCookie(loginCookie);
	}
	
	if (!url.equals("null")){
		response.sendRedirect(url);
	} else {
		response.sendRedirect("/index.jsp");
	}
	
} else if (check == 0) {
	%>
	<script>
		alert('아이디가 존재하지 않거나, 비밀번호가 일치하지 않습니다.');
		history.back();
	</script>
	<%
}
%>