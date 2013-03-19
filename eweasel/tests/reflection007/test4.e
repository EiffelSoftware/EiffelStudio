note
	description: "A expanded object that has an expanded field."

expanded class
	TEST4
inherit
	EXPANDED_COUNTER
		redefine
			copy, default_create,
			is_equal
		end

feature

	default_create
		do
			str4 := generator
			int4 := 4
		end

feature

	str4: STRING
	int4: INTEGER
	exp4: TEST5

	copy (other: like Current)
		do
			counter.put (counter.item + 1)
			int4 := other.int4
			str4 := other.str4
			exp4 := other.exp4
		end

	is_equal (other: like Current): BOOLEAN
			-- To prevent postcondition violation in `copy'.
		do
			Result := True
		end

end
