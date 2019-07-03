<%@page import="vo.BoardNoticeVO"%>
<%@page import="dao.BoardNoticeDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>공지사항</title>
<link href="../css/default.css" rel="stylesheet" type="text/css">
<link href="../css/subpage.css" rel="stylesheet" type="text/css">
<link href="../css/mycss.css" rel="stylesheet" type="text/css">
<script type="text/javascript">
	function fileCheck() {
		var file = document.fr.file.value;
		
		if(document.fr.subject.value == "") {
			alert("제목을 입력해주세요");
			return;
		}
		
		document.fr.submit();
	}
</script>
</head>
<body>
<div id="wrap">
<!-- 헤더 들어가는 곳 -->
<div id="login"></div>
<jsp:include page="../inc/top.jsp"/>
<!-- 헤더 들어가는 곳 -->
<!-- 메인이미지 -->
<img src="../images/gongji.gif" width="970px" height="300px">
<!-- 메인이미지 -->
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
	
	BoardNoticeDAO bdao = BoardNoticeDAO.getInstance();
	BoardNoticeVO board = bdao.getBoard(num);
	if(board != null) {
%>
<article>
<h1>공지사항</h1>
<form action="updatePro.jsp" method="post" enctype="multipart/form-data" name="fr">
	<input type="hidden" name="num" value="<%=num %>">
	<input type="hidden" name="pageNum" value="<%=pageNum %>">
	
	<table class="greyGridTable">
	<tr>
		<th>작성자</th>
		<td><input type="text" name="name" value="<%=board.getName() %>" readonly></td>
	</tr>
	<tr>
		<th>제목</th>
		<td><input type="text" name="subject" value="<%=board.getSubject() %>"  maxlength="50"></td>
	</tr>
	<tr>
		<th>첨부파일</th>
		<td><input type="file" name="file" ><br>
			<span id="board_filefont">10MB이하 파일만 등록가능합니다.</span> 
		</td>
	</tr>
	<tr>
		<th>내용</th>
		<td><textarea name="content" rows="10" cols="70" ><%= board.getContent()%></textarea></td>
	</tr>
	<tr>
		<td colspan="2">
			<input type="button" value="글수정" onclick="fileCheck()">
			<input type="reset" value="다시쓰기">
			<input type="button" value="취소" onclick="history.back()">
		</td>
	</tr>
</table>
</form>
<%} else { %>
	<script type="text/javascript">
		alert("잘못된 접근입니다.");
		location.href="list.jsp";
	</script>
<%} %>
</article>
<!-- 게시판 -->
<div class="clear"></div>

<!-- 푸터 들어가는 곳 -->
<jsp:include page="../inc/bottom.jsp"/>
<!-- 푸터 들어가는 곳 -->
</div>
</body>
</html>