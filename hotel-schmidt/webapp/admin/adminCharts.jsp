<%@page import="com.google.gson.Gson"%>
<%@page import="exam.dao.ChartDao"%>
<%@page import="java.time.LocalDateTime"%>
<%@page import="java.time.format.DateTimeFormatter"%>
<%@page import="exam.domain.MemberVo"%>
<%@page import="java.util.List"%>
<%@page import="exam.dao.MemberDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>Admin | Charts</title>
<link href="/css/default.css" rel="stylesheet" type="text/css" media="all" />
<link href="/css/board.css" rel="stylesheet" type="text/css" media="all" />
<style>
p {
cursor: pointer;
}
img {
margin-bottom: 0px !important;
}
i {
color: #3a89ff
}
.pages {
width: 500px !important;
margin: auto;
}
div .pie_chart {
width: 550px;
height: 400px;
}
</style>
</head>
<body>
	<%
	//Admin 사용자 확인
	String id = (String) session.getAttribute("id");
	if (id == null || !id.equals("admin")) {
		response.sendRedirect("/index.jsp");
		return;
	}
		
	ChartDao dao = ChartDao.getInstance();
	List<List<Object>> dateList = dao.getBoardDate();
	List<List<Object>> ageList = dao.getAge();

	Gson gson = new Gson();
	String dateStr = gson.toJson(dateList);
	String ageStr = gson.toJson(ageList);
	%>
	<div id="wrapper">
		<div id="menu" class="container">
			<jsp:include page="/include/menu.jsp" />
		</div>
		<!-- 리뷰 게시판 -->
		<div id="page" class="container">
			<jsp:include page="/include/adminSub.jsp" />
			<div class="column4">
				<h3 class="sub_title">통계</h3>
				<div id="pie_chart_1" class="pie_chart"></div>
				<div id="pie_chart_2" class="pie_chart"></div>
			</div>
		</div>
	</div>
	<script src="https://www.gstatic.com/charts/loader.js"></script>
	<script>
	google.charts.load('current', {packages: ['corechart']});
	
	google.charts.setOnLoadCallback(function () {
		pieChart1();
		pieChart2();
	});
	
	// 차트 1
	function pieChart1() {
		var arr = <%=dateStr %>;	
		var dataTable = google.visualization.arrayToDataTable(arr);
		var options = {
				title: '기간별 게시글 작성수'
		};
		
		var objDiv = document.getElementById('pie_chart_1');
		var chart = new google.visualization.PieChart(objDiv);
		chart.draw(dataTable, options);
	}
	
	// 차트2
	function pieChart2() {
		var arr = <%=ageStr %>;
		var dataTable = google.visualization.arrayToDataTable(arr);
		var options = {
				title: '회원 연령대 분포'
		};
		
		var objDiv = document.getElementById('pie_chart_2');
		var chart = new google.visualization.PieChart(objDiv);
		chart.draw(dataTable, options);
	}
	</script>
</body>

</html>