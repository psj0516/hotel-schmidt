<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
session.invalidate();

Cookie[] cookies = request.getCookies();
if (cookies != null) {
	for (Cookie cookie : cookies) {
		if (cookie.getName().equals("id")) {
	cookie.setMaxAge(0);
	cookie.setPath("/");
	response.addCookie(cookie);
		}
	}
}
%>

<script>
	alert('로그아웃 되었습니다.');
	location.href='<%=request.getHeader("REFERER") %>';
</script>