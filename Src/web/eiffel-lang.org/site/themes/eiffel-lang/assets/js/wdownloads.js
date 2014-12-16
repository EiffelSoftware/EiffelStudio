var WDOWNLOAD = WDOWNLOAD || { };

WDOWNLOAD.toggle = function () {
    $(".more").hide();
    $('.button-read-more').click(function () {
        $(this).closest('.less').addClass('active');
        $(this).closest(".less").prev().stop(true).slideDown("1000");
    });
    $('.button-read-less').click(function () {
        $(this).closest('.less').removeClass('active');
        $(this).closest(".less").prev().stop(true).slideUp("1000");
    });
};

WDOWNLOAD.toggle2 = function () {
    $(".more").hide();
    $('.button-read-more').click(function () {
        $(this).closest('.less').addClass('active');
        $(this).closest(".less").next().stop(true).slideDown("1000");
    });
    $('.button-read-less').click(function () {
        $(this).closest('.less').removeClass('active');
        $(this).closest(".less").next().stop(true).slideUp("1000");
    });
};


WDOWNLOAD.expand_first = function () {
    $('div.more:first').show();
    $('div.less:first').addClass('active');
    $('div.less:first').next().stop(true).slideDown("1000"); 
}

$(document).ready(function() {
		/* toogle EiffelSutdio Product*/

	WDOWNLOAD.toggle2 ();
    WDOWNLOAD.expand_first();
 
		/* Download a particular EiffelStudio version */
	$('.download_link').click(function(e) {
		e.preventDefault();	
		window.open (this.href);
		return false;
	});
 }
);