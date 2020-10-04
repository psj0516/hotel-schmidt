<%@page import="java.io.FileInputStream"%>
<%@page import="java.io.BufferedInputStream"%>
<%@page import="java.io.File"%>
<%@page import="exam.domain.AttachfileVo"%>
<%@page import="exam.dao.AttachfileDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
try {
	String uuid = request.getParameter("uuid");
	
	AttachfileDao dao = AttachfileDao.getInstance();
	AttachfileVo vo = dao.getAttachfileByUuid(uuid);
	
	String filename = vo.getUuid() + "_" + vo.getFilename();
	File file = new File(vo.getUploadpath(), filename);
	
	BufferedInputStream is = null;
	is = new BufferedInputStream(new FileInputStream(file));
	
	String mimeType = application.getMimeType(file.getPath());
	if (mimeType == null) {
		mimeType = "application/octet-stream";
	}

	response.setContentType(mimeType);
	
	// 다운로드 파일명 문자셋 utf-8을 iso-8859-1로 변환
	filename = new String(filename.getBytes("utf-8"), "iso8859-1");
	
	// UUID 제거
	int beginIndex = filename.indexOf("_")+1;
	String downloadFilename = filename.substring(beginIndex);
	
	// 다운로드할 파일 이름 설정
	response.setHeader("Content-Disposition", "attachment; filename=" + downloadFilename);
	
	// 출력스트림
	ServletOutputStream os = response.getOutputStream();
	
	int data;
	while ((data = is.read()) != -1) {
		os.write(data);
	}
	
	// 입출력 객체 자원닫기
	os.close(); // close() 내에서 flush() 호출됨
	is.close();
} catch (Exception e) {}
%>