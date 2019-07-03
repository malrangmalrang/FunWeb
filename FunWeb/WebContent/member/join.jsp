<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>회원가입</title>
<link href="../css/default.css" rel="stylesheet" type="text/css">
<link href="../css/subpage.css" rel="stylesheet" type="text/css">

<!-- 우편번호 검색 소스 -->
<script src="//ajax.googleapis.com/ajax/libs/jquery/1/jquery.min.js"></script>
<script src="//d1p7wdleee1q2z.cloudfront.net/post/search.min.js"></script>
<script> $(function() { $("#postcodify_search_button").postcodifyPopUp(); }); </script>
<!-- 우편번호 검색 소스 -->

<!--[if lt IE 9]>
<script src="http://ie7-js.googlecode.com/svn/version/2.1(beta4)/IE9.js" type="text/javascript"></script>
<script src="http://ie7-js.googlecode.com/svn/version/2.1(beta4)/ie7-squish.js" type="text/javascript"></script>
<script src="http://html5shim.googlecode.com/svn/trunk/html5.js" type="text/javascript"></script>
<![endif]-->
<!--[if IE 6]>
 <script src="../script/DD_belatedPNG_0.0.8a.js"></script>
 <script>
   /* EXAMPLE */
   DD_belatedPNG.fix('#wrap');
   DD_belatedPNG.fix('#main_img');   

 </script>
 <![endif]-->
 <script type="text/javascript">
 	var emailRe = /[a-zA-Z0-9]+@[a-zA-Z0-9]+/;
 	var phoneRe = /[0-9]/;
 	
 	function idcheck() {
 		if(document.fr.id.value == "") {
 			alert("아이디를 입력해주세요");
 			document.fr.id.focus();
 			return;
 		}
 		
 		var uid = document.fr.id.value;
 		window.open("idcheck.jsp?userId=" + uid, "", "width=400, height=300" )
 	}
 	
 	function inputIdChk() {
 		document.fr.isCheck.value = "Uncheck";
 		var x = document.getElementById("idStyle");
 		x.style.display="block";
 	}
 		
  	function checkValue() {
		var form = document.fr;
		var check = 1;
		
		if(!form.id.value) {
 			document.getElementById("idStyle").style.display="block";
 			check = 0;
 		}
		if(!form.pass.value) {
 			document.getElementById("passStyle").style.display="block";
 			check = 0;
 		} 
		if(form.pass.value != form.pass2.value) {
 			document.getElementById("pass2Style").style.display="block";
 			check = 0;
 		} 
		if(!form.name.value) {
 			document.getElementById("nameStyle").style.display="block";
			check = 0;
		}
		if(emailRe.exec(form.email.value) == null) {
 			document.getElementById("emailStyle").style.display="block";
			check = 0;
		}
		if(form.phone.value) {
			if(phoneRe.exec(form.phone.value) == null) {
				document.getElementById("phoneStyle").style.display="block";
				check = 0;
			}
		}
		if(check == 1) {
			if(form.isCheck.value == "Uncheck") {
				alert("아이디 중복체크 해주세요");
	 		} else {
 				form.submit();
	 		}
 		}
	}
 	
 	function checkValue2() {
 		var form = document.fr;
 		
 		if(form.pass.value) {
 			document.getElementById("passStyle").style.display="none";
 		} 
 		if(form.pass.value == form.pass2.value) {
 			document.getElementById("pass2Style").style.display="none";
 		} 
 		if(form.name.value) {
 			document.getElementById("nameStyle").style.display="none";
 		} 
 		if(emailRe.exec(form.email.value) != null) {
 			document.getElementById("emailStyle").style.display="none";
 		}
 		if(phoneRe.exec(form.phone.value) != null) {
 			document.getElementById("phoneStyle").style.display="none";
 		}
 	}
 </script>
</head>
<body>
<div id="wrap">
<!-- 헤더들어가는 곳 -->
<jsp:include page="../inc/top.jsp"/>
<!-- 헤더들어가는 곳 -->

<!-- 본문들어가는 곳 -->
<!-- 본문메인이미지 -->
<!-- <div id="sub_img_member"></div> -->
<img src="../images/heyyoumymember.jpg" width="1000px">
<!-- 본문메인이미지 -->
<!-- 왼쪽메뉴 -->
<nav id="sub_menu">
</nav>
<!-- 왼쪽메뉴 -->
<!-- 본문내용 -->
<article>
<h1>동료가입</h1>
<form action="joinPro.jsp" method="post" id="join" name="fr">
<fieldset>
<legend>필수입력</legend>
<label>아이디</label>
<input type="text" name="id" class="id" onkeydown="inputIdChk()" maxlength="10">
<input type="button" value="중복체크" class="dup" onclick="idcheck()">
<input type="hidden" name="isCheck" value="Uncheck"><br>
<div id=idStyle>아이디는 3자이상 10자리이하로 영문자랑 숫자만 사용하여 만들어주세요.</div>
<label>비밀번호</label>
<input type="password" name="pass" onblur="checkValue2()"><br>
<div id=passStyle>비밀번호를 입력해주세요</div>
<label>비밀번호 확인</label>
<input type="password" name="pass2" onblur="checkValue2()"><br>
<div id=pass2Style>비밀번호가 일치하지 않습니다</div>
<label>이름</label>
<input type="text" name="name" placeholder="해적왕" onblur="checkValue2()"><br>
<div id=nameStyle>이름을 입력해주세요.</div>
<label>이메일</label>
<input type="email" name="email" placeholder="abc123@naver.com" onblur="checkValue2()"><br>
<div id=emailStyle>이메일을 형식에 맞게 입력해주세요.</div>
</fieldset>

<fieldset>
<legend>선택입력</legend>
<label>주소</label>
<input type="button" id="postcodify_search_button" value="검색"><br>
<label>우편번호</label>
<input type="text" name="address1" class="postcodify_postcode5" readonly><br>
<label>도로명주소</label>
<input type="text" name="address2" class="postcodify_address"  readonly><br>
<label>동이름</label>
<input type="text" name="address3" class="postcodify_extra_info" readonly><br>
<label>상세주소</label>
<input type="text" name="address4" class="postcodify_details"  /><br>
<label>폰번호</label>
<input type="text" name="phone" maxlength="13" placeholder="01012341234" onblur="checkValue2()"><br>
<div id=phoneStyle>폰번호는 숫자만 입력해주세요</div>
</fieldset>
<div class="clear"></div>
<div id="buttons">
<input type="button" value="회원가입" class="submit" onclick="checkValue()" >
<input type="reset" value="다시쓰기" class="cancel">&emsp;
<input type="button" value="취소" class="submit" onclick="location.href='../main/main.jsp'" >
</div>
</form>
</article>
<!-- 본문내용 -->
<!-- 본문들어가는 곳 -->

<div class="clear"></div>
<!-- 푸터들어가는 곳 -->
<jsp:include page="../inc/bottom.jsp"/>
<!-- 푸터들어가는 곳 -->
</div>
</body>
</html>