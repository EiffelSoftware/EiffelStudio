note
	description:
		" EiffelVision internal timeout. Window that%
		% calls the different timeout created."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	EV_INTERNAL_TIMEOUT_IMP

inherit
	WEL_FRAME_WINDOW
		redefine
			on_timer,
			class_requires_icon
		end

create
	make_top

feature -- Access

	timeouts: detachable HASH_TABLE [INTEGER, INTEGER]
		-- The timeouts to call classed by id.

feature -- Element change

	add_timeout (timeout: EV_TIMEOUT_IMP)
			-- Add `timeout' to the list of timeout to
			-- be executed.
		local
			l_timeouts: like timeouts
		do
			l_timeouts := timeouts
			if l_timeouts = Void then
				create l_timeouts.make (5)
				timeouts := l_timeouts
			end
			l_timeouts.force (timeout.id, timeout.id)
		end

	change_interval (a_timer_id, an_interval: INTEGER)
			-- Set timer with `an_id' to `an_interval'.
		require
			a_timer_id_exists: a_timer_id > 0 and then attached timeouts as l_timeouts and then l_timeouts.has (a_timer_id)
			an_interval_non_negative: an_interval >= 0
		do
			if an_interval = 0 then
				kill_timer (a_timer_id)
			else
				set_timer (a_timer_id, an_interval)
			end
		end

feature -- Removal

	remove_timeout (id: INTEGER)
			-- Remove `timeout' from the list of timeouts to
			-- be executed.
		do
			kill_timer (id)
			if attached timeouts as l_timeouts then
				l_timeouts.remove (id)
				if l_timeouts.is_empty then
					timeouts := Void
				end
			end
		end

feature {NONE} -- Implementation

	on_timer (id: INTEGER)
			-- Wm_timer message.
		local
			timeout: detachable EV_TIMEOUT_IMP
		do
			timeout ?= eif_id_any_object (id)
			if timeout /= Void and then not timeout.is_destroyed then
				timeout.on_timeout
			else
				remove_timeout (id)
			end
		end

	class_requires_icon: BOOLEAN
			-- Does `Current' require an icon to be registered?
			-- If `True' `register_class' assigns a class icon, otherwise
			-- no icon is assigned.
		do
			Result := False
		end

note
	copyright:	"Copyright (c) 1984-2006, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			 Eiffel Software
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"




end -- class EV_INTERNAL_TIMEOUT_IMP










