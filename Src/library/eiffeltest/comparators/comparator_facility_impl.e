indexing
	description:
		"Implementation of comparator facility"

	status:	"See note at end of class"
	date: "$Date$"
	revision: "$Revision$"

class 
	COMPARATOR_FACILITY_IMPL

feature -- Basic operations

	compare_range (c: COMPARATOR; low, high: INTEGER; 
				state: BOOLEAN): BOOLEAN is
			-- Does `c' return `state' for all items in range from `low' to
			-- `high'?
		require
			comparator_exists: c /= Void
			low_non_negative: low >= 0
			high_non_negative: high >= 0
			boundaries_not_swapped: low <= high
		local
			i: INTEGER
		do
			from
				i := low
				Result := state
			until
				not Result or i > high
			loop
				Result := c.is_true (i)
				i := i + 1
			end
		end
	

end -- class COMPARATOR_FACILITY_IMPL

--|----------------------------------------------------------------
--| EiffelTest: Reusable components for developing unit tests.
--| Copyright (C) 2000 Interactive Software Engineering Inc.
--| All rights reserved. Duplication and distribution prohibited.
--| May be used only with ISE Eiffel, under terms of user license. 
--| Contact ISE for any other use.
--|
--| Interactive Software Engineering Inc.
--| ISE Building, 2nd floor
--| 270 Storke Road, Goleta, CA 93117 USA
--| Telephone 805-685-1006, Fax 805-685-6869
--| Electronic mail <info@eiffel.com>
--| Customer support e-mail <support@eiffel.com>
--| For latest info see award-winning pages: http://www.eiffel.com
--|----------------------------------------------------------------
