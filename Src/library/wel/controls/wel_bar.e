indexing
	description: "Ancestor to scroll bar and track bar."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

deferred class
	WEL_BAR

inherit
	WEL_CONTROL

feature -- Status report

	position: INTEGER is
			-- Current position
		require
			exists: exists
		deferred
		ensure
			valid_minimum: Result >= minimum
			valid_maximum: Result <= maximum
		end

	minimum: INTEGER is
			-- Minimum position
		require
			exists: exists
		deferred
		ensure
			minimum_ok: minimum <= maximum
		end

	maximum: INTEGER is
			-- Maximum position
		require
			exists: exists
		deferred
		ensure
			maximum_ok: maximum >= minimum
		end

feature -- Status setting

	set_position (new_position: INTEGER) is
			-- Set `position' with `new_position'
		require
			exists: exists
			valid_minimum: new_position >= minimum
			valid_maximum: new_position <= maximum
		deferred
		ensure
			position_set: position = new_position
		end

	set_range (a_minimum, a_maximum: INTEGER) is
			-- Set `minimum' and `maximum' with
			-- `a_minimum' and `a_maximum'
		require
			exists: exists
			valid_range: a_minimum <= a_maximum
		deferred
		ensure
			minimum_set: minimum = a_minimum
			maximum_set: maximum = a_maximum
		end

invariant
	--XXXX
	--range_ok: exists implies minimum <= maximum
	--position_ok: exists implies position >= minimum and position <= maximum

end -- class WEL_BAR


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

