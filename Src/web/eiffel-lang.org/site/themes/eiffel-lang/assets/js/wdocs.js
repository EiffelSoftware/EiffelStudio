
var WDOCSMOD = WDOCSMOD || { };
WDOCSMOD.prepareTreeMenuItem = function (li) {
	li.prepend("<span class=\"arrow \"/>");
	li.addClass("arrowed");
	if (li.hasClass("expandable")) {
		li.children("span.arrow").click(function () {
				WDOCSMOD.toggleTreeMenuItem(li);
			}
		);
	}
}

WDOCSMOD.toggleTreeMenuItem = function (li) {
	if (li.hasClass("expanded")) {
		li.removeClass("expanded");
	} else {
		li.addClass("expanded");
	}
}

$(document).ready(function() {
	$("#wdocs-tree.menu li").each(function() { WDOCSMOD.prepareTreeMenuItem($(this));});

	/* Prepare <code> for prettyPrint */
	$('code').each(function(i, block) {
		var codelang = $(block).attr("lang");
		if (codelang !== undefined) {
			$(block).addClass("lang-"+codelang);
		} else {
			$(block).addClass("lang-eiffel");
		}
		$(block).addClass("prettyprint");
	});

	prettyPrint();

	}
)
