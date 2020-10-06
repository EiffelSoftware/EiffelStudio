$(document).ready(function() {
	/* toggle display of sidebar */
    $("div.sidebar").each(function() {
       	var s = $('<span class="sidebar_toggle">&#9776;</span>');
       	s.insertBefore($(this));
       	$(s).click({target: $(this), toggle: $(s)}, function(ev) {
       		if ($(ev.data.target).attr('data-display') == 'yes') {
       			$(ev.data.target).attr('data-display','no');
       		} else {
       			$(ev.data.target).attr('data-display','yes');
	       	}
       	});
    });
});
