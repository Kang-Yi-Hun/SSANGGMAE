<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<!DOCTYPE html>
<html lang="en">

<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">

<title>쌍겜추</title>

<link rel="stylesheet"
	href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.7.1/font/bootstrap-icons.css">
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/css/body.css">
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/css/star_background.css">
</head>

<body>
	<div id="container">

		<%-- 헤더 부분은 JSP 파일로 공통화 --%>
		<jsp:include page="/header.jsp"></jsp:include>

		<div id="main">
			<div id="sidebar">
				<div id="button_box">
					<%-- 사이드바 카테고리 부분 --%>
					<jsp:include page="/sidebar_category.jsp"></jsp:include>
				</div>
			</div>

			<div id="contents">

				<div id="category">
					<%-- 게임 상세 페이지 헤더 --%>
					<jsp:include page="/game_detail_header.jsp"></jsp:include>
				</div>

				<div id="game_top">

					<c:forEach var="category" items="${categoryList}">
						<c:forEach var="selectedCategory" items="${selectedCategories}">
							<c:if test="${category.getPkCategoryNo() eq selectedCategory}">
								<c:set var="categoryNames"
									value="${categoryNames} ${category.name}" />
							</c:if>
						</c:forEach>

					</c:forEach>

					<div id="header">
						<c:out value="${playerCount}${categoryNames} 게임"></c:out>
					</div>
					<div class="game_box">
						<c:forEach var="game" items="${gameList}">
							<div class="game_link"
								onclick="gameDetails(${game.getPkGameNo()});">
								<div class="img_wrapper">
									<img src="${game.getImage()}" />
								</div>
								<span class="game_name">${game.getTitle()}</span>
							</div>
						</c:forEach>
					</div>
				</div>
			</div>
		</div>

		<%-- footer 부분은 JSP 파일로 공통화 --%>
		<jsp:include page="/footer.jsp"></jsp:include>

		<%-- 위로가기 버튼 --%>
		<a href="#">
			<div id="allow-icon">
				<img src="./images/ikon/allow.png" width="20">
			</div>
		</a>
	</div>

	<div id="game-detail-container"></div>

	<!-- 제이쿼리 사용 -->
	<script src="https://code.jquery.com/jquery-3.7.1.min.js"
		integrity="sha256-/JqT3SQfawRcv/BIHPThkBvs0OEvtFFmqPF/lYI/Cxo="
		crossorigin="anonymous"></script>
	<script>
				// 이미 정의된 변수라고 선언 script 단에서 선언한 변수는 스크립트가 합쳐질때 적용됩니다.
				let nav = $('div#container > header > div#header-wrapper > div.nav-container > nav > ul');

				// 위치에 따른 헤더 스타일 조정 //
				$(window).on('scroll', () => {

					if ($(window).scrollTop() != 0) {
						$('.logo').css({
							width: '5.0rem'
						});
						$('div#header-wrapper').css('height', '5.0rem');
						$('div.nav-container > nav > ul').css('line-height', '5.0rem');
						nav.css('top', '5.0rem');

						$('#allow-icon').fadeIn('#allow-icon.show'); // 위로가기 버튼 등장
					};
					if ($(window).scrollTop() == 0) {
						$('.logo').css({
							width: '10.0rem'
						});
						$('div#header-wrapper').css('height', '8.0rem');
						$('div.nav-container > nav > ul').css('line-height', '6.0rem');
						nav.css('top', '6.0rem');

						$('#allow-icon').fadeOut('#allow-icon.show'); // 위로가기 버튼 퇴장
					};

				});
				// 위치에 따른 헤더 스타일 조정 //

				// 게임 상세 페이지를 동적으로 불러오기 위한 ajax 코드
				function gameDetails(gameNo) {

					$("body").css({
						'overflow': 'hidden'
					});

					$.ajax({
						url: 'SSANGGMAE/details',
						data: { gameNumber: gameNo },
						success: function (response) {
							$('#game-detail-container').html(response);
						}
					});
				}

				// 문서 로딩 시 jquery 실행 시작 
				$(document).ready(function () {

					// 햄버거 및 드롭다운 메뉴 생성 //
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

			</script>
	<script type="text/javascript"
		src="${pageContext.request.contextPath}/js/star_background.js"></script>
</body>

</html>