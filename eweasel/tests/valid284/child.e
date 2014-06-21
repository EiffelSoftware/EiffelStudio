deferred class CHILD
inherit
	PARENT
		redefine
			creation_objects_proxy_anchor
		end

feature
	creation_objects_proxy_anchor: TEST3 [like document.proxy]
			-- <Precursor>
		do
			check False then end
		end

	document: DOCUMENT
		deferred
		end
end
