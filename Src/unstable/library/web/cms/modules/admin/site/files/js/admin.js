$(document).ready(function() {
	$("ul.logs li.log").each(function() { 
		console.log("log...");
		//this.addEventListener("dblclick", function() {
		$(this).dblclick(function() {
    		this.classList.toggle("active");
		});
	});
})
