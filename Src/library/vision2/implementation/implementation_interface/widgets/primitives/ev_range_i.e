indexing 
	description: "EiffelVision range."
	status: "See notice at end of class"
	date: "$Date$"
	revision: "$Revision$"

deferred class
	EV_RANGE_I

inherit
	EV_GAUGE_I

feature -- Access

	leap: INTEGER is
			-- Leap of the scrolling
			-- ie : the user clicks on the scroll bar
		require
			exists: not destroyed
		deferred
		ensure
			positive_result: Result >= 0
		end

feature -- Status setting

	leap_forward is
			-- Increase the current value of one leap.
		require
			exists: not destroyed
		deferred
		end

	leap_backward is
			-- Decrease the current value of one leap.
		require
			exists: not destroyed
		deferred
		end

feature -- Element change

	set_leap (val: INTEGER) is
			-- Make `val' the new leap.
		require
			exists: not destroyed
			positive_val: val >= 0
		deferred
		ensure
			val_set: leap = val
		end

end -- class EV_RANGE_I

--|----------------------------------------------------------------
--| EiffelVision: library of reusable components for ISE Eiffel.
--| Copyright (C) 1986-1998 Interactive Software Engineering Inc.
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
