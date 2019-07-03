<%@page import="dao.MemberDAO"%>
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
	request.setCharacterEncoding("utf-8");
	
	String id = request.getParameter("id");
	String pass =request.getParameter("pass");
	
	MemberDAO mdao = MemberDAO.getInstance();
	int check = mdao.userCheck(id, pass);
	
	if(check == 1) {
		session.setAttribute("id", id);
		response.sendRedirect("../main/main.jsp");
	} else if(check == 0) { %>
		<script type="text/javascript">
			alert("비밀번호가 틀렸습니다.");
			history.back();
		</script>
	<% } else { %>
		<script type="text/javascript">
			alert("아이디가 없습니다.");
			history.back();
		</script>
	<% } %>
</body>
</html>