indexing
	description:
		"Eiffel Vision timeout. Implementation interface."
	status: "See notice at end of class"
	date: "$Date$"
	revision: "$Revision$"

deferred class
	EV_TIMEOUT_I

inherit
	EV_ANY_I
		redefine
			interface
		end

feature -- Access

	interval: INTEGER is
			-- Time between calls to `interface.actions' in milliseconds.
			-- Zero when disabled.
		deferred
		end

	set_interval (an_interval: INTEGER) is
			-- Assign `an_interval' in milliseconds to `interval'.
			-- Zero disables.
		require
			an_interval_not_negative: an_interval >= 0
		deferred
		ensure
			interval_assigned: interval = an_interval
		end

feature -- Status report

	count: INTEGER
			-- Number of times `interface.actions' has been called.

feature -- Status setting

	reset_count is
			-- Set `count' to 0.
		do
			count := 0
		ensure
			count_is_zero: count = 0
		end

feature -- Implementation

	on_timeout is
			-- Call actions and increment count.
		do
			interface.actions.call ([])
			count := count + 1
		ensure
			count_incremented_or_reset:
				count = old count + 1 or else count = 1
		end

feature {EV_ANY_I} --Implementation

	interface: EV_TIMEOUT
			-- Provides a common user interface to platform dependent
			-- functionality implemented by `Current'

invariant
	interval_not_negative: interval >= 0
	count_not_negative: count >= 0

end -- class EV_TIMEOUT_I

--!-----------------------------------------------------------------------------
--! EiffelVision2: library of reusable components for ISE Eiffel.
--! Copyright (C) 1986-2000 Interactive Software Engineering Inc.
--! All rights reserved. Duplication and distribution prohibited.
--! May be used only with ISE Eiffel, under terms of user license. 
--! Contact ISE for any other use.
--!
--! Interactive Software Engineering Inc.
--! ISE Building, 2nd floor
--! 270 Storke Road, Goleta, CA 93117 USA
--! Telephone 805-685-1006, Fax 805-685-6869
--! Electronic mail <info@eiffel.com>
--! Customer support e-mail <support@eiffel.com>
--! For latest info see award-winning pages: http://www.eiffel.com
--!-----------------------------------------------------------------------------

--|-----------------------------------------------------------------------------
--| CVS log
--|-----------------------------------------------------------------------------
--|
--| $Log$
--| Revision 1.6  2001/06/07 23:08:08  rogers
--| Merged DEVEL branch into Main trunc.
--|
--| Revision 1.2.4.1  2000/05/03 19:08:56  oconnor
--| mergred from HEAD
--|
--| Revision 1.5  2000/03/07 00:18:57  brendel
--| Improved postcondition on on_timeout.
--|
--| Revision 1.4  2000/02/22 18:39:41  oconnor
--| updated copyright date and formatting
--|
--| Revision 1.3  2000/02/14 11:40:34  oconnor
--| merged changes from prerelease_20000214
--|
--| Revision 1.2.6.7  2000/02/04 04:15:56  oconnor
--| release
--|
--| Revision 1.2.6.6  2000/01/27 19:29:55  oconnor
--| added --| FIXME Not for release
--|
--| Revision 1.2.6.5  2000/01/19 07:59:25  oconnor
--| renamed timeout_actions -> actions
--|
--| Revision 1.2.6.4  2000/01/19 07:55:32  oconnor
--| added default state checking, reorganised count, added resent_count.
--|
--| Revision 1.2.6.3  2000/01/18 19:29:35  king
--| Changed position of count increment to deal with agent evaluation
--|
--| Revision 1.2.6.2  2000/01/18 01:13:01  king
--| Implemented timeout to use action sequence
--|
--| Revision 1.2.6.1  1999/11/24 17:30:06  oconnor
--| merged with DEVEL branch
--|
--| Revision 1.2.2.3  1999/11/04 23:10:33  oconnor
--| updates for new color model, removed exists: not destroyed
--|
--| Revision 1.2.2.2  1999/11/02 17:20:05  oconnor
--| Added CVS log, redoing creation sequence
--|
--|-----------------------------------------------------------------------------
--| End of CVS log
--|-----------------------------------------------------------------------------
