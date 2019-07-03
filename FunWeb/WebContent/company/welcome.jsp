<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>제작자</title>
<link href="../css/default.css" rel="stylesheet" type="text/css">
<link href="../css/subpage.css" rel="stylesheet" type="text/css">

<!--[if lt IE 9]>
<script src="http://ie7-js.googlecode.com/svn/version/2.1(beta4)/IE9.js" type="text/javascript"></script>
<script src="http://ie7-js.googlecode.com/svn/version/2.1(beta4)/ie7-squish.js" type="text/javascript"></script>
<script src="http://html5shim.googlecode.com/svn/trunk/html5.js" type="text/javascript"></script>
<![endif]-->

<!--[if IE 6]>
 <script src="../script/DD_belatedPNG_0.0.8a.js"></script>
 <script>
   /* EXAMPLE */
   DD_belatedPNG.fix('#wrap');
   DD_belatedPNG.fix('#main_img');   

 </script>
 <![endif]-->
 
</head>
<body>
<div id="wrap">
<!-- 헤더들어가는 곳 -->
<jsp:include page="../inc/top_login.jsp" />
<jsp:include page="../inc/top.jsp" />
<!-- 헤더들어가는 곳 -->

<!-- 본문 들어가는 곳 -->
<!-- 서브페이지 메인이미지 -->
<img src="../images/undongosu.jpg" width="970px" height="300px">
<!-- 서브페이지 메인이미지 -->
<!-- 왼쪽메뉴 -->
<nav id="sub_menu">
<ul>
<li><a href="../company/welcome.jsp">소개</a></li>
<li><a href="../board_notice/list.jsp">공지사항</a></li>
<li><a href="http://2runzzal.com/" target="blank">자매 사이트</a></li>
</ul>
</nav>
<!-- 왼쪽메뉴 -->
<!-- 내용 -->
<article>
<h1>Welcome</h1>
<figure class="ceo"><img src="../images/company/merong.gif" width="196" height="226" 
alt="CEO"><figcaption>Fun Web CEO 변정훈씨</figcaption>
</figure>
<p id="intro">
제작자 : 변정훈<br>
제작자 경력 : 이번에 처음 만들어봄<br>
제작자 기술 : <br>
자바 - 초급<br>
jsp - 초급<br>
javascript - 초급<br>
css - 초급<br>
database - 초급<br>
리눅스, 서버 - 맛만보고 하산함<br>	 
사이트 이름 : 1짤 <br>
사이트 소개 : 재밌는 짤들을 공유하는 사이트 입니다.<br> 
</p>
</article>
<!-- 내용 -->
<!-- 본문 들어가는 곳 -->
<div class="clear"></div>
<!-- 푸터들어가는 곳 -->
<jsp:include page="../inc/bottom.jsp"/>
<!-- 푸터들어가는 곳 -->
</div>
</body>
</html>
