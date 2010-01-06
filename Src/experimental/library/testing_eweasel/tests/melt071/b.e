class
	B [G]

inherit
	A [G]
		redefine
			bad
		end

create
	make

feature -- Initialization

	bad is
			-- Exchange item at `i'-th position with item
			-- at cursor position.
		do
			Precursor
		ensure then
			item_in_lookup_table: has (old item)
		end

	has (v: G): BOOLEAN is
			-- Initialize
		do
			Result := True
		end

end -- class B
