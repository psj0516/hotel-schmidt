<%@page import="exam.domain.ReviewBoardVo"%>
<%@page import="exam.dao.ReviewBoardDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
String pageNum = request.getParameter("pageNum");
%>

<jsp:useBean id="vo" class="exam.domain.ReviewBoardVo" />
<jsp:setProperty property="*" name="vo"/>

<%
ReviewBoardDao dao = ReviewBoardDao.getInstance();
ReviewBoardVo bVo = dao.getBoardByNum(vo.getNum());

if (bVo.getPasswd().equals(vo.getPasswd())) {
	response.sendRedirect("deleteReview.jsp?num=" + vo.getNum() + "&pageNum=" + pageNum);
} else {
	%>
	<script>
		alert('비밀번호가 일치하지 않습니다.');
		history.back();
	</script>
	<%
}
%>