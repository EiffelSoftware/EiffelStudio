deferred class
	ITEM_LIST [M -> ENTRY]

inherit
	PARENT_LIST [M]
		redefine
			new_creation_objects
		end

feature

	new_creation_objects: like {ENTRY}.creation_objects_proxy_anchor
		do
			Result := Precursor
			check False then end
		end

end
