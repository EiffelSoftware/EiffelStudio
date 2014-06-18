class PROXY_DESCENDANT
inherit
	PROXY
		redefine
			creation_objects
		end

feature

	creation_objects: TUPLE [l: LIST [like current_anchor.new_proxy]]
		do
			check False then end
		end

end
