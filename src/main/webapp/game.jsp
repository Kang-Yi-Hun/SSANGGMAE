<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>쌍겜추</title>
    <link rel="stylesheet" href="./css/header.css">
    <link rel="stylesheet" href="./css/footer.css">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.7.1/font/bootstrap-icons.css">
    <link rel="stylesheet" href="./css/body.css">
</head>
<body>
<%@ page import="java.sql.*, javax.sql.*, javax.naming.*, game.model.*, game.domain.*, java.util.*" %>
<%
request.setCharacterEncoding("utf-8");
	
GameDAO gameDAO = new GameDAO_imple();

List<GameDTO> gameList = gameDAO.getPopularGames();
%>
    <div id="container">
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

        <!-- 가상의 높이를 준 것이다 -->
        <!-- 가상의 높이를 준 것이다 -->
        <div id="main">

            <div id="sidebar">
                <div id="button_box">
                    <button type="button">점메추</button>
                    <button type="button">게임등록하기</button>
                </div>
            </div>


            <!-- 가상의 높이를 준 것이다  여기에 상세페이지나 게임등록페이지의 내용이 들어가면 될 것 같다.-->
            <div id="contents">
                <!-- div#main 부터 게임상세페이지 내용 -->
                <div id="game_top">
                    
                    <div id="header">인기게임</div>
                    <div class="game_box">
<%
for(int i=0; i<gameList.size(); i++) {
%>
                        <a class="game_link" href="<%=gameList.get(i).getLink()%>">
                            <div class="img_wrapper">
                                <img src="<%=gameList.get(i).getImage()%>"/>
                            </div>
                            <span class="game_name"><%=gameList.get(i).getTitle()%></span>
                        </a>
<%
}

if(gameList.size() < 4) {
	for(int i=0; i<4-gameList.size(); i++) {
%>
                        <a class="game_link" href="https://www.chelseafc.com/en">
                            <div class="img_wrapper">
                                <img src="images/logo/logo.png"/>
                            </div>
                            <span class="game_name">등록된 게임이 없습니다</span>
                        </a>
<%
	}
}
%>
                    </div>
                </div>
        
                <div id="game_bottom">
        
                    <div id="header">최신등록게임</div>
        
                    <div class="game_box">
                        <a class="game_link" href="https://www.naver.com/">
                            <div class="img_wrapper">
                                <img src="images/logo/logo.png"/>
                            </div>
                            <span class="game_name">게임이름1</span>
                        </a>
                        <a class="game_link" href="https://www.google.com/">
                            <div class="img_wrapper">
                                <img src="images/logo/logo.png"/>
                            </div>
                            <span class="game_name">게임이름2</span>
                        </a>
                        <a class="game_link" href="https://www.youtube.com/">
                            <div class="img_wrapper">
                                <img src="images/logo/logo.png"/>
                            </div>
                            <span class="game_name">게임이름3</span>
                        </a>
                        <a class="game_link" href="https://www.chelseafc.com/en">
                            <div class="img_wrapper">
                                <img src="images/logo/logo.png"/>
                            </div>
                            <span class="game_name">게임이름4</span>
                        </a>
                    </div>
        
                </div>
           </div>


        </div>
        <!-- 가상의 높이를 준 것이다 -->
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
        
        <a href="#"><div id="allow-icon"><img src="./images/ikon/allow.png" width="20"></div></a>
    </div>

    <!-- 제이쿼리 사용 -->
    <script src="https://code.jquery.com/jquery-3.7.1.min.js" integrity="sha256-/JqT3SQfawRcv/BIHPThkBvs0OEvtFFmqPF/lYI/Cxo=" crossorigin="anonymous"></script>
    <script>
        
        let nav = $('div#container > header > div#header-wrapper > div.nav-container > nav > ul');

        // 위치에 따른 헤더 스타일 조정 //
        $(window).on('scroll', () => {
            
            if($(window).scrollTop() != 0){
                $('.logo').css({
                    width: '5.0rem'
                });
                $('div#header-wrapper').css('height', '5.0rem');
                $('div.nav-container > nav > ul').css('line-height', '5.0rem');
                nav.css('top', '5.0rem');

                $('#allow-icon').fadeIn('#allow-icon.show'); // 위로가기 버튼 등장
            };
            if($(window).scrollTop() == 0){
                $('.logo').css({
                    width: '10.0rem'
                });
                $('div#header-wrapper').css('height', '10.0rem');
                $('div.nav-container > nav > ul').css('line-height', '6.0rem');
                nav.css('top', '6.0rem');

                $('#allow-icon').fadeOut('#allow-icon.show'); // 위로가기 버튼 퇴장
            };

        });
        // 위치에 따른 헤더 스타일 조정 //


        // 햄버거 및 드롭다운 메뉴 생성 //
        $(document).ready(function () {

            $('#hamburger').on('click', function(){
                nav.toggleClass('active').slideToggle();
            });

            $(window).resize(function() {
                if (window.innerWidth > 768) {
                    nav.show();
                } else {
                    nav.removeClass('active').hide();
                }
            });

        });
        // 햄버거 및 드롭다운 메뉴 생성 //

    </script>
</body>
</html>