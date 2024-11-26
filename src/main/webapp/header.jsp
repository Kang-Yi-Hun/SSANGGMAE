<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>쌍겜추</title>

<link rel="stylesheet"
	href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.7.1/font/bootstrap-icons.css">
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/css/header.css">
</head>
<body>
	<!-- header를 JSP파일로 분리해서 jsp import 하기 -->
	<header>
		<div id="header-wrapper">
			<div class="logo-container">
				<img src="./images/logo/logo.png" alt="로고" class="logo">
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
</body>
</html>