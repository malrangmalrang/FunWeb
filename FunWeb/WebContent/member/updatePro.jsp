<%@page import="dao.MemberDAO"%>
<%@page import="vo.MemberVO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<%
	request.setCharacterEncoding("UTF-8");

	String id = (String)session.getAttribute("id");
	String pass = request.getParameter("pass");
	String newPass = request.getParameter("pass1");
	String name = request.getParameter("name");
	String email = request.getParameter("email");
	String address = request.getParameter("address");
	String address1 = request.getParameter("address1");
	if(!address1.equals("")) {
		String address2 = request.getParameter("address2");
		String address3 = request.getParameter("address3");
		String address4 = request.getParameter("address4");
		
		address = "("+ address1 + ") " + address2 + address3 + " " + address4;
	}
	String phone = request.getParameter("phone");
	
	MemberVO mvo = new MemberVO();
	mvo.setId(id);
	mvo.setPass(pass);
	mvo.setName(name);
	mvo.setEmail(email);
	mvo.setAddress(address);
	mvo.setPhone(phone);
	
	MemberDAO mdao = MemberDAO.getInstance();
	int check = mdao.updateMember(mvo, newPass);
	
	if(check == 0) { %>
		<script type="text/javascript">
			alert("비밀번호가 틀렸습니다.");
			history.back();
		</script>
	<% } else { %>
		<script type="text/javascript">
			alert("수정성공");
			location.href="info.jsp";
		</script>
	<%}
%>
</body>
</html>