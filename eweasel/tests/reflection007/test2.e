note
	description: "A expanded object that has a reference field that will be filled with an expanded object."

expanded class
	TEST2
inherit
	EXPANDED_COUNTER
		redefine
			copy, default_create,
			is_equal
		end

create
	default_create

feature

	default_create
		local
			t: TEST3
		do
			attr := t
		end

	attr: ANY

	copy (other: like Current)
		do
			counter.put (counter.item + 1)
			attr := other.attr
		end

	is_equal (other: like Current): BOOLEAN
			-- To prevent postcondition violation in `copy'.
		do
			Result := True
		end

end
