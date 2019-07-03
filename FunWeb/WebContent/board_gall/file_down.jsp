<%@page import="java.net.URLEncoder"%>
<%@page import="java.io.FileInputStream"%>
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
	String fileName = request.getParameter("gall_file");
	
	String downloadPath = request.getRealPath("/board_gall_upload");
	String filePath = downloadPath + "\\" + fileName;
	byte b[] = new byte[4096];
	FileInputStream in = new FileInputStream(filePath);
	String mimeType = getServletContext().getMimeType(filePath);
	
	if(mimeType == null) {
		mimeType = "application/octet-stream";
	}
	
	response.setContentType(mimeType);
	String agent = request.getHeader("User-Agent");
	boolean isBrowser = (agent.indexOf("MISE") > -1) || (agent.indexOf("Trident") > -1);
	
	if(isBrowser) {
		fileName = URLEncoder.encode(fileName, "UTF-8").replaceAll("\\+", "%20");
	} else {
		fileName = new String(fileName.getBytes("UTF-8"), "iso-8859-1");
	}
	
	response.setHeader("content-Disposition", "attachment; filename=" + fileName); 
	
	ServletOutputStream out2 = response.getOutputStream();
	int numRead;
	
	while((numRead = in.read(b, 0, b.length)) != -1) {
		out2.write(b, 0, numRead);
	}
	out2.flush();
	out2.close();
	in.close();
	
	out.clear();
	out = pageContext.pushBody();
%>
</body>
</html>