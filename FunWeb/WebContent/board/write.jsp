<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>자유게시판</title>
<link href="../css/default.css" rel="stylesheet" type="text/css">
<link href="../css/subpage.css" rel="stylesheet" type="text/css">
<link href="../css/mycss.css" rel="stylesheet" type="text/css">
<script type="text/javascript">
	function submitCheck() {
		var file = document.fr.file.value;
		if(document.fr.subject.value == "") {
			alert("제목을 입력해주세요");
			return;
		}
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
		<td><input type="text" name="subject" maxlength="50"></td>
	</tr>
	<tr>
		<th>첨부파일</th>
		<td><input type="file" name="file" accept=".jpg,.gif,.png,.jpeg"><br>
			<span id="board_filefont">5MB이하 gif, jpg, jpeg, png 이미지 파일만 등록가능합니다.</span> 
		</td>
	</tr>
	<tr>
		<th>내용</th>
		<td><textarea name="content" rows="20" cols="70"></textarea></td>
	</tr>
	<tr>
		<td colspan="2">
			<input type="button" value="글쓰기" onclick="submitCheck()">
			<input type="reset" value="다시쓰기">
			<input type="button" value="글목록" onclick="location.href='../board/list.jsp'">
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