<%@page import="vo.BoardNoticeVO"%>
<%@page import="dao.BoardNoticeDAO"%>
<%@page import="vo.BoardGallVO"%>
<%@page import="dao.BoardGallDAO"%>
<%@page import="java.util.List"%>
<%@page import="vo.BoardVO"%>
<%@page import="dao.BoardDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>1짤 - 2짤 짝퉁싸이트</title>
<link href="../css/default.css" rel="stylesheet" type="text/css">
<link href="../css/front.css" rel="stylesheet" type="text/css">

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
<!-- 헤더파일들어가는 곳 -->
<jsp:include page="../inc/top_login.jsp" />
<jsp:include page="../inc/top.jsp" />
<!-- 헤더파일들어가는 곳 -->
<!-- 메인이미지 들어가는곳 -->
<div id="main_img"><img src="../images/mainJJal.jpg"
 width="971" height="282"></div>
<!-- 메인이미지 들어가는곳 -->
<!-- 메인 콘텐츠 들어가는 곳 -->
<article id="front">

<!-- 베스트 짤 -->
<div id="bestJJal">
<fieldset>
<legend class="best">BEST 짤</legend>
<%
	BoardGallDAO bdao_gall = BoardGallDAO.getInstance();
	List<BoardGallVO> boardList_gall = bdao_gall.getBestBoardList(1, 3);
	
	for(int i=0; i<boardList_gall.size(); i++) { 
		BoardGallVO board_gall = (BoardGallVO)boardList_gall.get(i);
%>
<div id="center-top">
<a href="../board_gall/content.jsp?num=<%=board_gall.getNum()%>&pageNum=1&readCount=true">
<img src="../board_gall_upload/<%=board_gall.getFile()%>" alt="<%=board_gall.getFile()%>" width="200px" height="200px">
</a><br><div id="grade"><%=i+1%>위<br><br>조회수 : <%=board_gall.getReadcount() %></div>
</div>
<%} %>
</fieldset>
</div>
<div class="clear"></div>
<!-- 베스트 짤 -->

<!-- 최신 짤 -->
<div id="recentJJal">
<fieldset>
<legend class="best">최신 짤</legend>
<%
	boardList_gall = bdao_gall.getBoardList(1, 6);
	
	for(int i=0; i<boardList_gall.size(); i++) {
		BoardGallVO board_gall = (BoardGallVO)boardList_gall.get(i);%>
<div id="center-bottom">		
<a href="../board_gall/content.jsp?num=<%=board_gall.getNum()%>&pageNum=1&readCount=true">
<img src="../board_gall_upload/<%=board_gall.getFile()%>" alt="<%=board_gall.getFile()%>" width="140px" height="140px" >
</a>
</div>
<%} %>
</fieldset>
</div>
<div class="clear"></div>
<!-- 최신 짤 -->

<!-- 공지사항 -->
<div id="sec_news">
<h3><span class="orange">공지사항</span></h3>
<%
BoardNoticeDAO bdao_notice = BoardNoticeDAO.getInstance();
List<BoardNoticeVO> boardList_notice = bdao_notice.getBoardList(1, 3);
for(int i=0; i<boardList_notice.size(); i++) {
	BoardNoticeVO board_notice = (BoardNoticeVO)boardList_notice.get(i);

%>
<dl>
<dt><a href="../board_notice/content.jsp?num=<%=board_notice.getNum()%>&pageNum=1&readCount=true"><%=board_notice.getSubject() %></a></dt>
<dd><%=board_notice.getContent() %></dd>
</dl>
<%} %>
</div>
<!-- 공지사항 -->

<!-- 최신 글 -->
<div id="news_notice">
<h3 class="brown">최근에 올라온 글</h3>
<table>
<%
	BoardDAO bdao = BoardDAO.getInstance();
	List<BoardVO> boardList = bdao.getBoardList(1, 5);
	
	for(int i=0; i<boardList.size(); i++) { 
		BoardVO board = (BoardVO)boardList.get(i); %>
		<tr><td class="contxt"><a href="../board/content.jsp?num=<%=board.getNum() %>"><%=board.getSubject() %></a></td><td><%=board.dateToString() %></td></tr>
	<%}
%>	
</table>		
</div>
<!-- 최신 글 -->
</article>
<!-- 메인 콘텐츠 들어가는 곳 -->
<div class="clear"></div>
<!-- 푸터 들어가는 곳 -->
<jsp:include page="../inc/bottom.jsp"/>
<!-- 푸터 들어가는 곳 -->
</div>
</body>
</html>