
var WDOCSMOD = WDOCSMOD || { };
WDOCSMOD.prepareTreeMenuItem = function (li) {
	if (li.hasClass("expandable")) {
		if (li.hasClass("expanded")) {
			li.prepend("<span class=\"treeitemcontrol\">-</span> ");
		} else {
			li.prepend("<span class=\"treeitemcontrol\">+</span> ");
		}

		li.children("span.treeitemcontrol").click(function () {
				WDOCSMOD.toggleTreeMenuItem($(this).parent("li.expandable"));
			}
		);
	} else {
		li.prepend("&middot; ");
	}
}
WDOCSMOD.refreshTreeMenuItem = function (li) {
	li.children("span.treeitemcontrol").each (function () {
		var ctrl = $(this);
		var li = ctrl.parent("li.expandable");
		if (li.hasClass("expandable")) {
			if (li.hasClass("expanded")) {
				ctrl.text("-");
			} else {
				ctrl.text("+");
			}
		}
	});
}

WDOCSMOD.toggleTreeMenuItem = function (li) {
	if (li.hasClass("expandable")) {
		if (li.hasClass("expanded")) {
			li.removeClass("expanded");
		} else {
			li.addClass("expanded");
		}
		WDOCSMOD.refreshTreeMenuItem(li);
	} else {
		alert(li.prop('outerHTML'));
		li.stopPropagation();
	}
}

$(document).ready(function() {
		// ....
	$("#wdocs-tree.menu li").each(function() { WDOCSMOD.prepareTreeMenuItem($(this));});
//	$("#wdocs-tree.menu li.expandable>a").click(function() {
//		WDOCSMOD.toggleTreeMenuItem($(this).parent("li.expandable"));
//		return false;
//	});
//	$("#wdocs-tree.menu li:not(.expandable)>a").click(function() {
//		alert($(this).prop('outerHTML'));
//		return false;
//	});
//	$("#wdocs-tree.menu li.expandable:not(.expanded)").click(function() {
//		$(this).addClass("expanded");
////		alert("not expanded");
//		return false;
//		}
//		);
//	$("#wdocs-tree.menu li.expandable.expanded").click(function() {
//		$(this).removeClass("expanded");
////		alert("expanded");
//		return false;
//	});
}
)
