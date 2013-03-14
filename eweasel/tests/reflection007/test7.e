note
	description: "A expanded object that has a no used defined expanded."

expanded class TEST7

inherit
	EXPANDED_COUNTER
		redefine
			copy, default_create,
			is_equal
		end

feature

	default_create
		do
			int7 := 7
			str7 := generator
		end

	int7: INTEGER
	str7: STRING
	attr7: detachable ANY

feature -- Duplication

	copy (other: like Current)
		do
			counter.put (counter.item + 1)
			int7 := other.int7
			str7 := other.str7
			attr7 := other.attr7
		end

	is_equal (other: like Current): BOOLEAN
			-- To prevent postcondition violation in `copy'.
		do
			Result := True
		end

end
