<%@page import="dao.BoardDAO"%>
<%@page import="vo.BoardVO"%>
<%@page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy"%>
<%@page import="com.oreilly.servlet.MultipartRequest"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<%
	String uploadPath = request.getRealPath("/board_upload");
	int fileSize = 5 * 1024 * 1024;
	MultipartRequest multi = new MultipartRequest(request, uploadPath, fileSize, "utf-8", new DefaultFileRenamePolicy());
	
	int num = Integer.parseInt(multi.getParameter("num"));
	String name = multi.getParameter("name");
	String subject = multi.getParameter("subject");
	String file = multi.getFilesystemName("file");
	String content = multi.getParameter("content");
	String pageNum = multi.getParameter("pageNum");
	
	BoardVO board = new BoardVO();
	board.setNum(num);
	board.setName(name);
	board.setSubject(subject);
	board.setFile(file);
	board.setContent(content);
	
	BoardDAO bdao = BoardDAO.getInstance();
	int check = bdao.updateBoard(board);
	
	if(check != 0 ) { %>
		<script type="text/javascript">
			alert("글이 수정되었습니다.");
			location.href="content.jsp?num=<%=num%>&pageNum=<%=pageNum%>";
		</script>
	<%} else { %>
		<script type="text/javascript">
			alert("수정에 실패하였습니다. 다시 해주세요.")
			history.back();
		</script>
	<%}
%>
</body>
</html>