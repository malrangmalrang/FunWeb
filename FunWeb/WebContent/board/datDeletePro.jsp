<%@page import="dao.Board_DatDAO"%>
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
	int dat_num = Integer.parseInt(request.getParameter("dat_num"));
	int board_num = Integer.parseInt(request.getParameter("board_num"));
	String pageNum = request.getParameter("pageNum");
	
	Board_DatDAO bddao = Board_DatDAO.getInstance();
	int check = bddao.deleteDat(dat_num, board_num);
	
	if(check != 0) { 
		response.sendRedirect("content.jsp?num=" + board_num + "&pageNum=" + pageNum);
	} else { %>
		<script type="text/javascript">
			alert("잘못된 접근입니다.")
			location.href="list.jsp";
		</script>
	<%}
%>
</body>
</html>