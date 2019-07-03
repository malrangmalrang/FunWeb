<%@page import="javax.mail.Transport"%>
<%@page import="javax.mail.internet.InternetAddress"%>
<%@page import="javax.mail.Address"%>
<%@page import="javax.mail.internet.MimeMessage"%>
<%@page import="javax.mail.Message"%>
<%@page import="javax.mail.Session"%>
<%@page import="javax.mail.Authenticator"%>
<%@page import="mail.GoogleAuthentication"%>
<%@page import="java.util.Properties"%>
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
	
	String sender = request.getParameter("sender");
	String receiver = request.getParameter("receiver");
	String subject = request.getParameter("subject");
	String content = request.getParameter("content");
	
	try {
		Properties properties = System.getProperties();
		properties.put("mail.smtp.starttls.enable", "true");
		properties.put("mail.smtp.host", "smtp.gmail.com");
		properties.put("mail.smtp.auth", "true");
		properties.put("mail.smtp.port", "587");
		
		Authenticator auth = new GoogleAuthentication();
		Session s = Session.getDefaultInstance(properties, auth);
		Message message = new MimeMessage(s);
		Address sender_address = new InternetAddress(sender);
		Address receiver_address = new InternetAddress(receiver);
		message.setHeader("content-type", "text/html;charset=UTF-8");
		message.setFrom(sender_address);
		message.addRecipient(Message.RecipientType.TO, receiver_address);
		message.setSubject(subject);
		message.setContent(content, "text/html;charset=UTF-8");
		message.setSentDate(new java.util.Date());
		Transport.send(message);
		%>
		<script type="text/javascript">
			alert("메일이 정상적으로 전송되었습니다.");
			location.href="../main/main.jsp";
		</script>
	<%} catch(Exception e) { %>
		<script type="text/javascript">
			alert("메일이 실패");
		</script>
	<%	e.printStackTrace();
	}
%>
</body>
</html>