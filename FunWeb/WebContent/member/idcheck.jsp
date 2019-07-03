<%@page import="java.util.regex.Pattern"%>
<%@page import="dao.MemberDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link href="../css/idcheck.css" rel="stylesheet" type="text/css">
<script type="text/javascript">
	function ok() {
		opener.document.fr.id.value=document.wfr.userId.value;
		opener.document.fr.isCheck.value = "Check";
		opener.document.getElementById("idStyle").style.display="none";
		window.close();
	}
</script>
</head>
<body>
<%
	String id = request.getParameter("userId");
	String pattern = "^[a-zA-Z0-9]*$";
	boolean result = Pattern.matches(pattern, id);
	
	if(result && id.length()>=3) {
	
		MemberDAO mdao = MemberDAO.getInstance();
		int check = mdao.idCheck(id);
		
		if(check == 1) { %>
			중복된아이디입니다. 다시 검색해주세요.
			<img src="../images/no.jpg" width="250px;">
		<% } else { %>
			사용가능한 아이디입니다. 이 아이디로<br>
			<img src="../images/gazza.jpg" width="250px;"><br>
			<input type="button" value="가즈아" onclick="ok()">
		<% }
	} else { %>
		아이디는 3자이상 10자리 이하로 영문자랑<br> 숫자만 사용하여 만들어주세요.
		<img src="../images/no.jpg" width="250px;">
	<%} %>
<br>
<form action="idcheck.jsp" name="wfr">
	아이디:<input type="text" name="userId" value="<%=id%>" maxlength="10">
	<input type="submit" value="아이디찾기">
</form>
</body>
</html>