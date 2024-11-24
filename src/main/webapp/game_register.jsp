<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>게임 등록</title>
<%-- <link rel="stylesheet" href="${pageContext.request.contextPath}/css/game_register.css"> --%>
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/star_background.css">
<script type="text/javascript" src="${pageContext.request.contextPath}/js/jquery-3.7.1.min.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/js/star_background.js">
	let shooting_star_interval = setInterval(func_shooting_star, 5000);
</script>
<%-- <script type="text/javascript" src="${pageContext.request.contextPath}/js/game_register.js"></script> --%>
<script type="text/javascript">
$(document).ready(function() {

	window.onbeforeunload = function(event) { // 사이트에서 나가시겠습니까? 띄우기
		event.returnValue = true;
	};
	
	const form = document.register_form;
	
	$(form.passwd).on("input", function() {
		this.value = this.value.replace(/[^0-9]/g, "");
		if(this.value.length >= 4) {
			this.value = this.value.substring(0,4);
		}
	});
	
	// input 태그 내용 입력시 경고 메시지 삭제
	$("form[name='register_form'] input").on("input", function(e) {
		$(e.target).parent().find("span.error").remove();
	});
	// select 태그 선택시 경고 메시지 삭제
	$("form[name='register_form'] select").on("change", function(e) {
		$(e.target).parent().find("span.error").remove();
	});
	
	$("form[name='register_form'] button[type='submit']").on("focus", function(e) {
		$(e.target).css({'margin':'2px 0 0 2px'});
		$("#btn_wrapper").css({'filter': 'drop-shadow(2px 2px 0 rgba(0,0,0,1))'});
		$("form[name='register_form'] li:last-child").css({'margin-bottom':'28px'});
	});

	$("form[name='register_form'] button[type='submit']").on("blur", function(e) {
		$(e.target).css({'margin-top':'', 'margin-left':''});
		$("#btn_wrapper").css({'filter': ''});
		$("form[name='register_form'] li:last-child").css({'margin-bottom':''});
	});

	form.onsubmit = function() {

		$("form[name='register_form'] input").parent().find("span.error").remove(); // 모든 경고 메시지 삭제
		
		// 게임 이름이 공백인지 확인
		if($(form.title).val().trim() == "") {
			$(form.title).parent().append(`<span class='error'>게임 이름을 입력하세요.</span>`);
			$(form.title).focus();
			return false;
		}
		
		// 게임 카테고리를 선택했는지 확인
		if($(form.category).val() == "-1") {
			$(form.category).parent().append(`<span class='error'>게임 카테고리를 선택하세요.</span>`);
			$(form.category).focus();
			return false;
		}

		// 게임 인원수를 선택했는지 확인
		if($(form.player_cnt).val() == "-1") {
			$(form.player_cnt).parent().append(`<span class='error'>게임 인원수를 선택하세요.</span>`);
			$(form.player_cnt).focus();
			return false;
		}
		
		// 게임 링크가 공백인지 확인
		if($(form.link).val().trim() == "") {
			$(form.link).parent().append(`<span class='error'>게임 링크를 입력하세요.</span>`);
			$(form.link).focus();
			return false;
		}
		
		// 게임 소개가 공백인지 확인
		if($(form.intro).val().trim() == "") {
			$(form.intro).parent().append(`<span class='error'>게임 소개를 입력하세요.</span>`);
			$(form.intro).focus();
			return false;
		}

		// 비밀번호가 4자리인지 확인
		if($(form.passwd).val().length != 4) {
			if($(form.passwd).val() == "") { // 비밀번호가 공백인지 확인
				$(form.passwd).parent().append(`<span class='error'>비밀번호를 입력하세요.</span>`);
			}
			else {
				$(form.passwd).parent().append(`<span class='error'>비밀번호는 4자리 숫자여야 합니다.</span>`);
				$(form.passwd).val("");
			}
			$(form.passwd).focus();
			return false;
		};
		
		if(confirm("게임을 등록하시겠습니까?")) {
			window.onbeforeunload = function(event) {}; // 사이트에서 나가시겠습니까? 안 뜨게 하기
			return true;
		}
		else {
			return false;
		}
	};
});


	function loadPreview(element) {
		if (element.files && element.files[0]) { // 파일을 업로드한 경우
			
			const fileType = element.files[0].type; // "image/jpeg", "image/png", ...
			const reg = /image\/(jpg|bmp|jpeg|png|webp)$/; // 확장자가 이미지인지 확인하기 위한 regex
			
			if(!reg.test(fileType)){ // 확장자가 이미지가 아닌 경우
				alert('이미지 파일만 업로드 가능합니다.\n .bmp, .jpg, .jpeg .png, .webp');
				element.value = ""; // input 비우기
				$('img#preview').attr("src", "images/logo/logo_white_artboard.png"); // 미리보기에 기본 이미지 표시
				return;
			}

			const mb = 1024 * 1024; // 1mb(1메가바이트)
			const limitSize = mb * 5; // 5mb 크기 제한을 위한 변수

			const uploadSize = element.files[0].size;

			if (limitSize < uploadSize) { // 이미지 크기가 5mb 이상인 경우
				alert('5MB 미만 이미지만 업로드가 가능합니다.');
				element.value = ""; // input 비우기
				$('img#preview').attr("src", "images/logo/logo_white_artboard.png"); // 미리보기에 기본 이미지 표시
				return;
			}
			
			let reader = new FileReader();
			reader.onload = function(e) { // 이미지 파일을 로드해서 미리보기에 표시
				$('img#preview').attr("src", e.target.result);
			};
			reader.readAsDataURL(element.files[0]);
		} else { // 파일을 업로드하지 않은 경우
			$('img#preview').attr("src", "images/logo/logo_white_artboard.png"); // 미리보기에 기본 이미지 표시
		}
	}
</script>

<style>
@font-face {
    font-family: 'NeoDunggeunmo';
    src: url('https://fastly.jsdelivr.net/gh/projectnoonnu/noonfonts_2001@1.3/NeoDunggeunmo.woff') format('woff');
    font-weight: normal;
}

body {
	background-color: #252525;
	color: white;
	margin: 0;
}

div#container{
    position: relative;
    z-index: 1;
}

div#contents {
    font-family: 'NeoDunggeunmo';
    min-width: 600px;
    max-width: 1200px;
    margin: 0 auto;
    padding-top: 7rem;
}

form[name='register_form'] {
	margin: 0 1rem; /* 헤터 크기 + 1rem */
	background-color: #3b3b3b;
}
form[name='register_form'] > fieldset {
	margin: 0;
	border: 0;
	padding: 0;
}

form[name='register_form'] h1 {
	padding-top: 2rem;
	margin-top: 0;
	text-align: center;
}

form[name='register_form'] ul {
	list-style-type: none;
	padding: 0;
}

form[name='register_form'] li {
    margin: 30px 8rem;
}

form[name='register_form'] input[type='text'],
form[name='register_form'] input[type='url'],
form[name='register_form'] input[type='password'] {
    width: 100%;
    height: 2rem;
	
	padding: 0;
	padding-top: 1rem;
    
	border: 0;
	border-bottom: solid 2px white;
	
    font-family: 'NeoDunggeunmo';
    font-size: 1rem;
    
	background-color: #00000000;
	color: white;
}
form[name='register_form'] input[type='password'] {
    width: 14rem;
}
form[name='register_form'] input::placeholder {
    font-family: 'NeoDunggeunmo';
    font-size: 1rem;
}
form[name='register_form'] input:focus {
	outline: 0;
	border-bottom: solid 2px #f2d377;
	color: #f2d377;
}

form[name='register_form'] select {
    font-family: 'NeoDunggeunmo';
    color: white;
    width: 14rem;
    height: 3rem;
    background-color: #00000000;
    border: solid 2px white;
}
form[name='register_form'] select:focus {
	outline: 0;
}
form[name='register_form'] select:hover {
	outline: 0;
	border: solid 2px #f2d377;
	color: #f2d377;
	cursor: pointer;
}
form[name='register_form'] option {
    color: white;
    background-color:#3b3b3b;
}

/* 잘못 입력했을 때 뜨는 경고 메시지 */
span.error {
	display: inline-block;
	color: red;
	font-size: 0.8rem;
	margin-top: 4px;
}

li#image_upload {
	display: flex;
	align-items: end;
}
.img_wrapper {
	background-color: #252525;
	display: inline-block;
	width: 14rem;
	/* border-radius: 1rem; */
	aspect-ratio: 1.3; /* 이미지의 비율 */
	margin-right: 20px;
	overflow: hidden;
	clip-path: polygon(
		calc(100% - 0.4rem) 0%,
		calc(100% - 0.4rem) 0.2rem,
		calc(100% - 0.2rem) 0.2rem,
		calc(100% - 0.2rem) 0.4rem,
		100% 0.4rem,
		100% calc(100% - 0.4rem),
		calc(100% - 0.2rem) calc(100% - 0.4rem),
		calc(100% - 0.2rem) calc(100% - 0.2rem),
		calc(100% - 0.4rem) calc(100% - 0.2rem),
		calc(100% - 0.4rem) 100%,
		0.4rem 100%,
		0.4rem calc(100% - 0.2rem),
		0.2rem calc(100% - 0.2rem),
		0.2rem calc(100% - 0.4rem),
		0% calc(100% - 0.4rem),
		0% 0.4rem,
		0.2rem 0.4rem,
		0.2rem 0.2rem,
		0.4rem 0.2rem,
		0.4rem 0%
	);
}
.img_wrapper:hover {
	cursor: pointer;
}

/* 게임 사진 */
.img_wrapper img {
	height: 100%;
	width: 100%;
	object-fit: cover; /* 이미지를 겉에 div 태그에 맞게 자름 */
}

input#image {
	display: none;
}

/* 이미지 업로드 버튼 */
label#image_button {
	display: inline-block;
	font-size: 0.8rem;
	margin-bottom: 8px;
	border: solid 2px white;
	padding: 1rem;
}
label#image_button:hover {
	border: solid 2px #f2d377;
	color: #f2d377;
	cursor: pointer;
}

li#image_upload > span {
	margin-bottom: calc(1rem + 8px + 2px); /* 이미지 업로드 버튼의 padding-bottom + margin-bottom + border */
	margin-left: 0.5rem;
	font-size: 0.8rem;
}

/* 등록하기 버튼 가운데 정렬 */
form[name='register_form'] li:last-child {
	text-align: center;
}
form[name='register_form'] button[type='submit'] {
    font-family: 'NeoDunggeunmo';
    font-size: 1rem;
    padding: 0.7rem 1rem;
	color: #3b3b3b;
	background-color: #f2d377;
	border: 0;
	clip-path: polygon(
		calc(100% - 0.4rem) 0%,
		calc(100% - 0.4rem) 0.2rem,
		calc(100% - 0.2rem) 0.2rem,
		calc(100% - 0.2rem) 0.4rem,
		100% 0.4rem,
		100% calc(100% - 0.4rem),
		calc(100% - 0.2rem) calc(100% - 0.4rem),
		calc(100% - 0.2rem) calc(100% - 0.2rem),
		calc(100% - 0.4rem) calc(100% - 0.2rem),
		calc(100% - 0.4rem) 100%,
		0.4rem 100%,
		0.4rem calc(100% - 0.2rem),
		0.2rem calc(100% - 0.2rem),
		0.2rem calc(100% - 0.4rem),
		0% calc(100% - 0.4rem),
		0% 0.4rem,
		0.2rem 0.4rem,
		0.2rem 0.2rem,
		0.4rem 0.2rem,
		0.4rem 0%
	);
}
#btn_wrapper {
 	filter: drop-shadow(4px 4px 0 rgba(0,0,0,1));
}
form[name='register_form'] button[type='submit']:hover {
	cursor: pointer;
}

</style>
</head>
<body>

	<div id="container">
		<div id="header-box">
			<!-- 헤더 공간 -->
		</div>
		
		<div id="contents">
			<form name="register_form" action="game_register_action.do" method="post" enctype="multipart/form-data">
			<!-- 김규빈
				이미지 파일을 전송하기 위해서 enctype 이 multipart/form-data여야 한다.
				기본 값인 application/x-www-form-urlencoded로 되면, 텍스트 형식만 넘겨줄 수 있기 때문이다.
				출처: https://dololak.tistory.com/726 [코끼리를 냉장고에 넣는 방법:티스토리]
			 -->
				<h1>게임 등록</h1>
				<fieldset>
					<ul>
						<li>
							<input name="title" type="text" placeholder="게임 이름" max="30"/>
						</li>
						<li>
							<select name="category">
								<option value="-1">게임 카테고리 선택</option>
								<c:forEach var="category" items="${categoryList}">
									<option value="${category.pkCategoryNo}">${category.name}</option>
								</c:forEach>
							</select>
							<select name="player_cnt">
								<option value="-1">인원수 선택</option>
								<option value="1">1인용</option>
								<option value="2">2인용</option>
								<option value="0">멀티플레이</option>
							</select>
						</li>
						<li>
							<input name="link" type="url" placeholder="게임 링크(https://www.example.com/)" max="500"/>
						</li>
						<li>
							<input name="intro" type="text" placeholder="게임 소개를 자유롭게 작성해주세요!" max="200"/>
						</li>
						<li>
							<input name="passwd" type="password" placeholder="비밀번호(숫자 4자리)" min="4" max="4"/>
						</li>
						<li id="image_upload">
							<label for="image" class="img_wrapper">
								<img id="preview" src="${pageContext.request.contextPath}/images/logo/logo_white_artboard.png"/>
							</label>
							<input id="image" name="image" type="file" onchange="loadPreview(this);" accept=".bmp, .jpg, .jpeg, .png, .webp"/>
							<label id="image_button" for="image">이미지 등록</label>
							<span>(선택 사항)</span>
						</li>
						<li>
							<div id="btn_wrapper">
								<button type="submit">등록하기</button>
							</div>
						</li>
					</ul>
				</fieldset>
			</form>
		</div>
		
		<div id="footer-box">
			<!-- 푸터 공간 -->
		</div>
	</div>
</body>
</html>