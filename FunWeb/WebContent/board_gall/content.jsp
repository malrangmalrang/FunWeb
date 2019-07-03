<%@page import="dao.BoardGall_DatDAO"%>
<%@page import="vo.BoardGallVO"%>
<%@page import="dao.BoardGallDAO"%>
<%@page import="vo.DatVO"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>짤!</title>
<link href="../css/default.css" rel="stylesheet" type="text/css">
<link href="../css/subpage.css" rel="stylesheet" type="text/css">
<link href="../css/mycss.css" rel="stylesheet" type="text/css">
<script src="../js/datCheck.js"></script>
</head>
<body>
<div id="wrap">
<!-- 헤더 들어가는 곳 -->
<div id="login"></div>
<jsp:include page="../inc/top.jsp" />
<!-- 헤더 들어가는 곳 -->

<!-- 왼쪽메뉴 -->
<nav id="sub_menu">
<img src="../images/hi1.jpg" width="150px"><br>
<img src="../images/hi2.jpg" width="150px">
</nav>
<!-- 왼쪽메뉴 -->

<!-- 게시판 -->
<%
	int num = Integer.parseInt(request.getParameter("num"));
	String pageNum = request.getParameter("pageNum");
	String readCount = request.getParameter("readCount");
	String search = request.getParameter("search");
	
	BoardGallDAO bdao = BoardGallDAO.getInstance();
	
	if(readCount != null) {
		bdao.updateReadcount(num);
	}
	
	BoardGallVO board = bdao.getBoard(num);
	
	String content = board.getContent();
	content = content.replaceAll(System.getProperty("line.separator"), "<br>");
%>
<article>
<h1>짤!</h1>
<table class="greyGridTable">
	<tr>
		<th>번호</th><td><%=board.getNum() %></td>
		<th>조회수</th><td><%=board.getReadcount() %></td>
	</tr>
	<tr>
		<th>작성자</th><td><%=board.getName() %></td>
		<th>작성날짜</th><td><%=board.dateToString() %></td>
	</tr>
	<tr>
		<th>제목</th><td colspan="3"><%=board.getSubject() %></td>
	</tr>
	<tr>
		<th>첨부파일</th>
		<td colspan="3">
			<%if(board.getFile() != null) { %>
				<a href="file_down.jsp?gall_file=<%=board.getFile()%>"><%=board.getFile() %></a>
			<%} else {%>
				없음
			<%}%>
		</td>
	</tr>
	<tr>
		<th>내용</th>
		<td colspan="3">
		<%if(board.getFile() != null) { %>
			<img src="../board_gall_upload/<%=board.getFile() %>" alt="<%=board.getFile() %>" width="500px" ><br>
		<%} %>
		<%=content%></td>
	</tr>
	<tr>
		<td colspan="4" style="text-align: center;">
			<input type="button" value="글목록" onclick="location.href='list.jsp?pageNum=<%=pageNum%><%if(search != null) {%>&search=<%=search%><%}%>'">
			<% 
				String id = (String)session.getAttribute("id");
				if(id != null) {
					if(id.equals(board.getName())) {%>
						<input type="button" value="글수정" onclick="location.href='update.jsp?num=<%=board.getNum()%>&pageNum=<%=pageNum%>'">
						<input type="button" value="글삭제" onclick="location.href='deletePro.jsp?num=<%=board.getNum()%>'">
					<%}
				}
			%>
		</td>
	</tr>
</table>
<!-- 게시판 -->
<br>
<!-- 댓글 -->
<h2>댓글</h2>
<%
	List<DatVO> datList = null;
	BoardGall_DatDAO bddao = BoardGall_DatDAO.getInstance();
	int dat_Count = bddao.getDatCount(board.getNum()); // 댓글 전체 갯수
	int dat_PageSize = 5;
	String dat_PageNum = request.getParameter("dat_PageNum");
	if(dat_PageNum == null) {
		dat_PageNum = "1";
	}
	int dat_CurrentPage = Integer.parseInt(dat_PageNum);
	int dat_StartRow = (dat_CurrentPage-1) * dat_PageSize + 1;
	int dat_EndRow = dat_CurrentPage * dat_PageSize;
	
	datList = bddao.getDatList(dat_StartRow, dat_PageSize, board.getNum()); // 댓글 리스트 받아오기
	
	if(datList != null) {
%> 
<div id="dat">
<%for(int i=0; i<datList.size(); i++) { 
	DatVO dat = (DatVO)datList.get(i); 
	String datContent = dat.getDat_content();
	datContent = datContent.replaceAll(System.getProperty("line.separator"), "<br>");
	%>
	<div>
	<% 
		// 대댓글인 경우
		int wid = 0;
		if(dat.getDat_re_lev() > 0) {
			wid = dat.getDat_re_lev() * 10;
		%>
			<img src="../images/level.gif" width="<%=wid %>" height="10">
			<img src="../images/re.gif">
		<%}
	%>
		<span id="dat_nn"><%=dat.getDat_num() %> <%=dat.getDat_name() %></span>
			&emsp;<%=dat.dateToString() %> 
			<%
				if(id != null) {%>
					<button type="button" id="reDatbut<%=i %>" onclick="reDatWrite(<%=i%>)">답글</button>
					<%if(id.equals(dat.getDat_name())) {%>
						<button type="button" class="datbut" onclick="location.href='datDeletePro.jsp?dat_num=<%=dat.getDat_num()%>&board_num=<%=board.getNum()%>&pageNum=<%=pageNum%>'">삭제</button>
						<button type="button" id="upDatBut<%=i %>" class="datbut" onclick="upDatWrite(<%=i%>)">수정</button>
					<%} %>
				<%} %>
	</div>
	<div id="dat_contentStyle<%=i%>" class="dat_contentStyle">
	<% if(dat.getDat_re_lev() > 0) { 
		wid = dat.getDat_re_lev() * 10 + 26;%>
		<img src="../images/level.gif" width="<%=wid %>" height="10">
	<%} %>
	<%=datContent %></div>
	<!-- 댓글 수정 -->
	<div id="dat_update<%=i%>" style="display: none;">
		<form action="datUpdatePro.jsp" method="post" name="fr_datUp">
			<input type="hidden" name="board_num" value="<%=dat.getBoard_num() %>">
			<input type="hidden" name="dat_num" value="<%=dat.getDat_num() %>">
			<input type="hidden" name="pageNum" value="<%=pageNum %>">
			<textarea name="dat_content" rows="2" cols="80"><%=dat.getDat_content() %></textarea>
			<input type="button" value="수정" class="but" onclick=" 			
			<%if(datList.size() == 1) {%>
				datUpCheck1()
			<%} else {%>	
				datUpCheck2(<%=i %>)
			<%}%>">
		</form>
	</div>
	<!-- 댓글 수정 -->
	<!-- 답글 -->
	<div id="reDat<%=i %>" style="display: none;">
		<form action="datReWritePro.jsp" method="post" name="fr_datRe"> 
			<input type="hidden" name="board_num" value="<%=board.getNum()%>">
			<input type="hidden" name="pageNum" value="<%=pageNum %>">
			<input type="hidden" name="dat_name" value="<%=id%>">
			<input type="hidden" name="dat_re_ref" value="<%=dat.getDat_re_ref() %>">
			<input type="hidden" name="dat_re_lev" value="<%=dat.getDat_re_lev() %>">
			<input type="hidden" name="dat_re_seq" value="<%=dat.getDat_re_seq() %>">
			<textarea name="dat_content" rows="2" cols="80" ></textarea>
			<input type="button" value="등록"  class="but" onclick= "
			<%if(datList.size() == 1) {%>
				datReCheck1()
			<%} else {%>	
				datReCheck2(<%=i %>)
			<%}%>">
		</form>
	</div>
	<!-- 답글 -->
<%}%>

<!-- 댓글 -->
<!-- 댓글 페이지 -->
<div id="page_control">
<%if(dat_Count != 0) { 
	int dat_PageCount = dat_Count / dat_PageSize + (dat_Count % dat_PageSize != 0 ? 1 : 0); // 전체 페이지수
	int dat_PageBlock = 5;
	int dat_StartPage = (dat_CurrentPage -1)/dat_PageBlock * dat_PageBlock + 1;
	int dat_EndPage = dat_StartPage + dat_PageBlock - 1;
	if(dat_EndPage > dat_PageCount) {
		dat_EndPage = dat_PageCount;
	}
	
	if(dat_CurrentPage > dat_PageBlock) { %>
		<a href="content.jsp?num=<%=board.getNum()%>&pageNum=<%=pageNum %>&dat_PageNum=<%=dat_StartPage-dat_PageBlock%>">[이전]</a>
	<%} 
	for(int i=dat_StartPage; i<=dat_EndPage; i++) {
		if(i != dat_CurrentPage) { %>
			<a href="content.jsp?num=<%=board.getNum()%>&pageNum=<%=pageNum %>&dat_PageNum=<%=i %>">[<%=i %>]</a>
		<%} else { %>
			<b>[<%=i %>]</b>
		<%} 
	}
	if(dat_PageCount - dat_StartPage >= dat_PageBlock) { %>
		<a href="content.jsp?num=<%=board.getNum()%>&pageNum=<%=pageNum %>&dat_PageNum=<%=dat_StartPage+dat_PageBlock%>">[다음]</a>
	<%}
}
%>
</div>
</div>
<%} %>
<br>
<%
if(id != null) {%>
<form action="datWritePro.jsp" method="post" name="fr_dat"> 
	<input type="hidden" name="board_num" value="<%=board.getNum()%>">
	<input type="hidden" name="pageNum" value="<%=pageNum %>">
	<input type="hidden" name="dat_name" value="<%=id%>">
	<textarea name="dat_content" rows="2" cols="80" ></textarea>
	<input type="button" value="등록" onclick="datCheck()" class="but">
</form>
<%} else {%>
<h3>댓글을 다실려면 로그인 해주세요.</h3>
<%} %>
</article>
<!-- 댓글 페이지-->
<div class="clear"></div>

<!-- 푸터 들어가는 곳 -->
<jsp:include page="../inc/bottom.jsp"/>
<!-- 푸터 들어가는 곳 -->
</div>
</body>
</html>