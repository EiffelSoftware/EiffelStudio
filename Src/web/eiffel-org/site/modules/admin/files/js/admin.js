$(document).ready(function() {
	$("ul.logs li.log").each(function() { 
		console.log("log...");
		this.addEventListener("click", function() {
    		this.classList.toggle("active");
    	});
	});
})
