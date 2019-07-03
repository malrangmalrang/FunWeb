<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>자료실</title>
<link href="../css/default.css" rel="stylesheet" type="text/css">
<link href="../css/subpage.css" rel="stylesheet" type="text/css">
<link href="../css/mycss.css" rel="stylesheet" type="text/css">
<script type="text/javascript">
function submitCheck() {
	if(document.fr.subject.value == "") {
		alert("제목을 입력해주세요");
		return;
	}
	if(document.fr.file.value == "") {
		alert("파일을 올려주세요");
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
<div class="clear"></div>
<jsp:include page="../inc/top.jsp" />
<!-- 헤더 들어가는 곳 -->

<!-- 왼쪽메뉴 -->
<nav id="sub_menu">
<img src="../images/hi1.jpg" width="150px"><br>
<img src="../images/hi2.jpg" width="150px">
</nav>
<!-- 왼쪽메뉴 -->

<!-- 게시판 -->
<%
	String id = (String)session.getAttribute("id");
	if(id==null) {
		response.sendRedirect("../member/login.jsp");
	} 
%>
<article>
<form action="writePro.jsp" method="post" enctype="multipart/form-data" name="fr">
	<table class="greyGridTable">
	<tr>
		<th>작성자</th>
		<td><input type="text" name="name" value="<%=id%>" readonly></td>
	</tr>
	<tr>
		<th>제목</th>
		<td><input type="text" name="subject"></td>
	</tr>
	<tr>
		<th>첨부파일</th>
		<td><input type="file" name="file"><br>
		<span id="board_filefont">10MB이하 파일만 등록가능합니다.</span>
		</td>
	</tr>
	<tr>
		<th>내용</th>
		<td><textarea name="content" rows="10" cols="20"></textarea></td>
	</tr>
	<tr>
		<td colspan="2">
			<input type="button" value="글쓰기" onclick="submitCheck()">
			<input type="reset" value="다시쓰기">
			<input type="button" value="글목록" onclick="location.href='list.jsp'">
		</td>
	</tr>
</table>
</form>
</article>
<!-- 게시판 -->
<div class="clear"></div>

<!-- 푸터 들어가는 곳 -->
<jsp:include page="../inc/bottom.jsp"/>
<!-- 푸터 들어가는 곳 -->
</div>
</body>
</html>