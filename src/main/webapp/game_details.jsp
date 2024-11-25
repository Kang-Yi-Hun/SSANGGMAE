<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
	<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
		<!DOCTYPE html>
		<html>

		<head>
			<link rel="stylesheet" href="${pageContext.request.contextPath}/css/game_details.css">
		</head>

		<body>
			<div id="game_container">
				<div id="close_button">
					<div class="close_art"></div>
				</div>

				<div id="game_main">
					<div id="image-container">
						<div id="game_image_wrapper">
							<img class="game_image" src="${gameDTO.getImage()}" onerror="this.onerror=null; this.src='images/logo/logo_white_artboard.png';"/>
						</div>

						<a id="start_game_button" href="${gameDTO.getLink()}">
							<span>게임 시작하기</span>
						</a>
					</div>

					<div id="details-container">
						<div id="details_header">
							<h1>
								<c:out value="${gameDTO.getTitle()}" />
							</h1>
							<div id="views_container">
								<img src="${pageContext.request.contextPath}/images/ikon/eye.png" />
								<span>views :
									<c:out value="${gameDTO.getViews()}" />
								</span>
							</div>
						</div>

						<div id="details">
							<p class="detail">
								<c:out value="${gameDTO.getIntro()}" />
							</p>
							<p class="detail">
								<c:out value="${gameDTO.getPlayerCnt()}" />인용 게임
							</p>
							<p class="detail">등록날짜 :
								<c:out value="${gameDTO.getRegisterDay()}" />
							</p>
							<p class="detail">조회수 :
								<c:out value="${gameDTO.getViews()}" />
							</p>
							<p class="detail">카테고리 :
								<c:out value="${gameDTO.getCategoryDTO().getName()}" />
							</p>
						</div>
					</div>
				</div>
			</div>
			<div id="background"></div>


			<script type="text/javascript" src="${pageContext.request.contextPath}/js/jquery-3.7.1.min.js"></script>
			<script>

				$(window).scroll(e => {
					const top = $(document).scrollTop();

					$("#game_container").css({
						'top': top + 200
					});
				});

				$(document).on("click", "#close_button", e => {
					$("#game_container").hide();
					$("#background").hide();
					
					$("body").css({
						'overflow': 'auto'
					});
				});
				
			</script>
		</body>

		</html>