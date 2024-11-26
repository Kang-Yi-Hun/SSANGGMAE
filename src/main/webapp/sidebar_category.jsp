<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>

<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.7.1/font/bootstrap-icons.css">
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/sidebar_category.css">
</head>

<body>
	<%-- 사이드바 카테고리 --%>
	<div id="sidebar_category_container">

		<form id="category_form" action="${pageContext.request.contextPath}/browse" method="get">

			<%-- 체크한 게임 카테고리의 정보가 담기는 필드 --%>
			<input type="hidden" name="playerCnt" value="">

			<%-- 체크한 플레이어 인원 수 정보가 담기는 필드 --%>
			<input type="hidden" name="categories" value="">

			<%-- tbl_game 테이블의 player_cnt의 체크 제약에서 0 : 멀티, 1 : 1인용, 2 : 2인용에 더하여 3: 전체로 처리 --%>
			<c:set var="playerCntNo" value="${playerCnt}"></c:set>

			<%-- 인원수 카테고리 --%>
			<%-- 이전 요청의 인원수 값(1인용)을 사용하여 해당 인원수 카테고리 하이라이트 --%>
			<div id="player_cnt_category">
				<span>인원수</span>
				<button id="1" class="player_cnt_btn ${(playerCntNo == '1') ? 'player_cnt_active' : '' }">1인용</button>
				<button id="2" class="player_cnt_btn ${(playerCntNo == '2') ? 'player_cnt_active' : '' }">2인용</button>
				<button id="0" class="player_cnt_btn ${(playerCntNo == '0') ? 'player_cnt_active' : '' }">멀티</button>
				<button id="3" class="player_cnt_btn ${(playerCntNo == '3') ? 'player_cnt_active' : '' }">전체</button>
			</div>
		
			<%-- 게임장르 카테고리 --%>
			<div id="game_category">
				<span>게임장르</span>
				<c:forEach var="category" items="${categoryList}">

					<c:set var="isSelected" value="false" />

					<%-- 이전 카테고리 요청에 포함된 카테고리라면 isSelected=true, 선택된 카테고리 이름들을 저장하는 변수에 저장 --%>
					<%-- 각 카테고리의 pk가 선택된 카테고리의 id와 동일하다면 토글 처리 --%>
					<c:if test="${selectedCategories != null}">
						<c:forEach var="selectedCategory" items="${selectedCategories}">
							<c:if test="${category.getPkCategoryNo() eq selectedCategory}">
								<c:set var="isSelected" value="true" />
							</c:if>
						</c:forEach>
					</c:if>

					<%-- 카테고리 버튼 렌더링 --%>
					<button type="button" id="${category.pkCategoryNo}" class="category_btn ${isSelected ? 'category_active' : ''}">${category.name}</button>
				</c:forEach>
			</div>
		</form>
	</div>

	<script src="https://code.jquery.com/jquery-3.7.1.min.js" integrity="sha256-/JqT3SQfawRcv/BIHPThkBvs0OEvtFFmqPF/lYI/Cxo=" crossorigin="anonymous"></script>
	<script>
	$(document).ready(function () {
	    // 인원수 카테고리 버튼 클릭 처리
	    $(document).on('click', 'button.player_cnt_btn', e => {
	    	
	    	// 라디오 버튼과 같은 처리
	    	// 이미 선택한 버튼이었다면 처리 X 그렇지 않은 버튼이면
	    	// 다른 모든 버튼의 토글상태 해제 이후 해당 버튼만 토글 처리 
	        if (!$(e.target).hasClass("player_cnt_active")) {
	            $('button.player_cnt_btn').removeClass("player_cnt_active");
	            $(e.target).addClass("player_cnt_active");
	        }
	        updateAndSubmitForm(); // 폼 업데이트 및 제출
	    });

	    // 게임장르 카테고리 버튼 클릭 처리
	    $(document).on('click', 'button.category_btn', e => {	 
	        if ($(e.target).hasClass("category_active")) {
	            $(e.target).removeClass("category_active"); // 이미 선택된 경우 해제
	        } else {
	            $(e.target).addClass("category_active"); // 선택되지 않은 경우 선택
	        }
	        updateAndSubmitForm(); // 폼 업데이트 및 제출
	    });
	    
	    // 폼 데이터 업데이트 및 제출 함수
	    function updateAndSubmitForm() {
	        let playerCountList = []; // 인원수 id를 담을 리스트
	        let categoryList = []; // 카테고리 id를 담을 리스트

	        // 선택된 인원수 id 추가
	        $('.player_cnt_active').each(function() {
	            playerCountList.push($(this).attr("id"));
	        });

	        // 선택된 게임장르 id 추가
	        $('.category_active').each(function() {
	            categoryList.push($(this).attr("id"));
	        });

	        // hidden input 값 업데이트
	        $('input[name="playerCnt"]').val(playerCountList.join(","));
	        $('input[name="categories"]').val(categoryList.join(","));

	        // 폼 제출
	       	$('#category_form').submit();
	    }
	});
	</script>

</body>

</html>