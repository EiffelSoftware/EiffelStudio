indexing
	description: "Process status listening timer implemented with thread."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	PROCESS_THREAD_TIMER
	
inherit
	PROCESS_TIMER
	
	PROCESS_IO_LISTENER_THREAD
		rename
			process_launcher as old_process_launcher
		export
			{NONE} all
		end

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
			should_exit_signal:= False
			time_interval := interval * 1000000
			create mutex		
			destroyed := True
		ensure
			process_launched_set: process_launcher = prc
			should_exit_signal_set_to_false: not should_exit_signal	
			time_interval_set: time_interval = interval * 1000000
			destroyed_set: destroyed = True
		end
		
feature -- Control
		
	destroy is
			-- 
		do
			set_exit_signal
		end
	
	start is
			-- 
		do
			mutex.lock
			destroyed := False
			should_exit_signal := False			
			mutex.unlock

			launch
		end		
		
feature{NONE} -- Implementation
	
	execute is
		local
			prc_imp: PROCESS_IMP		
		do
			prc_imp ?= process_launcher
			if prc_imp.platform.is_dotnet then
				
			end
			if prc_imp /= Void then
				from		
					
				until
					should_thread_exit
				loop
					prc_imp.check_exit
					if not should_exit_signal then
						sleep (time_interval)						
					end
				end
			end
			mutex.lock
			destroyed := True
			mutex.unlock
		end
end
