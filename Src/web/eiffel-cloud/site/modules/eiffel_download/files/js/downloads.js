$().ready(function() {
	$("div.download-channel div.product").each(function() {
		var d_title = $(this).children(".title");
		var d_details = $(this).children(".details");
		if (d_details.attr("data-item") == "first") {
			d_details.show();
			d_title.addClass('shown');
		} else {
			d_details.hide();
			d_title.addClass('hidden');
		}
		$(d_title).click({title: d_title, details: d_details}, function (e) {
			if (e.data.details.is(':visible')) {
				e.data.title.removeClass('shown').addClass('hidden');
				e.data.details.hide();
			} else {
				e.data.title.removeClass('hidden').addClass('shown');
				e.data.details.show();
			}
		});
	});
});
