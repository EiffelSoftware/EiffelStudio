indexing
	description: "Interface to access dotnet debugger services"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	author: "$Author$"
	date: "$Date$"
	revision: "$Revision$"

class
	EIFNET_DEBUGGER

inherit

	WEL_PROCESS_LAUNCHER

	EIFNET_DEBUGGER_INFO_ACCESSOR
		export
			{NONE} Eifnet_debugger_info
		end

	SHARED_ICOR_OBJECTS_MANAGER

	SHARED_DEBUG_VALUE_KEEPER

	SHARED_DBG_EVALUATOR
		export
			{NONE} all
		end

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

	SHARED_DEBUG
		export
			{NONE} all
		end

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

	SHARED_TYPE_I
		export
			{NONE} all
		end

create
	make

feature {EIFNET_EXPORTER} -- refact

	info: EIFNET_DEBUGGER_INFO is
			-- Restricted access to Eifnet_debugger_info
		do
			Result := Eifnet_debugger_info
		end

feature -- Initialization

	make is
			-- Creation
		do
			debug ("debugger")
				print ("call " + generator + ".make%N")
			end
		end

	init is
			-- Initialize current object
		do
			debug ("debugger")
				print ("call " + generator + ".init%N")
			end
		end

	create_icor_debug is
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

	initialize_clr_host is
			-- Initialize dotnet runtime, to be sure to use the correct version of the
			-- runtime after while
		local
			l_host: CLR_HOST
		once
			(create {CLI_COM}).initialize_com
			l_host := (create {CLR_HOST_FACTORY}).runtime_host (Eiffel_system.System.clr_runtime_version)
		end

	init_debugging_data is
		do
			debug_value_keeper.initialize
			if eifnet_dbg_evaluator = Void then
				create eifnet_dbg_evaluator.make (Current)
			end
--			Eifnet_debugger_info.set_debugger (Current)
		end

	reset_debugging_data is
				-- Reset objects who has session related data
		do
			reset_exception_info
			reset_dbg_evaluator
			reset_info
			exit_process_occurred := False

			il_debug_info_recorder.reset_debugging_live_data
			debug_value_keeper.terminate
				-- not required
			last_dbg_call_success := 0
			last_string_value_length := 0
--			context_output_tool := Void
		ensure
			not is_inside_function_evaluation
		end

	recycle_debug_value_keeper is
		do
			Debug_value_keeper.recycle
		end

	initialize_debugger_session (a_wel_item_pointer: POINTER) is
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

feature -- Termination monitoring ...

	timer_monitor_process_termination_on_exit: EV_TIMEOUT
			-- Timer used to check if debugging is finished.

	create_monitoring_of_process_termination_on_exit is
			-- Create and start the timer to check if the debugging is done
		require
			timer_void: timer_monitor_process_termination_on_exit = Void
		do
			create timer_monitor_process_termination_on_exit.make_with_interval (1000)
			timer_monitor_process_termination_on_exit.actions.extend (agent monitor_process_termination_on_exit)
		end

	destroy_monitoring_of_process_termination_on_exit is
			-- Destroy and clean timer
		do
			if timer_monitor_process_termination_on_exit /= Void then
				timer_monitor_process_termination_on_exit.destroy
				timer_monitor_process_termination_on_exit := Void
			end
		end

	monitor_process_termination_on_exit is
			-- Check if the debugging is done and continue the termination
		do
			if
				timer_monitor_process_termination_on_exit /= Void
				and then exit_process_occurred
				and then not is_dbg_synchronizing
			then
				destroy_monitoring_of_process_termination_on_exit
				--FIXME JFIAT:  try to reuse timer object !
				Application.process_termination

				--| else This means, Process_termination had already been called (from kill)
			end
		end

feature -- Debugging session Termination ...

	terminate_debugger_session is
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

	terminate_debugging is
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
fixme ("[jfiat] : check if we shoudln't Continue .. to get the ExitProcess ...")
				if not l_controller.last_call_succeed then
					--| the end of the killing process will be done on callback ExitProcess
					--| Maybe try with no Stop (..)
					--} but use violent .. ::TerminateProcess ...
					if icor_debug_process /= Void then
						l_pro_hdl := icor_debug_process.get_handle
					else
						l_pro_hdl := icor_debug.last_icor_debug_process_handle
					end
					l_success := cwin_terminate_process (l_pro_hdl, 0)
				end
					-- FIXME jfiat [2004/07/30] : check if this is not too violent ?
					-- maybe we could find a smarter way to terminate debugging synchronisation
fixme ("[jfiat] : check if this is not too violent, maybe use ExitProcess")
				terminate_debugger_session
				notify_exit_process_occurred
			else
				eif_debug_display ("[EIFDBG] could not find ICorDebugController object ...")
				notify_exit_process_occurred
				on_exit_process
			end
		end

	on_exit_process	is
			-- On ExitProcess callback
		do
			eif_debug_display ("[EIFDBG] execution exiting")
			terminate_debugger_session
		ensure
			not is_debugging
		end

	notify_exit_process_occurred is
			-- Notify callback `ExitProcess' occurred
		do
			exit_process_occurred := True
		end

feature {NONE} -- Logging

--	context_output_tool: EB_OUTPUT_TOOL
--			-- Context's output tool.

	debugger_message (m: STRING) is
			-- Put message on context tool's output
		do
			Application.debugger_manager.debugger_message (m)
--			if context_output_tool /= Void then
--				create st.make
--				st.add_string (m)
--				st.add_new_line
--				context_output_tool.process_text (st)
--				context_output_tool.scroll_to_end
--			end
		end

feature -- Status

	last_dbg_call_success: INTEGER
			-- Last return call success code.

	last_dbg_call_succeed: BOOLEAN is
			-- Last call succeed ?
		do
			Result := (last_dbg_call_success = 0)
			exception_info_retrieved := False
		end

feature {EIFNET_DEBUGGER} -- Callback notification about synchro

	dbgsync_cb_without_stopping : BOOLEAN
			-- Do we continue the execution without stopping ?

	on_estudio_callback_just_arrived (cb_id: INTEGER) is
		do
			set_last_managed_callback (cb_id)
		end

	estudio_callback_event_processing: BOOLEAN

	estudio_callback_event (cb_id: INTEGER) is
			-- Callback trigger for processing at end of dotnet callback
		require else
			not estudio_callback_event_processing
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
				eifnet_debugger_info.set_last_icd_breakpoint (Default_pointer)
				eifnet_debugger_info.set_last_icd_exception (Default_pointer)
				reset_exception_info
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
					s := Application.status
					s.set_is_stopped (execution_stopped)
					if managed_callback_is_exit_process (cb_id) then
						debug ("debugger_trace_callback")
							print (" - Info : ExitProcess occurred %N")
						end
					else
--| commented, since it shouldn't be useful anymore to do that						
--						s.set_thread_ids (eifnet_debugger_info.loaded_managed_threads_ids)
						s.set_current_thread_id (eifnet_debugger_info.last_icd_thread_id)
					end
					debug ("debugger_trace_callback")
						print (" - Info : Debuggee is STOPPED %N")
					end
				else
					debug ("debugger_trace_callback")
						print (" - Info : Debuggee is RUNNING %N")
					end
				end
				if not next_estudio_notification_disabled then
					Application.imp_dotnet.estudio_callback_notify
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

	consume_managed_callback_info (cb_id: INTEGER) is
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
					io.error.put_string ((create {ICOR_DEBUG_APP_DOMAIN}.make_by_pointer (p)).get_name + "%N")
				end
				r := {ICOR_DEBUG_APP_DOMAIN}.cpp_is_attached (p, $i)
				if not i.to_boolean then
						--| This should be done on the callback event
						--| but in case this is not done, let's do it
					r := {ICOR_DEBUG_APP_DOMAIN}.cpp_attach (p)
					check (r = 0) end
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
				Eifnet_debugger_info.notify_debugger_error (r, i)

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
					if eifnet_debugger_info.last_exception_is_handled then
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
				fixme ("jfiat: Maybe we should use p_process to set the controller ...")

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

			when Cst_managed_cb_load_module then
					--| p_app_domain, p_module
				p := dbg_cb_info_pointer_item (1) -- p_app_domain
				set_last_controller_by_pointer (icor_debug_controller_interface (p))
				p := dbg_cb_info_pointer_item (2) -- p_module
				if p /= Default_pointer then
					l_module := Icor_objects_manager.icd_module (p)
					debug ("debugger_trace_callback_data")
						io.error.put_string ("Loading module : " + l_module.get_name + "%N")
					end
					Eifnet_debugger_info.register_new_module (l_module)
					debugger_message ("Load module : " + l_module.module_name)
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
				set_last_controller_by_pointer (icor_debug_controller_interface (p))
				p := dbg_cb_info_pointer_item (2) -- p_thread
				if p /= Default_pointer then
					set_last_thread_by_pointer (p)
				end

			when Cst_managed_cb_step_complete then
					--|	p_app_domain, p_thread, p_stepper, a_reason				
				p := dbg_cb_info_pointer_item (1) -- p_app_domain
				set_last_controller_by_pointer (icor_debug_controller_interface (p))
				p := dbg_cb_info_pointer_item (2) -- p_thread
				set_last_thread_by_pointer (p)
				i := dbg_cb_info_integer_item (4) -- a_reason
				set_last_step_complete_reason (i)

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

	is_inside_function_evaluation: BOOLEAN is
			-- Is the current context correspond to a function evaluation ?
		do
			Result := Eifnet_debugger_info.is_evaluating
		end

feature {NONE} -- Callback actions

	icor_debug_controller_interface (p_controller: POINTER): POINTER is
			-- Computed ICorDebugController interface from a Process or AppDomain pointer.
		local
			p_process: POINTER
			p_app_domain: POINTER
			l_hr: INTEGER
			n: INTEGER
		do
			if p_controller /= Default_pointer then
				l_hr := {ICOR_DEBUG_CONTROLLER}.cpp_query_interface_ICorDebugController (p_controller, $Result)
			end
			if l_hr /= 0 then
				l_hr := {ICOR_DEBUG_CONTROLLER}.cpp_query_interface_ICorDebugController (p_controller, $p_app_domain)
				l_hr := {ICOR_DEBUG_APP_DOMAIN}.cpp_get_process (p_app_domain, $p_process)
				Result := p_process
				n := {CLI_COM}.release (p_app_domain)
			end
			n := {CLI_COM}.release (p_controller)
		end

	continue_on_cb (cb_id: INTEGER): BOOLEAN is
			-- Continue witout stopping the system
		do
				--| Let's continue, we don't stop on this callback
			call_do_continue_on_cb
			Result := False
		end

	stop_on_cb (cb_id: INTEGER): BOOLEAN is
			-- Stop the system (on step complete or breakpoint for instance)
		local
			execution_stopped: BOOLEAN
		do
				--| Refresh CallStack info
			if managed_callback_is_exit_process (cb_id) then
				reset_current_callstack
			else
				init_current_callstack
			end
			if managed_callback_is_breakpoint (cb_id) then
				execution_stopped := execution_stopped_on_end_of_breakpoint_callback
			elseif managed_callback_is_step_complete (cb_id) then
				if is_inside_function_evaluation then
					execution_stopped := False
				else
					execution_stopped := execution_stopped_on_end_of_step_complete_callback
				end
			elseif managed_callback_is_exception (cb_id) then
				if is_inside_function_evaluation then
					if icor_debug_controller /= Void then
						call_do_continue_on_cb
					end
					execution_stopped := False
				else
					execution_stopped := execution_stopped_on_exception_callback
				end
			else
					--| Then we stop the execution ;)
					--| do nothing for now
				execution_stopped := True
			end
			Result := execution_stopped
		end

	execution_stopped_on_end_of_breakpoint_callback: BOOLEAN is
			-- Process end_of_breakpoint_callback and then return if is stopped.
		require
			top_callstack_data_initialised: Eifnet_debugger_info.current_callstack_initialized
		do
			if last_control_mode_is_stepping then
				Result := execution_stopped_on_end_of_breakpoint_callback_while_stepping
			else
					--| not stepping, so real breakpoint stopping
				Result := True
			end
		end

	execution_stopped_on_end_of_breakpoint_callback_while_stepping: BOOLEAN is
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
			dbg_info := Eifnet_debugger_info
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

	execution_stopped_on_end_of_step_complete_callback: BOOLEAN is
			-- Process end_of_step_complete_callback and then return if is stopped.
		require
			top_callstack_data_initialised: Eifnet_debugger_info.current_callstack_initialized
		local
			unknown_class_for_call_stack_stop: BOOLEAN
			inside_valid_feature_call_stack_stepping: BOOLEAN
			is_valid_callstack_offset: BOOLEAN
			execution_stopped: like execution_stopped_on_end_of_step_complete_callback

			l_class_token: INTEGER
			l_feat_token: INTEGER

			l_module_name: STRING
			l_current_il_offset: INTEGER
			l_feat: FEATURE_I
			l_class_type: CLASS_TYPE
			l_current_stack_info: EIFNET_DEBUGGER_STACK_INFO
			l_il_debug_info: IL_DEBUG_INFO_RECORDER
			dbg_info: EIFNET_DEBUGGER_INFO
		do
			dbg_info := Eifnet_debugger_info
			l_current_stack_info := dbg_info.current_stack_info
			debug ("debugger_trace_callstack")
				dbg_info.debug_display_current_callstack_info
			end

				--| If we were stepping ...
			debug ("DEBUGGER_TRACE_STEPPING")
				print ("%N>=> StepComplete <=< %N")
				print ("%T - last_control_mode         = "   + dbg_info.last_control_mode_as_string + "%N")
				print ("%T - last_step_complete_reason = 0x" + dbg_info.last_step_complete_reason.to_hex_string)
				print ("  ==> " + step_id_to_string (dbg_info.last_step_complete_reason) + "%N")
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
				l_il_debug_info := Il_debug_info_recorder
				l_class_token := l_current_stack_info.current_class_token
				l_module_name := l_current_stack_info.current_module_name
				check
					module_name_valid: l_module_name /= Void and then not l_module_name.is_empty
				end
				if
					l_module_name /= Void
					and then not l_module_name.is_empty
					and l_class_token > 0
				then
					unknown_class_for_call_stack_stop := not l_il_debug_info.has_class_info_about_module_class_token (l_module_name, l_class_token)
				end
				if unknown_class_for_call_stack_stop then
					debug ("debugger_trace_stepping")
						print ("[!] Unknown Class [0x" + l_class_token.to_hex_string + "] .. we'd better go out to breath %N")
						print ("[!] module = " + l_module_name + "%N")
					end
					call_do_step_out_on_cb
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
							print ("[!] InValid or Unknown feature [0x" + l_class_token.to_hex_string + "::0x" + l_feat_token.to_hex_string + "].%N")
							print ("[!] class = " + l_il_debug_info.class_name_for_class_token_and_module ( l_class_token, l_module_name) + "%N")
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

	execution_stopped_on_exception_callback: BOOLEAN is
		require
			exception_occurred: exception_occurred
		local
			cln: STRING
			l_icd_exception: ICOR_DEBUG_VALUE
			l_exception_info: EIFNET_DEBUG_VALUE_INFO
		do
			if
				application.exceptions_handler.exception_handling_enabled
			then
				l_icd_exception := new_active_exception_value_from_thread
--| Check if we should not use directly the `exception_class_name' feature
--				cln := exception_class_name
				if l_icd_exception /= Void and then l_icd_exception.item /= default_pointer then
					l_icd_exception.add_ref
					create l_exception_info.make (l_icd_exception)
					cln := l_exception_info.value_class_name
					l_exception_info.icd_prepared_value.clean_on_dispose
					l_exception_info.clean
					l_icd_exception.clean_on_dispose
				end
				if cln /= Void then
					Result := application.exceptions_handler.exception_catched_by_name (cln)
				else
					Result := True
				end
			else
				Result := True
			end
			if not Result then
				call_do_continue_on_cb
			end
		end

feature -- Various continuing mode from callback

	call_disable_next_estudio_notification is
			-- In call_back processing, if we continue/step.. right away
			-- we don't need to process estudio_notification
		do
			if not is_inside_function_evaluation then
				disable_next_estudio_notification
			end
		end

	call_terminate_debugging is
			-- If there is no CorDebugController, then we can not continue
			-- thus let's terminate debugging
		do
			debug ("debugger_trace_callstack")
				io.error.put_string ("No ICorDebugController ... going to terminate_debugger ...%N")
			end
			terminate_debugging
		end

	call_do_continue_on_cb is
		do
			if icor_debug_controller /= Void then
				do_continue
				call_disable_next_estudio_notification
			else
				call_terminate_debugging
			end
		end

	call_do_step_range_on_cb (a_bstep_in: BOOLEAN; a_il_ranges: ARRAY [TUPLE [INTEGER, INTEGER]]) is
		do
			if icor_debug_controller /= Void then
				do_step_range (a_bstep_in, a_il_ranges)
				call_disable_next_estudio_notification
			else
				call_terminate_debugging
			end
		end

	call_do_step_out_on_cb is
		do
			if icor_debug_controller /= Void then
				do_step_out
				call_disable_next_estudio_notification
			else
				call_terminate_debugging
			end
		end

	call_do_step_into_on_cb is
		do
			if icor_debug_controller /= Void then
				do_step_into
				call_disable_next_estudio_notification
			else
				call_terminate_debugging
			end
		end

feature -- Interaction with .Net Debugger

	waiting_debugger_callback (a_title: STRING) is
		do
			debug ("debugger_trace_operation")
				print ("%N... Waiting for debugger to callback...%N%N")
			end

			eif_debug_display ("[EIFDBG] " + a_title)
		end

	do_create_process is
			-- Create Process
		local
			l_icd_process: POINTER
			n: INTEGER
		do
			l_icd_process := icor_debug.create_process (debug_param_executable + " " + debug_param_arguments, debug_param_directory)
			if icor_debug.last_call_succeed then
				n := {CLI_COM}.add_ref (l_icd_process)
				set_last_controller_by_pointer (l_icd_process)
				n := {CLI_COM}.release (l_icd_process)
			end
		end

	do_run is
			-- Start the process to debug
		do
			do_create_process
			waiting_debugger_callback ("run process")
			last_dbg_call_success := icor_debug.last_call_success
		end

	do_stop is
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
					print ("Last control mode = " + eifnet_debugger_info.last_control_mode_as_string + "%N")
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

	do_continue is
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

	new_stepper: ICOR_DEBUG_STEPPER is
			-- Retrieve or Create Stepper
			-- Result value is the error code
		local
			edti: EIFNET_DEBUGGER_THREAD_INFO
			thid: INTEGER
		do
			thid := application.status.current_thread_id
			if thid = 0 then
				thid := eifnet_debugger_info.last_icd_thread_id
			end
			edti := eifnet_debugger_info.managed_thread (thid)
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

	do_step (a_mode: INTEGER; a_continue_enabled: BOOLEAN) is
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

	do_step_range (a_bstep_in: BOOLEAN; a_il_ranges: ARRAY [TUPLE [INTEGER, INTEGER]]) is
			-- Step next.
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

	do_global_step_into is
			-- Step next on each thread to stop as soon as possible
			-- Nota: needed for Stop feature
			-- ie: we'll use a stepper for each thread
			-- then the final Continue .. to reach the Step callback
		local
			thid: INTEGER
			tids: ARRAY [INTEGER]
			i: INTEGER
		do
			debug ("debugger_trace_operation")
				print ("[enter] EIFNET_DEBUGGER.do_global_step_into%N")
			end

			thid := application.status.current_thread_id

			tids := eifnet_debugger_info.loaded_managed_threads.current_keys

			from
				i := tids.lower
			until
				i > tids.upper
			loop
				application.status.set_current_thread_id (tids @ i)
				do_step (cst_control_step_into, False)
				i := i + 1
			end
			application.status.set_current_thread_id (thid)
			do_continue
		end

	do_step_next is
			-- Step next.
		do
			debug ("debugger_trace_operation")
				print ("[enter] EIFNET_DEBUGGER.do_step_next%N")
			end
			do_step (cst_control_step_next, True)
			waiting_debugger_callback ("step next")
		end

	do_step_into is
			-- Step in.
		do
			debug ("debugger_trace_operation")
				print ("[enter] EIFNET_DEBUGGER.do_step_into%N")
			end

			do_step (cst_control_step_into, True)
			waiting_debugger_callback ("step into")
		end

	do_step_out is
			-- Step out.
		do
			debug ("debugger_trace_operation")
				print ("[enter] EIFNET_DEBUGGER.do_step_out%N")
			end

			do_step (cst_control_step_out, True)
			waiting_debugger_callback ("step out")
		end

	stepping_possible: BOOLEAN is
			--
		do
			Result := icor_debug_controller /= Void and then icor_debug_thread /= Void
		end

feature -- Debuggee Session Parameters

	debug_param_directory: STRING is
			-- Directory from where the debugger runs the process
		do
			Result := Eifnet_debugger_info.param_directory
		end

	debug_param_executable: STRING is
			-- Filename to the executable to debug
		do
			Result := Eifnet_debugger_info.param_executable
		end

	debug_param_arguments: STRING is
			-- Arguments
		do
			Result := Eifnet_debugger_info.param_arguments
		end

feature -- Change Debuggee Session Parameters

	set_debug_param_directory (a_dir: STRING) is
		do
			Eifnet_debugger_info.set_param_directory (a_dir)
		end

	set_debug_param_executable (a_exec: STRING) is
		do
			Eifnet_debugger_info.set_param_executable (a_exec)
		end

	set_debug_param_arguments (a_arg: STRING) is
		do
			Eifnet_debugger_info.set_param_arguments (a_arg)
		end

feature -- Tracer

	eif_debug_display (msg: STRING) is
		do
		end


feature -- Bridge to EIFNET_DEBUGGER_INFO

	new_active_frame: ICOR_DEBUG_FRAME is
			-- Active Thread value retrieved each call from .Net debugger
		local
			l_last_thread: ICOR_DEBUG_THREAD
		do
			l_last_thread := icor_debug_thread
			if l_last_thread /= Void then
				Result := l_last_thread.get_active_frame
			end
		end

	current_stack_icor_debug_frame: ICOR_DEBUG_FRAME is
			-- Frame related to current call stack.
			-- This is a shared instance, so don't release it unless you know
			-- what you do.
		local
			l_cse: CALL_STACK_ELEMENT_DOTNET
		do
			l_cse ?= application.status.current_call_stack_element
			if l_cse /= Void then
				Result := l_cse.icd_frame
			else
					--| Check if needed |--
				Result := icor_debug_thread.get_active_frame
			end
		end

feature -- Exception

	reset_evaluation_exception is
		do
			eifnet_debugger_info.reset_last_evaluation_icd_exception
		end

	reset_exception_info is
		do
			exception_info_retrieved   := False
			exception_info_to_string   := Void
			exception_info_message     := Void
			exception_info_class_name  := Void
			exception_info_module_name := Void
		end

	exception_info_retrieved: BOOLEAN
			-- Are exception info retrieved ?

	exception_info_to_string: STRING
			-- Exception "ToString" output.

	exception_info_message: STRING
			-- Exception "GetMessage" output.

	exception_info_class_name: STRING
			-- Exception's class name.

	exception_info_module_name: STRING
			-- Exception's module name.

	get_exception_info is
			-- Get `exception_info_to_string' and `exception_info_message'
		require
			exception_occurred: exception_occurred
			exception_not_not_yet_retrieved: not exception_info_retrieved
		local
			retried: BOOLEAN
			l_icd_exception: ICOR_DEBUG_VALUE
			l_exception_info: EIFNET_DEBUG_VALUE_INFO
			l_icdov: ICOR_DEBUG_OBJECT_VALUE
		do
			if not retried then
				reset_exception_info

				l_icd_exception := new_active_exception_value_from_thread
				if
					l_icd_exception /= Void
					and then l_icd_exception.item /= Default_pointer
				then
					l_icd_exception.add_ref
					create l_exception_info.make (l_icd_exception)

					exception_info_class_name := l_exception_info.value_class_name
					exception_info_module_name := l_exception_info.value_module_file_name

					l_icdov := l_exception_info.new_interface_debug_object_value
					if l_icdov /= Void then
						l_icdov.add_ref
						exception_info_to_string := to_string_value_from_exception_object_value (Void,
							l_icd_exception,
							l_icdov
						)
						exception_info_message := get_message_value_from_exception_object_value (Void,
							l_icd_exception,
							l_icdov
						)

						l_icdov.release
						l_icdov.clean_on_dispose

						if exception_info_message = Void then
							--| This could means the prog did exit_process
							--| or .. anything else
							exception_info_message := exception_info_class_name
						end
					end
					l_exception_info.icd_prepared_value.clean_on_dispose
					l_exception_info.clean
					l_icd_exception.clean_on_dispose
				end
			end
			exception_info_retrieved := True
		ensure
			exception_info_retrieved
		rescue
			retried := True
			retry
		end

	exception_text_from (icdv: ICOR_DEBUG_VALUE): STRING is
			-- Get `exception_info_to_string' and `exception_info_message'
		local
			retried: BOOLEAN
			l_exception_info: EIFNET_DEBUG_VALUE_INFO
			l_icdov: ICOR_DEBUG_OBJECT_VALUE
			l_class_name, l_module_name: STRING
			l_to_string, l_message: STRING
		do
			if not retried then
				if
					icdv /= Void
					and then icdv.item /= Default_pointer
				then
					icdv.add_ref
					create l_exception_info.make (icdv)
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

						if l_message = Void then
							--| This could means the prog did exit_process
							--| or .. anything else
							l_message := l_class_name
						end
						Result := l_message.twin
						if l_to_string /= Void then
							Result.append_string ("%N" + l_to_string)
						end
					end
					l_exception_info.icd_prepared_value.clean_on_dispose
					l_exception_info.clean
				end
			end
		rescue
			retried := True
			retry
		end

	exception_occurred: BOOLEAN is
			-- Last callback is about exception ?
		do
			Result := last_managed_callback_is_exception
		end

	active_exception_value: ICOR_DEBUG_VALUE is
			-- Active Exception value retrieved each call from .Net debugger
		do
			Result := eifnet_debugger_info.icd_exception
		end

	new_active_exception_value_from_thread: ICOR_DEBUG_VALUE is
		local
			l_last_thread: ICOR_DEBUG_THREAD
		do
			Result := active_exception_value
			if Result /= Void then
				Result := Result.duplicated_object
			end
			if Result = Void or else Result.item = Default_pointer then
				l_last_thread := icor_debug_thread
				if l_last_thread /= Void then
					Result := l_last_thread.get_current_exception
				end
			end
		end

	exception_class_name: STRING is
			-- Exception's class name.
		require
			exception_occurred: exception_occurred
		do
			if not exception_info_retrieved then
				get_exception_info
			end
			Result := exception_info_class_name
		end

	exception_module_name: STRING is
			-- Exception's module name.
		require
			exception_occurred: exception_occurred
		do
			if not exception_info_retrieved then
				get_exception_info
			end
			Result := exception_info_module_name
		end

	exception_to_string: STRING is
			-- Exception "ToString" output
		require
			exception_occurred: exception_occurred
		do
			if not exception_info_retrieved then
				get_exception_info
			end
			Result := exception_info_to_string
		end

	exception_message: STRING is
			-- Exception "GetMessage" output
		require
			exception_occurred: exception_occurred
		do
			if not exception_info_retrieved then
				get_exception_info
			end
			Result := exception_info_message
		end

feature -- Easy access

	icor_debug_module_for_class (a_class_c: CLASS_C): ICOR_DEBUG_MODULE is
		require
			arg_class_c_not_void: a_class_c /= Void
		local
			l_class_module_name: STRING
		do
			l_class_module_name := Il_debug_info_recorder.module_file_name_for_class (a_class_c)
			Result := icor_debug_module (l_class_module_name)
		end

	icor_debug_module_for_class_type (a_class_type: CLASS_TYPE): ICOR_DEBUG_MODULE is
		require
			a_class_type_not_void: a_class_type /= Void
		local
			l_class_module_name: STRING
		do
			l_class_module_name := Il_debug_info_recorder.module_file_name_for_class_type (a_class_type)
			Result := icor_debug_module (l_class_module_name)
		end

	icor_debug_class (a_class_type: CLASS_TYPE): ICOR_DEBUG_CLASS is
		require
			arg_class_type_not_void: a_class_type /= Void
		local
			l_icd_module: ICOR_DEBUG_MODULE
			l_class_token: INTEGER
		do
			l_icd_module := icor_debug_module_for_class_type (a_class_type)
			if l_icd_module /= Void then
				l_class_token := Il_debug_info_recorder.class_token (l_icd_module.name, a_class_type)
				Result := l_icd_module.get_class_from_token (l_class_token)
			end
		end

feature -- Bridge to MD_IMPORT

	class_token (a_mod_name: STRING; a_class_type: CLASS_TYPE): INTEGER is
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

	icd_function_by_feature (icdv: ICOR_DEBUG_VALUE; ct: CLASS_TYPE; a_feat: FEATURE_I): ICOR_DEBUG_FUNCTION is
			-- ICorDebugFunction for `ct'.`a_feat'
			-- and optionally on object `icdv'
		local
			l_feat_tok: INTEGER
			l_feat_name: STRING
			l_icd_class: ICOR_DEBUG_CLASS
			l_icd_module: ICOR_DEBUG_MODULE
			l_class_module_name: STRING
			l_icd_obj_val: ICOR_DEBUG_OBJECT_VALUE
			l_info: EIFNET_DEBUG_VALUE_INFO
		do
			if icdv /= Void and ct.is_external then
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
			else
					--| This should be an true Eiffel type
				l_feat_tok := Il_debug_info_recorder.feature_token_for_feat_and_class_type (a_feat, ct)
				l_class_module_name := Il_debug_info_recorder.module_file_name_for_class_type (ct)
				l_icd_module := icor_debug_module (l_class_module_name)
				if l_feat_tok = 0 then
					l_feat_name := a_feat.feature_name
				end
			end
			if l_icd_module /= Void then
					--| Now we have the ICOR_DEBUG_MODULE ...				
				if l_feat_tok = 0 then
					l_feat_tok := l_icd_module.md_member_token_by_names (
								ct.full_il_implementation_type_name,
								l_feat_name
							)
				end
				if l_feat_tok > 0 then
					Result := l_icd_module.get_function_from_token (l_feat_tok)
				end
			end
		end

feature {NONE} -- Implementation of ICorDebugFunction retriever

	icd_function_by_name (ct: CLASS_TYPE; a_f_name: STRING): ICOR_DEBUG_FUNCTION is
			-- ICorDebugClass for `a_class_c'.`a_f_name'
		local
			l_feat_i : FEATURE_I
			l_class_c: CLASS_C
		do
			l_class_c := ct.associated_class
			l_feat_i := l_class_c.feature_named (a_f_name)
			Result := icd_function_by_feature (Void, ct, l_feat_i)
		end

feature -- Specific function evaluation

	eiffel_string_icd_class: ICOR_DEBUG_CLASS is
			-- ICorDebugClass for STRING
		do
			Result := icor_debug_class (Eiffel_system.String_class.compiled_class.types.first)
		end

	reference_integer_32_icd_class: ICOR_DEBUG_CLASS is
			-- ICorDebugClass for `reference INTEGER'
		do
			Result := icor_debug_class (int32_c_type.associated_reference_class_type)
		end

	reference_integer_32_set_item_method: ICOR_DEBUG_FUNCTION is
			-- ICorDebugFunction for `reference INTEGER'.set_item
		do
			Result := icd_function_by_name (int32_c_type.associated_reference_class_type, "set_item")
		ensure
			Result /= Void
		end

	reference_real_icd_class: ICOR_DEBUG_CLASS is
			-- ICorDebugClass for `reference REAL'
		do
			Result := icor_debug_class (real32_c_type.associated_reference_class_type)
		end

	reference_real_set_item_method: ICOR_DEBUG_FUNCTION is
			-- ICorDebugFunction for `reference REAL'.set_item
		do
			Result := icd_function_by_name (real32_c_type.associated_reference_class_type, "set_item")
		ensure
			Result /= Void
		end

	reference_double_icd_class: ICOR_DEBUG_CLASS is
			-- ICorDebugClass for `reference DOUBLE'
		do
			Result := icor_debug_class (real64_c_type.associated_reference_class_type)
		end

	reference_double_set_item_method: ICOR_DEBUG_FUNCTION is
			-- ICorDebugFunction for `reference DOUBLE'.set_item
		do
			Result := icd_function_by_name (real64_c_type.associated_reference_class_type, "set_item")
		ensure
			Result /= Void
		end

	reference_boolean_icd_class: ICOR_DEBUG_CLASS is
			-- ICorDebugClass for `reference BOOLEAN'
		do
			Result := icor_debug_class (boolean_c_type.associated_reference_class_type)
		end

	reference_boolean_set_item_method: ICOR_DEBUG_FUNCTION is
			-- ICorDebugFunction for `reference BOOLEAN'.set_item
		do
			Result := icd_function_by_name (boolean_c_type.associated_reference_class_type, "set_item")
		ensure
			Result /= Void
		end

	reference_character_icd_class: ICOR_DEBUG_CLASS is
			-- ICorDebugClass for `reference CHARACTER'
		do
			Result := icor_debug_class (char_c_type.associated_reference_class_type)
		end

	reference_character_set_item_method: ICOR_DEBUG_FUNCTION is
			-- ICorDebugFunction for `reference CHARACTER'.set_item
		do
			Result := icd_function_by_name (char_c_type.associated_reference_class_type, "set_item")
		ensure
			Result /= Void
		end

	eiffel_string_make_from_cil_constructor: ICOR_DEBUG_FUNCTION is
			-- ICorDebugFunction for STRING.make_from_cil
		local
			l_class : CLASS_C
		do
			l_class := Eiffel_system.String_class.compiled_class
			Result := icd_function_by_name (l_class.types.first, "make_from_cil")
		ensure
			Result /= Void
		end

	length_from_string_class_object_value (icd_string_instance: ICOR_DEBUG_OBJECT_VALUE): INTEGER is
			-- String Length for `icd_string_instance' (STRING object)
		require
			icd_string_instance /= Void
		local
			l_icd_value: ICOR_DEBUG_VALUE
			l_class: ICOR_DEBUG_CLASS
			l_string_class: CLASS_C
			l_feat_count: FEATURE_I
			l_feat_count_token: INTEGER
		do
				--| Get STRING info from compilo
			l_string_class := Eiffel_system.String_class.compiled_class
				--| Get STRING.count
			l_feat_count := l_string_class.feature_named ("count")
			if l_feat_count /= Void then
				l_feat_count_token := Il_debug_info_recorder.feature_token_for_non_generic (l_feat_count)
				l_class := icd_string_instance.get_class
				if l_class /= Void then
					l_icd_value := icd_string_instance.get_field_value (l_class, l_feat_count_token)
					if l_icd_value /= Void then
						Result := edv_formatter.icor_debug_value_to_integer (l_icd_value)
						l_icd_value.clean_on_dispose
					end
				end
			end
		end

	icd_string_value_from_string_class_value (icd_string_instance_ref: ICOR_DEBUG_VALUE; icd_string_instance: ICOR_DEBUG_OBJECT_VALUE): ICOR_DEBUG_STRING_VALUE is
			-- ICorDebugStringValue for `icd_string_instance_ref' (STRING object)
		require
			icd_string_instance /= Void
		local
			l_icd_value: ICOR_DEBUG_VALUE
			l_class: ICOR_DEBUG_CLASS
			l_module: ICOR_DEBUG_MODULE
			l_string_class: CLASS_C

			l_feat_to_cil: FEATURE_I
			l_feat_to_cil_token: INTEGER
			l_function_to_cil: ICOR_DEBUG_FUNCTION
		do
				--| Get STRING info from compilo
			l_string_class := Eiffel_system.String_class.compiled_class

				--| Get token to access `to_cil'
			l_feat_to_cil := l_string_class.feature_named ("to_cil")
			if l_feat_to_cil /= Void then
				l_feat_to_cil_token := Il_debug_info_recorder.feature_token_for_non_generic (l_feat_to_cil)
				l_class := icd_string_instance.get_class
				if l_class /= Void then
					l_module := l_class.get_module
					l_function_to_cil := l_module.get_function_from_token (l_feat_to_cil_token)
					l_icd_value := eifnet_dbg_evaluator.function_evaluation (Void, l_function_to_cil, <<icd_string_instance_ref>>)
					if eifnet_dbg_evaluator.last_eval_is_exception then
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

	last_string_value_length: INTEGER
			-- Last length of the Result from `string_value_from_string_class_object_value'

	string_value_from_string_class_value (icd_string_instance_ref: ICOR_DEBUG_VALUE; icd_string_instance: ICOR_DEBUG_OBJECT_VALUE; min, max: INTEGER): STRING is
			-- STRING value for `icd_string_instance' with limits `min, max'
		local
			l_icd_string_value: ICOR_DEBUG_STRING_VALUE
		do
			last_string_value_length := 0
			if icd_string_instance = Void then
				Result := Void
			else
				l_icd_string_value := icd_string_value_from_string_class_value (icd_string_instance_ref, icd_string_instance)
				if l_icd_string_value /= Void then
					Result := string_value_from_system_string_class_value (l_icd_string_value, min, max)
					l_icd_string_value.clean_on_dispose
				end
			end
		end

	string_value_from_system_string_class_value (icd_string_value: ICOR_DEBUG_STRING_VALUE; min, max: INTEGER): STRING is
			-- STRING value for `icd_string_instance' with limits `min, max'
		local
			l_size: INTEGER
			last_string_length: INTEGER
		do
			last_string_value_length := 0
			if icd_string_value /= Void then
				last_string_length := icd_string_value.get_length
				last_string_value_length := last_string_length
					--| Be careful, in this context min,max correspond to string starting at position '0'
				if max < 0 then
					l_size := last_string_length
				else
					l_size := (max + 1).min (last_string_length)
				end
				Result := icd_string_value.get_string (l_size)
				Result := Result.substring ((min + 1).max (1), l_size)
			end
		end

 	generating_type_value_from_object_value (a_frame: ICOR_DEBUG_FRAME; a_icd: ICOR_DEBUG_VALUE;
 				a_icd_obj: ICOR_DEBUG_OBJECT_VALUE;
 				a_class_type: CLASS_TYPE; a_feat: FEATURE_I): STRING is
			-- ANY.generating_type: STRING evaluation result
		require
			icor_debug_object_value_not_void: a_icd_obj /= Void
		local
			l_icd: ICOR_DEBUG_VALUE
			l_icdov: ICOR_DEBUG_OBJECT_VALUE
			l_icd_class: ICOR_DEBUG_CLASS
			l_icd_module: ICOR_DEBUG_MODULE
			l_module_name: STRING
			l_feature_token: INTEGER

			l_class_type: CLASS_TYPE
			l_func: ICOR_DEBUG_FUNCTION

			l_value_info : EIFNET_DEBUG_VALUE_INFO
		do
			check
				running_and_stopped: Application.is_running and Application.is_stopped
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
				l_feature_token := l_icd_module.md_feature_token (l_icd_class.get_token, a_feat.feature_name) -- resolved {ANY}.generating_type
				l_func := l_icd_module.get_function_from_token (l_feature_token)
			end

			if l_func /= Void then
				l_icd := eifnet_dbg_evaluator.function_evaluation (a_frame, l_func, <<a_icd>>)
				if eifnet_dbg_evaluator.last_eval_is_exception then
					l_icd := Void
				end
				if l_icd /= Void then
					create l_value_info.make (l_icd)
					l_icdov := l_value_info.new_interface_debug_object_value
					if l_icdov /= Void then
						Result := string_value_from_string_class_value (l_icd, l_icdov, 0, -1)
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
					l_module_name := l_icd_module.get_name

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
 				min,max: INTEGER): STRING is
			-- Debug ouput string value
		local
			l_icd_frame: ICOR_DEBUG_FRAME
			l_icd: ICOR_DEBUG_VALUE
			l_icdov: ICOR_DEBUG_OBJECT_VALUE
			l_icd_class: ICOR_DEBUG_CLASS
			l_icd_module: ICOR_DEBUG_MODULE
			l_feature_token: INTEGER
			l_feat: FEATURE_I
			l_class_type: CLASS_TYPE
			l_func: ICOR_DEBUG_FUNCTION
			l_value_info : EIFNET_DEBUG_VALUE_INFO
		do
			check
				running_and_stopped: Application.is_running and Application.is_stopped
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
							l_func := icd_function_by_name (l_class_type, l_feat.feature_name)
						else
							l_func := l_icd_module.get_function_from_token (l_feature_token)
						end
						if l_func /= Void then
							l_icd_frame := a_frame
							l_icd := eifnet_dbg_evaluator.function_evaluation (l_icd_frame, l_func, <<a_icd>>)
							if eifnet_dbg_evaluator.last_eval_is_exception then
								l_icd := Void
							end
						else
							debug ("DEBUGGER_TRACE_EVAL")
								print ("EIFNET_DEBUGGER.debug_output_.. :: Unable to retrieve ICorDebugFunction %N")
								print ("                                :: class name    = [" + l_class_type.full_il_type_name + "]%N")
								print ("                                :: module_name   = %"" + l_icd_module.get_name + "%"%N")
								print ("                                :: feature_token = 0x" + l_feature_token.to_hex_string + " %N")
							end
						end
					end
				end
				if l_icd /= Void then
					create l_value_info.make (l_icd)
					l_icdov := l_value_info.new_interface_debug_object_value
					if l_icdov /= Void then
						Result := string_value_from_string_class_value (l_icd, l_icdov, min, max)
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

 	to_string_value_from_exception_object_value (a_frame: ICOR_DEBUG_FRAME; a_icd: ICOR_DEBUG_VALUE; a_icd_obj: ICOR_DEBUG_OBJECT_VALUE): STRING is
			-- System.Exception.ToString value
		local
			l_icd: ICOR_DEBUG_VALUE
			l_icdov: ICOR_DEBUG_OBJECT_VALUE
			l_icd_class: ICOR_DEBUG_CLASS
			l_icd_module: ICOR_DEBUG_MODULE
			l_module_name: STRING
			l_feature_token: INTEGER
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
				l_module_name := l_icd_module.get_name

				l_feature_token := Edv_external_formatter.token_Exception_ToString
				l_func := l_icd_module.get_function_from_token (l_feature_token)

				if l_func /= Void then
					l_icd := eifnet_dbg_evaluator.function_evaluation (a_frame, l_func, <<a_icd>>)
					if eifnet_dbg_evaluator.last_eval_is_exception then
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

 	get_message_value_from_exception_object_value (a_frame: ICOR_DEBUG_FRAME; a_icd: ICOR_DEBUG_VALUE; a_icd_obj: ICOR_DEBUG_OBJECT_VALUE): STRING is
			-- System.Exception.ToString value
		local
			l_icd: ICOR_DEBUG_VALUE
			l_icd_module: ICOR_DEBUG_MODULE
			l_feature_token: INTEGER
			l_func: ICOR_DEBUG_FUNCTION
			l_debug_info : EIFNET_DEBUG_VALUE_INFO
			l_icdov: ICOR_DEBUG_OBJECT_VALUE
		do
			debug ("debugger_trace_eval")
				print ("<start> " + generator + ".get_message_value_from_exception_object_value %N")
			end
-- FIXME jfiat [2004/07/20] : why do we use a_icd as l_icd if failed ?
--			l_icd := a_icd
			l_icd_module := eifnet_debugger_info.icor_debug_module_for_mscorlib
			l_feature_token := Edv_external_formatter.token_Exception_get_Message
			l_func := l_icd_module.get_function_from_token (l_feature_token)
			if l_func /= Void then
				l_icd := eifnet_dbg_evaluator.function_evaluation (a_frame, l_func, <<a_icd>>)
				if eifnet_dbg_evaluator.last_eval_is_exception then
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

	once_function_value (a_icd_frame: ICOR_DEBUG_FRAME; a_class_c: CLASS_C;
								a_feat: FEATURE_I): ICOR_DEBUG_VALUE is
			-- ICorDebugValue object representing the once value.
			-- This will also set `last_once_available' and `last_once_failed'.
		require
			a_class_c_not_void: a_class_c /= Void
			a_feat_not_void: a_feat /= Void
		local
			l_once_info_tokens: TUPLE [INTEGER, INTEGER, INTEGER, INTEGER]
			l_data_class_token, l_done_token, l_result_token, l_exception_token: INTEGER
			l_icd_debug_value: ICOR_DEBUG_VALUE
			l_prepared_icd_debug_value: ICOR_DEBUG_VALUE
			l_once_already_called: BOOLEAN
			l_once_not_available: BOOLEAN
			l_icd_frame: ICOR_DEBUG_FRAME
			l_data_icd_class: ICOR_DEBUG_CLASS
			l_icd_module: ICOR_DEBUG_MODULE
		do
			last_once_failed := False
			last_once_available := False
			last_once_already_called := False

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
				l_data_class_token := l_once_info_tokens.integer_item (1)
				l_done_token := l_once_info_tokens.integer_item (2)
				l_result_token := l_once_info_tokens.integer_item (3)
				l_exception_token := l_once_info_tokens.integer_item (4)
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
					if (l_data_icd_class.last_error_code) = {EIFNET_API_ERROR_CODE_FORMATTER}.cordbg_e_class_not_loaded then
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
				last_once_available := False
			else
				last_once_available := True
				if l_once_already_called then
					last_once_already_called := True
					l_icd_debug_value := l_data_icd_class.get_static_field_value (l_exception_token, l_icd_frame)
					if l_icd_debug_value /= Void then
						l_prepared_icd_debug_value := Edv_formatter.prepared_debug_value (l_icd_debug_value)
						last_once_failed := not Edv_formatter.prepared_icor_debug_value_is_null (l_prepared_icd_debug_value)
						if l_prepared_icd_debug_value /= l_icd_debug_value then
							l_prepared_icd_debug_value.clean_on_dispose
						end
						if last_once_failed then
							Result := l_icd_debug_value
						else
							l_icd_debug_value.clean_on_dispose
						end
					elseif l_data_icd_class.last_error_code = {EIFNET_API_ERROR_CODE_FORMATTER}.cordbg_e_static_var_not_available then
						fixme ("[
									JFIAT: in this case, the once data about exception is not initialized yet.
									So there is no exception and no result yet.
									What is the status of the once ... not yet called, or called ?
									There should be a status .... is being called
									]")
					else
						last_once_failed := True
					end

					if not last_once_failed and then l_result_token /= 0 then
						Result := l_data_icd_class.get_static_field_value (l_result_token, l_icd_frame)
					end
				else
					last_once_already_called := False
				end
			end
			debug ("debugger_trace_eval")
				print ("Last once feature          = " + a_class_c.name_in_upper + "." + a_feat.feature_name + "%N")
				print ("  last_once_already_called = " + last_once_already_called.out + "%N")
				print ("  last_once_available      = " + last_once_available.out + "%N")
				print ("  last_once_failed         = " + last_once_failed.out + "%N")
			end
		end

	last_once_available: BOOLEAN
			-- Last once request show the once is available
			-- if False, this mean the debugger had issue to get information

	last_once_already_called: BOOLEAN
			-- Last once request show the once has already been called
			-- thus the value is available
			-- ps: relevant only if last_once_available = True

	last_once_failed: BOOLEAN
			-- Last once request show the once has failed
			-- if True, this mean the once had an exception
			-- ps: relevant only if last_once_available = True

--| NOTA jfiat [2004/03/19] : not yet ready, to be continued
--
--feature -- GC related
--
--	keep_alive (addr: STRING) is
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
--			l_gc_class_token: INTEGER
--			l_meth_token: INTEGER
--			l_icdf: ICOR_DEBUG_FUNCTION
--		do
--			l_icdm := eifnet_debugger_info.icor_debug_module_for_mscorlib
--			l_md_import := l_icdm.interface_md_import
--			l_gc_class_token := l_md_import.find_type_def_by_name ("System.GC", 0)
--			l_meth_token := l_md_import.find_method (l_gc_class_token, "KeepAlive")
--			l_icdf := l_icdm.get_function_from_token (l_meth_token)
--			eifnet_dbg_evaluator.method_evaluation (active_frame, l_icdf, <<icdv>>)
--		end


feature -- Bridge to debug_value_keeper

	keep_only_objects (a_addresses: LIST [STRING]) is
			-- Remove all ref kept, and keep only the ones contained in `a_addresses'
		do
			Debug_value_keeper.keep_only (a_addresses)
		end

	kept_object_item (a_address: STRING): ABSTRACT_DEBUG_VALUE is
			-- Keep this object addressed by `a_address'
		require
			know_about_object: know_about_kept_object (a_address)
		do
			Result := Debug_value_keeper.item (a_address)
		end

	know_about_kept_object (a_address: STRING): BOOLEAN is
			-- Do we have a reference for the object addressed by `a_address' ?
		do
			Result := Debug_value_keeper.know_about (a_address)
		end

feature -- Bridge to eifnet_dbg_evaluator

	eifnet_dbg_evaluator: EIFNET_DEBUGGER_EVALUATOR
			-- Dotnet function evaluator

feature {NONE} -- External

	Infinite_time: INTEGER is 0xFFFFFFFF;
			-- Value for C externals to have an infinite wait

indexing
	copyright:	"Copyright (c) 1984-2006, Eiffel Software"
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
			distributed in the hope that it will be useful,	but
			WITHOUT ANY WARRANTY; without even the implied warranty
			of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
			See the	GNU General Public License for more details.
			
			You should have received a copy of the GNU General Public
			License along with Eiffel Software's Eiffel Development
			Environment; if not, write to the Free Software Foundation,
			Inc., 51 Franklin St, Fifth Floor, Boston, MA 02110-1301  USA
		]"
	source: "[
			 Eiffel Software
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"

end -- class EIFNET_DEBUGGER
