$(document).ready(function(){
	$("#fileDownload").click(function( event ) {
	    var mirror=  $( "#mirror" ).val();
		var platform= $( "#platform" ).val();

		var href= mirror.concat(platform); 
	
        window.open(href,'Download') ;
	});
})



