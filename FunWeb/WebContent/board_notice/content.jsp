<%@page import="java.util.List"%>
<%@page import="vo.BoardNoticeVO"%>
<%@page import="dao.BoardNoticeDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>공지사항</title>
<link href="../css/default.css" rel="stylesheet" type="text/css">
<link href="../css/subpage.css" rel="stylesheet" type="text/css">
<link href="../css/mycss.css" rel="stylesheet" type="text/css">
</head>
<body>
<div id="wrap">
<!-- 헤더 들어가는 곳 -->
<div id="login"></div>
<jsp:include page="../inc/top.jsp" />
<!-- 헤더 들어가는 곳 -->
<!-- 서브페이지 메인이미지 -->
<img src="../images/gongji.gif" width="970px" height="300px">
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

<!-- 게시판 -->
<%
	int num = Integer.parseInt(request.getParameter("num"));
	String pageNum = request.getParameter("pageNum");
	String readCount = request.getParameter("readCount");
	String search = request.getParameter("search");
	
	BoardNoticeDAO bdao = BoardNoticeDAO.getInstance();
	
	if(readCount != null) {
		bdao.updateReadcount(num);
	}
	
	BoardNoticeVO board = bdao.getBoard(num);
	
	String content = board.getContent();
	content = content.replaceAll(System.getProperty("line.separator"), "<br>");
%>
<article>
<h1>공지사항</h1>
<table class="greyGridTable">
	<tr>
		<th>번호</th><td><%=board.getNum() %></td>
		<th>조회수</th><td><%=board.getReadcount() %></td>
	</tr>
	<tr>
		<th>작성자</th><td><%=board.getName() %></td>
		<th>작성날짜</th><td><%=board.dateToString() %></td>
	</tr>
	<tr>
		<th>제목</th><td colspan="3"><%=board.getSubject() %></td>
	</tr>
	<tr>
		<th>내용</th>
		<td colspan="3">
		<%if(board.getFile() != null) { %>
			<img src="../board_notice_upload/<%=board.getFile() %>" alt="<%=board.getFile() %>" ><br>
		<%} %>
		<%=content%></td>
	</tr>
	<tr>
		<td colspan="4" style="text-align: center;">
			<input type="button" value="글목록" onclick="location.href='list.jsp?pageNum=<%=pageNum%><%if(search != null) {%>&search=<%=search%><%}%>'">
			<% 
				String id = (String)session.getAttribute("id");
				if(id != null) {
					if(id.equals(board.getName())) {%>
						<input type="button" value="글수정" onclick="location.href='update.jsp?num=<%=board.getNum()%>&pageNum=<%=pageNum%>'">
						<input type="button" value="글삭제" onclick="location.href='deletePro.jsp?num=<%=board.getNum()%>'">
					<%}
				}
			%>
		</td>
	</tr>
</table>
<!-- 게시판 -->
</article>
<div class="clear"></div>
<!-- 푸터 들어가는 곳 -->
<jsp:include page="../inc/bottom.jsp"/>
<!-- 푸터 들어가는 곳 -->
</div>
</body>
</html>