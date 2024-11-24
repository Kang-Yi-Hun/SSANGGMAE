

let nav = $('div#container > header > div#header-wrapper > div.nav-container > nav > ul');

$(document).ready(function(){
    $('.main-item').css({ // 비행기 스타일
            right: '38%',
            top: '40%',
            transform: 'rotate(-180deg)'
    });
});


// 첫 섹션 타이틀 등장 //
$('#section1 > div:first-child').css({
    opacity: "1",
    left: "0%"
});
// 첫 섹션 타이틀 등장 //

$(window).scroll(()=>{
    const scrollTop = $(window).scrollTop();
    
    // 위치에 따른 헤더 스타일 조정 //
    if($(window).scrollTop() != 0){
        $('.logo').css({
            width: '5.0rem',
            height: '5.0rem'
        });
        $('div#header-wrapper').css('height', '5.0rem');
        $('div.nav-container > nav > ul').css('line-height', '5.0rem');
        nav.css('top', '5.0rem');

        $('#allow-icon').fadeIn('#allow-icon.show'); // 위로가기 버튼 등장

    };
    if($(window).scrollTop() == 0){
        $('.logo').css({
            width: '6.0rem',
            height: '6.0rem'
        });
        $('div#header-wrapper').css('height', '6.0rem');
        $('div.nav-container > nav > ul').css('line-height', '6.0rem');
        nav.css('top', '6.0rem');

        $('#allow-icon').fadeOut('#allow-icon.show'); // 위로가기 버튼 퇴장
    };
    // 위치에 따른 헤더 스타일 조정 //

    


    // 방정식 캐러셀 시작 //
    let container = $('#equation-container').offset().top;
    // console.log(container);
    // 방정식 캐러셀 시작위치

    let nextsection = $('#section2').offset().top;
    // console.log(nextsection);
    // 방정식 캐러셀 끝 위치

    const 높이 = $(window).scrollTop();
    // console.log(높이);
    // 스크롤 할 때마다의 사용자 스크롤 위치

    let y = (200 / (nextsection - container)) * 높이 +(-(200 / (nextsection - container)) * container);
    let y_2 = (200 / (nextsection - container)) * (높이 - container);

    $('.topimg').css('left', y);
    $('.bottomimg').css('right', y_2);


    let section2Height = $('#section2').offset().top;

    let 투명도1 = (-1/900) * 높이 + (23/9); // 1600 - 2300
    let 사이즈1 = (-0.00014) * 높이 + (1.22857);    

    let 투명도2 = (-1/900) * 높이 + (30/9);
    let 사이즈2 = (-0.00014) * 높이 + (1.32857);

    $('#section2 > div:nth-child(2)').css({
        'opacity' : `${투명도1}`,
        'transform' : `scale(${사이즈1})`
    });

    $('#section2 > div:nth-child(3)').css({
        'opacity' : `${투명도2}`,
        'transform' : `scale(${사이즈2})`
    });

    // 방정식 캐러셀 끝 //




    // 두번째 섹션 타이틀 등장 //
    if(scrollTop > $('#section2').offset().top-200){
        $('#section2 > div:first-child').css({
            opacity: "1",
            top: "45%"
        });
    }
    // 두번째 섹션 타이틀 등장 //
    // 두번째 섹션 비행기 모션 //
    if(scrollTop > $('#section2').offset().top-500){
        $('.main-item').css({ // 비행기 스타일
            right: '48%',
            top: '20%'
        });
    }
    // 두번째 섹션 비행기 모션 //



    // 세번째 섹션 배경화면 모션 //
    if(scrollTop > $('#section3').offset().top-300){
        $('#section-container').css({ 
            'background-color' : '#fff',
            'background-image': 'none'
        });
        $('header').css({
            'background-color': '#e8e6e1b9'
        });
        $('a').css({
            'color' : '#000'
        });

        // $('div#container > div:first-child').removeClass('star_box')//////////////////////////////
    }
    if(scrollTop < $('#section3').offset().top-300){
        $('#section-container').css({
            'background-color' : '',
            'background-image': ''
        });
        $('header').css({
            'background-color': ''
        });
        $('a').css({
            'color' : ''
        });
        
    }
    // 세번째 섹션 배경화면 모션 //

    
});



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


let top_left = []; // top, left 값을 저장하기 위한 2차원 배열 생성

// 별 50개 생성
for(let i=0; i<50; i++) {
    $("div#star_box").append(`<div class='star'></div>`);

    // 크기 랜덤 값 뽑기
    let max = 8; // 최대 크기
    let min = 2; // 최소 크기
    let star_size = Math.floor( Math.random()*(max-min+1) ) + min;
    star_size /= 10.0;

    // 위치 랜덤 값 뽑기
    top_left.push([Math.random()*(100+1), Math.random()*(100+1)]);

    // 위치와 크기 지정
    $(`div.star`).eq(i).css({
        'width': `${star_size}rem`,
        'height': `${star_size}rem`,
        'top': `${top_left[i][0]}vh`,
        'left': `${top_left[i][1]}vw`
    });

    // 별 10개는 약간 블러 주기
    if(i>=40){
        $(`div.star`).eq(i).css({'box-shadow': '0px 0px 5px 1px #F2D377'});
    }
}

let func_star = function() {
    for(let i=0; i<50; i++) {
        if(top_left[i][0] > 105){
            top_left[i][0] = -5;
        }
        if(top_left[i][1] > 105){
            top_left[i][1] = -5;
        }
        if(i<30){
            top_left[i][0] += 0.01;
            top_left[i][1] += 0.01;
            $(`div.star`).eq(i).css({'top':`${top_left[i][0]}vh`});
            $(`div.star`).eq(i).css({'left':`${top_left[i][1]}vw`});
        }
        else {
            top_left[i][0] += 0.02;
            top_left[i][1] += 0.02;
            $(`div.star`).eq(i).css({'top':`${top_left[i][0]}vh`});
            $(`div.star`).eq(i).css({'left':`${top_left[i][1]}vw`});
        }
    }
};

// 10ms 마다 움직이도록 설정
let star_interval = setInterval(func_star, 10);

// 별똥별
let func_shooting_star = function() {
    
    $("div#star_box").append(`<div id='shooting_star'></div>`);
    
    let top_left2 = [Math.random()*(80+1), Math.random()*(80+1)];

    $(`div#shooting_star`).css({
        'top': `${top_left2[0]}vh`,
        'left': `${top_left2[1]}vw`
    });

    setTimeout(function() {
        $("div#shooting_star").remove();
    }, 1000);

    setTimeout(function() {
        $(`div#shooting_star`).css({
            'top': `${top_left2[0] + 15}vh`,
            'left': `${top_left2[1] + 15}vw`
        });
    }, 50);

};

// 5초 마다 별똥별이 떨어지도록 설정
let shooting_star_interval = setInterval(func_shooting_star, 5000);