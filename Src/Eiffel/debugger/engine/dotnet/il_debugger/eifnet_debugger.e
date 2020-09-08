note
	description: "Interface to access dotnet debugger services"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	author: "$Author$"
	date: "$Date$"
	revision: "$Revision$"

class
	EIFNET_DEBUGGER

inherit

	EIFNET_DEBUGGER_INFO_ACCESSOR
		rename
			eifnet_debugger_info as info
		export
			{EIFNET_EXPORTER} info
		redefine
			make
		end

	SHARED_ICOR_OBJECTS_MANAGER

	SHARED_DEBUG_VALUE_KEEPER

	EIFNET_EXPORTER
		export
			{NONE} all
		end

	ICOR_EXPORTER
		export
			{NONE} all
		end

	COMPILER_EXPORTER
		export
			{NONE} all
		end

	EIFNET_DEBUGGER_SYNCHRO
		export
			{NONE} all
			{EIFNET_EXPORTER} dbg_timer_active, stop_dbg_timer, start_dbg_timer,
					process_debugger_evaluation,
					callback_notification_processing, set_callback_notification_processing,
					restore_callback_notification_state,
					notify_debugger
			{ICOR_DEBUG_MANAGED_CALLBACK} disable_next_estudio_notification
		redefine
			estudio_callback_event
		end

	SHARED_DEBUGGER_MANAGER

	DEBUG_OUTPUT_SYSTEM_I
		export
			{NONE} all
		end

	SHARED_IL_DEBUG_INFO_RECORDER
		export
			{NONE} all
			{ICOR_DEBUG_MANAGED_CALLBACK, EIFNET_EXPORTER} Il_debug_info_recorder
		end

	SHARED_EIFNET_DEBUG_VALUE_FORMATTER
		export
			{NONE} all
			{EIFNET_EXPORTER} edv_formatter
		end

	INTERNAL_COMPILER_STRING_EXPORTER

create
	make

feature -- Initialization

	make
			-- Creation
		do
			debug ("debugger")
				print ("call " + generator + ".make%N")
			end
			Precursor
		end

	init
			-- Initialize current object
		do
			debug ("debugger")
				print ("call " + generator + ".init%N")
			end

			if edv_external_formatter = Void then
				create edv_external_formatter.make (info)
			end
		end

	create_icor_debug
			-- Create icor_debug as ICorDebug
		local
			icor_debug_managed_callback_obj: ICOR_DEBUG_MANAGED_CALLBACK
			icor_debug_unmanaged_callback_obj: ICOR_DEBUG_UNMANAGED_CALLBACK
			l_icor_debug: ICOR_DEBUG
			last_icor_debug_pointer: POINTER -- Last ICorDebug created
			icor_debug_factory: ICOR_DEBUG_FACTORY
		do
			if icor_debug = Void then
					-- And now for the dotnet world			
				initialize_clr_host

				create icor_debug_factory

				eif_debug_display ("[EIFDBG] initialize debugger session")
				last_icor_debug_pointer := icor_debug_factory.new_cordebug_pointer_for (eiffel_system.system.clr_runtime_version)

				if last_icor_debug_pointer /= Default_pointer then
					create icor_debug.make_by_pointer (last_icor_debug_pointer)
					l_icor_debug := icor_debug
					l_icor_debug.add_ref

					l_icor_debug.initialize
					if l_icor_debug.last_call_succeed then
							--| We keep the callback server objects alive in the C/Cpp glue
							--| then let's add a ref, but we'll leave `dispose' the responsibility
							--| to Release the object
						icor_debug_managed_callback_obj := icor_debug_factory.new_cordebug_managed_callback
						icor_debug_managed_callback_obj.add_ref
						icor_debug_managed_callback_obj.initialize_callback
						l_icor_debug.set_managed_handler (icor_debug_managed_callback_obj)

						icor_debug_unmanaged_callback_obj := icor_debug_factory.new_cordebug_unmanaged_callback
						icor_debug_unmanaged_callback_obj.add_ref
						icor_debug_unmanaged_callback_obj.initialize_callback
						l_icor_debug.set_unmanaged_handler (icor_debug_unmanaged_callback_obj)

							--| Enable callback to update data in the estudio world.
						enable_estudio_callback
					else
						l_icor_debug.release
						l_icor_debug := Void
					end
				end
			end
		end

	icor_debug: ICOR_DEBUG
			-- ICorDebug object used to control and access Dotnet debugger

	initialize_clr_host
			-- Initialize dotnet runtime, to be sure to use the correct version of the
			-- runtime after while
		local
			l_host: CLR_HOST
		once
			;(create {CLI_COM}).initialize_com
			l_host := (create {CLR_HOST_FACTORY}).runtime_host (Eiffel_system.System.clr_runtime_version)
		end

	init_debugging_data
		do
			debug_value_keeper.initialize
			if eifnet_dbg_evaluator = Void then
				create eifnet_dbg_evaluator.make (Current)
			end
		end

	reset_debugging_data
				-- Reset objects who has session related data
		do
			debugger_manager.reset_dbg_evaluator

			reset_info
			exit_process_occurred := False

			il_debug_info_recorder.reset_debugging_live_data
			debug_value_keeper.terminate
				-- not required
			last_dbg_call_success := 0
			last_string_value_length := 0
		ensure
			not is_inside_function_evaluation
		end

	recycle_debug_value_keeper
		do
			Debug_value_keeper.recycle
		end

	initialize_debugger_session (a_wel_item_pointer: POINTER)
			-- Initialize a debugger session
		require
			not is_debugging
		local
			l_icor_debug: ICOR_DEBUG
		do
				-- Reset objects who has session related data
			init_debugging_data

			create_icor_debug
			l_icor_debug := icor_debug
			if l_icor_debug /= Void then
					--| Initialize the dbg synchronization
				init_dbg_synchronisation (a_wel_item_pointer)
					--| start the timer which will trigger the callbacks
				start_dbg_timer
					--| Create a timer which will check for the end of the process
				create_monitoring_of_process_termination_on_exit
					--| And now we can consider inside a debugging session ...
				is_debugging := True
			else
				is_debugging := False
			end
		ensure
			is_debugging implies icor_debug /= Void
		end

	is_debugging: BOOLEAN
			-- Is current process in debugging session ?

	exit_process_occurred: BOOLEAN
			-- Does Call back "ExitProcess" occurred ?
			--| This could be during evaluation ...

feature -- Helpers

	application_status: APPLICATION_STATUS
		require
			application_is_executing: debugger_manager.application_is_executing
		do
			Result := debugger_manager.application_status
		end

feature -- Termination monitoring ...

	timer_monitor_process_termination_on_exit: DEBUGGER_TIMER --EV_TIMEOUT
			-- Timer used to check if debugging is finished.

	create_monitoring_of_process_termination_on_exit
			-- Create and start the timer to check if the debugging is done
		require
			timer_void: timer_monitor_process_termination_on_exit = Void
		do
			timer_monitor_process_termination_on_exit := debugger_manager.new_timer
			timer_monitor_process_termination_on_exit.set_interval (1000)
			timer_monitor_process_termination_on_exit.actions.extend (agent monitor_process_termination_on_exit)
		end

	destroy_monitoring_of_process_termination_on_exit
			-- Destroy and clean timer
		do
			if timer_monitor_process_termination_on_exit /= Void then
				timer_monitor_process_termination_on_exit.set_interval (0)
				timer_monitor_process_termination_on_exit := Void
			end
		end

	monitor_process_termination_on_exit
			-- Check if the debugging is done and continue the termination
		do
			if
				timer_monitor_process_termination_on_exit /= Void
				and then exit_process_occurred
				and then not is_dbg_synchronizing
			then
				destroy_monitoring_of_process_termination_on_exit
				--FIXME JFIAT:  try to reuse timer object !
				debugger_manager.application.process_termination

				--| else This means, Process_termination had already been called (from kill)
			end
		end

feature -- Debugging session Termination ...

	terminate_debugger_session
			-- Terminate debugging session and clean what need to be cleaned
		do
			is_debugging := False
			stop_dbg_timer
			terminate_dbg_synchronisation
			eifnet_dbg_evaluator.reset
			reset_info
			Icor_objects_manager.clean
			icor_debug.clean_data
		end

	terminate_debugging
			-- Terminate the debugging session
		require
			is_debugging: is_debugging
		local
			l_controller: ICOR_DEBUG_CONTROLLER
			l_pro_hdl: POINTER
			l_success: BOOLEAN
		do
			eif_debug_display ("[EIFDBG] terminate debugging")
			l_controller := icor_debug_controller
			if l_controller /= Void then
				eif_debug_display ("[EIFDBG] pProcess->Terminate (..)")
				l_controller.stop (infinite_time) --| to get the hand on and to be synchronized
				l_controller.terminate (0)
debug ("refactor_fixme")
	fixme ("[jfiat] : check if we shoudln't Continue .. to get the ExitProcess ...")
end
				if not l_controller.last_call_succeed then
					--| the end of the killing process will be done on callback ExitProcess
					--| Maybe try with no Stop (..)
					--} but use violent .. ::TerminateProcess ...
					if icor_debug_process /= Void then
						l_pro_hdl := icor_debug_process.get_handle
					else
						l_pro_hdl := icor_debug.last_icor_debug_process_handle
					end
					l_success := {WEL_API}.terminate_process (l_pro_hdl, 0)
				end
					-- FIXME jfiat [2004/07/30] : check if this is not too violent ?
					-- maybe we could find a smarter way to terminate debugging synchronisation
debug ("refactor_fixme")
	fixme ("[jfiat] : check if this is not too violent, maybe use ExitProcess")
end
				terminate_debugger_session
				notify_exit_process_occurred
			else
				eif_debug_display ("[EIFDBG] could not find ICorDebugController object ...")
				notify_exit_process_occurred
				on_exit_process
			end
		end

	on_exit_process
			-- On ExitProcess callback
		do
			eif_debug_display ("[EIFDBG] execution exiting")
			terminate_debugger_session
		ensure
			not is_debugging
		end

	notify_exit_process_occurred
			-- Notify callback `ExitProcess' occurred
		do
			exit_process_occurred := True
		end

feature {NONE} -- Logging

	debugger_message (m: STRING)
			-- Put message on context tool's output
		do
			Debugger_manager.debugger_message (m)
		end

feature -- Status

	last_dbg_call_success: INTEGER
			-- Last return call success code.

	last_dbg_call_succeed: BOOLEAN
			-- Last call succeed ?
		do
			Result := last_dbg_call_success = 0
		end

feature {EIFNET_DEBUGGER} -- Callback notification about synchro

	dbgsync_cb_without_stopping : BOOLEAN
			-- Do we continue the execution without stopping ?

	on_estudio_callback_just_arrived (cb_id: INTEGER)
		do
			set_last_managed_callback (cb_id)
		end

	estudio_callback_event_processing: BOOLEAN

	estudio_callback_event (cb_id: INTEGER)
			-- Callback trigger for processing at end of dotnet callback
		local
			may_stop_on_callback: BOOLEAN
			s: APPLICATION_STATUS
			execution_stopped: BOOLEAN
		do
			estudio_callback_event_processing := True
			debug ("debugger_trace_callback", "debugger_trace_synchro")
				print ("<" + generator + ".estudio_callback_event>%N")
				print ("  ::Callback [" + managed_callback_name (cb_id) + "]. %N")
			end
			on_estudio_callback_just_arrived (cb_id)
			if not is_inside_function_evaluation then
				reset_current_callstack
				info.set_last_icd_breakpoint (Default_pointer)
				info.set_last_icd_exception (Default_pointer)
			end
				--| Consume Callback data (stored on the C side in struct)
			consume_managed_callback_info (cb_id)
			if dbgsync_cb_without_stopping then
				execution_stopped := continue_on_cb (cb_id) -- False
			elseif is_inside_function_evaluation then
				debug ("debugger_trace_callback")
					print (" - " + generator + ".estudio_callback_event from Evaluation %N")
				end
				if not callback_info.managed_callback_is_an_end_of_eval (cb_id) then
					execution_stopped := continue_on_cb (cb_id) -- False
				end
				--FIXME jfiat [2005/02/22] : What if ExitProcess or anything else occurs inside function eval ?
				-- it should be handle by the evaluation caller
			else
				may_stop_on_callback := callback_info.callback_enabled (cb_id)
				if may_stop_on_callback then
					execution_stopped := stop_on_cb (cb_id)
				else
					execution_stopped := continue_on_cb (cb_id)
				end

				if execution_stopped then
					s := application_status
					s.set_is_stopped (execution_stopped)
					if managed_callback_is_exit_process (cb_id) then
						debug ("debugger_trace_callback")
							print (" - Info : ExitProcess occurred %N")
						end
					else
							--| Set current thread id and active thread id.
						s.set_active_thread_id (info.last_icd_thread_id)
						s.set_current_thread_id (info.last_icd_thread_id)
					end
					debug ("debugger_trace_callback")
						print (" - Info : Debuggee is PAUSED %N")
					end
				else
					debug ("debugger_trace_callback")
						print (" - Info : Debuggee is RUNNING %N")
					end
				end
				if not next_estudio_notification_disabled then
					if attached {APPLICATION_EXECUTION_DOTNET} debugger_manager.application as app_impl then
						app_impl.estudio_callback_notify
					else
						check False end
					end
				end
			end

				-- Reset dbgsync data
			dbgsync_cb_without_stopping := False
			next_estudio_notification_disabled := False

			debug ("debugger_trace_callback")
				print ("</" + generator + ".estudio_callback_event>%N")
			end

			estudio_callback_event_processing := False
		end

	consume_managed_callback_info (cb_id: INTEGER)
		local
			p: POINTER
			i: INTEGER
			r: INTEGER
			l_module: ICOR_DEBUG_MODULE
			l_callback_id: INTEGER
		do
			l_callback_id := dbg_cb_info_get_callback_id
			set_last_managed_callback (l_callback_id)
			check l_callback_id = cb_id end

			debug ("debugger_trace_callback")
				debugger_message ("Callback :: " + managed_callback_name (l_callback_id))
			end

			inspect l_callback_id
			when Cst_managed_cb_break then
					--| p_app_domain, p_thread
				p := dbg_cb_info_pointer_item (1) -- p_app_domain
				set_last_controller_by_pointer (icor_debug_controller_interface (p))
				p := dbg_cb_info_pointer_item (2) -- p_thread
				set_last_thread_by_pointer (p)

			when Cst_managed_cb_breakpoint then
					--| p_app_domain, p_thread, p_breakpoint
				p := dbg_cb_info_pointer_item (1) -- p_app_domain
				set_last_controller_by_pointer (icor_debug_controller_interface (p))
				p := dbg_cb_info_pointer_item (2) -- p_thread
				set_last_thread_by_pointer (p)
				p := dbg_cb_info_pointer_item (3) -- p_breakpoint
				set_last_breakpoint_by_pointer (p)
				debugger_message ("Breakpoint occurred")

			when Cst_managed_cb_breakpoint_set_error then
					--| p_app_domain, p_thread, p_breakpoint, dw_error
				p := dbg_cb_info_pointer_item (1) -- p_app_domain
				set_last_controller_by_pointer (icor_debug_controller_interface (p))
				p := dbg_cb_info_pointer_item (2) -- p_thread
				set_last_thread_by_pointer (p)
				p := dbg_cb_info_pointer_item (3) -- p_breakpoint
				debug ("debugger_trace_callstack")
					r := dbg_cb_info_integer_item (4) -- dw_error
					io.put_string ("DBG callback : breakpoint_set_error %N")
					io.put_string ("  error = " + (r & 0x0FFFF).to_hex_string + "%N")
				end
				r := dbg_cb_info_integer_item (4) -- dw_error
				debugger_message ("BreakpointSetError occurred : error = " + (r & 0x0FFFF).to_hex_string )
				dbgsync_cb_without_stopping := True
			when Cst_managed_cb_control_ctrap then
					--| p_process
				p := dbg_cb_info_pointer_item (1) -- p_process				
				set_last_controller_by_pointer (p)

			when Cst_managed_cb_create_app_domain then
					--| p_process, p_app_domain
				p := dbg_cb_info_pointer_item (1) -- p_process
				set_last_controller_by_pointer (p)
				set_last_process_by_pointer (p)
				p := dbg_cb_info_pointer_item (2) -- p_app_domain
				debug ("debugger_trace_callback_data")
					io.error.put_string ({UTF_CONVERTER}.utf_32_string_to_utf_8_string_8 ((create {ICOR_DEBUG_APP_DOMAIN}.make_by_pointer (p)).get_name) + "%N")
				end
				r := {ICOR_DEBUG_APP_DOMAIN}.cpp_is_attached (p, $i)
				if not i.to_boolean then
						--| This should be done on the callback event
						--| but in case this is not done, let's do it
					r := {ICOR_DEBUG_APP_DOMAIN}.cpp_attach (p)
					check r = 0 end
				end
				dbgsync_cb_without_stopping := True
			when Cst_managed_cb_create_process then
					--| p_process
				p := dbg_cb_info_pointer_item (1) -- p_process
				set_last_controller_by_pointer (p)
				set_last_process_by_pointer (p)
				dbgsync_cb_without_stopping := True

			when Cst_managed_cb_create_thread then
					--| p_app_domain, p_thread
				p := dbg_cb_info_pointer_item (1) -- p_app_domain
				set_last_controller_by_pointer (icor_debug_controller_interface (p))
				p := dbg_cb_info_pointer_item (2) -- p_thread
				add_managed_thread_by_pointer (p)
				dbgsync_cb_without_stopping := True

			when Cst_managed_cb_debugger_error then
					--| p_process, error_hr, error_code
				p := dbg_cb_info_pointer_item (1) -- p_process
				set_last_controller_by_pointer (p)
				set_last_process_by_pointer (p)
 				r := dbg_cb_info_integer_item (2) -- error_hr
 				i := dbg_cb_info_integer_item (3) -- error_code
				info.notify_debugger_error (r, i)

			when Cst_managed_cb_edit_and_continue_remap then
					--| p_app_domain, p_thread, p_function, f_accurate
				p := dbg_cb_info_pointer_item (1) -- p_app_domain
				set_last_controller_by_pointer (icor_debug_controller_interface (p))
				p := dbg_cb_info_pointer_item (2) -- p_thread
				set_last_thread_by_pointer (p)

			when Cst_managed_cb_eval_complete then
					--| p_app_domain, p_thread, p_eval
				p := dbg_cb_info_pointer_item (1) -- p_app_domain
				set_last_controller_by_pointer (icor_debug_controller_interface (p))
				p := dbg_cb_info_pointer_item (2) -- p_thread
				set_last_thread_by_pointer (p)

			when Cst_managed_cb_eval_exception then
					--| p_app_domain, p_thread, p_eval
				p := dbg_cb_info_pointer_item (1) -- p_app_domain
				set_last_controller_by_pointer (icor_debug_controller_interface (p))
				p := dbg_cb_info_pointer_item (2) -- p_thread				
				set_last_thread_by_pointer (p)

			when Cst_managed_cb_exception then
					--| p_app_domain, p_thread, unhandled, + pExceptionValue
				p := dbg_cb_info_pointer_item (1) -- p_app_domain
				set_last_controller_by_pointer (icor_debug_controller_interface (p))
				p := dbg_cb_info_pointer_item (2) -- p_thread
				set_last_thread_by_pointer (p)
				i := dbg_cb_info_integer_item (3) -- unhandled
					--| unhandled == 1 --> TRUE
					--| unhandled /= 1 --> FALSE
				p := dbg_cb_info_pointer_item (4) -- pExceptionValue

				if not is_inside_function_evaluation then
					set_last_exception_handled (i /= 1)
					set_last_exception_by_pointer (p)
					if info.last_exception_is_handled then
						debugger_message ("First chance exception occurred")
					else
						debugger_message ("Unhandled exception occurred")
					end
				else
					set_last_evaluation_exception_by_pointer (p)
				end
			when Cst_managed_cb_exit_app_domain then
					--| p_process, p_app_domain
				p := dbg_cb_info_pointer_item (1) -- p_process
				set_last_process_by_pointer (p)
				p := dbg_cb_info_pointer_item (2) -- p_app_domain
				set_last_controller_by_pointer (icor_debug_controller_interface (p))
				debug ("refactor_fixme")
					fixme ("jfiat: Maybe we should use p_process to set the controller ...")
				end

			when Cst_managed_cb_exit_process then
					--|	p_process
				p := dbg_cb_info_pointer_item (1) -- p_process
				reset_last_controller_by_pointer (p)
				reset_last_process_by_pointer (p)
				r := {CLI_COM}.release (p)
				debug ("com_object")
					io.error.put_string ("ExitProcess Release ref pProcess <" + p.out +
							"> -> nb= " + r.out + " %N")
				end

			when Cst_managed_cb_exit_thread then
					--| p_app_domain, p_thread
				p := dbg_cb_info_pointer_item (1) -- p_app_domain
				set_last_controller_by_pointer (icor_debug_controller_interface (p))
				p := dbg_cb_info_pointer_item (2) -- p_thread
				remove_managed_thread_by_pointer (p)

			when Cst_managed_cb_load_assembly then
					--| p_app_domain, p_assembly
				p := dbg_cb_info_pointer_item (1) -- p_app_domain
				set_last_controller_by_pointer (icor_debug_controller_interface (p))

			when Cst_managed_cb_load_class then
					--| p_app_domain, p_class
				p := dbg_cb_info_pointer_item (1) -- p_app_domain
				set_last_controller_by_pointer (icor_debug_controller_interface (p))
				debug ("debugger_trace_callback_data")
					p := dbg_cb_info_pointer_item (2) -- p_app_class
					if p /= Default_pointer then
						debugger_message ("Class loaded :%"" + Icor_objects_manager.icd_class (p).get_module.md_type_name (Icor_objects_manager.icd_class (p).token) + "%"")
					end
				end
			when Cst_managed_cb_load_module then
					--| p_app_domain, p_module
				p := dbg_cb_info_pointer_item (1) -- p_app_domain
				set_last_controller_by_pointer (icor_debug_controller_interface (p))
				p := dbg_cb_info_pointer_item (2) -- p_module
				if p /= Default_pointer then
					l_module := Icor_objects_manager.icd_module (p)
					debug ("debugger_trace_callback_data")
						io.error.put_string ("Module loaded : %"" + l_module.name + "%" %N")
					end
					info.register_new_module (l_module)
					debugger_message ("Module loaded : %"" + l_module.module_name + "%"")
				end

			when Cst_managed_cb_log_message then
					--| p_app_domain, p_thread, l_level, p_log_switch_name, p_message
				p := dbg_cb_info_pointer_item (1) -- p_app_domain
				set_last_controller_by_pointer (icor_debug_controller_interface (p))
				p := dbg_cb_info_pointer_item (2) -- p_thread
				set_last_thread_by_pointer (p)

			when Cst_managed_cb_log_switch then
					--| p_app_domain, p_thread, l_level, ul_reason, p_log_switch_name, p_parent_name
				p := dbg_cb_info_pointer_item (1) -- p_app_domain
				set_last_controller_by_pointer (icor_debug_controller_interface (p))
				p := dbg_cb_info_pointer_item (2) -- p_thread				
				set_last_thread_by_pointer (p)

			when Cst_managed_cb_name_change then
					--| p_app_domain, p_thread
				p := dbg_cb_info_pointer_item (1) -- p_app_domain
				if p /= Default_pointer then
					set_last_controller_by_pointer (icor_debug_controller_interface (p))
				end
				p := dbg_cb_info_pointer_item (2) -- p_thread
				if p /= Default_pointer then
					set_last_thread_by_pointer (p)
					info.refresh_last_thread_details
				end

			when Cst_managed_cb_step_complete then
					--|	p_app_domain, p_thread, p_stepper, a_reason				
				p := dbg_cb_info_pointer_item (1) -- p_app_domain
				set_last_controller_by_pointer (icor_debug_controller_interface (p))
				p := dbg_cb_info_pointer_item (2) -- p_thread
				set_last_thread_by_pointer (p)
				i := dbg_cb_info_integer_item (4) -- a_reason
				set_last_step_complete_reason (i)

				debug ("debugger_trace_callback", "debugger_trace_callback_data")
					io.error.put_string ("Last step complete reason : "
						+ enum_cor_debug_step_reason_to_string (info.last_step_complete_reason)
						+ "%N")
				end
			when Cst_managed_cb_unload_assembly then
					--| p_app_domain, p_assembly
				p := dbg_cb_info_pointer_item (1) -- p_app_domain
				set_last_controller_by_pointer (icor_debug_controller_interface (p))

			when Cst_managed_cb_unload_class then
					--| p_app_domain, p_class
				p := dbg_cb_info_pointer_item (1) -- p_app_domain
				set_last_controller_by_pointer (icor_debug_controller_interface (p))

			when Cst_managed_cb_unload_module then
					--| p_app_domain, p_module
				p := dbg_cb_info_pointer_item (1) -- p_app_domain
				set_last_controller_by_pointer (icor_debug_controller_interface (p))

			when Cst_managed_cb_update_module_symbols then
					--|	p_app_domain, p_module, p_symbol_stream
				p := dbg_cb_info_pointer_item (1) -- p_app_domain
				set_last_controller_by_pointer (icor_debug_controller_interface (p))

			when Cst_managed_cb2_function_remap_opportunity then
			when Cst_managed_cb2_create_connection then
			when Cst_managed_cb2_change_connection then
			when Cst_managed_cb2_destroy_connection then
			when Cst_managed_cb2_exception then
			when Cst_managed_cb2_exception_unwind then
			when Cst_managed_cb2_function_remap_complete then
			when Cst_managed_cb2_mdanotification then

			when Cst_unmanaged_debug_event then

			else
				check False end
			end

			dbg_clear_cb_info
		end

feature {EIFNET_EXPORTER} -- Callback access

	is_inside_function_evaluation: BOOLEAN
			-- Is the current context correspond to a function evaluation ?
		do
			Result := info.is_evaluating
		end

feature {NONE} -- Callback actions

	icor_debug_controller_interface (p_controller: POINTER): POINTER
			-- Computed ICorDebugController interface from a Process or AppDomain pointer.
		local
			p_process: POINTER
			p_app_domain: POINTER
			l_hr: INTEGER
			n: INTEGER
		do
			if p_controller /= Default_pointer then
				l_hr := {ICOR_DEBUG_CONTROLLER}.cpp_query_interface_ICorDebugController (p_controller, $Result)
				if l_hr /= 0 then
					l_hr := {ICOR_DEBUG_CONTROLLER}.cpp_query_interface_ICorDebugController (p_controller, $p_app_domain)
					l_hr := {ICOR_DEBUG_APP_DOMAIN}.cpp_get_process (p_app_domain, $p_process)
					Result := p_process
					n := {CLI_COM}.release (p_app_domain)
				end
				n := {CLI_COM}.release (p_controller)
			end
		end

	continue_on_cb (cb_id: INTEGER): BOOLEAN
			-- Continue without stopping the system
		do
				--| Let's continue, we don't stop on this callback
			call_do_continue_on_cb
			Result := False
		end

	stop_on_cb (cb_id: INTEGER): BOOLEAN
			-- Stop the system (on step complete or breakpoint for instance)
		do
				--| Refresh CallStack info
			if managed_callback_is_exit_process (cb_id) then
				reset_current_callstack
			else
				init_current_callstack
			end
			if managed_callback_is_breakpoint (cb_id) then
				Result := execution_stopped_on_end_of_breakpoint_callback
			elseif managed_callback_is_step_complete (cb_id) then
				Result := not is_inside_function_evaluation and then execution_stopped_on_end_of_step_complete_callback
			elseif managed_callback_is_exception (cb_id) then
				if is_inside_function_evaluation then
					if icor_debug_controller /= Void then
						call_do_continue_on_cb
					end
				else
					application_status.set_exception_occurred (True)
					Result := execution_stopped_on_exception_callback
				end
			else
					--| Then we stop the execution ;)
					--| do nothing for now
				Result := True
			end
		end

	execution_stopped_on_end_of_breakpoint_callback: BOOLEAN
			-- Process end_of_breakpoint_callback and then return if is stopped.
		require
			top_callstack_data_initialised: info.current_callstack_initialized
		do
			if last_control_mode_is_stepping then
				Result := execution_stopped_on_end_of_breakpoint_callback_while_stepping
			else
					--| not stepping, so real breakpoint stopping
				Result := True
			end
		end

	execution_stopped_on_end_of_breakpoint_callback_while_stepping: BOOLEAN
			-- Do we stop on this bp slot, if we are in stepping action ?
		local
			l_previous_stack_info, l_current_stack_info: EIFNET_DEBUGGER_STACK_INFO
			l_copy: EIFNET_DEBUGGER_STACK_INFO
			l_potential_il_offset: INTEGER
			l_il_debug_info: IL_DEBUG_INFO_RECORDER
			l_feat: FEATURE_I
			l_class_type: CLASS_TYPE
			dbg_info: EIFNET_DEBUGGER_INFO
		do
			dbg_info := info
			l_previous_stack_info := dbg_info.previous_stack_info
			l_current_stack_info := dbg_info.current_stack_info

			l_il_debug_info := Il_debug_info_recorder
			if l_il_debug_info.has_info_about_module (l_previous_stack_info.current_module_name) then
				l_feat := l_il_debug_info.feature_i_by_module_feature_token (
							l_previous_stack_info.current_module_name,
							l_previous_stack_info.current_feature_token
						)
				l_class_type := l_il_debug_info.class_type_for_module_class_token (
							l_previous_stack_info.current_module_name,
							l_previous_stack_info.current_class_token
						)
				l_potential_il_offset := l_il_debug_info.approximate_feature_breakable_il_offset_for (
												l_class_type,
												l_feat,
												l_previous_stack_info.current_il_offset
												)
					--| current il offset if corresponding to a bp slot, or approximate offset.
			end

			create l_copy.make_copy (l_previous_stack_info)
			l_copy.set_current_il_offset (l_potential_il_offset)
			if l_copy.is_equal (l_current_stack_info) then
				call_do_continue_on_cb
				Result := False
			else
				Result := True
			end
		end

	execution_stopped_on_end_of_step_complete_callback: BOOLEAN
			-- Process end_of_step_complete_callback and then return if is stopped.
		require
			top_callstack_data_initialised: info.current_callstack_initialized
		local
			unknown_eiffel_info_for_call_stack_stop: BOOLEAN
			inside_valid_feature_call_stack_stepping: BOOLEAN
			is_valid_callstack_offset: BOOLEAN
			execution_stopped: like execution_stopped_on_end_of_step_complete_callback

			l_class_token: NATURAL_32
			l_feat_token: NATURAL_32

			l_module_name: STRING
			l_current_il_offset: INTEGER
			l_feat: FEATURE_I
			l_class_type: CLASS_TYPE
			l_current_stack_info: EIFNET_DEBUGGER_STACK_INFO
			l_il_debug_info: IL_DEBUG_INFO_RECORDER
			dbg_info: EIFNET_DEBUGGER_INFO
		do
			dbg_info := info

				--| If we were stepping ...
			debug ("DEBUGGER_TRACE_STEPPING")
				print ("%N>=> StepComplete <=< %N")
				print ("%T - last_control_mode         = "   + dbg_info.last_control_mode_as_string + "%N")
				print ("%T - last_step_complete_reason = 0x" + dbg_info.last_step_complete_reason.to_hex_string)
				print ("  ==> " + enum_cor_debug_step_reason_to_string (dbg_info.last_step_complete_reason) + "%N")
				print ("%N")
			end

			if
				dbg_info.last_control_mode_is_step_into
				and then dbg_info.is_current_state_same_as_previous
			then
				call_do_step_into_on_cb
			elseif
				dbg_info.last_control_mode_is_stop
			then
				-- FIXME jfiat: special case for Stop now ...
				Result := True
			else
				l_current_stack_info := dbg_info.current_stack_info
				if l_current_stack_info.is_synchronized then
					l_class_token := l_current_stack_info.current_class_token
					l_module_name := l_current_stack_info.current_module_name

					check
						module_name_valid: l_module_name /= Void and then not l_module_name.is_empty
					end

					l_il_debug_info := Il_debug_info_recorder
					if l_module_name = Void
						or else l_module_name.is_empty
						or else not l_il_debug_info.has_info_about_module (l_module_name)
					then
						unknown_eiffel_info_for_call_stack_stop := True
					else
						unknown_eiffel_info_for_call_stack_stop := l_class_token <= 0
							or else not l_il_debug_info.has_class_info_about_module_class_token (l_module_name, l_class_token)
					end
				else
					unknown_eiffel_info_for_call_stack_stop := True
				end
				if unknown_eiffel_info_for_call_stack_stop then
					debug ("debugger_trace_stepping")
						print ("[!] Unknown Eiffel info: %N")
						if l_module_name /= Void then
							print ("[!]    module=" + l_module_name + "%N")
						end
						print ("[!]    class = 0x" + l_class_token.to_hex_string + " %N")
					end
					if not dbg_info.last_control_mode_is_step_into then
						call_do_step_out_on_cb
					elseif keep_stepping_into_dotnet_feature_enabled then
						call_do_step_range_on_cb (True, <<[0, l_current_stack_info.current_il_code_size]>>)
					else
						call_do_step_out_on_cb
					end
				else
					l_class_type := l_il_debug_info.class_type_for_module_class_token (l_module_name, l_class_token)
					l_feat_token := l_current_stack_info.current_feature_token
					if l_feat_token > 0 then
						inside_valid_feature_call_stack_stepping := l_il_debug_info.has_feature_info_about_module_class_token (l_module_name, l_class_token, l_feat_token)
					end
					if inside_valid_feature_call_stack_stepping then
						l_current_il_offset := l_current_stack_info.current_il_offset

						l_feat := l_il_debug_info.feature_i_by_module_feature_token (l_module_name, l_feat_token)
						debug ("debugger_trace_stepping")
							print ("[!] Valid and known feature [0x" + l_class_token.to_hex_string
									+ "::" + l_feat.feature_name
									+ "] => IP=0x"+l_current_il_offset.to_hex_string
									+" %N")
							print ("[!] module = " + l_module_name + "%N")
						end

						if l_current_il_offset = 0 then
								--| Let's skip the first `nop' , non sense for the eStudio debugger					
							call_do_step_into_on_cb
						else
							is_valid_callstack_offset := l_il_debug_info.is_il_offset_related_to_eiffel_line (l_class_type, l_feat, l_current_il_offset)
							if
								(not dbg_info.last_control_mode_is_step_out)
								and then (not is_valid_callstack_offset)
							then
								debug ("debugger_trace_stepping")
									print ("[!] InValid or Unknown offset [0x" + l_current_il_offset.to_hex_string + "].%N")
								end
									--| if the offset is not related to an know stoppable point, let adjust it					
									--| In case we are not on a potential stop point
									--| this means we are at the beginning of a feature : offset = 0
									--| or we are in a step_into concerning a `foo( a(), b())'
									--| so in either case, a step_into is the correct behavior.

								call_do_step_into_on_cb
							else
									--| we can stop, this is a valid stoppable point for
									--| the eStudio debugger
								execution_stopped := True
							end
						end
					else
						debug ("debugger_trace_stepping")
							print ("[!] InValid or Unknown feature [0x"
									+ l_class_token.to_hex_string
									+ "::0x" + l_feat_token.to_hex_string + "].%N")
							print ("[!] class = " + l_il_debug_info.class_name_for_class_token_and_module ( l_class_token, l_module_name)
									+ "%N")
							print ("[!] module = " + l_module_name + "%N")
						end
							--| We'll continue the stepping in the same mode

							--| ranges ...
						if dbg_info.last_control_mode_is_step_out then
							call_do_step_out_on_cb
						elseif dbg_info.last_control_mode_is_step_into then
							call_do_step_range_on_cb (True, <<[0, l_current_stack_info.current_il_code_size]>>)
						elseif dbg_info.last_control_mode_is_step_next then
							call_do_step_range_on_cb (False, <<[0, l_current_stack_info.current_il_code_size]>>)
						else
								--| FIXME JFIAT : is this default stepping case needed ???
							call_do_step_range_on_cb (False, <<[0, l_current_stack_info.current_il_code_size]>>)
						end
					end
				end
				Result := execution_stopped
			end
		end

	execution_stopped_on_exception_callback: BOOLEAN
		require
			exception_occurred: exception_occurred
		do
			Result := debugger_manager.process_exception
			if not Result then
				call_do_continue_on_cb
			end
		end

feature -- Specific case

	enable_keep_stepping_into_dotnet_feature
		do
			keep_stepping_into_dotnet_feature_enabled := True
		end

	disable_keep_stepping_into_dotnet_feature
		do
			keep_stepping_into_dotnet_feature_enabled := False
		end

	keep_stepping_into_dotnet_feature_enabled: BOOLEAN
			-- Keep stepping into even if this is a pure dotnet feature ?
			-- useful to get into agent call.

feature -- Various continuing mode from callback

	call_disable_next_estudio_notification
			-- In call_back processing, if we continue/step.. right away
			-- we don't need to process estudio_notification
		do
			if not is_inside_function_evaluation then
				disable_next_estudio_notification
			end
		end

	call_terminate_debugging
			-- If there is no CorDebugController, then we cannot continue
			-- thus let's terminate debugging
		do
			debug ("debugger_trace_callstack")
				io.error.put_string ("No ICorDebugController ... going to terminate_debugger ...%N")
			end
			terminate_debugging
		end

	call_do_continue_on_cb
		do
			if icor_debug_controller /= Void then
				do_continue
				call_disable_next_estudio_notification
			else
				call_terminate_debugging
			end
		end

	call_do_step_range_on_cb (a_bstep_in: BOOLEAN; a_il_ranges: ARRAY [TUPLE [left: INTEGER; right: INTEGER]])
		do
			if icor_debug_controller /= Void then
				do_step_range (a_bstep_in, a_il_ranges)
				call_disable_next_estudio_notification
			else
				call_terminate_debugging
			end
		end

	call_do_step_out_on_cb
		do
			if icor_debug_controller /= Void then
				do_step_out
				call_disable_next_estudio_notification
			else
				call_terminate_debugging
			end
		end

	call_do_step_into_on_cb
		do
			if icor_debug_controller /= Void then
				do_step_into
				call_disable_next_estudio_notification
			else
				call_terminate_debugging
			end
		end

feature -- Interaction with .Net Debugger

	waiting_debugger_callback (a_title: STRING)
		do
			debug ("debugger_trace_operation")
				print ("%N... Waiting for debugger to callback...%N%N")
			end

			eif_debug_display ("[EIFDBG] " + a_title)
		end

	do_create_process (cmd: READABLE_STRING_32; a_working_dir: PATH; args: READABLE_STRING_32; env: detachable NATIVE_STRING)
			-- Create Process
		require
			cmd_attached: cmd /= Void
			a_working_dir_attached: a_working_dir /= Void
			args_attached: args /= Void
		local
			l_icd_process: POINTER
			n: INTEGER
		do
			l_icd_process := icor_debug.create_process (cmd + {STRING_32} " " + args, a_working_dir, env)

			if icor_debug.last_call_succeed then
				n := {CLI_COM}.add_ref (l_icd_process)
				set_last_controller_by_pointer (l_icd_process)
				set_last_process_by_pointer (l_icd_process)
				n := {CLI_COM}.release (l_icd_process)
			else
				set_last_controller_by_pointer (Default_pointer)
				set_last_process_by_pointer (Default_pointer)
			end
		end

	do_run (cmd: READABLE_STRING_32; cwd: PATH; args: READABLE_STRING_32; env: detachable NATIVE_STRING)
			-- Start the process to debug
		require
			cmd_attached: cmd /= Void
			cwd_attached: cwd /= Void
			args_attached: args /= Void
		do
			do_create_process (cmd, cwd, args, env)
			waiting_debugger_callback ("run process")
			last_dbg_call_success := icor_debug.last_call_success
		end

	do_stop
			-- (Async) Stop the process (on a step complete or breakpoint for instance)
		require
			controller_exists: icor_debug_controller /= Void
		local
			l_controller: ICOR_DEBUG_CONTROLLER
		do
			check
				outside_callback_notification: not callback_notification_processing
			end

			debug ("debugger_trace_synchro")
				notify_debugger ("<start> " + generator + ".do_stop %N")
			end

			l_controller := icor_debug_controller
			if exit_process_occurred or else l_controller = Void then
				on_exit_process
			else
				debug ("debugger_eifnet_data")
					print ("Last control mode = " + info.last_control_mode_as_string + "%N")
				end
				l_controller.stop (infinite_time)
				last_dbg_call_success := l_controller.last_call_success
				debug ("debugger_eifnet_data")
					print ("EIFNET_DEBUGGER.do_stop : after stop ICorDebugController.last_call_success = " + l_controller.last_error_code_id + "%N")
				end
				waiting_debugger_callback ("stop")
			end
			debug ("debugger_trace_synchro")
				notify_debugger ("<end> " + generator + ".do_stop %N")
			end
		end

	do_continue
		local
			l_controller: ICOR_DEBUG_CONTROLLER
			l_hr: INTEGER
		do
			if exit_process_occurred or else icor_debug_controller = Void then
				on_exit_process
			else
				l_controller := icor_debug_controller
				l_hr := process_continue (l_controller, False)
				last_dbg_call_success := l_controller.last_call_success
				debug ("debugger_trace_eifnet")
					if last_dbg_call_success /= 0 then
						io.error.put_string ("EIFNET_DEBUGGER.do_continue failed %N")
					end
				end
			end
		end

feature {NONE} -- Stepping Implementation

	new_stepper: ICOR_DEBUG_STEPPER
			-- Retrieve or Create Stepper
			-- Result value is the error code
		local
			edti: EIFNET_DEBUGGER_THREAD_INFO
			thid: POINTER
		do
			thid := application_status.current_thread_id
			if thid = Default_pointer then
				thid := info.last_icd_thread_id
			end
			edti := info.managed_thread (thid)
			if edti /= Void then
				Result := edti.new_stepper
				if Result /= Void then
					Result.add_ref
				end
			else
				Result := Void
				eif_debug_display ("[DBG/WARNING] No thread available ...")
			end
		end

	do_step (a_mode: INTEGER; a_continue_enabled: BOOLEAN)
		require
--			valid_step_mode: (a_mode = cst_control_step_next)
--								or else (a_mode = cst_control_step_in)
--								or else (a_mode = cst_control_step_out)						
			controller_exists: icor_debug_controller /= Void
		local
			l_stepper: ICOR_DEBUG_STEPPER
		do
			l_stepper := new_stepper
			if l_stepper /= Void then
				--| Manage the step
				inspect	a_mode
				when cst_control_step_next then
					l_stepper.step (False)
				when cst_control_step_into then
					l_stepper.step (True)
				when cst_control_step_out then
					l_stepper.step_out
				else
					l_stepper.step (False)
				end
				check l_stepper.check_last_call_succeed end
				if a_continue_enabled then
					do_continue
				end
			else
				debug  ("DEBUGGER_TRACE_EIFNET")
					eif_debug_display ("[DBG/WARNING] No stepper made available ...")
				end
				last_dbg_call_success := -1
			end
		end

feature -- Stepping Access

	do_step_range (a_bstep_in: BOOLEAN; a_il_ranges: ARRAY [TUPLE [left: INTEGER; right: INTEGER]])
			-- Step next.
			-- FIXME: a_il_ranges should be made of NATURAL_32
		local
			l_stepper: ICOR_DEBUG_STEPPER
		do
			debug ("debugger_trace_operation")
				print ("[enter] EIFNET_DEBUGGER.do_step_range (" + a_bstep_in.out + ")%N")
			end
			l_stepper := new_stepper
			if l_stepper /= Void then
				debug  ("DEBUGGER_TRACE_EIFNET")
					print ("[>] Stepping using ICorDebugStepper [0x" + l_stepper.out + "]%N")
				end
				l_stepper.step_range (a_bstep_in, a_il_ranges)
				check l_stepper.check_last_call_succeed end

				do_continue
			else
				eif_debug_display ("[DBG/WARNING] No stepper made available ...")
			end

			waiting_debugger_callback ("step range")
		end

	do_global_step_into
			-- Step next on each thread to stop as soon as possible
			-- Nota: needed for Stop feature
			-- ie: we'll use a stepper for each thread
			-- then the final Continue .. to reach the Step callback
		local
			thid: POINTER
			tids: ARRAY [POINTER]
			i: INTEGER
			st: APPLICATION_STATUS
		do
			debug ("debugger_trace_operation")
				print ("[enter] EIFNET_DEBUGGER.do_global_step_into%N")
			end
			st := application_status
			thid := st.current_thread_id
			tids := info.loaded_managed_threads.current_keys

			from
				i := tids.lower
			until
				i > tids.upper
			loop
				st.set_current_thread_id (tids @ i)
				do_step (cst_control_step_into, False)
				i := i + 1
			end
			st.set_current_thread_id (thid)
			do_continue
		end

	do_step_next
			-- Step next.
		do
			debug ("debugger_trace_operation")
				print ("[enter] EIFNET_DEBUGGER.do_step_next%N")
			end
			do_step (cst_control_step_next, True)
			waiting_debugger_callback ("step next")
		end

	do_step_into
			-- Step in.
		do
			debug ("debugger_trace_operation")
				print ("[enter] EIFNET_DEBUGGER.do_step_into%N")
			end

			do_step (cst_control_step_into, True)
			waiting_debugger_callback ("step into")
		end

	do_step_out
			-- Step out.
		do
			debug ("debugger_trace_operation")
				print ("[enter] EIFNET_DEBUGGER.do_step_out%N")
			end

			do_step (cst_control_step_out, True)
			waiting_debugger_callback ("step out")
		end

	stepping_possible: BOOLEAN
			--
		do
			Result := icor_debug_controller /= Void and then icor_debug_thread /= Void
		end

feature -- Tracer

	eif_debug_display (msg: STRING)
		do
		end

feature -- Bridge to EIFNET_DEBUGGER_INFO

	last_process_id: INTEGER
			-- Process id of icor_debug_process
			-- Usually used to get the launch application's process id.
		local
			icdp: like icor_debug_process
		do
			icdp := icor_debug_process
			if icdp /= Void then
				Result := icdp.get_id
			end
		end

	new_active_frame: ICOR_DEBUG_FRAME
			-- Active Thread value retrieved each call from .Net debugger
		local
			l_last_thread: ICOR_DEBUG_THREAD
		do
			l_last_thread := icor_debug_thread
			if l_last_thread /= Void then
				Result := l_last_thread.get_active_frame
			end
		end

	current_stack_icor_debug_frame: ICOR_DEBUG_FRAME
			-- Frame related to current call stack.
			-- This is a shared instance, so don't release it unless you know
			-- what you do.
		do
			if attached {CALL_STACK_ELEMENT_DOTNET} application_status.current_call_stack_element as l_cse then
				Result := l_cse.icd_frame
			else
					--| Check if needed |--
				Result := icor_debug_thread.get_active_frame
			end
		end

feature -- Bridge to formatters

	icor_debug_value_is_null_value (icd: ICOR_DEBUG_VALUE): BOOLEAN
			-- Is `icd' a null reference ?
		require
			icd_not_void: icd /= Void
		local
			l_prep: ICOR_DEBUG_VALUE
		do
			l_prep := edv_formatter.prepared_debug_value (icd)
			if l_prep /= Void then
				Result := edv_formatter.prepared_icor_debug_value_is_null (l_prep)
				if l_prep /= icd then
					l_prep.clean_on_dispose
				end
			end
		end

feature -- Assertion change

	check_assert_on_debuggee (b: BOOLEAN): BOOLEAN
		local
			l_frame: ICOR_DEBUG_FRAME
			l_bool, l_icd: ICOR_DEBUG_VALUE
			l_icd_module: ICOR_DEBUG_MODULE
			l_token: NATURAL_32
			l_func: ICOR_DEBUG_FUNCTION
		do
			l_icd_module := ise_runtime_module
			l_token := edv_external_formatter.token_iseruntime__check_assert
			if l_token /= 0 then
				l_func := l_icd_module.get_function_from_token (l_token)
				if l_func /= Void then
					l_frame := current_stack_icor_debug_frame
					l_bool := eifnet_dbg_evaluator.new_boolean_evaluation (l_frame, b)
					l_icd := eifnet_dbg_evaluator.function_evaluation (l_frame, l_func, << l_bool >>)
					l_bool.clean_on_dispose
					if eifnet_dbg_evaluator.last_eval_is_exception and l_icd /= Void then
						l_icd.clean_on_dispose
						l_icd := Void
					end
					if l_icd /= Void then
						Result := edv_formatter.icor_debug_value_to_boolean (l_icd)
						l_icd.clean_on_dispose
					end
				end
			end
		end

feature -- Exception

	reset_evaluation_exception
		do
			info.reset_last_evaluation_icd_exception
		end

	exception_occurred: BOOLEAN
			-- Last callback is about exception ?
		do
			Result := last_managed_callback_is_exception
		end

	active_exception_value: ICOR_DEBUG_VALUE
			-- Active Exception value retrieved each call from .Net debugger
		do
			Result := info.icd_exception
		end

	new_active_exception_value_from_thread: ICOR_DEBUG_VALUE
		local
			l_last_thread: ICOR_DEBUG_THREAD
		do
			Result := active_exception_value
			if Result = Void or else Result.item = Default_pointer then
				l_last_thread := icor_debug_thread
				if l_last_thread /= Void then
					Result := l_last_thread.get_current_exception
				end
			end
		end

	exception_class_name (v: ABSTRACT_REFERENCE_VALUE): STRING
			-- Exception's class name.
		local
			l_exception_info: EIFNET_DEBUG_VALUE_INFO
		do
			if attached {EIFNET_DEBUG_REFERENCE_VALUE} v as dv then
				l_exception_info := dv.icd_value_info
				if l_exception_info /= Void then
					Result := l_exception_info.value_class_name
				end
			end
		end

	exception_module_name (v: ABSTRACT_REFERENCE_VALUE): STRING_32
			-- Exception's module name.
		local
			l_exception_info: EIFNET_DEBUG_VALUE_INFO
		do
			if attached {EIFNET_DEBUG_REFERENCE_VALUE} v as dv then
				l_exception_info := dv.icd_value_info
				if l_exception_info /= Void then
					Result := l_exception_info.value_module_file_name
				end
			end
		end

	exception_text (v: ABSTRACT_REFERENCE_VALUE): STRING_32
			-- Get `exception_info_to_string' and `exception_info_message' output
		local
			retried: BOOLEAN
			icdv: ICOR_DEBUG_VALUE
			l_icdov: ICOR_DEBUG_OBJECT_VALUE
			l_class_name, l_module_name: STRING
			l_to_string, l_message: STRING_32
		do
			if
				not retried and then
				attached {EIFNET_DEBUG_REFERENCE_VALUE} v as dv and then
				attached dv.icd_value_info as l_exception_info
			then
				icdv := l_exception_info.icd_referenced_value
				l_class_name := l_exception_info.value_class_name
				l_module_name := l_exception_info.value_module_file_name

				l_icdov := l_exception_info.new_interface_debug_object_value
				if l_icdov /= Void then
					l_to_string := to_string_value_from_exception_object_value (Void,
						icdv,
						l_icdov
					)
					l_message := get_message_value_from_exception_object_value (Void,
						icdv,
						l_icdov
					)
					l_icdov.clean_on_dispose

					create Result.make_empty
					if l_message = Void or else l_message.is_empty then
						--| This could means the prog did exit_process
						--| or .. anything else
						if l_class_name /= Void then
							Result.append (l_class_name)
						end
						if l_module_name /= Void then
							if not Result.is_empty then
								Result.append_character (' ')
							end
							Result.append_character ('(')
							Result.append (l_module_name)
							Result.append_character (')')
						end
					else
						Result.append (l_message)
					end
					if l_to_string /= Void and then not l_to_string.is_empty then
						if not Result.is_empty then
							Result.append_character ('%N')
						end
						Result.append_string (l_to_string)
					end
				end
			end
		rescue
			retried := True
			retry
		end

feature -- Easy access

	icor_debug_module_for_class (a_class_c: CLASS_C): ICOR_DEBUG_MODULE
		require
			arg_class_c_not_void: a_class_c /= Void
		do
			Result := icor_debug_module (Il_debug_info_recorder.module_file_name_for_class (a_class_c))
		end

	icor_debug_module_for_class_type (a_class_type: CLASS_TYPE): ICOR_DEBUG_MODULE
		require
			a_class_type_not_void: a_class_type /= Void
		do
			Result := icor_debug_module (Il_debug_info_recorder.module_file_name_for_class_type (a_class_type))
		end

	icor_debug_module_for_external_class (a_class_c: CLASS_C): ICOR_DEBUG_MODULE
		require
			a_class_c_not_void: a_class_c /= Void
		local
			n: READABLE_STRING_GENERAL
			m: ICOR_DEBUG_MODULE
			mods: like {EIFNET_DEBUGGER_INFO}.loaded_modules
		do
			if attached {ASSEMBLY_I} a_class_c.group as ai then
				n := ai.consumed_assembly.name
				m := ise_runtime_module
				if m /= Void and then m.has_short_name (n) then
					Result := m
				else
					m := info.mscorlid_module
					if m /= Void and then m.has_short_name (n) then
						Result := m
					end
				end
				if Result = Void then
					mods := info.loaded_modules
					from
						mods.start
					until
						mods.after or Result /= Void
					loop
						m := mods.item_for_iteration
						if m.has_short_name (n) then
							Result := m
						end
						mods.forth
					end
				end
			end
		end

	icor_debug_class (a_class_type: CLASS_TYPE): ICOR_DEBUG_CLASS
		require
			arg_class_type_not_void: a_class_type /= Void
		local
			l_icd_module: ICOR_DEBUG_MODULE
			l_class_token: NATURAL_32
		do
			l_icd_module := icor_debug_module_for_class_type (a_class_type)
			if l_icd_module /= Void then
				l_class_token := Il_debug_info_recorder.class_token (l_icd_module.name, a_class_type)
				Result := l_icd_module.get_class_from_token (l_class_token)
			end
		end

feature -- Bridge to MD_IMPORT

	class_token (a_mod_name: PATH; a_class_type: CLASS_TYPE): NATURAL_32
			-- Find class token using Meta Data.
		local
			l_icd_module: ICOR_DEBUG_MODULE
		do
			l_icd_module := icor_debug_module (a_mod_name)
			if l_icd_module /= Void then
				Result := l_icd_module.md_class_token_by_type_name (a_class_type.full_il_implementation_type_name)
			end
		end

feature -- Function Evaluation

	icd_function_by_names (a_icdmod: ICOR_DEBUG_MODULE; cl_name: STRING; f_name: STRING): ICOR_DEBUG_FUNCTION
			-- ICorDebugFunction for `a_icdmod' module,
			-- with class name `cl_name'
			-- with feature name `f_name'.
		require
			a_icdmod_not_void: a_icdmod /= Void
			valid_class_name: cl_name /= Void and then not cl_name.is_empty
			valid_feature_name: f_name /= Void and then not f_name.is_empty
		local
			l_cl_tok: NATURAL_32
			icdm: ICOR_DEBUG_MODULE
		do
			l_cl_tok := a_icdmod.md_class_token_by_type_name (cl_name)
			if l_cl_tok = 0 then
					--| Let's try the mscorlib module
					--| We might need to look in all ancestor of `a_classtok'
					--| but for now, let's do simple.			
				icdm := info.icor_debug_module_for_mscorlib
				if icdm /= Void and icdm /= a_icdmod then
					l_cl_tok := icdm.md_class_token_by_type_name (cl_name)
				end
			end
			if l_cl_tok > 0 then
				Result := icd_function_by_name (a_icdmod, l_cl_tok, f_name)
			end
		end

	icd_function_by_name (a_icdmod: ICOR_DEBUG_MODULE; a_classtok: NATURAL_32; f_name: STRING): ICOR_DEBUG_FUNCTION
			-- ICorDebugFunction for `a_icdmod' module,
			-- with class token `a_classtok'
			-- with feature name `f_name'.
		require
			a_icdmod_not_void: a_icdmod /= Void
			a_classtok_positive: a_classtok > 0
			valid_feature_name: f_name /= Void and then not f_name.is_empty
		local
			icdm: ICOR_DEBUG_MODULE
			feattok: NATURAL_32
		do
			icdm := a_icdmod
			feattok := icdm.md_feature_token (a_classtok, f_name)
			if feattok > 0 then
				Result := icdm.get_function_from_token (feattok)
				if Result = Void then
						--| Let's try the mscorlib module with System.Object
						--| We might need to look in all ancestor of `a_classtok'
						--| but for now, let's do simple.
					icdm := info.icor_debug_module_for_mscorlib
					if icdm /= Void and icdm /= a_icdmod then
						feattok := icdm.md_member_token_by_names (info.system_object_class_name, f_name)
						if feattok > 0 then
							Result := icdm.get_function_from_token (feattok)
							if Result = Void then
									--| Let's try the ise_runtime module with ISE_RUNTIME
									--| We might need to look in all ancestor of `a_classtok'
									--| but for now, let's do simple.
								icdm := info.icor_debug_module_for_ise_runtime
								if icdm /= Void and icdm /= a_icdmod then
									feattok := icdm.md_member_token_by_names ("EiffelSoftware.Runtime.ISE_RUNTIME", f_name)
									if feattok > 0 then
										Result := icdm.get_function_from_token (feattok)
									end
								end
							end
						end
					end
				end
			end
		end

	icd_function_by_feature (icdv: ICOR_DEBUG_VALUE; ct: CLASS_TYPE; a_feat: FEATURE_I): ICOR_DEBUG_FUNCTION
			-- ICorDebugFunction for `ct'.`a_feat'
			-- and optionally on object `icdv'
		local
			l_feat_tok: NATURAL_32
			l_feat_name: STRING
			l_icd_class: ICOR_DEBUG_CLASS
			l_icd_module: ICOR_DEBUG_MODULE
			l_icd_obj_val: ICOR_DEBUG_OBJECT_VALUE
			l_info: EIFNET_DEBUG_VALUE_INFO
		do
			if ct.is_external then
				l_icd_module := icor_debug_module_for_external_class (ct.associated_class)
				if l_icd_module /= Void then
					l_feat_tok := l_icd_module.md_member_token_by_names (ct.full_il_implementation_type_name, a_feat.external_name)
				end
					if l_feat_tok = 0 and icdv /= Void then
					create l_info.make (icdv)
					if l_info.has_object_interface then
						l_icd_obj_val := l_info.new_interface_debug_object_value
						if l_icd_obj_val /= Void then
							l_icd_class := l_icd_obj_val.get_class
							if l_icd_class /= Void then
								l_icd_module := l_icd_class.get_module
								l_feat_name := a_feat.external_name
							end
							l_icd_obj_val.clean_on_dispose
						end
					end
					l_info.icd_prepared_value.clean_on_dispose
					l_info.clean
				end
			else
					--| This should be an true Eiffel type
				l_feat_tok := Il_debug_info_recorder.feature_token_for_feat_and_class_type (a_feat, ct)
				l_icd_module := icor_debug_module (Il_debug_info_recorder.module_file_name_for_class_type (ct))
				if l_feat_tok = 0 then
					l_feat_name := a_feat.feature_name
				end
			end
			if l_icd_module /= Void then
				if l_feat_tok > 0 then
					Result := l_icd_module.get_function_from_token (l_feat_tok)
				end
				if Result = Void then
					Result := icd_function_by_names (l_icd_module, ct.full_il_implementation_type_name, l_feat_name)
				end
			end
		end

feature {EIFNET_DEBUGGER_EVALUATOR} -- Implementation of ICorDebugFunction retriever

	eiffel_icd_function_by_name (ct: CLASS_TYPE; a_f_name: STRING): ICOR_DEBUG_FUNCTION
			-- ICorDebugClass for `a_class_c'.`a_f_name'
		local
			l_feat_i : FEATURE_I
		do
			l_feat_i := ct.associated_class.feature_named_32 (a_f_name)
			Result := icd_function_by_feature (Void, ct, l_feat_i)
		end

feature -- Specific function evaluation

--| Not used for now |--
--	length_from_string_class_object_value (icd_string_instance: ICOR_DEBUG_OBJECT_VALUE): INTEGER is
--			-- String Length for `icd_string_instance' (STRING object)
--		require
--			icd_string_instance /= Void
--		local
--			l_icd_value: ICOR_DEBUG_VALUE
--			l_class: ICOR_DEBUG_CLASS
--			l_string_class: CLASS_C
--			l_feat_count: FEATURE_I
--			l_feat_count_token: NATURAL_32
--		do
--				--| Get STRING info from compilo
--			l_string_class := Eiffel_system.String_class.compiled_class
--				--| Get STRING.count
--			l_feat_count := l_string_class.feature_named ("count")
--			if l_feat_count /= Void then
--				l_feat_count_token := Il_debug_info_recorder.feature_token_for_non_generic (l_feat_count)
--				l_class := icd_string_instance.get_class
--				if l_class /= Void then
--					l_icd_value := icd_string_instance.get_field_value (l_class, l_feat_count_token)
--					if l_icd_value /= Void then
--						Result := edv_formatter.icor_debug_value_to_integer (l_icd_value)
--						l_icd_value.clean_on_dispose
--					end
--				end
--			end
--		end

	icd_string_value_from_string_class_value (sc: CLASS_C; icd_string_instance_ref: ICOR_DEBUG_VALUE; icd_string_instance: ICOR_DEBUG_OBJECT_VALUE): ICOR_DEBUG_STRING_VALUE
			-- ICorDebugStringValue for `icd_string_instance_ref' (STRING object)
			--| `sc' represents the STRING or STRING_32 class_i
		require
			sc_not_void: sc /= Void
			icd_string_instance_not_void: icd_string_instance /= Void
		local
			l_icd_value: ICOR_DEBUG_VALUE
			l_module: ICOR_DEBUG_MODULE

			l_feat_to_cil: FEATURE_I
			l_feat_to_cil_token: NATURAL_32
			l_function_to_cil: ICOR_DEBUG_FUNCTION
		do
				--| Get STRING info from compilo
				--| Get token to access `to_cil'
			l_feat_to_cil := sc.feature_named_32 ("to_cil")

			if l_feat_to_cil /= Void then
				l_feat_to_cil_token := Il_debug_info_recorder.feature_token_for_non_generic (l_feat_to_cil)
				if l_feat_to_cil_token > 0 then
					l_module := icor_debug_module_for_class (l_feat_to_cil.written_class)
					if l_module /= Void then
						l_function_to_cil := l_module.get_function_from_token (l_feat_to_cil_token)
						if l_function_to_cil /= Void then
							l_icd_value := eifnet_dbg_evaluator.function_evaluation (Void, l_function_to_cil, <<icd_string_instance_ref>>)
							if eifnet_dbg_evaluator.last_eval_is_exception and l_icd_value /= Void then
								l_icd_value.clean_on_dispose
								l_icd_value := Void
							end
								--| l_icd_value represents the `System.String' value
							if l_icd_value /= Void then
								Result := edv_formatter.icor_debug_string_value (l_icd_value)
								l_icd_value.clean_on_dispose
							end
						end
					end
				end
			end
		end

	last_string_value_length: INTEGER
			-- Last length of the Result from `string_value_from_string_class_object_value'

	string_value_from_string_class_value (
				sc: CLASS_C;
				icd_string_instance_ref: ICOR_DEBUG_VALUE; icd_string_instance: ICOR_DEBUG_OBJECT_VALUE;
				min, max: INTEGER): detachable STRING_32
			-- STRING value for `icd_string_instance' with limits `min, max'
			-- precise in `sc' if this is a STRING, or STRING_32
		local
			l_icd_string_value: ICOR_DEBUG_STRING_VALUE
		do
			last_string_value_length := 0
			if icd_string_instance = Void then
				Result := Void
			else
				l_icd_string_value := icd_string_value_from_string_class_value (sc, icd_string_instance_ref, icd_string_instance)
				if l_icd_string_value /= Void then
					Result := string_value_from_system_string_class_value (l_icd_string_value, min, max)
					l_icd_string_value.clean_on_dispose
				end
			end
		end

	string_value_from_system_string_class_value (icd_string_value: ICOR_DEBUG_STRING_VALUE; min, max: INTEGER): detachable STRING_32
			-- STRING value for `icd_string_instance' with limits `min, max'
		local
			l_size, l_len: NATURAL_32
			l_icd_string_value: ICOR_DEBUG_STRING_VALUE
		do
			last_string_value_length := 0
			l_icd_string_value := icd_string_value
			if l_icd_string_value /= Void then
				l_len := l_icd_string_value.get_length
				if not l_icd_string_value.last_error_was_object_neutered then
					last_string_value_length := l_len.as_integer_32
						--| Be careful, in this context min,max correspond to string starting at position '0'
					if max < 0 then
						l_size := l_len
					else
						l_size := (max + 1).as_natural_32.min (l_len)
					end
					Result := l_icd_string_value.get_string (l_size)
					Result := Result.substring ((min + 1).max (1), l_size.as_integer_32.min (Result.count))
				end
			end
		end

	unneutered_icd_string_value	(a_icd_str: ICOR_DEBUG_STRING_VALUE): ICOR_DEBUG_STRING_VALUE
		require
			a_icd_str_not_void: a_icd_str /= Void
		local
			einfo: EIFNET_DEBUG_VALUE_INFO
		do
			if a_icd_str.strong_reference_value /= Void then
				create einfo.make (a_icd_str.strong_reference_value)
				Result := einfo.interface_debug_string_value
				if einfo.icd_prepared_value /= Void then
					einfo.icd_prepared_value.clean_on_dispose
				end
				einfo.clean
			else
				Result := a_icd_str
			end
		end

 	generating_type_value_from_object_value (a_frame: ICOR_DEBUG_FRAME; a_icd: ICOR_DEBUG_VALUE;
 				a_icd_obj: ICOR_DEBUG_OBJECT_VALUE;
 				a_class_type: CLASS_TYPE; a_feat: FEATURE_I): detachable STRING
			-- ANY.generating_type: STRING evaluation result
		require
			icor_debug_object_value_not_void: a_icd_obj /= Void
		local
			l_icd: ICOR_DEBUG_VALUE
			l_icdov: ICOR_DEBUG_OBJECT_VALUE
			l_icd_class: ICOR_DEBUG_CLASS
			l_icd_module: ICOR_DEBUG_MODULE
			l_module_name: STRING
			l_feature_token: NATURAL_32

			l_class_type: CLASS_TYPE
			l_func: ICOR_DEBUG_FUNCTION

			l_value_info : EIFNET_DEBUG_VALUE_INFO
		do
			check
				running_and_stopped: debugger_manager.safe_application_is_stopped
			end
			debug ("debugger_trace_eval")
				print ("<start> " + generator + ".generating_type_value_from_object_value %N")
			end

-- FIXME jfiat [2004/07/20] : why do we use a_icd as l_icd if failed ?
--			l_icd := a_icd
			l_class_type := a_class_type

			l_icd_class := a_icd_obj.get_class
			if l_icd_class /= Void then
				l_icd_module := l_icd_class.get_module
				l_feature_token := l_icd_module.md_feature_token (l_icd_class.token, a_feat.feature_name) -- resolved {ANY}.generating_type
				l_func := l_icd_module.get_function_from_token (l_feature_token)
			end

			if l_func /= Void then
				l_icd := eifnet_dbg_evaluator.function_evaluation (a_frame, l_func, <<a_icd>>)
				if eifnet_dbg_evaluator.last_eval_is_exception and l_icd /= Void then
					l_icd.clean_on_dispose
					l_icd := Void
				end
				if l_icd /= Void then
					create l_value_info.make (l_icd)
					l_icdov := l_value_info.new_interface_debug_object_value
					if l_icdov /= Void then
							--| the result should be a STRING instance
						if attached string_value_from_string_class_value (debugger_manager.compiler_data.string_8_class_c, l_icd, l_icdov, 0, -1) as l_s32 then
							Result := l_s32.to_string_8
						end
						l_icdov.clean_on_dispose
					end
					l_value_info.icd_prepared_value.clean_on_dispose
					l_value_info.clean
					l_icd.clean_on_dispose
				else
					Result := Void -- "WARNING: Could not evaluate output"
				end
			else
				debug ("DEBUGGER_TRACE_EVAL")
					l_module_name := l_icd_module.name

					print ("EIFNET_DEBUGGER.generating_type_.. :: Unable to retrieve ICorDebugFunction %N")
					print ("                                :: class name    = [" + l_class_type.full_il_type_name + "]%N")
					print ("                                :: module_name   = %"" + l_module_name + "%"%N")
					print ("                                :: feature_token = 0x" + l_feature_token.to_hex_string + " %N")
				end
			end
			debug ("debugger_trace_eval")
				if Result = Void then
					print (l_class_type.full_il_type_name + ".generating_type.. :: Error ! %N")
				end
				print ("<stop> " + generator + ".generating_type_value_from_object_value %N")
			end
		end

 	debug_output_value_from_object_value (a_frame: ICOR_DEBUG_FRAME; a_icd: ICOR_DEBUG_VALUE;
 				a_icd_obj: ICOR_DEBUG_OBJECT_VALUE; a_class_type: CLASS_TYPE;
 				min,max: INTEGER): STRING_32
			-- Debug ouput string value
		local
			l_icd: ICOR_DEBUG_VALUE
			l_icdov: ICOR_DEBUG_OBJECT_VALUE
			l_icd_class: ICOR_DEBUG_CLASS
			l_icd_module: ICOR_DEBUG_MODULE
			l_feature_token: NATURAL_32
			l_feat: FEATURE_I
			l_class_type: CLASS_TYPE
			l_func: ICOR_DEBUG_FUNCTION
			l_value_info : EIFNET_DEBUG_VALUE_INFO
		do
			check
				running_and_stopped: debugger_manager.safe_application_is_stopped
			end
-- FIXME jfiat [2004/07/20] : Why do we set l_icd as a_icd ... this is not what we want, check it
--			l_icd := a_icd
			debug ("debugger_trace_eval")
				print ("<start> "+ generator + ".debug_output_value_from_object_value %N")
			end

			l_class_type := a_class_type
			l_feat := debug_output_feature_i (l_class_type.associated_class)
			if l_feat /= Void then
				l_icd_class := a_icd_obj.get_class
				if l_icd_class /= Void then
					l_icd_module := l_icd_class.get_module
					l_feature_token := Il_debug_info_recorder.feature_token_for_feat_and_class_type (l_feat, l_class_type)
					if l_feat.is_attribute then
						l_icd := a_icd_obj.get_field_value (l_icd_class, l_feature_token)
					else
						if l_feature_token = 0 then
							l_func := eiffel_icd_function_by_name (l_class_type, l_feat.feature_name)
						else
							l_func := l_icd_module.get_function_from_token (l_feature_token)
						end
						if l_func /= Void then
							l_icd := eifnet_dbg_evaluator.function_evaluation (a_frame, l_func, <<a_icd>>)
							if eifnet_dbg_evaluator.last_eval_is_exception and l_icd /= Void then
								l_icd.clean_on_dispose
								l_icd := Void
							end
						else
							debug ("DEBUGGER_TRACE_EVAL")
								print ("EIFNET_DEBUGGER.debug_output_.. :: Unable to retrieve ICorDebugFunction %N")
								print ("                                :: class name    = [" + l_class_type.full_il_type_name + "]%N")
								print ("                                :: module_name   = %"" + l_icd_module.name + "%"%N")
								print ("                                :: feature_token = 0x" + l_feature_token.to_hex_string + " %N")
							end
						end
					end
				end
				if l_icd /= Void then
					create l_value_info.make (l_icd)
					l_icdov := l_value_info.new_interface_debug_object_value
					if l_icdov /= Void then
							--| This is a STRING instance
						Result := string_value_from_string_class_value (debugger_manager.compiler_data.string_8_class_c, l_icd, l_icdov, min, max)
						l_icdov.clean_on_dispose
					end
					l_value_info.icd_prepared_value.clean_on_dispose
					l_value_info.clean
					l_icd.clean_on_dispose
				else
					Result := Void -- "WARNING: Could not evaluate output"	
				end
			else
				debug ("DEBUGGER_TRACE_EVAL")
					print ("EIFNET_DEBUGGER.debug_output_.. :: Unable to retrieve FEATURE_I ["
						+ l_class_type.associated_class.name_in_upper
						+"] %N")
				end
			end
			debug ("debugger_trace_eval")
				if Result = Void then
					print ("EIFNET_DEBUGGER.debug_output_.. :: Error: non debuggable ! %N")
				end
				print ("<stop> "+ generator + ".debug_output_value_from_object_value %N")
			end
		end

 	to_string_value_from_exception_object_value (a_frame: ICOR_DEBUG_FRAME; a_icd: ICOR_DEBUG_VALUE; a_icd_obj: ICOR_DEBUG_OBJECT_VALUE): STRING_32
			-- System.Exception.ToString value
		local
			l_icd: ICOR_DEBUG_VALUE
			l_icdov: ICOR_DEBUG_OBJECT_VALUE
			l_icd_class: ICOR_DEBUG_CLASS
			l_icd_module: ICOR_DEBUG_MODULE
			l_module_name: STRING
			l_feature_token: NATURAL_32
			l_func: ICOR_DEBUG_FUNCTION
			l_debug_info : EIFNET_DEBUG_VALUE_INFO
		do
			debug ("debugger_trace_eval")
				print ("<start> " + generator + ".to_string_value_from_exception_object_value %N")
			end

-- FIXME jfiat [2004/07/20] : why do we use a_icd as l_icd if failed ?
--			l_icd := a_icd
			l_icd_class := a_icd_obj.get_class
			if l_icd_class /= Void then
				l_icd_module := l_icd_class.get_module
				l_module_name := l_icd_module.name

				l_feature_token := Edv_external_formatter.token_Exception_ToString
				l_func := l_icd_module.get_function_from_token (l_feature_token)

				if l_func /= Void then
					l_icd := eifnet_dbg_evaluator.function_evaluation (a_frame, l_func, <<a_icd>>)
					if eifnet_dbg_evaluator.last_eval_is_exception and l_icd /= Void then
						l_icd.clean_on_dispose
						l_icd := Void
					end
					if l_icd /= Void then
							--| We should get a System.String
						create l_debug_info.make (l_icd)
						l_icdov := l_debug_info.new_interface_debug_object_value
						if l_icdov /= Void then
							Result := Edv_external_formatter.system_string_value_to_string (l_icdov)
							l_icdov.clean_on_dispose
						end
						l_debug_info.icd_prepared_value.clean_on_dispose
						l_debug_info.clean
						l_icd.clean_on_dispose
--					else
--						Result := Void -- "WARNING: Could not evaluate output"	
					end
				end
--			else
--				Result := Void -- "WARNING: Could not evaluate output"	
			end

			debug ("debugger_trace_eval")
				print ("<stop> " + generator + ".to_string_value_from_exception_object_value %N")
			end
		end

 	get_message_value_from_exception_object_value (a_frame: ICOR_DEBUG_FRAME; a_icd: ICOR_DEBUG_VALUE; a_icd_obj: ICOR_DEBUG_OBJECT_VALUE): STRING_32
			-- System.Exception.ToString value
		local
			l_icd: ICOR_DEBUG_VALUE
			l_icd_module: ICOR_DEBUG_MODULE
			l_feature_token: NATURAL_32
			l_func: ICOR_DEBUG_FUNCTION
			l_debug_info : EIFNET_DEBUG_VALUE_INFO
			l_icdov: ICOR_DEBUG_OBJECT_VALUE
		do
			debug ("debugger_trace_eval")
				print ("<start> " + generator + ".get_message_value_from_exception_object_value %N")
			end
-- FIXME jfiat [2004/07/20] : why do we use a_icd as l_icd if failed ?
--			l_icd := a_icd
			l_icd_module := info.icor_debug_module_for_mscorlib
			l_feature_token := Edv_external_formatter.token_Exception_get_Message
			l_func := l_icd_module.get_function_from_token (l_feature_token)
			if l_func /= Void then
				l_icd := eifnet_dbg_evaluator.function_evaluation (a_frame, l_func, <<a_icd>>)
				if eifnet_dbg_evaluator.last_eval_is_exception and l_icd /= Void then
					l_icd.clean_on_dispose
					l_icd := Void
				end
				if l_icd /= Void then
						--| We should get a System.String
					create l_debug_info.make (l_icd)
					l_icdov := l_debug_info.new_interface_debug_object_value
					if l_icdov /= Void then
						Result := Edv_external_formatter.system_string_value_to_string (l_icdov)
						l_icdov.clean_on_dispose
					end
					l_debug_info.icd_prepared_value.clean_on_dispose
					l_debug_info.clean
					l_icd.clean_on_dispose
				else
					Result := Void -- "WARNING: Could not evaluate output"	
				end
			end
			debug ("debugger_trace_eval")
				print ("<stop> " + generator + ".get_message_value_from_exception_object_value %N")
			end
		end

	once_function_data (a_icd_frame: ICOR_DEBUG_FRAME; a_class_c: CLASS_C;
								a_feat: FEATURE_I): TUPLE [called: BOOLEAN; exc: ICOR_DEBUG_VALUE; res: ICOR_DEBUG_VALUE]
			-- ICorDebugValue object representing the once value.
			-- This will also set `last_once_available' and `last_once_failed'.
		require
			a_class_c_not_void: a_class_c /= Void
			a_feat_not_void: a_feat /= Void
			a_feat.is_process_or_thread_relative_once
		local
			l_once_info_tokens: TUPLE [cl: NATURAL_32; done: NATURAL_32; res: NATURAL_32; ex: NATURAL_32]
			l_data_class_token, l_done_token, l_result_token, l_exception_token: NATURAL_32
			l_icd_debug_value: ICOR_DEBUG_VALUE
			l_prepared_icd_debug_value: ICOR_DEBUG_VALUE
			l_once_not_available: BOOLEAN
			l_icd_frame: detachable ICOR_DEBUG_FRAME
			l_data_icd_class: ICOR_DEBUG_CLASS
			l_icd_module: ICOR_DEBUG_MODULE
			l_once_available, l_once_already_called, l_once_failed: BOOLEAN
			exc, res: ICOR_DEBUG_VALUE
		do
				--| Set related frame
			if a_icd_frame = Void and then icor_debug_thread /= Void then
					--| just in case icd_frame is not set
				l_icd_frame := current_stack_icor_debug_frame
			else
				l_icd_frame := a_icd_frame
			end

				--| Get related tokens
			l_once_info_tokens := Il_debug_info_recorder.once_feature_tokens_for_feat_and_class (a_feat, a_class_c)
			if l_once_info_tokens /= Void then
				l_data_class_token := l_once_info_tokens.cl
				l_done_token := l_once_info_tokens.done
				l_result_token := l_once_info_tokens.res
				l_exception_token := l_once_info_tokens.ex
			end

				--| Get ICorDebugClass
			if l_data_class_token /= 0 then
				l_icd_module := icor_debug_module_for_class (a_class_c)
				l_data_icd_class := l_icd_module.get_class_from_token (l_data_class_token)
			end

				--| Check if already called (_done)
			if
				l_data_icd_class /= Void
				and then l_done_token /= 0
				and then l_icd_frame /= Void
			then
				l_icd_debug_value := l_data_icd_class.get_static_field_value (l_done_token, l_icd_frame)
				if l_icd_debug_value /= Void then
					l_prepared_icd_debug_value := Edv_formatter.prepared_debug_value (l_icd_debug_value)
					l_once_already_called := Edv_formatter.prepared_icor_debug_value_as_boolean (l_prepared_icd_debug_value)
					if l_prepared_icd_debug_value /= l_icd_debug_value then
						l_prepared_icd_debug_value.clean_on_dispose
					end
					l_icd_debug_value.clean_on_dispose
				else
					if l_data_icd_class.last_error_code = {ICOR_DEBUG_API_ERROR_CODE_FORMATTER}.cordbg_e_class_not_loaded then
						l_once_already_called := False
					else
						l_once_not_available := True
					end
				end
			else
				l_once_not_available := True
			end

				--| if already called then get the value (_result)
			if l_once_not_available then
				l_once_available := False
			else
				check l_icd_frame /= Void end
				l_once_available := True
				if l_once_already_called then
					l_once_already_called := True
					l_icd_debug_value := l_data_icd_class.get_static_field_value (l_exception_token, l_icd_frame)
					if l_icd_debug_value /= Void then
						l_prepared_icd_debug_value := Edv_formatter.prepared_debug_value (l_icd_debug_value)
						l_once_failed := not Edv_formatter.prepared_icor_debug_value_is_null (l_prepared_icd_debug_value)
						if l_prepared_icd_debug_value /= l_icd_debug_value then
							l_prepared_icd_debug_value.clean_on_dispose
						end
						if l_once_failed then
							exc := l_icd_debug_value
						else
							l_icd_debug_value.clean_on_dispose
						end
					elseif l_data_icd_class.last_error_code = {ICOR_DEBUG_API_ERROR_CODE_FORMATTER}.cordbg_e_static_var_not_available then
						debug ("refactor_fixme")
							fixme ("[
										JFIAT: in this case, the once data about exception is not initialized yet.
										So there is no exception and no result yet.
										What is the status of the once ... not yet called, or called ?
										There should be a status .... is being called
										]")
						end
					else
						l_once_failed := True
					end

					if
						(a_feat.is_function or a_feat.is_constant)
						and then not l_once_failed
						and then l_result_token /= 0
					then
						res := l_data_icd_class.get_static_field_value (l_result_token, l_icd_frame)
					end
				else
					l_once_already_called := False
				end
			end
			if l_once_available then
				Result := [l_once_already_called, exc, res]
			end
		end

	object_relative_once_function_data (a_icd_frame: ICOR_DEBUG_FRAME; a_addr: DBG_ADDRESS; a_class_c: CLASS_C; a_feat: FEATURE_I): TUPLE [called: BOOLEAN; exc: ICOR_DEBUG_VALUE; res: ICOR_DEBUG_VALUE]
			-- Data representing the once per object's values.
		require
			a_class_c_not_void: a_class_c /= Void
			a_feat_not_void: a_feat /= Void
			a_feat_is_object_relative_once: a_feat.is_object_relative_once
		local
			l_once_info_tokens: TUPLE [cl: NATURAL_32; done: NATURAL_32; res: NATURAL_32; ex: NATURAL_32]
			l_data_class_token, l_done_token, l_result_token, l_exception_token: NATURAL_32
			l_prepared_icd_debug_value: ICOR_DEBUG_VALUE
			l_once_already_called: BOOLEAN
			l_once_not_available: BOOLEAN
			l_once_exc, l_once_res: detachable ICOR_DEBUG_VALUE
			l_icd_frame: ICOR_DEBUG_FRAME
			l_data_icd_class: ICOR_DEBUG_CLASS
			l_icd_module: ICOR_DEBUG_MODULE
			v: ABSTRACT_DEBUG_VALUE
			l_icdv_tmp, l_prepared_icdv_tmp: detachable ICOR_DEBUG_VALUE
		do
				--| Set related frame
			if a_icd_frame = Void and then icor_debug_thread /= Void then
					--| just in case icd_frame is not set
				l_icd_frame := current_stack_icor_debug_frame
			else
				l_icd_frame := a_icd_frame
			end

				--| Get related tokens
			l_once_info_tokens := Il_debug_info_recorder.once_feature_tokens_for_feat_and_class (a_feat, a_class_c)
			if l_once_info_tokens /= Void then
				l_data_class_token := l_once_info_tokens.cl
				l_done_token := l_once_info_tokens.done
				l_result_token := l_once_info_tokens.res
				l_exception_token := l_once_info_tokens.ex
			end

				--| Get ICorDebugClass
			if l_data_class_token /= 0 then
				l_icd_module := icor_debug_module_for_class (a_class_c)
				l_data_icd_class := l_icd_module.get_class_from_token (l_data_class_token)
			end

			if
				l_data_icd_class /= Void
				and then l_done_token /= 0
				and then l_icd_frame /= Void
			then
				if know_about_kept_object (a_addr) then
					v := kept_object_item (a_addr)
					if
						attached {EIFNET_ABSTRACT_DEBUG_VALUE} v as dv and then
						attached dv.icd_value as icdv and then not icdv.is_null_reference
					then
						l_prepared_icd_debug_value := Edv_formatter.prepared_debug_value (icdv)
						if attached l_prepared_icd_debug_value.query_interface_icor_debug_object_value as icdov then
							l_icdv_tmp := icdov.get_field_value (l_data_icd_class, l_done_token)
							if l_icdv_tmp /= Void then
								l_prepared_icdv_tmp := edv_formatter.prepared_debug_value (l_icdv_tmp)
								l_once_already_called := edv_formatter.prepared_icor_debug_value_as_boolean (l_prepared_icdv_tmp)
								if l_prepared_icdv_tmp /= l_icdv_tmp then
									l_prepared_icdv_tmp.clean_on_dispose
								end
								l_icdv_tmp.clean_on_dispose
								if l_once_already_called then
									l_icdv_tmp := icdov.get_field_value (l_data_icd_class, l_exception_token)
									if l_icdv_tmp /= Void then
										l_prepared_icdv_tmp := edv_formatter.prepared_debug_value (l_icdv_tmp)
										if not l_prepared_icdv_tmp.is_null_reference then
											l_once_exc := l_icdv_tmp--l_prepared_icdv_tmp
										else
											if l_prepared_icdv_tmp /= l_icdv_tmp then
												l_prepared_icdv_tmp.clean_on_dispose
											end
										end
									end
									if l_once_exc = Void and then a_feat.has_return_value then
										l_icdv_tmp := icdov.get_field_value (l_data_icd_class, l_result_token)
										if l_icdv_tmp /= Void then
											l_prepared_icdv_tmp := edv_formatter.prepared_debug_value (l_icdv_tmp)
											if not l_prepared_icd_debug_value.is_null_reference then
												l_once_res := l_icdv_tmp--l_prepared_icdv_tmp
											else
												if l_prepared_icdv_tmp /= l_icdv_tmp then
													l_prepared_icdv_tmp.clean_on_dispose
												end
											end
										end
									end
								end
							end
							icdov.clean_on_dispose
						else
							l_once_not_available := True
						end
						if l_prepared_icd_debug_value /= icdv then
							l_prepared_icd_debug_value.clean_on_dispose
						end
					else
						l_once_not_available := True
					end
				end
			else
				l_once_not_available := True
			end

			if not l_once_not_available then
				Result := [l_once_already_called, l_once_exc, l_once_res]
			end

			debug ("debugger_trace_eval")
				print ("Last once feature          = " + a_class_c.name_in_upper + "." + a_feat.feature_name + "%N")
				print ("  last_once_already_called = " + l_once_already_called.out + "%N")
				print ("  last_once_available      = " + (not l_once_not_available).out + "%N")
				print ("  last_once_failed         = " + (l_once_exc /= Void).out + "%N")
			end
		end

--| NOTA jfiat [2004/03/19] : not yet ready, to be continued
--
--feature -- GC related
--
--	keep_alive (addr: DBG_ADDRESS) is
--		local
--			l_icdv: ICOR_DEBUG_VALUE
--		do
--			l_icdv := dbg_evaluator.icd_value_by_address (addr)
--			keep_icdv_alive (l_icdv)
--		end
--		
--	keep_icdv_alive (icdv: ICOR_DEBUG_VALUE) is
--		require
--			icdv_not_void: icdv /= Void
--		local
--			l_icdm: ICOR_DEBUG_MODULE
--			l_md_import: MD_IMPORT
--			l_gc_class_token: NATURAL_32
--			l_meth_token: NATURAL_32
--			l_icdf: ICOR_DEBUG_FUNCTION
--		do
--			l_icdm := info.icor_debug_module_for_mscorlib
--			l_md_import := l_icdm.interface_md_import
--			l_gc_class_token := l_md_import.find_type_def_by_name ("System.GC", 0)
--			l_meth_token := l_md_import.find_method (l_gc_class_token, "KeepAlive")
--			l_icdf := l_icdm.get_function_from_token (l_meth_token)
--			eifnet_dbg_evaluator.method_evaluation (active_frame, l_icdf, <<icdv>>)
--		end

--feature -- Debugging purpose
--
--	dbg_icd_value_to_string (a_icd: ICOR_DEBUG_VALUE): STRING_32 is
--			-- System.Object.ToString value
--			-- Debugging purpose !!!
--		local
--			l_icd: ICOR_DEBUG_VALUE
--			l_icdov: ICOR_DEBUG_OBJECT_VALUE
--			l_icd_class: ICOR_DEBUG_CLASS
--			l_icd_module: ICOR_DEBUG_MODULE
--			l_module_name: STRING
--			l_func: ICOR_DEBUG_FUNCTION
--			l_debug_info : EIFNET_DEBUG_VALUE_INFO
--		do
--			l_icdov := edv_formatter.prepared_debug_value (a_icd).query_interface_icor_debug_object_value
--			l_icd_class := l_icdov.get_class
--			if l_icd_class /= Void then
--				l_icd_module := l_icd_class.get_module
--				l_module_name := l_icd_module.get_name
--
--				l_func := icd_function_by_name (l_icd_module, l_icd_class.get_token, "ToString")
--				if l_func /= Void then
--					l_icd := eifnet_dbg_evaluator.function_evaluation (Void, l_func, <<a_icd>>)
--					if eifnet_dbg_evaluator.last_eval_is_exception and l_icd /= Void then
--						l_icd.clean_on_dispose
--						l_icd := Void
--					end
--					if l_icd /= Void then
--							--| We should get a System.String
--						create l_debug_info.make (l_icd)
--						l_icdov := l_debug_info.new_interface_debug_object_value
--						if l_icdov /= Void then
--							Result := Edv_external_formatter.system_string_value_to_string (l_icdov)
--							l_icdov.clean_on_dispose
--						end
--						l_debug_info.icd_prepared_value.clean_on_dispose
--						l_debug_info.clean
--						l_icd.clean_on_dispose
--					end
--				end
--			end
--		end
--

feature -- Bridge to debug_value_keeper

	keep_only_objects (a_addresses: LIST [DBG_ADDRESS])
			-- Remove all ref kept, and keep only the ones contained in `a_addresses'
		do
			Debug_value_keeper.keep_only (a_addresses)
		end

	kept_object_item (a_address: DBG_ADDRESS): ABSTRACT_DEBUG_VALUE
			-- Keep this object addressed by `a_address'
		require
			know_about_object: know_about_kept_object (a_address)
		do
			Result := Debug_value_keeper.item (a_address)
		end

	know_about_kept_object (a_address: DBG_ADDRESS): BOOLEAN
			-- Do we have a reference for the object addressed by `a_address' ?
		do
			Result := Debug_value_keeper.know_about (a_address)
		end

feature -- Bridge

	edv_external_formatter: EIFNET_DEBUG_EXTERNAL_FORMATTER

	eifnet_dbg_evaluator: EIFNET_DEBUGGER_EVALUATOR
			-- Dotnet function evaluator

feature {NONE} -- External

	Infinite_time: INTEGER = 0xFFFFFFFF;
			-- Value for C externals to have an infinite wait

note
	copyright:	"Copyright (c) 1984-2020, Eiffel Software"
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

end
