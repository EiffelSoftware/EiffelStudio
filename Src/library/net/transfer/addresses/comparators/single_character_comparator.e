indexing
	description:
		"Comparators for single characters"

	status:	"See note at end of class"
	date: "$Date$"
	revision: "$Revision$"

class SINGLE_CHARACTER_COMPARATOR inherit

	COMPARATOR

create

	make

feature {NONE} -- Initialization

	make (c: CHARACTER) is
			-- Create comparator.
		do
			character := c
		ensure
			character_set: character = c
		end

feature -- Access

	character_set: STRING is
			-- Character represented by comparator
		do
			create Result.make (1)
			Result.extend (character)
		end

	contains (c: CHARACTER): BOOLEAN is
			-- Does comparator contain `c'?
		do
			Result := character = c
		end

feature {NONE} -- Implementation

	character: CHARACTER

end -- class SINGLE_CHARACTER_COMPARATOR


--|----------------------------------------------------------------
--| EiffelNet: library of reusable components for ISE Eiffel.
--| Copyright (C) 1986-2001 Interactive Software Engineering Inc.
--| All rights reserved. Duplication and distribution prohibited.
--| May be used only with ISE Eiffel, under terms of user license. 
--| Contact ISE for any other use.
--|
--| Interactive Software Engineering Inc.
--| ISE Building
--| 360 Storke Road, Goleta, CA 93117 USA
--| Telephone 805-685-1006, Fax 805-685-6869
--| Electronic mail <info@eiffel.com>
--| Customer support: http://support.eiffel.com>
--| For latest info see award-winning pages: http://www.eiffel.com
--|----------------------------------------------------------------

