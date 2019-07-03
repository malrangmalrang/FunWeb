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

	String id = (String)session.getAttribute("id");
	String pass = request.getParameter("pass");
	
	MemberDAO mdao = MemberDAO.getInstance();
	int check = mdao.deleteMember(id, pass);
	
	if(check == 0) { %>
		<script type="text/javascript">
			alert("비밀번호가 틀렸습니다.");
			history.back();
		</script>
	<%} else if(check == 1){ %>
		<script type="text/javascript">
			alert("탈퇴가 완료되었습니다.");
			location.href="logout.jsp";
		</script>
	<%} else { %>
		<script type="text/javascript">
			alert("오류발생");
			history.back();
		</script>
	<%} %>
</body>
</html>