indexing
	description: "Manage synchronisation between EiffelDebugger and .NET debugger (CLR)"
	author: "$Author$"
	date: "$Date$"
	revision: "$Revision$"

class
	EIFNET_DEBUGGER_SYNCHRO
	
feature
	
	start_dbg_timer is
			-- 
		local
			l_id: INTEGER
		do
			debug ("DBG_SYNCHRO")
				l_id := c_dbg_timer_id
				print (">>timer::" + l_id.out + "%N")
			end
			if l_id = 0 then
				debug ("DBG_SYNCHRO")
					io.put_string ("[EIFFEL] Start dbg timer%N")
				end
				c_start_dbg_timer			
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
			end
		end	

	lock_and_wait_for_callback is
			-- 
		do
			c_lock_and_wait_callback
		end			

feature {NONE} -- External DBG Timer

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
