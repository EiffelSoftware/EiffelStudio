
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
WDOCSMOD.replaceTagName2 = function (elt,newtag) {
		var n = $('<' + newtag + '/>').html(elt.html());
		//foreach (elt.attributes as a) {
			//n.setAttribute(a.nodeName, a.nodeValue);
		//}
		elt.replaceWith(n.html(elt.html()));
}
WDOCSMOD.replaceTagName = function(elt, replaceWith) {
        var tags = [],
        i = elt.length;
        while (i--) {
            var newElement = document.createElement(replaceWith),
                elt_i      = elt[i],
                elt_ia     = elt_i.attributes;
            for (var a = elt_ia.length - 1; a >= 0; a--) {
                var attrib = elt_ia[a];
                newElement.setAttribute(attrib.name, attrib.value);
            };
            newElement.innerHTML = elt_i.innerHTML;
            $(elt_i).after(newElement).remove();
            tags[i] = newElement;
        }
        return $(tags);
    };
WDOCSMOD.prepareCode = function(elt) {
	/* Prepare <code> for prettyPrint */
	$(elt).find('code').each(function(i, block) {
		var codelang = $(block).attr("lang");
		if (codelang !== undefined) {
			$(block).addClass("lang-"+codelang);
		} else {
			$(block).addClass("lang-eiffel");
		}
		$(block).addClass("prettyprint");
	});
	/* Also support <eiffel> and <e> */
	$(elt).find('eiffel,e').each(function(i, block) {
		var l_code = WDOCSMOD.replaceTagName($(block), 'code');
		l_code.addClass("lang-eiffel");
		l_code.addClass("prettyprint");
	});
	console.log(typeof PR.prettyPrint);
	console.log(typeof prettyPrint);
	if (typeof PR.prettyPrint === 'function') {
		PR.prettyPrint();
	}
}

$(document).ready(function() {
	$("#wdocs-tree.menu li").each(function() { WDOCSMOD.prepareTreeMenuItem($(this));});

	/* Prepare <code> for prettyPrint */
	WDOCSMOD.prepareCode($(document.body));

	}
)
