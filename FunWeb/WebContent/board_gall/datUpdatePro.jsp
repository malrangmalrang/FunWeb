<%@page import="dao.BoardGall_DatDAO"%>
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
	request.setCharacterEncoding("UTF-8");

	int board_num = Integer.parseInt(request.getParameter("board_num"));
	int dat_num = Integer.parseInt(request.getParameter("dat_num"));
	String dat_content = request.getParameter("dat_content");
	String pageNum = request.getParameter("pageNum");
	
	BoardGall_DatDAO bddao = BoardGall_DatDAO.getInstance();
	int check = bddao.updateDat(dat_num, board_num, dat_content);
	
	if(check != 0) { 
		response.sendRedirect("content.jsp?num=" + board_num + "&pageNum=" + pageNum);
	} else {
%>
		<script type="text/javascript">
			alert("잘못된 접근입니다.")
			location.href="list.jsp";
		</script>
	<%}
%>
</body>
</html>