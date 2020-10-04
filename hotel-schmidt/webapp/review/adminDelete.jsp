<%@page import="java.io.File"%>
<%@page import="exam.domain.AttachfileVo"%>
<%@page import="java.util.List"%>
<%@page import="exam.dao.AttachfileDao"%>
<%@page import="exam.dao.ReviewBoardDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
String id = (String) session.getAttribute("id");
if (id == null || !id.equals("admin")) {
	response.sendRedirect("/index.jsp");
	return;
}

String pageNum = request.getParameter("pageNum");
String[] selected = request.getParameterValues("selected") ;

if (selected != null) {
	ReviewBoardDao dao = ReviewBoardDao.getInstance();
	AttachfileDao attachDao = AttachfileDao.getInstance();
	for (int i=0; i<selected.length; i++) {
		int bno = Integer.parseInt(selected[i]);
		List<AttachfileVo> attachList = attachDao.getAttachfilesByBno(bno);
		
		for (AttachfileVo attachVo : attachList) {
			String filename = attachVo.getUuid() + "_" + attachVo.getFilename();

			File file = new File(attachVo.getUploadpath(), filename);
			
			if (file.exists()) {
				file.delete();
			}
		}
		attachDao.deleteAttachfilesByBno(bno);
		dao.deleteByNum(bno);
	}
	response.sendRedirect("review.jsp?pageNum=" + pageNum);
} else {
	%>
	<script>
	alert('선택한 글이 없습니다.')
	history.back();
	</script>
	<%
}
%>