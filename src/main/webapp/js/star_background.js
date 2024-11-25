$(document).ready(function() {
	$("body").prepend("<div id='star_box'></div>");
	

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
//	let shooting_star_interval = setInterval(func_shooting_star, 5000);
});