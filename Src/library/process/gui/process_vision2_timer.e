indexing
	description: "Process status listening timer implemented with Vision2 timer."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	PROCESS_VISION2_TIMER

inherit
	PROCESS_TIMER

create
	make
	
feature{NONE} -- Implementation
	
	make (prc: PROCESS; interval: INTEGER) is
			-- `prc' is process launcher object to which this timer is attached.
			-- Unit of `interval' is milliseconds.
		require
			interval_positive: interval > 0
			prc_not_null: prc /= Void			
		do
			process_launcher := prc
			time_interval := interval
			timer := Void
		ensure
			timer_set_to_null: timer = Void
			time_interval_set: time_interval = interval
		end
		
feature -- Control

	start is
			-- 
		local
			prc_imp: PROCESS_IMP
		do
			prc_imp ?= process_launcher
			if prc_imp /= Void then
				create timer.make_with_interval (time_interval)
				timer.actions.extend (agent prc_imp.check_exit)				
			end
		end
		
	destroy is
			-- 
		do
			if timer /= Void then
				timer.destroy
			end
		end

feature{NONE} -- Implementation
	
	timer: EV_TIMEOUT
end
