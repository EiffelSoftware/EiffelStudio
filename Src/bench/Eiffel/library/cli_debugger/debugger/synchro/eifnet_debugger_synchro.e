indexing
	description: "Manage synchronisation between EiffelDebugger and .NET debugger (CLR)"
	author: "$Author$"
	date: "$Date$"
	revision: "$Revision$"

deferred class
	EIFNET_DEBUGGER_SYNCHRO
	
feature -- Synchro Initialization

	init_dbg_synchronisation is
			-- Initialize eStudio/.NET debugger synchronisation
		do
			debug ("DBG_SYNCHRO")
				print (">>Initialize eStudio/.NET debugger synchronisation%N")
			end
			c_init_dbg_synchronisation
		end
		
feature -- eStudio callback

	estudio_callback_event is
		deferred
		end
		
	enable_estudio_callback is
			-- Enable callback
		do
			c_dbg_enable_estudio_callback (Current, $estudio_callback_event);
		end

feature -- Synchro Timer

	dbg_timer_active: BOOLEAN
			-- Is dbg timer active ?
	
	start_dbg_timer is
			-- 
		local
			l_id: INTEGER
		do
			l_id := c_dbg_timer_id
			debug ("DBG_SYNCHRO")
				print (">>timer::" + l_id.out + "%N")
			end
			if l_id = 0 then
				debug ("DBG_SYNCHRO")
					io.put_string ("[EIFFEL] Start dbg timer%N")
				end
				c_start_dbg_timer
				dbg_timer_active := True
			end
		end
		
	stop_dbg_timer is
			-- 
		local
			l_id: INTEGER
		do
			l_id := c_dbg_timer_id
			debug ("DBG_SYNCHRO")
				print (">>timer::" + l_id.out + "%N")
			end
			if l_id /= 0 then
				debug ("DBG_SYNCHRO")
					io.put_string ("[EIFFEL] Stop dbg timer%N")
				end
				c_stop_dbg_timer
				dbg_timer_active := False
			end
		end	

feature -- Evaluation 

	lock_and_wait_for_callback is
			-- 
		do
			c_lock_and_wait_callback
		end			

feature {NONE} -- External DBG Timer

	c_init_dbg_synchronisation is
		external
			"C use %"cli_debugger.h%" "
		alias
			"dbg_init_synchro"
		end

	c_dbg_enable_estudio_callback (obj: EIFNET_DEBUGGER_SYNCHRO; p_cb: POINTER) is
		external
			"C signature () use %"cli_debugger.h%" "
		alias
			"dbg_enable_estudio_callback"
		end
		
	c_dbg_timer_id: INTEGER is
		external
			"C signature (): EIF_INTEGER use %"cli_debugger.h%" "
		alias
			"dbg_timer_id"
		end

	c_start_dbg_timer is
		external
			"C use %"cli_debugger.h%" "
		alias
			"dbg_start_timer"
		end

	c_stop_dbg_timer is
		external
			"C use %"cli_debugger.h%" "
		alias
			"dbg_stop_timer"
		end

	c_lock_and_wait_callback is
		external
			"C use %"cli_debugger.h%" "
		alias
			"dbg_lock_and_wait_callback"
		end

end -- class EIFNET_DEBUGGER_SYNCHRO
