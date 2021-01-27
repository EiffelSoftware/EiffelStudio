$(document).ready(function() {
	$("ul.logs li.log").each(function() { 
		//this.addEventListener("dblclick", function() {
		$(this).dblclick(function() {
    		this.classList.toggle("active");
		});
	});
})
