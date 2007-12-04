expanded class E

inherit
	ANY
		redefine
			out
		end

feature -- Data

	item: STRING
			-- Current value

feature -- Modification

	put (value: like item)
			-- Set `item' to `value'.
		do
			item := value
		end

feature -- Output

	out: STRING
			-- Printable representation
		do
			Result := item
		end

end