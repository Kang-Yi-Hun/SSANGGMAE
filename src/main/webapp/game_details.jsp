<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>

<body>
	<div id="game_container">
		<div id="game_main">
			<button id="close_btn">닫기</button>

			<div id="image-container">
				<img class="game_image" src="${gameDTO.image}" />
			</div>

			<div id="details-container">
				<h1>
					<c:out value="${gameDTO.title}" />
				</h1>
			</div>
		</div>
	</div>
	<div id="background"></div>


	<script src="https://code.jquery.com/jquery-3.7.1.min.js"
		integrity="sha256-/JqT3SQfawRcv/BIHPThkBvs0OEvtFFmqPF/lYI/Cxo="
		crossorigin="anonymous"></script>
	<script>
				$(window).scroll(e => {
					const top = $(document).scrollTop();

					$("#game_container").css({
						'top': top + 200
					});
				});

				$(document).on("click", "#close_btn", e => {
					$("#game_container").hide();
					$("#background").hide();
				});
			</script>
</body>

</html>