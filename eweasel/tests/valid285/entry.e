deferred class
	ENTRY

inherit
	LINE_ITEM
		redefine
			document,
			creation_objects_anchor,
			creation_objects_proxy_anchor
		end

feature

	document: DOCUMENT
		deferred
		end

	creation_objects_anchor: TUPLE [order: like document]
		do
			check False then end
		end

	creation_objects_proxy_anchor: TUPLE [order: like document.proxy]
		do
			check False then end
		end

end
