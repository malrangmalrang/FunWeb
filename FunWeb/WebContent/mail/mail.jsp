<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>메일 보내기</title>
</head>
<body>
<form action="mailPro.jsp" method="post">
<table>
	<tr>
		<th>보내는 사람 메일 : </th>
		<td><input type="text" name="sender"></td>
	</tr>
	<tr>
		<th>받는 사람 메일 : </th>
		<td><input type="text" name="receiver" value="comori4@naver.com" readonly></td>		
	</tr>
	<tr>
		<th>제목 : </th>
		<td><input type="text" name="subject"></td>
	</tr>
	<tr>
		<th>내용 : </th>
		<td><textarea name="content" cols="40" rows="20"></textarea></td>
	</tr>
	<tr>
		<td colspan="2"><input type="submit" value="보내기">
		<input type="reset" value="다시쓰기">
		<input type="button" value="취소" onclick="location.href='../main/main.jsp'">
		</td>
	</tr>
</table>
</form>
</body>
</html>