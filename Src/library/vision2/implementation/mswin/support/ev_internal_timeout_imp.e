indexing
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
			if timeouts /= Void then
				timeouts.remove (id)
				if timeouts.is_empty then
					timeouts := Void
				end
			end
		end

feature {NONE} -- Implementation

	on_timer (id: INTEGER) is
			-- Wm_timer message.
		local
			timeout: EV_TIMEOUT_IMP
		do
			timeout ?= eif_id_any_object (id)
			if timeout /= Void then
				timeout.on_timeout
			else
				remove_timeout (id)
			end
		end
		
	class_requires_icon: BOOLEAN is
			-- Does `Current' require an icon to be registered?
			-- If `True' `register_class' assigns a class icon, otherwise
			-- no icon is assigned.
		do
			Result := False
		end

indexing
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

