indexing
	description: "Timer used to check process status."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

deferred class
	PROCESS_TIMER

feature {PROCESS} -- Control

	start is
			-- Start timer.
		require
			process_launcher_not_void: process_launcher /= Void
			timer_destroyed: destroyed
		deferred
		end

	destroy is
			-- Destroy timer.
		require
			process_launcher_not_void: process_launcher /= Void
		deferred
		end

feature -- Setting

	set_process_launcher (prc_launcher: PROCESS) is
			-- Set process launcher to which this timer is attached with `prc_launcher'.
		require
			prc_launcher_not_void: prc_launcher /= Void
			timer_destroyed: destroyed
		do
			process_launcher := prc_launcher
		ensure
			process_launcher_set: process_launcher = prc_launcher
		end

feature -- Status reporting

	destroyed: BOOLEAN is
		-- Has this timer been destroyed?
		deferred
		end

	time_interval: INTEGER_64
			-- Time for this timer to sleep	

	process_launcher: PROCESS
			-- process launcher to which this timer is attached.

invariant
	time_interval_positive: time_interval > 0

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




end
