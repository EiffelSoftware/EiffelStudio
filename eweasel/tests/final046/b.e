class
	B [G -> NUMERIC]

inherit
	A [G]
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
