<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en" >
    <!-- oncontextmenu="return false" ondragstart="return false" onselectstart="return false" -->
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    
	<meta property="og:title" content="쌍겜추"/>
	<meta property="og:type" content="website"/>
	<meta property="og:url" content="https://www.ssanggame.kro.kr"/>
	<meta property="og:description" content="쌍용 게임 추천 사이트"/>
	<meta property="og:image" content="https://www.ssanggame.kro.kr/images/logo/logo.png"/>
	<meta property="og:image:width" content="1200" />
	<meta property="og:image:height" content="627" />
	
    <title>쌍겜추</title>
    <link rel="stylesheet" href="./css/css.css">
    <link rel="stylesheet" href="./css/main_body.css">
    <link rel="stylesheet" href="./css/footer.css">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.7.1/font/bootstrap-icons.css">
</head>
<body>
    <div id="container">
        <div id="star_box">
        <header>
            <div id="header-wrapper">
                <div class="logo-container">
                    <a href="game.jsp">
                        <img src="./images/logo/logo.png" alt="로고" class="logo">
                    </a>
                </div>
                <div class="nav-container">
                    <nav>
                        <div class="hamburgerbar" id="hamburger">
                            <ul>
                                <li class="hamburger"></li>
                                <li class="hamburger"></li>
                                <li class="hamburger"></li>
                            </ul>
                        </div>
                        <ul style="display: flex;">
                            <li><a href="/game">모든게임</a></li>
                            <li><a href="/game_register">게임추가</a></li>
                            <li><a href="#">회사소개</a></li>
                            <li><a href="#">점메추</a></li>
                        </ul>
                    </nav>
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
        <!-- header -->

        <!-- <div style="height: 2000px; width: 80%; margin: 0 auto; background-color: antiquewhite; min-width: 600px;"> -->
            <!-- 가상의 높이를 준 것이다 -->
        <!-- </div> -->

        <div id="section-container">
            <!-- 꾸미기 용도 오브젝트 -->
            <div class="object-pixel"></div>
            <div class="object-pixel"></div>
            <div class="object-pixel"></div>
            <div class="object-pixel"></div>
            <div class="object-pixel"></div>
            <div class="object-pixel"></div>

            <div class="main-item"></div> <!-- 비행기 -->
            <!-- 꾸미기 용도 오브젝트 -->
            <div id="section1"class="section">
                <div>모두 함께 즐기는 <div>쌍겜추</div></div>
                <div class="main-img">main-img</div>

            </div>

            <!-- 방정식 캐러셀 -->
            <div id="equation-container">
                <div class="topimg">
                    <div class="img"></div>
                    <div class="img"></div>
                    <div class="img"></div>
                    <div class="img"></div>
                </div>
                <div class="bottomimg">
                    <div class="img"></div>
                    <div class="img"></div>
                    <div class="img"></div>
                    <div class="img"></div>
                </div>
            </div>
            <!-- 방정식 캐러셀 -->

        
            <div id="section2"class="section">
                <div>들키지 않았던 <span>게임들!</span></div>
                <!-- 방정식 카드 -->
                <div class="section2-item"></div> 
                <div class="section2-item"></div>
                <div class="section2-item"></div>
                <!-- 방정식 카드 -->
            </div>
            <div id="section3"class="section"><div>쌍용.게임.추천</div></div>
            <div id="section4"class="section">section4</div>
        </div>
        <!-- contents -->
        </div>

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
                    <p>
                        Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. 
                        Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. 
                        Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. 
                    </p>
                    <div class="social">
                        <a href="#"><i class="bi bi-facebook"></i></a>
                        <a href="#"><i class="bi bi-twitter"></i></a>
                        <a href="#"><i class="bi bi-instagram"></i></a>
                        <a href="#"><i class="bi bi-linkedin"></i></a>
                    </div>
                </div>
            </div>
            <div class="footer-bottom"> 
                Copyright ⓒ kyh kkb ksj kjs
            </div>
        </footer>
        <!-- footer -->
        <a href="#"><div id="allow-icon"><img src="./images/ikon/allow.png" width="20"></div></a><!-- 귀요미 위로가기 버튼 -->
    </div>

    <!-- 제이쿼리 사용 -->
    <script src="https://code.jquery.com/jquery-3.7.1.min.js" integrity="sha256-/JqT3SQfawRcv/BIHPThkBvs0OEvtFFmqPF/lYI/Cxo=" crossorigin="anonymous"></script>
    <script type="text/javascript" src="js/header.js"></script>
</body>
</html>