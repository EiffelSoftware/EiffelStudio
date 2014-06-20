deferred class CHILD
inherit
	PARENT
		redefine
			creation_objects_proxy_anchor
		end

feature
	creation_objects_proxy_anchor: TUPLE [order: like document.new_proxy]
			-- <Precursor>
		do
			check False then end
		end

	document: DOCUMENT
		deferred
		end
end
