$(document).ready(function() {
	$("ul.logs li.log").each(function() { 
		//this.addEventListener("dblclick", function() {
		$(this).dblclick(function() {
    		this.classList.toggle("active");
		});
	});

	$(".roc-select-all").each(function() { 
		cb_all = $("<div><label><input type=\"checkbox\" id=\"_select_all_\" value=\"Select all\"/>Select all</label></div>");
		cb_all.insertBefore(this);
		cb_all.find("input").on('click', this, function(event) {
    		if(this.checked) {
				$(event.data).find('[type="checkbox"]').prop('checked', true);
    		} else {
				$(event.data).find('[type="checkbox"]').prop('checked', false);
    		}
		});
	});
})
