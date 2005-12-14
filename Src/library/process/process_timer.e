indexing
	description: "Timer used to check process status."
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
		ensure
			timer_not_destroyed: not destroyed
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

end
