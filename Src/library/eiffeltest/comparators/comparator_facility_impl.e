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

--|----------------------------------------------------------------------
--| EiffelTest: Reusable components for developing unit tests.
--| Copyright (C) 2000-2001 Interactive Software Engineering Inc (ISE).
--| EiffelTest may be used by anyone as FREE SOFTWARE to
--| develop any product, public-domain or commercial, without
--| payment to ISE, under the terms of the ISE Free Eiffel Library
--| License (IFELL) at http://eiffel.com/products/base/license.html.
--|
--| Interactive Software Engineering Inc.
--| ISE Building, 2nd floor
--| 270 Storke Road, Goleta, CA 93117 USA
--| Telephone 805-685-1006, Fax 805-685-6869
--| Electronic mail <info@eiffel.com>
--| Customer support e-mail <support@eiffel.com>
--| For latest info see award-winning pages: http://www.eiffel.com
--|----------------------------------------------------------------------
