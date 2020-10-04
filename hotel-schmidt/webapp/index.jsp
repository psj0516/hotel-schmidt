<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>

<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>SCHMIDT</title>
<link href="http://fonts.googleapis.com/css?family=Source+Sans+Pro:200,300,400,600,700,900" rel="stylesheet" />
<link href="/css/default.css" rel="stylesheet" type="text/css" media="all" />
<link href="/css/index.css" rel="stylesheet" type="text/css" media="all" />
</head>
<body>
	<div id="wrapper">
		<div id="header-wrapper">
			<div id="header" class="container">
				<div id="logo">
					<h1>
						<a href="#">SCHMIDT</a>
					</h1>
					<p>the most comfortable hotel</p>
				</div>
			</div>
			<div id="menu" class="container">
			<jsp:include page="/include/menu.jsp" />
			</div>
		</div>
		<div id="page" class="container">
			<div class="column1">
				<div class="title">
					<h2>Info</h2>
				</div>
				<p>Donec nonummy magna quis risus. Quisque eleifend. Phasellus tempor vehicula justo. Aliquam lacinia metus.</p>
			</div>
			<div class="column2">
				<div class="title">
					<h2>View</h2>
				</div>
				<img src="images/pic01.jpg" width="282" height="150" alt="" />
				<p>Donec nonummy magna quis risus. Quisque eleifend. Phasellus tempor vehicula justo. Aliquam lacinia metus.</p>
			</div>
			<div class="column3">
				<div class="title">
					<h2>Room</h2>
				</div>
				<img src="images/pic02.jpg" width="282" height="150" alt="" />
				<p>Phasellus tempor vehicula justo. Aliquam lacinia metus ut elit. Suspendisse iaculis mauris nec lorem.</p>
			</div>
			<div class="column4">
				<div class="title">
					<h2>Food</h2>
				</div>
				<img src="images/pic03.jpg" width="282" height="150" alt="" />
				<p>Quisque eleifend. Phasellus tempor vehicula justo. Aliquam lacinia metus ut elit. Suspendisse iaculis mauris.</p>
			</div>
		</div>
	</div>
<jsp:include page="/include/bottom.jsp" />
</body>
</html>
