<%@page import="java.util.UUID"%>
<%@page import="exam.domain.ReviewBoardVo"%>
<%@page import="java.util.ArrayList"%>
<%@page import="exam.dao.AttachfileDao"%>
<%@page import="exam.domain.AttachfileVo"%>
<%@page import="exam.dao.ReviewBoardDao"%>
<%@page import="org.apache.commons.fileupload.FileItem"%>
<%@page import="java.util.List"%>
<%@page import="java.io.File"%>
<%@page import="java.time.format.DateTimeFormatter"%>
<%@page import="java.time.LocalDateTime"%>
<%@page import="org.apache.commons.fileupload.DiskFileUpload"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
	String path = "C:/Users/it/Desktop/upload";
	String pageNum = request.getParameter("pageNum");
	
	LocalDateTime dateTime = LocalDateTime.now();
	DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd");
	String strDate = dateTime.format(formatter);
	
	File dir = new File(path, strDate); // 날짜별로 하위폴더 생성
	if (!dir.exists()) {
		dir.mkdir();
	}
	
	DiskFileUpload upload = new DiskFileUpload();
	
	upload.setSizeMax(1024 * 1024 * 20); // 용량제한 20MB
	upload.setSizeThreshold(4068);
	upload.setRepositoryPath("C:/Users/it/Desktop/upload");
	
	List<FileItem> list = upload.parseRequest(request);
	
	ReviewBoardDao dao = ReviewBoardDao.getInstance();
	AttachfileDao aDao = AttachfileDao.getInstance();
	
	// 첨부파일 정보 담는 리스트
	List<AttachfileVo> attachList = new ArrayList<>();
	
	// 글번호 생성 / 설정
	int num = dao.getBoardNum();
	ReviewBoardVo vo = new ReviewBoardVo();
	vo.setNum(num);
	
	for (FileItem item : list) {
		if (item.isFormField()) { // 텍스트값
			if (item.getFieldName().equals("name")) {
		vo.setName(item.getString("utf-8"));
			} else if (item.getFieldName().equals("passwd")) {
		vo.setPasswd(item.getString("utf-8"));
			} else if (item.getFieldName().equals("id")) {
		vo.setId(item.getString("utf-8"));
			} else if (item.getFieldName().equals("subject")) {
		vo.setSubject(item.getString("utf-8"));
			} else if (item.getFieldName().equals("content")) {
		vo.setContent(item.getString("utf-8"));
			} else if (item.getFieldName().equals("reRef")) {
		vo.setReRef(Integer.parseInt(item.getString("utf-8")));
			} else if (item.getFieldName().equals("reSeq")) {
		vo.setReSeq(Integer.parseInt(item.getString("utf-8")));		
			} else if (item.getFieldName().equals("reLev")) {
		vo.setReLev(Integer.parseInt(item.getString("utf-8")));		
			}
		} else { // 파일
			if (!item.getString("utf-8").equals("")) { // 파일 이름이 있을 때
		AttachfileVo aVo = new AttachfileVo();
		aVo.setBno(num);
		aVo.setUploadpath(dir.getPath());
	
		String filename = item.getName();
	
		// 익스플로러 (파일 이름에 포함된 경로 자르고 가져오기)
		int index = filename.lastIndexOf("\\") + 1;
		filename = filename.substring(index);
	
		aVo.setFilename(filename);
	
		// 파일 확장자 구분
		String ext = filename.substring(filename.lastIndexOf(".") + 1);
		if (ext.equalsIgnoreCase("png") || ext.equalsIgnoreCase("gif") || ext.equalsIgnoreCase("jpg")
				|| ext.equalsIgnoreCase("jpeg")) {
			aVo.setImage("I"); // 이미지
		} else {
			aVo.setImage("O"); // 일반 파일
		}
	
		UUID uuid = UUID.randomUUID();
		String strUuid = uuid.toString();
		aVo.setUuid(strUuid);
	
		filename = strUuid + "_" + filename;
	
		File file = new File(dir, filename);
		item.write(file);
	
		attachList.add(aVo);
			} // 파일 if
		}
	} // for
	
	vo.setRegDate(LocalDateTime.now());
			
	dao.replyInsert(vo);
	aDao.insert(attachList);
	
	response.sendRedirect("review.jsp?pageNum" + pageNum);
%>