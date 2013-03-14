note
	description: "A expanded object that has a reference field filled with an expanded object."

expanded class TEST6

inherit
	EXPANDED_COUNTER
		redefine
			copy, default_create,
			is_equal
		end

feature

	default_create
		local
			t: TEST7
		do
			int6 := 6
			str6 := generator
			attr6 := t
		end

	int6: INTEGER
	str6: STRING
	attr6: detachable ANY

feature -- Duplication

	copy (other: like Current)
		do
			counter.put (counter.item + 1)
			int6 := other.int6
			str6 := other.str6
			attr6 := other.attr6
		end

	is_equal (other: like Current): BOOLEAN
			-- To prevent postcondition violation in `copy'.
		do
			Result := True
		end

end
