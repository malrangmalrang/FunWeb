<%@page import="dao.Board_DatDAO"%>
<%@page import="vo.DatVO"%>
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
	String pageNum = request.getParameter("pageNum");
	String dat_name = request.getParameter("dat_name");
	String dat_content = request.getParameter("dat_content");

	DatVO dat = new DatVO();
	dat.setBoard_num(board_num);
	dat.setDat_name(dat_name);
	dat.setDat_content(dat_content);
	
	Board_DatDAO bddao = Board_DatDAO.getInstance();
	int check = bddao.insertDat(dat);
	
	if(check != 0) { 
		response.sendRedirect("content.jsp?num="+ board_num + "&pageNum=" + pageNum);
	} else { %>
		<script type="text/javascript">
			alert("등록실패");
			history.back();
		</script>
	<% }
%>
</body>
</html>