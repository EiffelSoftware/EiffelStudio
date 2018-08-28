var CBPLAYMOD = CBPLAYMOD || {};
CBPLAYMOD.slider_delay = 5000;
CBPLAYMOD.slider_timeout = null;
CBPLAYMOD.initialize_slider = function (a_slider) {
	//console.log("CBPLAYMOD.initialize_slider (...)");
	
    var l_delay = $(a_slider).find('.slider').first().attr('data-slider-delay');
	if (l_delay) {
		CBPLAYMOD.slider_delay = l_delay;
		//console.log("CBPLAYMOD.slider_delay = " + l_delay);
	}
	$(a_slider).find('.slider-nav label').click (function () {
//		console.dir($(this));
		if (CBPLAYMOD.slider_timeout) {
			clearTimeout(CBPLAYMOD.slider_timeout);
		}
		CBPLAYMOD.update_slider_mark(a_slider, $(this).attr('for'));
		CBPLAYMOD.next_slide(a_slider);
	});
	
	CBPLAYMOD.update_slider_mark(a_slider, $(a_slider).find('.slider-nav label').first().attr('for'));
	CBPLAYMOD.next_slide(a_slider);
}
CBPLAYMOD.next_slide = function (a_slider) {
	var slide_trigger_first=null;
	var slide_trigger_last=null;
	var slide_trigger_next=null;
	//console.log("CBPLAYMOD.next_slide ...");
	$(a_slider).find('.slider>input.trigger').each (function () {
		//console.dir($(this));
		var t=$(this);
		if (!slide_trigger_next) {
			if (!slide_trigger_first) {
				slide_trigger_first = t;
			}
			if (t.is(':checked')) {
				slide_trigger_last = t;
			} else if (slide_trigger_last) {
				slide_trigger_next = t;
			}
		}
	});
	if (!slide_trigger_last) {
		slide_trigger_last = slide_trigger_first;
	}
	if (slide_trigger_last) {
		CBPLAYMOD.update_slider_mark(a_slider, slide_trigger_last.attr('id'));
	}
	if (!slide_trigger_next) {
		slide_trigger_next = slide_trigger_first;
	}

	if (slide_trigger_next) {
		CBPLAYMOD.slider_timeout = setTimeout(function(a_slider, a_next) {
				a_next.prop('checked', true);
				CBPLAYMOD.next_slide(a_slider);
			}, CBPLAYMOD.slider_delay, a_slider, slide_trigger_next);
	} else {
		//console.log("No next slide !!!");
	}
}

CBPLAYMOD.update_slider_mark = function (a_slider, a_slide_id) {
//	console.log("CBPLAYMOD.update_slider_mark("+ a_slide_id +") ...");
	$(a_slider).find('.slider-nav label').each (function () {
		$(this).removeClass('slider-active');
	});
	$(a_slider).find('.slider-nav label[for="' + a_slide_id + '"]').each (function () {
		$(this).addClass('slider-active');
	});
}

$(document).ready(function() {
	//console.log("Start CBPLAYMOD ...");
	$('.slider-wrapper').each (function() { CBPLAYMOD.initialize_slider($(this)); });
});
