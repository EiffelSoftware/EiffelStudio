indexing
	description: "Timer used to check process status."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

deferred class
	PROCESS_TIMER
	
feature	 -- Control
	
	start is
			-- Start timer.
		deferred
		end
		
	destroy is
			-- Destroy timer.
		deferred
		end
	
feature{NONE} -- Implementation

	process_launcher: PROCESS
			-- process launcher to which this timer is attached.
	
	time_interval: INTEGER
		
invariant
	process_launcher_not_null: process_launcher /= Void
	time_interval_positive: time_interval > 0
end
