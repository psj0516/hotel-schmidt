<%@page import="com.google.gson.Gson"%>
<%@page import="java.util.HashMap"%>
<%@page import="java.util.Map"%>
<%@page import="exam.dao.MemberDao"%>
<%@ page language="java" contentType="application/json; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%
	String id = request.getParameter("id");

	if (id == null || id.length() == 0) {
		return;
	}

	MemberDao dao = MemberDao.getInstance();
	
	boolean isIdDup = dao.dupIdCheck(id);
	
	Map<String, Object> map = new HashMap<>();
	map.put("isIdDup", isIdDup);

	Gson gson = new Gson();
	String strJson = gson.toJson(map);
	out.println(strJson);
%>