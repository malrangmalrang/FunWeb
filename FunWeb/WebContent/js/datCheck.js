	function datCheck() {
		if(document.fr_dat.dat_content.value == "") {
			alert("댓글 내용을 입력해주세요");
			return;
		}
		
		document.fr_dat.submit();
	}
	
	function datUpCheck1() {
		var content = document.fr_datUp.dat_content;
		if(content.value == "") {
			alert("댓글 내용을 입력해주세요");
			return;
		}
		
		document.fr_datUp.submit();
	}
	
	function datUpCheck2(i) {
		var content = document.fr_datUp[i].dat_content;
		if(content.value == "") {
			alert("댓글 내용을 입력해주세요");
			return;
		}
		
		document.fr_datUp[i].submit();
	}
	
	function datReCheck1() {
		var content = document.fr_datRe.dat_content;
		if(content.value == "") {
			alert("댓글 내용을 입력해주세요");
			return;
		}
		
		document.fr_datRe.submit();
	}
	
	function datReCheck2(i) {
		var content = document.fr_datRe[i].dat_content;
		if(content.value == "") {
			alert("댓글 내용을 입력해주세요");
			return;
		}
		
		document.fr_datRe[i].submit();
	}
	
	
	function reDatWrite(i) {
		if(document.getElementById("reDatbut"+i).innerHTML == "답글") {
			document.getElementById("reDat"+i).style.display="block";
			document.getElementById("reDatbut"+i).innerHTML = "답글취소"
		} else if(document.getElementById("reDatbut"+i).innerHTML == "답글취소"){
			document.getElementById("reDat"+i).style.display="none";
			document.getElementById("reDatbut"+i).innerHTML = "답글"
		}
	}
	
	function upDatWrite(i) {
		if(document.getElementById("upDatBut"+i).innerHTML == "수정") {
			document.getElementById("dat_update"+i).style.display="block";
			document.getElementById("dat_contentStyle"+i).style.display="none";
			document.getElementById("upDatBut"+i).innerHTML = "수정취소"
		} else if(document.getElementById("upDatBut"+i).innerHTML == "수정취소"){
			document.getElementById("dat_update"+i).style.display="none";
			document.getElementById("dat_contentStyle"+i).style.display="block";
			document.getElementById("upDatBut"+i).innerHTML = "수정"
		}
	}