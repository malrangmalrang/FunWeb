<%@page import="dao.BoardDAO"%>
<%@page import="vo.BoardVO"%>
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
	String uploadPath=request.getRealPath("/board_upload");
	int fileSize = 5 * 1024 * 1024;
	
	try {
		MultipartRequest multi = new MultipartRequest(request, uploadPath, fileSize, "utf-8", new DefaultFileRenamePolicy());
	
		String name = multi.getParameter("name");
		String subject = multi.getParameter("subject");
		String file = multi.getFilesystemName("file");
		String content = multi.getParameter("content");
	
		BoardVO board = new BoardVO();
		board.setName(name);
		board.setSubject(subject);
		board.setFile(file);
		board.setContent(content);
	
		BoardDAO bdao = BoardDAO.getInstance();
		int check = bdao.insertBoard(board); 
	
		if(check != 0) { %>
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
			alert("파일 용량이 초과하였습니다!!");
			history.back();
		</script>
	<%}
%>
</body>
</html>