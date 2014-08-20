jQuery(document).ready( function($){
		$( '.responsiveMenuSelect' ).change(function() {
			var loc = $(this).find( 'option:selected' ).val();
			if( loc != '' && loc != '#' ) window.location = loc;
		});
		//$( '.responsiveMenuSelect' ).val('');
	});