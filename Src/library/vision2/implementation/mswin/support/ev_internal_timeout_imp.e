--| FIXME NOT_REVIEWED this file has not been reviewed
indexing
	description:
		" EiffelVision internal timeout. Window that%
		% calls the different timeout created."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	EV_INTERNAL_TIMEOUT_IMP

inherit
	WEL_FRAME_WINDOW
		redefine
			on_timer
		end

create
	make_top

feature -- Access

	timeouts: HASH_TABLE [EV_TIMEOUT_IMP, INTEGER]
		-- The timeouts to call classed by id.

feature -- Element change

	add_timeout (timeout: EV_TIMEOUT_IMP) is
			-- Add `timeout' to the list of timeout to
			-- be executed.
		local
			id: INTEGER
		do
			-- We update the list first.
			if timeouts = Void then
				create timeouts.make (1)
				id := 1
			else
				id := timeouts.count + 1
			end
			timeouts.force (timeout, id)
			timeout.set_id (id)
		end

	change_interval (a_timer_id, an_interval: INTEGER) is
			-- Set timer with `an_id' to `an_interval'.
		require
			a_timer_id_exists:
				a_timer_id > 0 and then a_timer_id <= timeouts.count
			an_interval_positive: an_interval > 0
		do
			if an_interval = 0 then
				kill_timer (a_timer_id)
			else
				set_timer (a_timer_id, an_interval)
			end
		end

feature -- Removal

	remove_timeout (id: INTEGER) is
			-- Remove `timeout' to the list of timeout to
			-- be executed.
		do
			kill_timer (id)
			timeouts.remove (id)
			if timeouts.empty then
				timeouts := Void
			end
		end

feature {NONE} -- Implementation

	on_timer (id: INTEGER) is
			-- Wm_timer message.
		do
			(timeouts @ id).on_timeout
		end

end -- class EV_INTERNAL_TIMEOUT_IMP

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
--| Revision 1.4  2000/03/06 23:12:18  brendel
--| Implemented.
--|
--| Revision 1.3  2000/02/19 05:45:00  oconnor
--| released
--|
--| Revision 1.2  2000/02/14 11:40:41  oconnor
--| merged changes from prerelease_20000214
--|
--| Revision 1.1.10.2  2000/01/27 19:30:15  oconnor
--| added --| FIXME Not for release
--|
--| Revision 1.1.10.1  1999/11/24 17:30:21  oconnor
--| merged with DEVEL branch
--|
--| Revision 1.1.6.2  1999/11/02 17:20:08  oconnor
--| Added CVS log, redoing creation sequence
--|
--|
--|-----------------------------------------------------------------------------
--| End of CVS log
--|-----------------------------------------------------------------------------
