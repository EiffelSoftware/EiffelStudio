class
	D [G -> NUMERIC]

inherit
	C [G]
		redefine
			item, has
		end

feature --

	item (v: G): G is
		do
			Result := v + v
		end

	has (v: G): BOOLEAN is
		do
		end

end
