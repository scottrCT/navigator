// Add support for background blend mode
// Does modernsize add a class for this?
if( 'backgroundBlendMode' in document.body.style ) {
	// No support for background-blend-mode
	var html = document.getElementsByTagName("html")[0];
	html.className = html.className + " background-blend-mode";
}

var SITE = (function($) {

	var init = function() {

		// Prevent CSS animations until load
		$('body').removeClass('preload');

		// Uses nprogress() script for ajax loading of internal links
		// if( $('html').hasClass('history') ) {
		// 	$.getScript( '/assets/js/project.links.js' )
		// }

		$('.hamburger').click(function(){
			$('body').toggleClass('modalOpen navOpen');
			$('.modal .insideModal').html('');
		});

		$(document).on('click', '.close', function(){
			$('body').removeClass('modalOpen navOpen');
		});

		// Click outside of modal ara
		$(document).on('click', '.modalOpen .modal', function(e) {
			if ( $(e.target).hasClass('modal') ) {
				$('.close').trigger('click');
			}
		});



		moveProgressBar();
	    // on browser resize...
	    $(window).resize(function() {
	        moveProgressBar();
	    });

	    // SIGNATURE PROGRESS
	    function moveProgressBar() {
	        var getPercent = ($('.progress-wrap').data('progress-percent') / 100);
	        var getProgressWrapWidth = $('.progress-wrap').width();
	        var progressTotal = getPercent * getProgressWrapWidth;
	        var animationLength = 2500;
	        
	        // on page load, animate percentage bar to data percentage length
	        // .stop() used to prevent animation queueing
	        $('.progress-bar').stop().animate({
	            left: progressTotal
	        }, animationLength);
	    }
	    





	};

	var scroll = function() {

		var winH = $(window).height();
		var pixelsScrolled = $(window).scrollTop();

	};

	var resize = function() {

		var docH = $(document).height();
		var winH = $(window).height();
		var winW = $(window).width();

	};

	return {
		init: 	init,
		scroll: scroll,
		resize: resize
	};

}(jQuery));

$(document).ready(function() {
	SITE.init();
	SITE.scroll();
	SITE.resize();
});

$(window).scroll(function() {
	SITE.scroll();
});

$(window).resize(function() {
	SITE.resize();
});

$(window).load(function(){
	$('body').addClass('loaded');
});

$(document).keyup(function(e) {
	if (e.keyCode == 27) { // Esc key
		$('.close').trigger('click');
	}
	if (e.keyCode == 37) { // Left arrow
	}
	if (e.keyCode == 39) { // Right arrow
	}
});
