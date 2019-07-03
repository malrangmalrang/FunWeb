<%@page import="vo.BoardGallVO"%>
<%@page import="dao.BoardGallDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>짤</title>
<link href="../css/default.css" rel="stylesheet" type="text/css">
<link href="../css/subpage.css" rel="stylesheet" type="text/css">
<link href="../css/mycss.css" rel="stylesheet" type="text/css">
<script type="text/javascript">
	function fileCheck() {
		
		if(document.fr.subject.value == "") {
			alert("제목을 입력해주세요");
			return;
		}
		
		if(document.fr.file.value == "") {
			alert("이미지 파일을 올려주세요");
			return;
		}
		
		var file = document.fr.file.value;
		if(file != "") {
			var fileExt = file.substring(file.lastIndexOf(".") + 1);
			var reg = /gif|jpg|jpeg|png/i;
			
			if(reg.test(fileExt) == false) {
				alert("첨부파일은 gif, jpg, jpeg, png로 된 이미지만 가능합니다.");
				return;
			}
		}
		document.fr.submit();
	}
</script>
</head>
<body>
<div id="wrap">
<!-- 헤더 들어가는 곳 -->
<div id="login"></div>
<div class="clear"></div>
<jsp:include page="../inc/top.jsp"/>
<!-- 헤더 들어가는 곳 -->

<!-- 왼쪽메뉴 -->
<nav id="sub_menu">
<img src="../images/hi1.jpg" width="150px"><br>
<img src="../images/hi2.jpg" width="150px">
</nav>
<!-- 왼쪽메뉴 -->

<!-- 게시판 -->
<%
	int num = Integer.parseInt(request.getParameter("num"));
	String pageNum = request.getParameter("pageNum");
	
	BoardGallDAO bdao = BoardGallDAO.getInstance();
	BoardGallVO board = bdao.getBoard(num);
	if(board != null) {
%>
<article>
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
		<td><input type="text" name="subject" value="<%=board.getSubject() %>" ></td>
	</tr>
	<tr>
		<th>첨부파일</th>
		<td><input type="file" name="file" accept=".jpg,.gif,.png,.jpeg"><br>
			<span id="board_filefont">5MB이하 gif, jpg, jpeg, png 이미지 파일만 등록가능합니다.</span> 
		</td>
	</tr>
	<tr>
		<th>내용</th>
		<td><textarea name="content" rows="10" cols="20" ><%= board.getContent()%></textarea></td>
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