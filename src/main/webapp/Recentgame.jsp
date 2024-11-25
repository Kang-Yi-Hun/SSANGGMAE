<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
	<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
		<!DOCTYPE html>
		<html lang="en">

		<head>
			<meta charset="UTF-8">
			<meta name="viewport" content="width=device-width, initial-scale=1.0">
			<title>쌍겜추 최신게임</title>

			<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.7.1/font/bootstrap-icons.css">
			<link rel="stylesheet" href="${pageContext.request.contextPath}/css/header.css">
			<link rel="stylesheet" href="${pageContext.request.contextPath}/css/footer.css">
			<link rel="stylesheet" href="${pageContext.request.contextPath}/css/Recentgame.css">
			<link rel="stylesheet" href="${pageContext.request.contextPath}/css/star_background.css">
			<link rel="stylesheet" href="${pageContext.request.contextPath}/css/game_detail_header.css">
		</head>

		<body>
			<div id="container">

				<!-- header를 JSP파일로 분리해서 jsp import 하기 -->
				<header>
					<div id="header-wrapper">
						<div class="logo-container">
							<img src="./images/logo/logo_red_white.png" alt="로고" class="logo">
						</div>
						<div class="search-container">
							<form>
								<input type="text" placeholder="게임을 검색하세요">
								<button type="submit" id="search-btn">
									<img src="./images/ikon/search.png" class="search-ikon">
								</button>
							</form>
						</div>
					</div>
				</header>

				<!-- 가상의 높이를 준 것이다 -->
				<div id="main">

					<!-- 가상의 높이를 준 것이다  여기에 상세페이지나 게임등록페이지의 내용이 들어가면 될 것 같다.-->
					<div id="contents">
					<jsp:include page="/game_detail_header.jsp"></jsp:include>
					
						<!-- div#main 부터 게임상세페이지 내용 -->
						<div id="game_bottom">

							<div id="header">최신등록게임</div>

							<div class="game_box">
							
								<!-- forEach문으로 var는 하나의 item, items는 List<gameDTO>인 gameList를 말합니다. 따라서 game은 하나의 gameDTO입니다. -->
								<c:forEach var="game" items="${Recent_gameList}">
									<div class="game_link" onclick="gameDetails(${game.getPkGameNo()});">
										<div class="img_wrapper">
											<img src="${game.getImage()}" onerror="this.onerror=null; this.src='images/logo/logo_white_artboard.png';"/>
										</div>
										<span class="game_name">${game.getTitle()}</span>
									</div>
								</c:forEach>

						
							</div>

						</div>
					</div>


				</div>
				<!-- 가상의 높이를 준 것이다 -->

				<footer>
					<div class="heading">
						<a href="#"><img src="./images/logo/footerlogo.png"></a>
					</div>
					<div class="menus">
						<ul>
							<li class="title">Projects</li>
							<li>Portfolio</li>
							<li>Other Site</li>
							<li>Team</li>
						</ul>
						<ul>
							<li class="title">Resources</li>
							<li>Portfolio</li>
							<li>Other Site</li>
							<li>Team</li>
						</ul>
						<div class="info">
							<span class="title">Social Media</span>
							<p>Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco
								laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur.</p>
							<div class="social">
								<a href="#"><i class="bi bi-facebook"></i></a> <a href="#"><i class="bi bi-twitter"></i></a> <a href="#"><i class="bi bi-instagram"></i></a> <a href="#"><i class="bi bi-linkedin"></i></a>
							</div>
						</div>
					</div>
					<div class="footer-bottom">Copyright ⓒ kyh kkb ksj kjs</div>
				</footer>

				<a href="#">
					<div id="allow-icon">
						<img src="./images/ikon/allow.png" width="20">
					</div>
				</a>
			</div>

			<!-- 제이쿼리 사용 -->
			<script type="text/javascript" src="${pageContext.request.contextPath}/js/jquery-3.7.1.min.js"></script>
			<script>

				let nav = $('div#container > header > div#header-wrapper > div.nav-container > nav > ul');

				// 위치에 따른 헤더 스타일 조정 //
				$(window).on('scroll', () => {

					if ($(window).scrollTop() != 0) {
						$('.logo').css({
							'width': '4.0rem',
							'margin-top': '0.4rem'
						});
						$('div#header-wrapper').css('height', '5.0rem');
						$('header').css('backdrop-filter', 'blur(1rem)');
						$('div.nav-container > nav > ul').css('line-height', '5.0rem');
						nav.css('top', '5.0rem');

						$('#allow-icon').fadeIn('#allow-icon.show'); // 위로가기 버튼 등장
					};
					if ($(window).scrollTop() == 0) {
						$('.logo').css({
							'width': '',
							'margin-top': ''
						});
						$('div#header-wrapper').css('height', '');
						$('header').css('backdrop-filter', '');
						$('div.nav-container > nav > ul').css('line-height', '');
						nav.css('top', '');

						$('#allow-icon').fadeOut('#allow-icon.show'); // 위로가기 버튼 퇴장
					};

				});
				// 위치에 따른 헤더 스타일 조정 //


				// 햄버거 및 드롭다운 메뉴 생성 //
				$(document).ready(function () {

					$('#hamburger').on('click', function () {
						nav.toggleClass('active').slideToggle();
					});

					$(window).resize(function () {
						if (window.innerWidth > 768) {
							nav.show();
						} else {
							nav.removeClass('active').hide();
						}
					});

				});
				// 햄버거 및 드롭다운 메뉴 생성 //

				function gameDetails(gameNo) {
					$("body").css({
						'overflow': 'hidden'
					});

					$.ajax({
						url: '${pageContext.request.contextPath}/game_details',
						data: { gameNumber: gameNo },
						success: function (response) {
							$('#game-detail-container').html(response);
						}
					});
				}
				
				// 게시글 등록 완료 후 게시글 보여주기
				if("${sessionScope.gameNumber}" != ""){
					alert('게임 등록이 완료되었습니다.');
					gameDetails(${sessionScope.gameNumber});
				}

			</script>
			<script type="text/javascript" src="${pageContext.request.contextPath}/js/star_background.js"></script>
			<div id="game-detail-container"></div>
		<c:remove var="gameNumber" scope="session" /> <!-- 세션 삭제 -->

		</body>

		</html>