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

			-- Then, we create the timer for the system.
			set_timer (id, timeout.period)
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
			(timeouts @ id).execute
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
