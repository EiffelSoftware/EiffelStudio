
$(document).ready(function() {
		/* toogle EiffelSutdio Product*/
	$('#EiffelStudio').click(function() {
	    $('.toggle2').toggle();
	    return false;
	});

		/* Download a particular EiffelStudio version */
	$('.download_link').click(function(e) {
		e.preventDefault();	
		window.open (this.href);
		return false;
	});
 }
);