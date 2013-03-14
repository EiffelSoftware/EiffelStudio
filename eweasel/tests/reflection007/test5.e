note
	description: "A expanded object that has a reference field filled with an expanded object."

expanded class TEST5

inherit
	EXPANDED_COUNTER
		redefine
			copy, default_create,
			is_equal
		end

feature

	default_create
		local
			t: TEST6
		do
			int5 := 5
			str5 := generator
			attr5 := t
		end

	int5: INTEGER
	str5: STRING
	attr5: detachable ANY

feature -- Duplication

	copy (other: like Current)
		do
			counter.put (counter.item + 1)
			int5 := other.int5
			str5 := other.str5
			attr5 := other.attr5
		end

	is_equal (other: like Current): BOOLEAN
			-- To prevent postcondition violation in `copy'.
		do
			Result := True
		end

end
