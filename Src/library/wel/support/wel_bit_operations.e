indexing
	description: "Bit operations on integer (or, and not)."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	WEL_BIT_OPERATIONS

feature -- Basic operations

	set_flag (flags, mask: INTEGER): INTEGER is
			-- Set the `mask' in `flags'
		do
			Result := flags | mask
		ensure
			flag_set: flag_set (Result, mask)
		end

	clear_flag (flags, mask: INTEGER): INTEGER is
			-- Clear the `mask' in `flags'
		do
			Result := flags & mask.bit_not
		ensure
			flag_unset: not flag_set (Result, mask)
		end

feature -- Status report

	flag_set (flags, mask: INTEGER): BOOLEAN is
			-- Is `mask' set in `flags'?
		do
			Result := (flags & mask) = mask
		end

end -- class WEL_BIT_OPERATIONS


--|----------------------------------------------------------------
--| Windows Eiffel Library: library of reusable components for ISE Eiffel.
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

