<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	String id = (String)session.getAttribute("id");

	if(id==null) { %>
		<div id="login"><a href="../member/login.jsp">로그인</a> | <a href="../member/join.jsp">회원가입</a></div>
	<% } else { %>
		<div id="login"><%=id %>님 <a href="../member/logout.jsp">로그아웃</a>
		| <a href="../member/info.jsp">info</a></div>
	<% } 
%>

