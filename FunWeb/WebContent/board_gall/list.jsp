<%@page import="dao.BoardGall_DatDAO"%>
<%@page import="dao.BoardGallDAO"%>
<%@page import="vo.BoardGallVO"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>짤 게시판</title>
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

<!-- 본문들어가는 곳 -->
<!-- 메인이미지 -->
<!-- <div id="sub_img_center"></div> -->
<!-- 메인이미지 -->

<!-- 왼쪽메뉴 -->
<nav id="sub_menu">
<img src="../images/hi1.jpg" width="150px"><br>
<img src="../images/hi2.jpg" width="150px">
</nav>
<!-- 왼쪽메뉴 -->

<!-- 게시판 -->
<article>
<h1>짤!</h1>
<%
	String search = request.getParameter("search");

	List<BoardGallVO> boardList = null;
	BoardGallDAO bdao = BoardGallDAO.getInstance();
	int count = bdao.getBoardCount(); // 전체 글 개수
	int pageSize = 9;
	String pageNum = request.getParameter("pageNum");
	if(pageNum == null) {
		pageNum = "1";
	}
	int currentPage = Integer.parseInt(pageNum);
	int startRow = (currentPage-1) * pageSize + 1;
	int endRow = currentPage * pageSize;
	
	if(search == null) {
		boardList = bdao.getBoardList(startRow, pageSize);
	} else { 
		boardList = bdao.getBoardList(startRow, pageSize, search);
		count = boardList.size();
	}
%> 
<%
 	if(session.getAttribute("id") != null) {
 %>
<div id="table_write">
	<input type="button" value="글쓰기" onclick="location.href='write.jsp'">
</div>
<%
	}
%>
<div class="clear"></div>
<table id="notice">
	<tr>
		<%
			for(int i=0; i<boardList.size(); i++) {
			BoardGallVO board = (BoardGallVO)boardList.get(i);
			
			// 댓글 갯수 받아오기
			BoardGall_DatDAO bddao = BoardGall_DatDAO.getInstance();
			int dat_Count = bddao.getDatCount(board.getNum());
		%>
			<td><a href="content.jsp?num=<%=board.getNum()%>&pageNum=<%=pageNum%>&readCount=true">
			<img src="../board_gall_upload/<%=board.getFile()%>" alt="<%=board.getFile()%>" width="200px" height="200px"></a><br>
			<b><%=board.getSubject() %></b>
			<span id="dat_countfont">[<%=dat_Count %>]</span><br>
			<%=board.getName() %><br>
			<%=board.dateToString() %>
			조회<%=board.getReadcount() %>
			<br></td>
			<% if((i+1) % 3 == 0) {%>  
				</tr>
				<tr>
		  	<%} 
		  }
		%>
	</tr>
</table>
<div id="table_search">
<form action="list.jsp" method="get">
<input type="text" name="search" class="input_box">
<input type="submit" value="검색" class="btn">
</form>
</div>
<div class="clear"></div>
<div id="page_control">
<%
	if(count != 0) {
		int pageCount = count / pageSize + (count % pageSize != 0 ? 1 : 0);// 전체페이지수
		int pageBlock = 5;
		int startPage = (currentPage-1)/pageBlock * pageBlock + 1;
		int endPage = startPage + pageBlock - 1;
		if(endPage > pageCount) {
			endPage = pageCount;
		}
		
		if(currentPage > pageBlock) {%>
		<a href="list.jsp?pageNum=<%=startPage-pageBlock %>">[이전]</a>
		<%}
		for(int i=startPage; i<=endPage; i++) {
				if(i != currentPage) { %>
					<a href="list.jsp?pageNum=<%=i %>">[<%=i %>]</a>
				<%} else { %>
					<b>[<%=i %>]</b>
				<%}
		} 
		if(pageCount - startPage >= pageBlock ) {%>
		<a href="list.jsp?pageNum=<%=startPage+pageBlock%>">[다음]</a>
		<%} 
	}
%>
</div>
</article>
<!-- 게시판 -->
<!-- 본문들어가는 곳 -->
<div class="clear"></div>
<!-- 푸터들어가는 곳 -->
<jsp:include page="../inc/bottom.jsp"/>
<!-- 푸터들어가는 곳 -->
</div>
</body>
</html>