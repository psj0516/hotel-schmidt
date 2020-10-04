<%@page import="exam.dao.ReviewBoardDao"%>
<%@page import="java.io.File"%>
<%@page import="exam.domain.AttachfileVo"%>
<%@page import="java.util.List"%>
<%@page import="exam.dao.AttachfileDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
int bno = Integer.parseInt(request.getParameter("num"));
String pageNum = request.getParameter("pageNum");

// 파일 삭제
AttachfileDao attachDao = AttachfileDao.getInstance();
List<AttachfileVo> attachList = attachDao.getAttachfilesByBno(bno);

for (AttachfileVo attachVo : attachList) {
	String filename = attachVo.getUuid() + "_" + attachVo.getFilename();

	File file = new File(attachVo.getUploadpath(), filename);
	
	if (file.exists()) {
		file.delete();
	}
}

// 첨부파일 DB 삭제
attachDao.deleteAttachfilesByBno(bno);

// 게시판 DB 삭제
ReviewBoardDao dao = ReviewBoardDao.getInstance();
dao.deleteByNum(bno);

response.sendRedirect("review.jsp?pageNum=" + pageNum);

%>