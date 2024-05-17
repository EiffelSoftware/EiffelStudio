note
	description: "Manage synchronisation between EiffelDebugger and .NET debugger (CLR)"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	author: "$Author$"
	date: "$Date$"
	revision: "$Revision$"

deferred class
	EIFNET_DEBUGGER_SYNCHRO

inherit
	ICOR_EXPORTER

feature -- Synchro Initialization

	init_dbg_synchronisation (a_wel_item_pointer: POINTER)
			-- Initialize eStudio/.NET debugger synchronisation
		require
			a_wel_item_pointer_not_null: a_wel_item_pointer /= default_pointer
		do
			debug ("debugger_eifnet_synchro")
				io.error.put_string (">>Initialize eStudio/.NET debugger synchronisation%N")
			end
			dbg_timer_active := False
			callback_notification_processing := False
			next_estudio_notification_disabled := False

			c_init_dbg_synchronisation (a_wel_item_pointer)
		end

	terminate_dbg_synchronisation
			-- Initialize eStudio/.NET debugger synchronisation
		require
			dbg_timer_stopped: not dbg_timer_active
		do
			debug ("debugger_trace_synchro")
				io.error.put_string (">>Terminate eStudio/.NET debugger synchronisation%N")
			end
			c_terminate_dbg_synchronisation
		end

	disable_next_estudio_notification
			-- Disable next estudio notification
		do
			debug ("debugger_trace_synchro")
				io.error.put_string ("%N>>Disable next estudio notification%N")
			end
			next_estudio_notification_disabled := True
		end

	next_estudio_notification_disabled: BOOLEAN
			-- Proceed deep EiffelStudio notification ?
			-- (Only at the Eiffel level.)
			-- i.e: update eb tools

	is_dbg_synchronizing: BOOLEAN
			-- Are we still synchronizing ?
		do
			Result := c_dbg_is_synchronizing
		end

feature -- eStudio callback

	estudio_callback_event (cb_id: INTEGER)
			-- Callback trigger for processing at end of dotnet callback
		do
			--| To be redefined in EIFNET_DEBUGGER
		end

	enable_estudio_callback
			-- Enable callback
		do
			c_dbg_enable_estudio_callback (Current, $estudio_callback_event);
		end

feature -- Synchro Timer

	dbg_timer_active: BOOLEAN
			-- Is dbg timer active ?

	start_dbg_timer
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

	stop_dbg_timer
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

	set_callback_notification_processing (v: BOOLEAN)
		do
			callback_notification_processing := v
		end

	restore_callback_notification_state
		require
			is_inside_callback_notification: callback_notification_processing
		do
			c_restore_cb_notification_state
		end

	notify_debugger (s: STRING)
			--
		local
			a: ANY
		do
			a := s.to_c
			c_notify_from_estudio ($a)
		end

feature -- bridge to ICorDebugController->Continue ()

	process_continue (icdc: ICOR_DEBUG_CONTROLLER; a_f_is_out_of_band:BOOLEAN): INTEGER
			-- Call `ICorDebugController->Continue (a_f_is_out_of_band)' on `icdc'
			-- Nota: a dbg_start_timer is performed on `c_dbg_continue'
		require
			icdc /= Void and then icdc.item_not_null
		do
			Result := c_dbg_continue (icdc.item, a_f_is_out_of_band.to_integer)
		end

feature -- Evaluation

	process_debugger_evaluation (icdeval: ICOR_DEBUG_EVAL; icdc: ICOR_DEBUG_CONTROLLER; timeout: INTEGER)
			-- Start evaluation processing, this implies a
			-- Lock and wait for callback, and callback handlings
		require
			icdeval /= Void and then icdeval.item_not_null
			icdc /= Void and then icdc.item_not_null
		do
			c_dbg_process_evaluation (icdeval.item, icdc.item, timeout)
		end

feature -- Access to dbg data

	dbg_clear_cb_info
			-- Callback id from stored callback datas
		do
			c_dbg_clear_cb_info
		end

	dbg_cb_info_get_callback_id: INTEGER
			-- Callback id from stored callback datas
		do
			Result := c_dbg_cb_info_get_callback_id
		end

	dbg_cb_info_pointer_item (i: INTEGER): POINTER
			-- Pointer value of i_th item from stored callback datas
		require
			valid_index: i > 0 and i < 5
		do
			Result := c_dbg_cb_info_pointer_ith (i)
		end

	dbg_cb_info_integer_item (i: INTEGER): INTEGER
			-- Integer value of i_th item from stored callback datas
		require
			valid_index: i > 0 and i < 5
		do
			Result := c_dbg_cb_info_integer_ith (i)
		end

feature {NONE} -- External Dbg Sync routine

	c_dbg_is_synchronizing: BOOLEAN
		external
			"C++ inline use %"cli_debugger.h%" "
		alias
			"dbg_is_synchronizing()"
		end

	c_init_dbg_synchronisation (p: POINTER)
		external
			"C++ inline use %"cli_debugger.h%" "
		alias
			"dbg_init_synchro((HWND) $p)"
		end

	c_terminate_dbg_synchronisation
		external
			"C++ inline use %"cli_debugger.h%" "
		alias
			"dbg_terminate_synchro()"
		end

	c_dbg_enable_estudio_callback (obj: EIFNET_DEBUGGER_SYNCHRO; p_cb: POINTER)
		external
			"C++ inline use %"cli_debugger.h%" "
		alias
			"dbg_enable_estudio_callback((EIF_OBJECT)$obj, (EIF_POINTER) $p_cb)"
		end

	c_dbg_timer_id: INTEGER
		external
			"C++ inline use %"cli_debugger.h%" "
		alias
			"dbg_timer_id()"
		end

	c_start_dbg_timer
		external
			"C++ inline use %"cli_debugger.h%" "
		alias
			"dbg_start_timer()"
		end

	c_stop_dbg_timer
		external
			"C++ inline use %"cli_debugger.h%" "
		alias
			"dbg_stop_timer()"
		end

	c_dbg_continue (icdc_p: POINTER; a_f_is_out_of_band: INTEGER): INTEGER
		external
			"C++ inline use %"cli_debugger.h%" "
		alias
			"dbg_continue((void*) $icdc_p, (BOOL) $a_f_is_out_of_band)"
		end

	c_dbg_process_evaluation (icdeval_p: POINTER; icdc_p: POINTER; timeout: INTEGER)
		external
			"C++ inline use %"cli_debugger.h%" "
		alias
			"dbg_process_evaluation((void*) $icdeval_p, (void*) $icdc_p, (EIF_INTEGER) $timeout)"
		end

	c_restore_cb_notification_state
		external
			"C++ inline use %"cli_debugger.h%" "
		alias
			"dbg_restore_cb_notification_state()"
		end

	c_notify_from_estudio (p: POINTER)
		external
			"C++ inline use %"cli_debugger.h%" "
		alias
			"dbg_notify_from_estudio((char*)$p)"
		end

	c_dbg_clear_cb_info
		external
			"C++ inline use %"cli_debugger.h%" "
		alias
			"CLEAR_DBG_CB_INFO"
		end

	c_dbg_cb_info_get_callback_id: INTEGER
			-- Access `callback_id' data member of `dbg_cb_info' struct.
		external
			"C++ inline use %"cli_debugger.h%" "
		alias
			"(EIF_INTEGER)((struct CorDbgCallbackInfo *) dbg_cb_info)->callback_id"
		end

	c_dbg_cb_info_pointer_ith (i: INTEGER): POINTER
			-- Access `ptr1' data member of `dbg_cb_info' struct.
		external
			"C++ inline use %"cli_debugger.h%" "
		alias
			"DBG_CB_INFO_POINTER_ITEM($i)"
		end

	c_dbg_cb_info_integer_ith (i: INTEGER): INTEGER
			-- Access `ptr1' data member of `dbg_cb_info' struct.
		external
			"C++ inline use %"cli_debugger.h%" "
		alias
			"DBG_CB_INFO_INTEGER_ITEM($i)"
		end

note
	copyright:	"Copyright (c) 1984-2024, Eiffel Software"
	license:	"GPL version 2 (see http://www.eiffel.com/licensing/gpl.txt)"
	licensing_options:	"http://www.eiffel.com/licensing"
	copying: "[
			This file is part of Eiffel Software's Eiffel Development Environment.
			
			Eiffel Software's Eiffel Development Environment is free
			software; you can redistribute it and/or modify it under
			the terms of the GNU General Public License as published
			by the Free Software Foundation, version 2 of the License
			(available at the URL listed under "license" above).
			
			Eiffel Software's Eiffel Development Environment is
			distributed in the hope that it will be useful, but
			WITHOUT ANY WARRANTY; without even the implied warranty
			of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
			See the GNU General Public License for more details.
			
			You should have received a copy of the GNU General Public
			License along with Eiffel Software's Eiffel Development
			Environment; if not, write to the Free Software Foundation,
			Inc., 51 Franklin St, Fifth Floor, Boston, MA 02110-1301 USA
		]"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"

end -- class EIFNET_DEBUGGER_SYNCHRO
