indexing
	description: "Manage synchronisation between EiffelDebugger and .NET debugger (CLR)"
	author: "$Author$"
	date: "$Date$"
	revision: "$Revision$"

deferred class
	EIFNET_DEBUGGER_SYNCHRO
	
inherit
	ICOR_EXPORTER

feature -- Synchro Initialization

	init_dbg_synchronisation is
			-- Initialize eStudio/.NET debugger synchronisation
		do
			debug ("debugger_eifnet_synchro")
				io.error.put_string (">>Initialize eStudio/.NET debugger synchronisation%N")
			end
			dbg_timer_active := False
			callback_notification_processing := False
			c_init_dbg_synchronisation
		end
		
	terminate_dbg_synchronisation is
			-- Initialize eStudio/.NET debugger synchronisation
		require
			dbg_timer_stopped: not dbg_timer_active
		do
			debug ("debugger_trace_synchro")
				io.error.put_string (">>Terminate eStudio/.NET debugger synchronisation%N")
			end
			c_terminate_dbg_synchronisation
		end
		
	is_dbg_synchronizing: BOOLEAN is
			-- Are we still synchronizing ?
		do
			Result := c_dbg_is_synchronizing
		end		
		
feature -- eStudio callback

	estudio_callback_event is
			-- Callback trigger for processing at end of dotnet callback
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
			-- Start the dbg_timer used for dotnet debugger synchronisation.
		local
			l_id: INTEGER
		do
			l_id := c_dbg_timer_id
			debug ("debugger_trace_synchro")
				io.error.put_string (">>timer::" + l_id.out + "%N")
			end
			if l_id = 0 then
				debug ("debugger_trace_synchro")
					io.put_string ("[EIFFEL] Start dbg timer%N")
				end
				c_start_dbg_timer
			end
			dbg_timer_active := True
		end
		
	stop_dbg_timer is
			-- Stop the dbg_timer used for dotnet debugger synchronisation.
		local
			l_id: INTEGER
		do
			l_id := c_dbg_timer_id
			debug ("debugger_trace_synchro")
				notify_debugger (generator + ".stop_dbg_timer %N")
				io.error.put_string (">>timer::" + l_id.out + "%N")
			end
			if l_id /= 0 then
				debug ("debugger_trace_synchro")
					io.put_string ("[EIFFEL] Stop dbg timer%N")
				end
				c_stop_dbg_timer
			end
			dbg_timer_active := False
		end
		
feature -- Callback Notification

	callback_notification_processing: BOOLEAN
	
	set_callback_notification_processing (v: BOOLEAN) is
		do
			callback_notification_processing := v
		end

	restore_callback_notification_state is
		require
			is_inside_callback_notification: callback_notification_processing
		do
			c_restore_cb_notification_state
		end
		
	notify_debugger (s: STRING) is
			-- 
		local
			a: ANY
		do
			a := s.to_c
			c_notify_from_estudio ($a)
		end		
	
feature -- bridge to ICorDebugController->Continue ()

	process_continue (icdc: ICOR_DEBUG_CONTROLLER; a_f_is_out_of_band:BOOLEAN): INTEGER is
			-- Call `ICorDebugController->Continue (a_f_is_out_of_band)' on `icdc'
			-- Nota: a dbg_start_timer is performed on `c_dbg_continue'
		do
			Result := c_dbg_continue (icdc.item, a_f_is_out_of_band.to_integer)
		end

feature -- Evaluation 

	lock_and_wait_for_callback (icdc: ICOR_DEBUG_CONTROLLER) is
			-- Lock and wait for callback
			-- used in evaluation processing.
		do
			c_lock_and_wait_callback (icdc.item)
		end			

feature {NONE} -- External DBG Timer

	c_dbg_is_synchronizing: BOOLEAN is
		external
			"C signature (): EIF_BOOLEAN use %"cli_debugger.h%" "
		alias
			"dbg_is_synchronizing"
		end

	c_init_dbg_synchronisation is
		external
			"C use %"cli_debugger.h%" "
		alias
			"dbg_init_synchro"
		end

	c_terminate_dbg_synchronisation  is
		external
			"C use %"cli_debugger.h%" "
		alias
			"dbg_terminate_synchro"
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

	c_dbg_continue (icdc_p: POINTER; a_f_is_out_of_band: INTEGER): INTEGER is
		external
			"C signature (void*, BOOL): EIF_INTEGER use %"cli_debugger.h%" "
		alias
			"dbg_continue"
		end
		
	c_lock_and_wait_callback (icdc_p: POINTER) is
		external
			"C signature (void*) use %"cli_debugger.h%" "
		alias
			"dbg_lock_and_wait_callback"
		end
		
	c_restore_cb_notification_state is
		external
			"C use %"cli_debugger.h%" "
		alias
			"dbg_restore_cb_notification_state"
		end
		
	c_notify_from_estudio (p: POINTER) is
		external
			"C signature (char*) use %"cli_debugger.h%" "
		alias
			"dbg_notify_from_estudio"
		end

end -- class EIFNET_DEBUGGER_SYNCHRO
