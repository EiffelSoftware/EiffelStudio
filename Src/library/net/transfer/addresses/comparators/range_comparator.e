indexing
	description:
		"Comparators for character ranges"

	status:	"See note at end of class"
	date: "$Date$"
	revision: "$Revision$"

class RANGE_COMPARATOR inherit

	COMPARATOR

create

	make

feature {NONE} -- Initialization

	make (lo, up: CHARACTER) is
			-- Create comparator.
		do
			lower := lo
			upper := up
		ensure
			lower_set: lower = lo
			upper_set: upper = up
		end

feature -- Access

	character_set: STRING is
			-- Character set represented by comparator
		do
			create Result.make (3)
			Result.extend (lower)
			Result.extend ('-')
			Result.extend (upper)
		end

	contains (c: CHARACTER): BOOLEAN is
			-- Does comparator contain `c'?
		do
			Result := lower <= c and c <= upper
		end
		
feature {NONE} -- Implementation

	lower: CHARACTER
	
	upper: CHARACTER

end -- class RANGE_COMPARATOR


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

