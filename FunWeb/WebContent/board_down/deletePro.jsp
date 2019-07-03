<%@page import="dao.BoardDownDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<%
	int down_num = Integer.parseInt(request.getParameter("num"));

	BoardDownDAO bdao = BoardDownDAO.getInstance();
	int check = bdao.deleteBoard(down_num);
	
	if(check != 0) {
%>
		<script type="text/javascript">
			alert("글이 삭제되었습니다.");
			location.href="list.jsp";
		</script>
	<%} else { %>
		<script type="text/javascript">
			alert("잘못된 접근입니다.");
			location.href="list.jsp";
		</script>		
	<%}
%>
</body>
</html>