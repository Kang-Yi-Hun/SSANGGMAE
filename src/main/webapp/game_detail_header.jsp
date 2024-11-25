<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">

<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.7.1/font/bootstrap-icons.css">
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/game_detail_header.css">
</head>
<body>
	<%-- 게임 상세 페이지 전용 헤더 (전체게임, 인기게임, 최신게임, 게임추가) --%>
	<div id="player_cnt_container">
		<a class="player_cnt_item" href="#">전체게임</a>
		<a class="player_cnt_item" href="#">인기게임</a>
		<a class="player_cnt_item" href="${pageContext.request.contextPath}/Recentgame">최신게임</a>
		<a class="player_cnt_item" href="#">게임추가</a>
	</div>
</body>
</html>