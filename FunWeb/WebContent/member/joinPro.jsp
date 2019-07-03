<%@page import="java.sql.Timestamp"%>
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
	
	String id = request.getParameter("id");
	String pass = request.getParameter("pass");
	String name = request.getParameter("name");
	String email = request.getParameter("email");
	String address = request.getParameter("address1");
	if(!address.equals("")) {
		String address2 = request.getParameter("address2");
		String address3 = request.getParameter("address3");
		String address4 = request.getParameter("address4");
		
		address = "("+ address + ") " + address2 + address3 + " " + address4;
	}
	String phone = request.getParameter("phone");
	Timestamp reg_date = new Timestamp(System.currentTimeMillis());
	
	MemberVO member = new MemberVO();
	member.setId(id);
	member.setPass(pass);
	member.setName(name);
	member.setEmail(email);
	member.setAddress(address);
	member.setPhone(phone);
	member.setReg_date(reg_date);

	MemberDAO mdao = MemberDAO.getInstance();
	int insertCheck = mdao.insertMember(member);
	
	if(insertCheck != 0) {
%>
		<script type="text/javascript">
			alert("가입이 완료되었습니다.");
			location.href = "login.jsp";
		</script>
	<% } else { %>
		<script type="text/javascript">
			alert("가입이 실패하였습니다. 다시 해주십시오.")
			history.back();
		</script>
	<% }
%>
</body>
</html>