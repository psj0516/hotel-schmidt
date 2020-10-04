<%@page import="java.time.LocalDateTime"%>
<%@page import="java.time.format.DateTimeFormatter"%>
<%@page import="exam.domain.ReviewBoardVo"%>
<%@page import="java.util.List"%>
<%@page import="exam.dao.ReviewBoardDao"%>
<%@ page language="java" contentType="text/html; charset=EUC-KR"
	pageEncoding="utf-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>About</title>
<link href="/css/default.css" rel="stylesheet" type="text/css"
	media="all" />
<link href="/css/about.css" rel="stylesheet" type="text/css" media="all" />
</head>
  <body>
    <div id="wrapper">
      <div id="menu" class="container">
        <jsp:include page="/include/menu.jsp" />
      </div>
      <div id="page" class="container">
        <div class="about-container">
          <div class="column1">
            <h2>About Us</h2>
            <p>
              Lorem ipsum dolor, sit amet consectetur adipisicing elit. Illum
              totam iure harum facilis autem soluta nostrum natus ullam. Veniam
              saepe, soluta error nam voluptate voluptas assumenda cupiditate
              temporibus optio, dignissimos laboriosam esse, ullam perspiciatis.
              Reiciendis porro reprehenderit laudantium quam voluptates? Iure
              voluptatem neque ad quis nulla id adipisci unde libero.
            </p>
            <br>
            <p>
              Lorem ipsum dolor sit amet, consectetur adipisicing elit. Vel
              blanditiis odio nihil optio quisquam nostrum dolore error. Velit
              perspiciatis animi dicta officiis ipsam cupiditate excepturi alias
              non! Eveniet dicta expedita fuga impedit accusamus ex blanditiis
              sed, corporis consequatur at asperiores delectus laboriosam
              assumenda? Accusantium vel nulla quaerat sit reiciendis? Nam.
            </p>
          </div>
          <div class="column4">
            <img src="/images/aboutinfo.jpg" />
          </div>
        </div>
        <div class="clear"></div>
        <br>
        <hr>
        <br>
        <section id="about">
          <div class="column1">
            <img src="/images/aboutbg.jpg" />
          </div>
          <div class="column4">
            <h2 style="text-align: right;">
              History
            </h2>
            <p>
              Lorem ipsum dolor, sit amet consectetur adipisicing elit. Illum
              totam iure harum facilis autem soluta nostrum natus ullam. Veniam
              saepe, soluta error nam voluptate voluptas assumenda cupiditate
              temporibus optio, dignissimos laboriosam esse, ullam perspiciatis.
              Reiciendis porro reprehenderit laudantium quam voluptates? Iure
              voluptatem neque ad quis nulla id adipisci unde libero.
            </p>
            <br>
            <p>
              Lorem ipsum dolor sit amet, consectetur adipisicing elit. Vel
              blanditiis odio nihil optio quisquam nostrum dolore error. Velit
              perspiciatis animi dicta officiis ipsam cupiditate excepturi alias
              non! Eveniet dicta expedita fuga impedit accusamus ex blanditiis
              sed, corporis consequatur at asperiores delectus laboriosam
              assumenda? Accusantium vel nulla quaerat sit reiciendis? Nam.
            </p>
          </div>
        </section>
      </div>
    </div>
	<jsp:include page="/include/bottom.jsp" />

</body>

</html>