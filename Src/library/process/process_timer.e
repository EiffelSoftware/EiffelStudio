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
		deferred
		end
		
	destroy is
			-- Destroy timer.
		require
			process_launcher_not_void: process_launcher /= Void
		deferred
		end
		
	set_process_launcher (prc_launcher: PROCESS) is
			-- Set process launcher to which this timer is attached with `prc_launcher'.
		require
			prc_launcher_not_void: prc_launcher /= Void
		do
			process_launcher := prc_launcher
		ensure
			process_launcher_set: process_launcher = prc_launcher
		end
				
feature -- Status reporting

	process_launcher: PROCESS
			-- process launcher to which this timer is attached.
			
	destroyed: BOOLEAN
		-- Has this timer been destroyed?

	time_interval: INTEGER
			-- Time for this timer to sleep	

invariant
	time_interval_positive: time_interval > 0

end
