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

	timeouts: HASH_TABLE [INTEGER, INTEGER]
		-- The timeouts to call classed by id.

feature -- Element change

	add_timeout (timeout: EV_TIMEOUT_IMP) is
			-- Add `timeout' to the list of timeout to
			-- be executed.
		do
			if timeouts = Void then
				create timeouts.make (5)
			end
			timeouts.force (timeout.id, timeout.id)
		end

	change_interval (a_timer_id, an_interval: INTEGER) is
			-- Set timer with `an_id' to `an_interval'.
		require
			a_timer_id_exists: a_timer_id > 0 and then timeouts.has (a_timer_id)
			an_interval_non_negative: an_interval >= 0
		do
			if an_interval = 0 then
				kill_timer (a_timer_id)
			else
				set_timer (a_timer_id, an_interval)
			end
		end

feature -- Removal

	remove_timeout (id: INTEGER) is
			-- Remove `timeout' from the list of timeouts to
			-- be executed.
		do
			kill_timer (id)
			timeouts.remove (id)
			if timeouts.is_empty then
				timeouts := Void
			end
		end

feature {NONE} -- Implementation

	on_timer (id: INTEGER) is
			-- Wm_timer message.
		local
			timeout: EV_TIMEOUT_IMP
		do
			timeout ?= eif_id_object (id)
			if timeout /= Void then
				timeout.on_timeout
			else
					-- Object has been collected, remove it from
					-- `timeouts'.
				timeouts.remove (id)
			end
		end

end -- class EV_INTERNAL_TIMEOUT_IMP

--|-----------------------------------------------------------------------------
--| EiffelVision: library of reusable components for ISE Eiffel.
--| Copyright (C) 1986-2000 Interactive Software Engineering Inc.
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
--|-----------------------------------------------------------------------------
