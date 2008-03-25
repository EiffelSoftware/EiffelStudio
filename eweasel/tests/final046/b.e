class
	B [G -> NUMERIC]

inherit
	A [G]
		redefine
			item
		end

feature --

	item (v: G): G is
		do
			Result := v + v
		end

end
