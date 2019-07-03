<%@page import="dao.BoardDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<%
	int num = Integer.parseInt(request.getParameter("num"));

	BoardDAO bdao = BoardDAO.getInstance();
	int check = bdao.deleteBoard(num);
	
	if(check != 0) { %>
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