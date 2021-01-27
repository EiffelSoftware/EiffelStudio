class ROCCMS_RespMenu {
	constructor(a_menu) {
		this.menu = a_menu;
		this.list = a_menu.find('ul').first();
	}
	apply() {
		var m = $("<li class=\"icon\" onclick=\"onRespMenu()\">&#x2630;</li>");
		this.list.prepend (m);
	}
};

function onRespMenu() {
	var x = $("#menu-bar div.menu");
	x.toggleClass("responsive");
}

$().ready(function() {
  	$("time.timeago").timeago();

	$("form div.description.collapsible").each(function() { 
		console.log("Collapsible description...");
		d = $(this).find('div').first();
		$(d).next().hide();
		$(d).click(function() {
			$(this).toggleClass("expanded");
			c = $(this).next();
    		c.toggle();
		});
	});

  	$("#menu-bar div.menu").each(function() {
		let respMenu = new ROCCMS_RespMenu($(this));
		respMenu.apply();
  	});
});

