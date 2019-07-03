<%@page import="dao.BoardDownDAO"%>
<%@page import="vo.BoardDownVO"%>
<%@page import="com.oreilly.servlet.MultipartRequest"%>
<%@page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<%
	String uploadPath=request.getRealPath("/board_down_upload");
	int fileSize = 10 * 1024 * 1024;
	
	try {
		MultipartRequest multi = new MultipartRequest(request, uploadPath, fileSize, "utf-8", new DefaultFileRenamePolicy());
	
		String name = multi.getParameter("name");
		String subject = multi.getParameter("subject");
		String file = multi.getFilesystemName("file");
		String content = multi.getParameter("content");
	
		BoardDownVO board = new BoardDownVO();
		board.setName(name);
		board.setSubject(subject);
		board.setFile(file);
		board.setContent(content);
	
		BoardDownDAO bdao = BoardDownDAO.getInstance();
		int check = bdao.insertBoard(board); 
	 
		if(check != 0) {
%>
			<script type="text/javascript">
				alert("글이 등록되었습니다.");
				location.href="list.jsp";
			</script>
		<% } else {%>
			<script type="text/javascript">
				alert("잘못된 접근입니다.");
				history.back();
			</script>
		<% }
	} catch(Exception e) { %>
		<script type="text/javascript">
			alert("용량이 초과하였습니다.");
			histroy.back();
		</script>
	<%}
%>
</body>
</html>