var EHOME = EHOME || { };

$(document).ready(function() {
    $("main form input, main form textarea").on("input[type='text'] change", function() {
        window.onbeforeunload = window.onbeforeunload || function (e) {
            return "You have unsaved changes. Do you want to leave this page and lose your changes?";
        };
    });
    $("form").on("submit", function() {
        window.onbeforeunload = null;
    });
    $("form button").click(function() {
        window.onbeforeunload = null;
    });

	$(".roccms-load").each(function() {
		$(this).html('<span class="loading">loading ...</span>');
		$("span.loading").fadeOut ("slow");
		var h = $(this).attr("data-href");
		if (typeof h !== 'undefined') {
			$(this).load(h);
		};
	});

});

/* Google Analytics */
(function(i,s,o,g,r,a,m){i['GoogleAnalyticsObject']=r;i[r]=i[r]||function(){
(i[r].q=i[r].q||[]).push(arguments)},i[r].l=1*new Date();a=s.createElement(o),
m=s.getElementsByTagName(o)[0];a.async=1;a.src=g;m.parentNode.insertBefore(a,m)
})(window,document,'script','//www.google-analytics.com/analytics.js','ga');

ga('create', 'UA-73090313-1', 'auto');
ga('send', 'pageview');

