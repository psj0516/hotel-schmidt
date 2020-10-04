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
	
	// DB 객체 가져오기
	ReviewBoardDao dao = ReviewBoardDao.getInstance();
	AttachfileDao aDao = AttachfileDao.getInstance();
	
	// 첨부파일 정보 담는 리스트
	List<AttachfileVo> attachList = new ArrayList<>();
	
	// 삭제할 첨부파일 uuid 담기
	List<String> delUuidList = new ArrayList<>();
	
	ReviewBoardVo vo = new ReviewBoardVo();
	
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
			} else if (item.getFieldName().equals("num")) {
				vo.setNum(Integer.parseInt(item.getString("utf-8")));
			} else if (item.getFieldName().equals("delfile")) {
				String uuid = item.getString("utf-8");
				AttachfileVo attachVo = aDao.getAttachfileByUuid(uuid);
				
				// 파일삭제
				File delFile = new File(attachVo.getUploadpath(), attachVo.getUuid() + "_" + attachVo.getFilename());
				
				if (delFile.exists()) {
					delFile.delete();
				}
				delUuidList.add(uuid);
			}
		}
	}
	
	if (delUuidList.size() > 0) {
		aDao.deleteAttachfilesByUuids(delUuidList);
	}
	
	// 파일 업로드
	for (FileItem item : list) {
		 if (!item.isFormField()) {
			// 파일이름이 있을때만 업로드
			if (!item.getString("utf-8").equals("")) {
				String filename = item.getName();
				
				// 익스플로러 파일이름 처리
				int index = filename.lastIndexOf("\\") + 1;
				filename = filename.substring(index);
				
				// uuid 붙이기
				UUID uuid = UUID.randomUUID();
				String strUuid = uuid.toString();

				String uploadFilename = strUuid + "_" + filename;
				
				// 생성할 파일정보 File 객체로 준비
				File file = new File(dir, uploadFilename);
				// 해당 경로에 해당 파일명으로 파일 생성(업로드 수행)
				item.write(file);

				AttachfileVo attachVo = new AttachfileVo();
				attachVo.setBno(vo.getNum());
				attachVo.setUploadpath(dir.getPath());
				attachVo.setUuid(strUuid);
				attachVo.setFilename(filename);
				
				// 파일명 확장자
				String ext = filename.substring(filename.lastIndexOf(".") + 1);
				if (ext.equalsIgnoreCase("png")
						|| ext.equalsIgnoreCase("gif")
						|| ext.equalsIgnoreCase("jpg")
						|| ext.equalsIgnoreCase("jpeg")) {
					attachVo.setImage("I");
				} else {
					attachVo.setImage("O");
				}
				
				attachList.add(attachVo);
			}
		}
	} // for
	
	dao.update(vo);
	aDao.insert(attachList);
	
	response.sendRedirect("review.jsp");
%>