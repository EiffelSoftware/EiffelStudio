note
	description: "A expanded object that has an expanded field."

expanded class TEST3

inherit
	EXPANDED_COUNTER
		redefine
			copy, default_create,
			is_equal
		end

feature

	default_create
		do
			int3 := 3
			str3 := generator
		end

	int3: INTEGER
	str3: STRING
	exp3: TEST4

feature -- Duplication

	copy (other: like Current)
		do
			counter.put (counter.item + 1)
			int3 := other.int3
			str3 := other.str3
			exp3 := other.exp3
		end

	is_equal (other: like Current): BOOLEAN
			-- To prevent postcondition violation in `copy'.
		do
			Result := True
		end

end
