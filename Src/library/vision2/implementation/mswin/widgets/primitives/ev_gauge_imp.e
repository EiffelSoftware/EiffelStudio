indexing
	description: "EiffelVision gauge. Mswindows implementation."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

deferred class
	EV_GAUGE_IMP

inherit
	EV_PRIMITIVE_IMP
		redefine
			on_key_down,
			interface,
			initialize
		end

	EV_GAUGE_I
		redefine
			interface
		end

feature {NONE} -- Initialization

	initialize is
			-- Default initialization of every gauge.
		do
			Precursor
			wel_set_range (1, 100)
			wel_set_step (1)
			wel_set_leap (10)
			wel_set_value (1)
		end

feature -- Access

	range: INTEGER_INTERVAL is
			-- Get `minimum' and `maximum' as interval.
		do
			create Result.make (minimum, maximum)
		end

feature -- Status setting

	step_forward is
			-- Increase the current value of one step.
		do
			wel_set_value (maximum.min (value + step))
		end

	step_backward is
			-- Decrease the current value of one step.
		do
			wel_set_value (minimum.max (value - step))
		end

	leap_forward is
			-- Increment `value' by `leap' if possible.
		do
			wel_set_value (maximum.min (value + leap))
		end

	leap_backward is
			-- Decrement `value' by `leap' if possible.
		do
			wel_set_value (minimum.max (value - leap))
		end

feature -- Element change

	set_value (a_value: INTEGER) is
			-- Set `value' to `a_value'.
		do
			wel_set_value (a_value)
		end

	set_step (a_step: INTEGER) is
			-- Set `step' to `a_step'.
		do
			wel_set_step (a_step)
		end

	set_leap (a_leap: INTEGER) is
			-- Set `leap' to `a_leap'.
		do
			wel_set_leap (a_leap)
		end

	set_minimum (a_minimum: INTEGER) is
			-- Set `minimum' to `a_minimum'.
		do
			wel_set_range (a_minimum, maximum)
		end

	set_maximum (a_maximum: INTEGER) is
			-- Set `maximum' to `a_maximum'.
		do
			wel_set_range (minimum, a_maximum)
		end

	set_range (a_range: INTEGER_INTERVAL) is
			-- Set `range' to `a_range'.
		do
			wel_set_range (a_range.lower, a_range.upper)
		end

	reset_with_range (a_range: INTEGER_INTERVAL) is
			-- Set `range' to `a_range'.
			-- Set `value' to `a_range.lower'.
		do
			wel_set_range (a_range.lower, a_range.upper)
			wel_set_value (a_range.lower)
		end

feature -- Deferred

	on_scroll (scroll_code, pos: INTEGER) is
			-- Called when gauge changed.
			--| Is called from EV_CONTAINER_IMP.
			--| FIXME Not generated for EV_RANGE's at least.
		do
		end

	on_key_down (virtual_key, key_data: INTEGER) is
			-- A key has been pressed.
		do
			{EV_PRIMITIVE_IMP} Precursor (virtual_key, key_data)
			process_tab_key (virtual_key)
		end

	wel_set_value (a_value: INTEGER) is
		deferred
		end

	wel_set_step (a_step: INTEGER) is
		deferred
		end

	wel_set_leap (a_leap: INTEGER) is
		deferred
		end

	wel_set_range (a_minimum, a_maximum: INTEGER) is
		deferred
		end

feature {EV_ANY_I, EV_INTERNAL_SILLY_CONTAINER_IMP} -- Implementation

	interface: EV_GAUGE

end -- class EV_GAUGE_IMP

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

--|-----------------------------------------------------------------------------
--| CVS log
--|-----------------------------------------------------------------------------
--|
--| $Log$
--| Revision 1.6  2000/02/15 16:49:25  brendel
--| Implementation of feature `range' moved to _IMP.
--|
--| Revision 1.5  2000/02/15 03:18:08  brendel
--| Cleanup.
--| Released.
--|
--| Revision 1.4  2000/02/14 22:30:34  brendel
--| Changed to comply with signature change of `set_range' in EV_GAUGE.
--| Now takes INTEGER_INTERVAL instead of 2 integers.
--|
--| Revision 1.3  2000/02/14 11:40:44  oconnor
--| merged changes from prerelease_20000214
--|
--| Revision 1.2.10.6  2000/02/03 17:19:47  brendel
--| Implemented complying to new interface.
--|
--| Revision 1.2.10.5  2000/02/01 03:33:07  brendel
--| Added make_with_range.
--| Changed export status of interface.
--|
--| Revision 1.2.10.4  2000/01/29 01:05:03  brendel
--| Tweaked inheritance clause.
--|
--| Revision 1.2.10.3  2000/01/27 19:30:27  oconnor
--| added --| FIXME Not for release
--|
--| Revision 1.2.10.2  1999/12/17 00:40:17  rogers
--| Altered to fit in with the review branch. redefinition of interface.
--|
--| Revision 1.2.10.1  1999/11/24 17:30:32  oconnor
--| merged with DEVEL branch
--|
--| Revision 1.2.6.2  1999/11/02 17:20:09  oconnor
--| Added CVS log, redoing creation sequence
--|
--|
--|-----------------------------------------------------------------------------
--| End of CVS log
--|-----------------------------------------------------------------------------
