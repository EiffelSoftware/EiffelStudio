(function($, document, window){
	
	$(document).ready(function(){

		// Cloning main navigation for mobile menu
		$(".mobile-navigation").append($(".main-navigation .menu").clone());

		// Mobile menu toggle 
		$(".menu-toggle").click(function(){
			$(".mobile-navigation").slideToggle();
		});

		$(".testimonial-slider").flexslider({
			directionNav: false,
			controlNav: true,
		});

		var map = $(".map");
		var latitude = map.data("latitude");
		var longitude = map.data("longitude");
		if( map.length ){
			
			map.gmap3({
				map:{
					options:{
						center: [latitude,longitude],
						zoom: 15,
						scrollwheel: false,
					}
				},
				marker:{
					latLng: [latitude,longitude],
					options: {
						icon: new google.maps.MarkerImage(
							"images/map-pin.png",
							new google.maps.Size(73, 95, "px", "px")
						)
					}
				}
			});
			
		}
	});

	$(window).load(function(){

	});

})(jQuery, document, window);