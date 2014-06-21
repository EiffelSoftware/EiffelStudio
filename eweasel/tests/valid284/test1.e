class TEST1 [M -> CHILD]
inherit
	TEST2 [M]
		redefine
			new_creation_objects
		end

feature

	new_creation_objects: like {CHILD}.creation_objects_proxy_anchor
			-- <Precursor>
		do
			create Result
--			Result := Precursor
		end

end
