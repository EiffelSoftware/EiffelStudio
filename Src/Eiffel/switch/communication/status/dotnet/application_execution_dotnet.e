indexing
	description	: "Controls execution of dotnet debugged application."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date		: "$Date$"
	revision	: "$Revision $"

class
	APPLICATION_EXECUTION_DOTNET

inherit
	APPLICATION_EXECUTION
		redefine
			status,
			is_valid_object_address,
			can_not_launch_system_message,
			recycle,
			clean_on_process_termination,
			make_with_debugger
		end

	SHARED_EIFNET_DEBUGGER

	EB_SHARED_MANAGERS

	DEBUG_VALUE_EXPORTER

	VALUE_TYPES

	APPLICATION_STATUS_EXPORTER
		export
			{NONE} all
		end

	SHARED_IL_DEBUG_INFO_RECORDER
		export
			{NONE} all
		end

	SHARED_EIFNET_DEBUG_VALUE_FACTORY
		export
			{NONE} all
		end

	EIFNET_EXPORTER
		export
			{NONE} all
		end

	SHARED_WORKBENCH
		export
			{NONE} all
		end

	COMPILER_EXPORTER
		export
			{NONE} all
		end

	EV_SHARED_APPLICATION
		export
			{NONE} all
		end

create {DEBUGGER_MANAGER}
	make_with_debugger

feature {APPLICATION_EXECUTION} -- Initialization

	make_with_debugger (dbg: like debugger_manager) is
			-- Create Current
		local
			p: BOOLEAN_PREFERENCE
		do
			Precursor {APPLICATION_EXECUTION} (dbg)

			Eifnet_debugger.init

			p := Debugger_manager.dotnet_keep_stepping_info_non_eiffel_feature_pref
			if p /= Void then
				if p.value then
					eifnet_debugger.enable_keep_stepping_into_dotnet_feature
				else
					eifnet_debugger.disable_keep_stepping_into_dotnet_feature
				end
				p.typed_change_actions.extend (
					agent (b: BOOLEAN; ed: EIFNET_DEBUGGER)
						do
							if b then
								ed.enable_keep_stepping_into_dotnet_feature
							else
								ed.disable_keep_stepping_into_dotnet_feature
							end
						end (?, eifnet_debugger)
					)
			end

			agent_update_notify_on_after_stopped :=	agent real_update_notify_on_after_stopped
		end

feature -- recycling data

	recycle is
		do
			Eifnet_debugger.recycle_debug_value_keeper
			Precursor
		end

feature {EIFNET_DEBUGGER, EIFNET_EXPORTER} -- Trigger eStudio done

	estudio_callback_notify is
			-- Once the callback is done, when ec is back to life
			-- it will process this notification.
		require
			not_alread_inside_notify: not is_inside_callback_notification_processing
		local
			l_status: APPLICATION_STATUS_DOTNET
			retried: BOOLEAN
			cb_id: INTEGER
		do
			if not retried then
				cb_id := Eifnet_debugger.last_managed_callback
				debug ("debugger_trace_callback_notify")
					print ("** ->START::NotifyEstudio ** [" + Eifnet_debugger.managed_callback_name (cb_id) + "].%N")
					if callback_notification_processing then
						print ("** WARNING ** there is already an Estudio notification running%N")
					end
				end
				Eifnet_debugger.set_callback_notification_processing (True)
				if Eifnet_debugger /= Void then
					l_status := status
					if
						l_status.is_stopped
						and then not l_status.is_evaluating
					then
						if Eifnet_debugger.managed_callback_is_exit_process (cb_id) then --| Exit Process |--	
							notify_execution_on_exit_process
						elseif Eifnet_debugger.info.debugger_error_occurred then
							notify_execution_on_debugger_error
						else
							notify_execution_on_stopped (cb_id)
						end
					elseif --| Evaluation |--
						Eifnet_debugger.managed_callback_is_eval_complete (cb_id)
						and then l_status.is_evaluating
					then
						notify_evaluation_done
					else
						--| do_nothing
					end
				end
				Eifnet_debugger.set_callback_notification_processing (False)
				debug ("debugger_trace_callback_notify")
					print ("** ->END::NotifyEstudio ** [" + Eifnet_debugger.managed_callback_name (cb_id) + "].%N")
				end
			else
				io.error.put_string ("ERROR : during APPLICATION_EXECUTION_DOTNET.estudio_callback_notify %N")
				io.error.flush
				Eifnet_debugger.set_callback_notification_processing (False)
			end
		rescue
			retried := True
			retry
		end

feature {EIFNET_EXPORTER, EV_SHARED_APPLICATION}  -- Trigger eStudio status

	callback_notification_processing: BOOLEAN is
			-- Is inside callback notification processing ?
		do
			Result := Eifnet_debugger.callback_notification_processing
		end

feature {APPLICATION_EXECUTION} -- load and save

--	load_dotnet_debug_info is
--			-- Load debug information
--		local
--			w_dlg: EB_WARNING_DIALOG
--		do
--			Il_debug_info_recorder.load_data_for_debugging
--			if not Il_debug_info_recorder.load_successful then
--				if (create {EV_ENVIRONMENT}).application /= Void then
--					create w_dlg.make_with_text (Il_debug_info_recorder.loading_errors_message)
--					w_dlg.show
--				else
--					io.error.put_string (Il_debug_info_recorder.loading_errors_message)
--				end
--			end
--		end

	reload_dotnet_debug_info_if_needed is
			-- Reload debug information if last mode was finalized
			-- since for debugging we need the workbench info
			-- we force the reload
		do
			if not Il_debug_info_recorder.last_loading_is_workbench then
				debug ("debugger_trace")
					print ("Reload IL debug info for dotnet %N")
				end
				Il_debug_info_recorder.load_data_for_debugging
			else
				debug ("debugger_trace")
					print ("Keep current IL debug info for dotnet %N")
				end
			end
		end

feature {NONE} -- Status

	build_status is
		do
			create status.make (Current)
		end

feature -- Properties

	status: APPLICATION_STATUS_DOTNET
			-- Status of the running dotnet application

	is_inside_callback_notification_processing: BOOLEAN is
		do
			Result := Eifnet_debugger.callback_notification_processing
		end

feature {APPLICATION_EXECUTION} -- Properties

	is_valid_object_address (addr: STRING): BOOLEAN is
			-- Is object address `addr' valid?
			-- (i.e Does bench know about it)
		do
			Result := Precursor (addr) and then Eifnet_debugger.know_about_kept_object (addr)
		end

feature -- Bridge to Debugger

	exit_process_occurred: BOOLEAN is
			-- Did the exit_process occurred ?
		require
			eifnet_debugger_exists: eifnet_debugger_initialized
		do
			Result := Eifnet_debugger.exit_process_occurred
		end

	exception_occurred: BOOLEAN is
			-- Last callback is about exception ?
		do
			Result := status.exception_occurred
		end

feature -- Execution

	run_with_env_string (app: STRING; args, cwd: STRING; env: STRING_GENERAL) is
			-- Run application `app' with arguments `args' in directory `cwd'.
			-- If `is_running' is false after the
			-- execution of this routine, it means that
			-- the application was unable to be launched
			-- due to the time_out (see `eiffel_timeout_message').
			-- Before running the application you must check
			-- to see if the debugged information is up to date.
		do
			reload_dotnet_debug_info_if_needed
			if il_debug_info_recorder.entry_point_feature_i = Void then
				--| No entry point .. this is not an executable system
			else
				Eifnet_debugger.initialize_debugger_session (debugger_manager.windows_handle)
				if Eifnet_debugger.is_debugging then
					process_before_running

					Eifnet_debugger.do_run (safe_path (app), cwd, args, env)

					if not Eifnet_debugger.last_dbg_call_succeed then
							-- This means we had issue creating process
						Eifnet_debugger.terminate_debugger_session
						Eifnet_debugger.destroy_monitoring_of_process_termination_on_exit
					else
						build_status
					end

					if is_running then
							-- Application was able to be started
						status.set_is_stopped (False)
						status.set_process_id (eifnet_debugger.last_process_id)
					end
				end
			end
		end

	continue_ignoring_kept_objects is
		do
			inspect execution_mode
			when {EXEC_MODES}.step_into then
				step_into
			when {EXEC_MODES}.step_by_step then
				step_next
			when {EXEC_MODES}.out_of_routine then
				step_out
			else
				process_before_running
				Eifnet_debugger.set_last_control_mode_is_continue

				status.set_is_stopped (False)
				Eifnet_debugger.do_continue
			end
		end

	interrupt is
			-- Send an interrupt to the application
			-- which will stop at the next breakable line number
		do
			if Eifnet_debugger.icor_debug_controller /= Void then
				debug ("debugger_eifnet_data")
					print ("IsRunning :: " + Eifnet_debugger.icor_debug_controller.is_running.out + "%N")
				end

				process_before_running
				Eifnet_debugger.set_last_control_mode_is_stop
				Eifnet_debugger.stop_dbg_timer
				Eifnet_debugger.do_stop

				debug ("debugger_eifnet_data")
					print ("IsRunning :: " + Eifnet_debugger.icor_debug_controller.is_running.out + "%N")
				end

				--| Here debugger may not be synchronized |--
				Eifnet_debugger.reset_current_callstack
				Eifnet_debugger.init_current_callstack
				debug ("debugger_eifnet_data_extra")
					debug_display_threads
				end

					--| In case the stored current Thread id is obsolete
					--| we refresh the thread id's value
				status.refresh_current_thread_id
				Eifnet_debugger.do_global_step_into
			end
		end

	notify_newbreakpoint is
			-- Send an interrupt to the application
			-- which will stop at the next breakable line number
			-- in order to record the new breakpoint(s) before
			-- automatically resuming its execution.
		do
			send_breakpoints
		end

	kill is
			-- Ask the application to terminate itself.
		do
			if Eifnet_debugger.is_debugging then
				Eifnet_debugger.set_last_control_mode_is_kill
				Eifnet_debugger.terminate_debugging
			end
			process_termination
		end

	query_replay_status (direction: INTEGER): INTEGER is
			-- Query number of available steps in `direction'.
		do
				--| Not Yet Implemented for dotnet !
			to_implement ("Add support for execution replay to dotnet system.")
		end

	remote_rt_object_icd_value: ICOR_DEBUG_VALUE is
			-- Return the remote rt_object
		local
			m: ICOR_DEBUG_MODULE
			f: ICOR_DEBUG_FRAME
			icl: ICOR_DEBUG_CLASS
			ctok, ftok: INTEGER
		do
			m := eifnet_debugger.ise_runtime_module
			if m /= Void then
				ctok := eifnet_debugger.edv_external_formatter.token_IseRuntime
				if ctok > 0 then
					ftok := eifnet_debugger.edv_external_formatter.token_IseRuntime__rt_extension_object
					if ftok > 0 then
						icl := m.get_class_from_token (ctok)
						f := eifnet_debugger.new_active_frame
						Result := icl.get_static_field_value (ftok, f)
						f.clean_on_dispose
						icl.clean_on_dispose
					end
				end
			end
		end

	remote_rt_object: EIFNET_ABSTRACT_DEBUG_VALUE is
			-- Return the remote rt_object
		local
			icdv: ICOR_DEBUG_VALUE
		do
			icdv := remote_rt_object_icd_value
			if icdv /= Void and then system.rt_extension_class /= Void then
				Result := debug_value_from_icdv (icdv, system.rt_extension_class.compiled_class)
			end
		end

	remotely_store_object (oa: STRING; fn: STRING): BOOLEAN is
		local
			icdv, r: ICOR_DEBUG_VALUE
			rto: like remote_rt_object
			icdf: ICOR_DEBUG_FUNCTION
			args: ARRAY [ICOR_DEBUG_VALUE]
			dv: EIFNET_ABSTRACT_DEBUG_VALUE
			i_ref, i_fn: ICOR_DEBUG_VALUE
		do
			dv ?= kept_object_item (oa)
			if dv /= Void then
				rto := remote_rt_object
				if rto /= Void then
					icdf := rto.icd_value_info.value_icd_function ("saved_object_to")
					icdv := rto.icd_referenced_value
					if icdf /= Void then
						i_ref := dv.icd_referenced_value
						i_fn := eifnet_debugger.eifnet_dbg_evaluator.new_eiffel_string_evaluation (Void, fn)
						args := <<icdv, i_ref, i_fn>>
						r := eifnet_debugger.eifnet_dbg_evaluator.function_evaluation (Void, icdf, args)
						i_fn.clean_on_dispose
						if r /= Void then
							Result := not eifnet_debugger.icor_debug_value_is_null_value (r)
							r.clean_on_dispose
						end
					end
				end
			end
		end

	remotely_loaded_object (oa: STRING; fn: STRING): ABSTRACT_DEBUG_VALUE is
		local
			icdv, r: ICOR_DEBUG_VALUE
			rto: like remote_rt_object
			icdf: ICOR_DEBUG_FUNCTION
			args: ARRAY [ICOR_DEBUG_VALUE]
			dv: EIFNET_ABSTRACT_DEBUG_VALUE
			i_ref, i_fn: ICOR_DEBUG_VALUE
		do
			rto := remote_rt_object
			if rto /= Void then
				icdv := rto.icd_referenced_value
				icdf := rto.icd_value_info.value_icd_function ("object_loaded_from")
				if icdf /= Void then
					if oa /= Void then
						dv ?= kept_object_item (oa)
						if dv /= Void then
							i_ref := dv.icd_referenced_value
						end
					end
					i_fn := eifnet_debugger.eifnet_dbg_evaluator.new_eiffel_string_evaluation (Void, fn)
					args := <<icdv, i_ref, i_fn>>
					r := eifnet_debugger.eifnet_dbg_evaluator.function_evaluation (Void, icdf, args)
					i_fn.clean_on_dispose
					Result := debug_value_from_icdv (r, Void)
				end
			end
		end

	clean_on_process_termination is
			-- Process the termination of the executed
			-- application. Also execute the `termination_command'.
		do
			Precursor {APPLICATION_EXECUTION}
			Eifnet_debugger.reset_debugging_data
			Eifnet_debugger.destroy_monitoring_of_process_termination_on_exit

--			Eifnet_debugger.terminate_debugger_session
-- this is now called directly from EIFNET_DEBUGGER.on_exit_process
		end

--	load_system_dependent_debug_info is
--		do
--			if
--				Eiffel_system.workbench.system_defined
--			then
--				load_dotnet_debug_info
--			end
--		end

feature {NONE} -- Assertion change Implementation

	impl_check_assert (b: BOOLEAN): BOOLEAN is
			-- `check_assert (b)' on debuggee
		do
			Result := eifnet_debugger.check_assert_on_debuggee (b)
		end

feature {APPLICATION_EXECUTION} -- Launching status

	can_not_launch_system_message: STRING is
			-- Message displayed when estudio is unable to launch the system
		do
			if il_debug_info_recorder /= Void and then il_debug_info_recorder.entry_point_feature_i = Void then
				Result := debugger_names.w_System_has_no_entry_and_is_not_executable.as_string_8
			else
				Result := debugger_names.w_Error_occurred_during_icordebug_initialization.as_string_8
			end
		end

feature -- Query

	onces_values (flist: LIST [E_FEATURE]; a_addr: STRING; a_cl: CLASS_C): ARRAY [ABSTRACT_DEBUG_VALUE] is
		local
			l_class: CLASS_C
			l_feat: FEATURE_I
			i: INTEGER
			err_dv: DUMMY_MESSAGE_DEBUG_VALUE
			exc_dv: EXCEPTION_DEBUG_VALUE
			proc_dv: PROCEDURE_RETURN_DEBUG_VALUE
			odv: ABSTRACT_DEBUG_VALUE
			icdv: ICOR_DEBUG_VALUE
			l_icdframe: ICOR_DEBUG_FRAME
			l_eifnet_debugger: like eifnet_debugger
		do
			l_eifnet_debugger := Eifnet_debugger
			l_icdframe := l_eifnet_debugger.current_stack_icor_debug_frame
			from
				i := 1
				create Result.make (i, i + flist.count - 1)
				flist.start
			until
				flist.after
			loop
					--| Get the once's value
				l_feat := flist.item.associated_feature_i
				check l_feat.type /= Void end
				l_class := l_feat.written_class
				icdv := l_eifnet_debugger.once_function_value (l_icdframe, l_class, l_feat)
				if l_eifnet_debugger.last_once_available then
					if not l_eifnet_debugger.last_once_already_called then
						create err_dv.make_with_name  (l_feat.feature_name)
						err_dv.set_message (debugger_names.m_Not_yet_called)
						err_dv.set_display_kind (Void_value)
						if l_feat.is_function then
							err_dv.set_display_kind (Void_value)
						else
							err_dv.set_display_kind (Procedure_return_message_value)
						end
						odv := err_dv
					elseif l_eifnet_debugger.last_once_failed then
						create exc_dv.make_with_name (l_feat.feature_name)
						exc_dv.set_tag ("An exception occurred during the once execution")
						exc_dv.set_exception_value (debug_value_from_icdv (icdv, Void))
						odv := exc_dv
					elseif icdv /= Void then
						odv := debug_value_from_icdv (icdv, l_feat.type.associated_class)
						odv.set_name (l_feat.feature_name)
					elseif not l_feat.is_function then
						create proc_dv.make_with_name (l_feat.feature_name)
						odv := proc_dv
					else
							--| This case occurs when we enter into the once's code
							--| then the once is Called
							--| but the once's data are not yet initialized and set
							--| then the once' value is not yet available
						create err_dv.make_with_name  (l_feat.feature_name)
						err_dv.set_message ("Could not retrieve information (once is being called)")
						err_dv.set_display_kind (Void_value)
						if l_feat.is_function then
							err_dv.set_display_kind (Void_value)
						else
							err_dv.set_display_kind (Procedure_return_message_value)
						end
						odv := err_dv
					end
				else
					create err_dv.make_with_name  (l_feat.feature_name)
					err_dv.set_message (debugger_names.m_Not_yet_called)
					err_dv.set_display_kind (Void_value)
					if l_feat.is_function then
						err_dv.set_display_kind (Void_value)
					else
						err_dv.set_display_kind (Procedure_return_message_value)
					end
					odv := err_dv
				end
				Result.put (odv, i)
				i := i + 1
				flist.forth
			end
		end

	dump_value_at_address_with_class (a_addr: STRING; a_cl: CLASS_C): DUMP_VALUE is
		local
			l_dv: ABSTRACT_DEBUG_VALUE
		do
			l_dv := debug_value_at_address_with_class (a_addr, a_cl)
			if l_dv /= Void then
				Result := l_dv.dump_value
			end
		end

	debug_value_at_address_with_class (a_addr: STRING; a_cl: CLASS_C): ABSTRACT_DEBUG_VALUE is
		do
			if know_about_kept_object (a_addr) then
				Result := kept_object_item (a_addr)
			end
		end

feature -- Control execution

	process_before_running is
		local
			l_entry_point_feature: E_FEATURE
			l_entry_fi: FEATURE_I
			bpm: BREAKPOINTS_MANAGER
		do
			check il_debug_info_recorder.last_loading_is_workbench end

			debug ("debugger_trace_operation")
				print ("%N%N")
				print ("/\/\/\/\/\/\  Process before running  /\/\/\/\/\/\/\/\/\%N")
				print ("%N%N")
			end

			bpm := Debugger_manager.breakpoints_manager
			bpm.update
			inspect execution_mode
			when {EXEC_MODES}.no_stop_points then
				send_no_breakpoints
			when {EXEC_MODES}.step_by_step, {EXEC_MODES}.step_into then
				if not is_running then
					debug ("debugger_trace_stepping")
						print ("Let's add a breakpoint at the entry point of the system%N")
					end
					l_entry_fi := Il_debug_info_recorder.entry_point_feature_i
					if l_entry_fi /= Void then
						l_entry_point_feature := l_entry_fi.e_feature
						bpm.enable_breakpoint (l_entry_point_feature, 1)
						send_breakpoints
						bpm.remove_breakpoint (l_entry_point_feature , 1)
					end
				else
					send_breakpoints
				end
			else
				send_breakpoints
			end

			debug ("debugger_eifnet_data_extra")
				debug_display_threads
			end

			Eifnet_debugger.init_current_callstack
			Eifnet_debugger.save_current_stack_as_previous
			Eifnet_debugger.set_last_control_mode_is_nothing
		end

	debug_display_threads is
			--
		local
			l_controller: ICOR_DEBUG_CONTROLLER
			l_enum_thread: ICOR_DEBUG_THREAD_ENUM
			l_threads: ARRAY [ICOR_DEBUG_THREAD]
			l_last_thread_id: STRING
			i: INTEGER
			l_th: ICOR_DEBUG_THREAD
		do
			l_controller := Eifnet_debugger.icor_debug_controller
			if l_controller /= Void then
				l_controller.add_ref
				l_enum_thread := l_controller.enumerate_threads
				if l_enum_thread /= Void and then l_enum_thread.count > 0 then
					l_enum_thread.reset
					l_th := Eifnet_debugger.icor_debug_thread
					if l_th /= Void then
						l_last_thread_id := l_th.get_id.to_hex_string
					end
					l_threads := l_enum_thread.next (l_enum_thread.count)
					print ("[info]  => " + l_threads.count.out + " Threads.%N")
					print ("        => last   :: " + l_last_thread_id + "%N")
					from
						i := l_threads.lower
					until
						i > l_threads.upper
					loop
						l_th := l_threads.item (i)
						print ("        => " + l_th.get_id.to_hex_string + "%N")
						l_th.clean_on_dispose
						i := i + 1
					end
					l_enum_thread.clean_on_dispose
				end
				l_controller.release
			end
		end

feature -- Stepping

	step_out is
			-- Stepping out of the routine
		do
			process_before_running

			debug ("debugger_trace_stepping")
				print ("++++++++++++++++++++++++++++++++++++++++++++++++++++++%N")
				print ("++ OPERATION :: APPLICATION_EXECUTION_DOTNET::step_out%N")
				print ("++++++++++++++++++++++++++++++++++++++++++++++++++++++%N")
			end
			raw_step_out
		end

	step_into is
			-- Stepping into next routine
		do
			process_before_running

			debug ("debugger_trace_stepping")
				print ("+++++++++++++++++++++++++++++++++++++++++++++++++++++++%N")
				print ("++ OPERATION :: APPLICATION_EXECUTION_DOTNET::step_into%N")
				print ("+++++++++++++++++++++++++++++++++++++++++++++++++++++++%N")
			end
			Eifnet_debugger.set_last_control_mode_is_into
			raw_step_range (True)
		end

	step_next is
			-- Stepping to next step point
		local
			l_status: APPLICATION_STATUS_DOTNET
		do
			process_before_running

			debug ("debugger_trace_stepping")
				print ("+++++++++++++++++++++++++++++++++++++++++++++++++++++++%N")
				print ("++ OPERATION :: APPLICATION_EXECUTION_DOTNET::step_next%N")
				print ("+++++++++++++++++++++++++++++++++++++++++++++++++++++++%N")
			end

			l_status := status
			if
				(l_status.e_feature /= Void)
				and then (l_status.break_index = l_status.e_feature.number_of_breakpoint_slots)
			then
				--| This is an optimisation when we are at the end of a routine
				--| End of feature, go out ...
				raw_step_out
			else
				Eifnet_debugger.set_last_control_mode_is_next
				raw_step_range (False)
			end
		end

feature {NONE} -- Stepping

	raw_step_out is
			-- Effective call to step out
			-- without calling `process_before_running'
		do
			if Eifnet_debugger.stepping_possible then
				Eifnet_debugger.set_last_control_mode_is_out

				Eifnet_debugger.do_step_out
				status.set_is_stopped (False)
			end
		end

	raw_step_range (a_bstep_in: BOOLEAN) is
			-- Step over the next range
			-- faster than stepping next for each dotnet step.
		local
			curr_il_offset: INTEGER
			csed: CALL_STACK_ELEMENT_DOTNET
			do_not_use_range: BOOLEAN
			l_ranges:  ARRAY [TUPLE [INTEGER,INTEGER]]
			l_origin_cc: CLASS_C
			l_impl_ct: CLASS_TYPE
		do
			do_not_use_range := False
			if do_not_use_range then
				if a_bstep_in then
					Eifnet_debugger.do_step_into
				else
					Eifnet_debugger.do_step_next
				end
				status.set_is_stopped (False)
			else
				if Eifnet_debugger.stepping_possible then
					csed := status.current_call_stack_element_dotnet
					if csed /= Void then
						curr_il_offset := csed.il_offset
						debug ("debugger_trace_stepping")
							print (" ### Current IL OffSet = 0x"+curr_il_offset.to_hex_string+" ~ "+curr_il_offset.out+" %N")
						end
						l_impl_ct := csed.dynamic_type
						l_origin_cc := csed.written_class
						if l_origin_cc /= csed.dynamic_class then
							l_impl_ct := il_debug_info_recorder.implemented_type (l_origin_cc, l_impl_ct)
						end

						l_ranges := Il_debug_info_recorder.next_feature_breakable_il_range_for (
										l_impl_ct,
										csed.routine.associated_feature_i,
										curr_il_offset
										)
					end
					if l_ranges /= Void then
						debug ("debugger_trace_stepping")
							print ("[>] Go for next point %N")
						end
						Eifnet_debugger.do_step_range (a_bstep_in, l_ranges)
					else
						debug ("debugger_trace_stepping")
							print ("[>] Go out of routine (from "+curr_il_offset.to_hex_string+")%N")
						end
						Eifnet_debugger.do_step_out
--						Eifnet_debugger.do_step_range (a_bstep_in, <<[0 , curr_il_offset]>>)
					end
					status.set_is_stopped (False)
				end
			end
		end

feature -- Breakpoints controller

	send_breakpoints is
			-- Synchronise the EiffelStudio BreakPoints with the application ones in execution
		local
			l_bp_list: BREAK_LIST
			l_bp_item: BREAKPOINT
		do
			debug ("debugger_trace_breakpoint")
				print (generator + ".send_breakpoints %N")
			end
			l_bp_list := Debugger_manager.breakpoints_manager.breakpoints

			from
				l_bp_list.start
			until
				l_bp_list.off
			loop
				l_bp_item := l_bp_list.item_for_iteration
				inspect l_bp_item.update_status
				when {BREAKPOINT}.Breakpoint_to_add then
					debug ("debugger_trace_breakpoint")
						print ("ADD BP :: " + l_bp_item.routine.associated_class.name_in_upper +"."+ l_bp_item.routine.name +" @ " + l_bp_item.breakable_line_number.out + "%N")
					end
					if l_bp_item.is_valid then
						add_dotnet_breakpoint (l_bp_item)
						l_bp_item.set_application_set
					end
				when {BREAKPOINT}.Breakpoint_to_remove then
					debug ("debugger_trace_breakpoint")
						print ("DEL BP :: " + l_bp_item.routine.associated_class.name_in_upper +"."+ l_bp_item.routine.name +" @ " + l_bp_item.breakable_line_number.out + "%N")
					end
					remove_dotnet_breakpoint (l_bp_item)
					l_bp_item.set_application_not_set
				when {BREAKPOINT}.Breakpoint_do_nothing then
					debug ("debugger_trace_breakpoint")
						print ("NADA BP %N")
					end
				end
				l_bp_list.forth
			end
			debugger_manager.breakpoints_manager.reset_breakpoints_changed
		end

	send_no_breakpoints is
			-- Remove BreakPoints from the application ones in execution
			-- to perform a NoStopPoint operation
		local
			l_bp_list: BREAK_LIST
			l_bp_item: BREAKPOINT
		do
			l_bp_list := Debugger_manager.breakpoints_manager.breakpoints

			from
				l_bp_list.start
			until
				l_bp_list.off
			loop
				l_bp_item := l_bp_list.item_for_iteration
				if l_bp_item.is_set_for_application then
					debug ("debugger_trace_breakpoint")
						print ("REMOVE APPLICATION BP :: " + l_bp_item.routine.associated_class.name_in_upper +"."+ l_bp_item.routine.name +" @ " + l_bp_item.breakable_line_number.out + "%N")
					end
					remove_dotnet_breakpoint (l_bp_item)
					l_bp_item.set_application_not_set
					-- then next time we go with StopPoint enable ... we'll add them again
				end
				l_bp_list.forth
			end
		end

feature -- BreakPoints

	set_dotnet_breakpoint (bp: BREAKPOINT; a_state: BOOLEAN) is
			-- enable the `i'-th breakpoint of `f' if `a_state' is `True'
			-- otherwise disable it
			-- if no breakpoint already exists for 'f' at 'i', a breakpoint is created
		require
			bp_valid: bp.is_valid
		local
			f: E_FEATURE
			ln: INTEGER
			l_feature_token: INTEGER
			l_il_offset_set: IL_OFFSET_SET
			l_il_offset: INTEGER
			l_module_name: STRING
			l_class_c: CLASS_C
			l_class_token: INTEGER

			l_class_type_list: TYPE_LIST
			l_class_type: CLASS_TYPE
			i, upper: INTEGER
		do
			f := bp.routine
			ln := bp.breakable_line_number
			debug ("debugger_trace_breakpoint")
				print ("setBreakpoint (" + a_state.out + ") " + f.name + " index=" + ln.out + "%N")
				display_feature_info (f)
			end

			l_class_c := f.written_class

				--| loop on the different derivation of a generic class
			l_class_type_list := l_class_c.types
			from
				l_class_type_list.start
			until
				l_class_type_list.after
			loop
				l_class_type := l_class_type_list.item
				l_module_name := Il_debug_info_recorder.module_file_name_for_class_type (l_class_type)

				l_class_token := Il_debug_info_recorder.class_token (l_module_name, l_class_type)
				if l_class_token = 0 then
						--| Try to find the token, using the Meta Data
					l_class_token := Eifnet_debugger.class_token (l_module_name, l_class_type)
				end
				l_feature_token := Il_debug_info_recorder.feature_token_for_feat_and_class_type (f.associated_feature_i, l_class_type)

				l_il_offset_set := Il_debug_info_recorder.feature_breakable_il_line_for (l_class_type, f.associated_feature_i, ln)
				if l_il_offset_set /= Void and then not l_il_offset_set.is_empty then
					from
						i := l_il_offset_set.lower
						upper := i + l_il_offset_set.count
					until
						i >= upper
					loop
						l_il_offset := l_il_offset_set.item (i)
						if a_state then
							Eifnet_debugger.request_breakpoint_add (bp, l_module_name, l_class_token, l_feature_token, l_il_offset)
						else
							Eifnet_debugger.request_breakpoint_remove (bp, l_module_name, l_class_token, l_feature_token, l_il_offset)
						end
						i := i + 1
					end
				else
					check False end -- Should not occurs, unless data are corrupted
				end
				l_class_type_list.forth
			end
		end

	add_dotnet_breakpoint (bp: BREAKPOINT) is
			-- enable the `i'-th breakpoint of `f'
			-- if no breakpoint already exists for 'f' at 'i', a breakpoint is created
		do
			set_dotnet_breakpoint (bp, True)
		end

	remove_dotnet_breakpoint (bp: BREAKPOINT) is
			-- remove the `i'-th breakpoint of `f'
			-- if no breakpoint already exists for 'f' at 'i', a breakpoint is created
		do
			set_dotnet_breakpoint (bp, False)
		end

feature {NONE} -- Implementation

	display_feature_info (f: E_FEATURE) is
			-- Display info related to feature `f'
			-- debug purpose only
		require
			f /= Void
		local
			l_class_c: CLASS_C

			l_str: STRING
			l_types: TYPE_LIST
			l_class_type: CLASS_TYPE

			l_class_token: INTEGER
			l_module_name: STRING
		do
			l_str := "----%N"
			l_str.append_string ("%TFeature :: ")

			l_class_c := f.written_class

			l_str.append_string ("%N%T Associated class="+ f.associated_class.name_in_upper + "%T")
			l_str.append_string ("%N%T Written class="+ f.written_class.name_in_upper )

			if l_class_c /= Void then
				l_str.append_string ("%N%T class id=" + l_class_c.class_id.out + " [" + l_class_c.name_in_upper)

				if l_class_c.is_generic then
					l_str.append_string (" !Generic! ")
					l_types := l_class_c.types
					from
						l_types.start
					until
						l_types.after
					loop
						l_class_type := l_types.item
						l_module_name := Il_debug_info_recorder.module_file_name_for_class_type (l_class_type)

						l_class_token := Il_debug_info_recorder.class_token (l_module_name, l_class_type)
						l_str.append_string ("%T" + l_class_token.out)
						l_str.append_string (" ~ 0x" + l_class_token.to_hex_string)
						l_types.forth
					end
				else
					l_types := l_class_c.types
					l_class_type := l_types.first
					l_module_name := Il_debug_info_recorder.module_file_name_for_class_type (l_class_type)
					l_class_token := Il_debug_info_recorder.class_token (l_module_name, l_class_type)

					l_str.append_string (":" + l_class_token.out)
					l_str.append_string (" ~ 0x" + l_class_token.to_hex_string)
				end
				l_str.append_string ("]")
				l_str.append_string ("%N")

				l_str.append_string ("%T module_name="+Il_debug_info_recorder.module_file_name_for_class (l_class_c) )
			end

			print (l_str)
			print ("%N")
		end

feature -- Evaluation

	notify_evaluation_done is
			-- Notify that an evaluation is done.
		do
			debug ("debugger_trace")
				print ("%N%T !!! notify_evaluation_done !!! %N")
			end
		end

feature {NONE} -- Events on notification

	notify_execution_on_exit_process is
			-- Notify the system is exiting
		do
			--| We need to stop
			--| Already "stopped" but let's be sure ..

			status.set_is_stopped (True)
			Eifnet_debugger.on_exit_process
			Eifnet_debugger.notify_exit_process_occurred
		end

	notify_execution_on_debugger_error is
			-- Notify the system is exiting on debugger error
		local
--			st: TEXT_FORMATTER
			l_err_msg: STRING
			dbg_info: EIFNET_DEBUGGER_INFO
		do
			--| We need to stop
			--| Already "stopped" but let's be sure ..
			dbg_info := Eifnet_debugger.info
			l_err_msg := "The dotnet debugger has encountered a fatal error.%N"
						+ " - error_hr   = 0x" + dbg_info.debugger_error_hr.to_hex_string + "%N"
						+ " - error_code = 0x" + dbg_info.debugger_error_code.to_hex_string + "%N"

-- FIXME JFIAT: removed because it is not used the good way
-- assertion violation
--			create st.make
--			st.add_string (l_err_msg)
--			output_manager.process_text (st)

			(create {ES_SHARED_PROMPT_PROVIDER}).prompts.show_error_prompt (l_err_msg, Void, Void)

			status.set_is_stopped (True)
			Eifnet_debugger.terminate_debugging
		end

	notify_execution_on_stopped (cb_id: INTEGER) is
		local
			need_to_continue: BOOLEAN
			l_status: APPLICATION_STATUS_DOTNET
			dbg_info: EIFNET_DEBUGGER_INFO
		do
			debug ("debugger_trace")
				print ("%N*** REASON TO STOP *** %N")
				print ("%T Callback = " + Eifnet_debugger.managed_callback_name (cb_id) +"%N")
			end -- debug
			dbg_info := Eifnet_debugger.info

--| Useless, but we may need it one day
--			on_application_before_stopped

				--| on top of the stack = current stack/feature
			set_current_execution_stack_number (1)
			-- FIXME jfiat: we should point to the first Eiffel Call Stack ...

				--| We need to stop
				--| Already "stopped" but let's be sure ..
			l_status := status
			l_status.set_is_stopped (True)
			l_status.set_top_level

				--| CallStack
			l_status.reload_current_call_stack --| since we stop, let's reload the whole callstack

			debug ("debugger_trace_callstack")
				io.put_new_line
				print (" ### CallStack : Head level ## 0x" + dbg_info.last_step_complete_reason.to_hex_string + " ### %N")
--| uncomment next ligneto have different kind of debug output
--				io.put_new_line
--				print (frame_callstack_info (Eifnet_debugger.active_frame))
--				io.put_new_line
				display_full_callstack_info
			end

			if dbg_info.last_control_mode_is_stop then
				l_status.set_reason_as_interrupt
			else
				if Eifnet_debugger.managed_callback_is_step_complete (cb_id) then
					l_status.set_reason_as_step
				elseif Eifnet_debugger.managed_callback_is_breakpoint (cb_id) then
					l_status.set_reason_as_break
					need_to_continue := not do_stop_on_breakpoint
				elseif Eifnet_debugger.managed_callback_is_exception (cb_id) then
					l_status.set_reason_as_raise

					if eifnet_debugger.last_exception_is_handled then
						l_status.set_exception (0, "First chance exception occurred .. waiting for information")
					else
						l_status.set_exception (0, "UnHandled exception occurred .. waiting for information")
					end
				end
			end

--| not true in case of empty stack .. when exception occurs during launching
--			set_current_execution_stack (1)
			set_current_execution_stack_number (number_of_stack_elements)

			if need_to_continue then
				debug ("debugger_trace_callstack")
					print ("Note: Continue on stopped status (need_to_continue = True)%N")
					print ("Note: last managed callback = " + Eifnet_debugger.managed_callback_name (cb_id) + "%N")
				end
				release_all_but_kept_object
				l_status.set_is_stopped (False)
				Eifnet_debugger.do_continue
			else
				update_notify_on_after_stopped
			end
		end

	do_stop_on_breakpoint: BOOLEAN is
			-- In case of conditional breakpoint, do we really stop on it ?
		local
			l_bp: BREAKPOINT
		do
			if Eifnet_debugger.last_control_mode_is_stepping then
				debug ("debugger_trace")
					print ("Stepping then continue ..%N")
				end
				Result := True
			else
				l_bp := Eifnet_debugger.current_breakpoint
				Result := debugger_manager.process_breakpoint (l_bp)
			end
		end

	display_breakpoint_info (icd_bp: ICOR_DEBUG_BREAKPOINT) is
			-- display information related to `icd_bp'
			-- debug purpose only
		local
			l_icd_bp: ICOR_DEBUG_BREAKPOINT
			l_icd_func_bp: ICOR_DEBUG_FUNCTION_BREAKPOINT
			l_function: ICOR_DEBUG_FUNCTION
		do
			print ("%T Breakpoint:%N")
			l_icd_bp := icd_bp
			l_icd_func_bp := l_icd_bp.query_interface_icor_debug_function_breakpoint
			if l_icd_func_bp /= Void then
				print ("%T   - Offset = " + l_icd_func_bp.get_offset.out + "%N")
				l_function := l_icd_func_bp.get_function
				print ("%T   - Function = " + l_function.to_string + "%N")
			end
		end

feature -- update processing

	agent_update_notify_on_after_stopped: PROCEDURE [ANY, TUPLE]
			-- Procedure used as agent for `update_notify_on_after_stopped'

	update_notify_on_after_stopped is
			-- Ask to notify studio right after the execution is stopped
			-- but in the studio graphical loop
		do
				--FIXME jfiat: may be we should move this EV_... to another class
			debugger_manager.remove_idle_action (agent_update_notify_on_after_stopped)
			debugger_manager.add_idle_action (agent_update_notify_on_after_stopped)
		end

	real_update_notify_on_after_stopped is
			-- Proceed effective notification to studio
			-- make sure we are outside the callback notification
		local
			retried: BOOLEAN
		do
			if not retried then
				debug ("debugger_trace")
					io.error.put_string (generator + ".real_update_notify_on_after_stopped %N")
				end
				debugger_manager.remove_idle_action (agent_update_notify_on_after_stopped)
				if not callback_notification_processing then
					debug ("debugger_trace")
						io.error.put_string (generator + ".real_update_notify_on_after_stopped : call real notification%N")
					end
					on_application_just_stopped
				else
					debug ("debugger_trace")
						io.error.put_string (generator + ".real_update_notify_on_after_stopped : postpone real notification%N")
					end
					debugger_manager.add_idle_action (agent_update_notify_on_after_stopped)
				end
			else
				debug ("debugger_trace")
					io.error.put_string (generator + ".real_update_notify_on_after_stopped : RESCUED !!!%N")
				end
			end
		rescue
			retried := True
			retry
		end

feature -- Call stack related

	frame_callstack_info (a_frame: ICOR_DEBUG_FRAME): STRING is
			-- obsolete "To remove soon or later, this is just a debug use for now"
			-- Called by `select_actions' of `but_callstack_update'.
		local
			l_frame_il: ICOR_DEBUG_IL_FRAME
			l_output: STRING
			l_func: ICOR_DEBUG_FUNCTION
			l_class: ICOR_DEBUG_CLASS
			l_module: ICOR_DEBUG_MODULE
			l_class_token: INTEGER
			l_feature_token: INTEGER
			l_module_name: STRING
			l_module_display: STRING

			l_class_type: CLASS_TYPE
			l_class_name: STRING
			l_feature_i : FEATURE_I
			l_feature_name: STRING

			l_eiffel_bp_slot: INTEGER
			l_il_offset: INTEGER
			l_mapping: STRING
		do
			create l_output.make (100)
			if a_frame = Void then
				--| FIXME: JFIAT
				l_output := "Debugger not synchronized => no information available%N"
			else
				l_frame_il := a_frame.query_interface_icor_debug_il_frame
				if a_frame.last_call_succeed and then l_frame_il /= Void then
					l_func := l_frame_il.get_function
					l_feature_token := l_func.get_token
					l_class := l_func.get_class
					l_class_token := l_class.get_token
					l_module := l_func.get_module
					l_module_name := l_module.get_name

					l_module_display := l_module_name.twin
					l_module_display.keep_tail (20)
					l_module_display.prepend_string (" ..")

					if il_debug_info_recorder.has_info_about_module (l_module_name) then
						l_class_type := Il_debug_info_recorder.class_type_for_module_class_token (l_module_name, l_class_token)
						l_feature_i := Il_debug_info_recorder.feature_i_by_module_feature_token (l_module_name, l_feature_token)
					end
					if l_class_type /= Void then
						l_class_name := l_class_type.associated_class.name_in_upper
					else
						l_class_name := "<?"+ l_class_token.out + "?>"
					end
					if l_feature_i /= Void then
						l_feature_name := Il_debug_info_recorder.feature_i_by_module_feature_token (l_module_name, l_feature_token).feature_name
					else
						l_feature_name := "<?"+ l_feature_token.out + "?>"
					end

					if l_class_type /= Void and then l_feature_i /= Void then
						l_il_offset := l_frame_il.get_ip
						l_mapping := l_frame_il.last_cordebugmapping_result_to_string
						l_eiffel_bp_slot := Il_debug_info_recorder.feature_eiffel_breakable_line_for_il_offset(l_class_type, l_feature_i, l_il_offset)
						l_output.append_string ("  + <"
							+ l_eiffel_bp_slot.out
							+ " | "
							+ l_il_offset.out + ":0x" + l_il_offset.to_hex_string + "> "
							+ "(mapping=" + l_mapping + ")"
							+ l_class_name + "." + l_feature_name + "%N"
							+ "%T0x"+l_class_token.to_hex_string
							+ " :: 0x"+ l_feature_token.to_hex_string
							+ "%N%T Module=" + l_module_display
							)

						l_output.append_string ("%N")
					else
						l_output.append_string ("  - <"+ l_frame_il.get_ip.out + ":0x" + l_frame_il.get_ip.to_hex_string + "> ")
						l_output.append_string (" [???] ")
						if l_class_type /= Void then
							l_output.append_string ("%T " + l_class_name)
						end
						if l_feature_i /= Void then
							l_output.append_string ("." + l_feature_name)
						end

						l_output.append_string ("%N")
						l_output.append_string ("%T0x" + l_class_token.to_hex_string )
						l_output.append_string (" :: 0x" + l_feature_token.to_hex_string)
						l_output.append_string (" module=" + l_module_display + "%N")
					end
				end
				l_frame_il.clean_on_dispose
			end
			Result := l_output
		end

	display_full_callstack_info is
			-- obsolete "To remove soon or later, this is just a debug use for now"
			-- Called by `select_actions' of `but_callstack_update'.
		local
			l_active_thread: ICOR_DEBUG_THREAD
			l_enum_chain: ICOR_DEBUG_CHAIN_ENUM
			l_chain: ICOR_DEBUG_CHAIN
			l_enum_frames: ICOR_DEBUG_FRAME_ENUM
			l_chains: ARRAY [ICOR_DEBUG_CHAIN]
			l_frames: ARRAY [ICOR_DEBUG_FRAME]
			l_frame: ICOR_DEBUG_FRAME
			c: INTEGER
			i: INTEGER
			l_output: STRING

		do
			l_active_thread := Eifnet_debugger.icor_debug_thread

			l_enum_chain := l_active_thread.enumerate_chains
			if l_active_thread.last_call_succeed and then l_enum_chain.get_count > 0 then
				l_enum_chain.reset
				l_chains := l_enum_chain.next (l_enum_chain.get_count)
				from
					c := l_chains.lower
				until
					c > l_chains.upper
				loop
					l_chain := l_chains @ c
					if l_chain /= Void then
						l_output := " ### Callstack from Chain : " + l_chain.item.out + " (" + l_chain.get_reason_to_string + ")###%N"
						l_enum_frames := l_chain.enumerate_frames
						if l_chain.last_call_succeed and then l_enum_frames.get_count > 0 then
							l_enum_frames.reset
							l_frames := l_enum_frames.next (l_enum_frames.get_count)
							from
								i := l_frames.lower
							until
								i > l_frames.upper
							loop
								l_frame := l_frames @ i
								l_output.append_string ("... chain::" + c.out + " frame::" + i.out + " =%N")
								l_output.append_string (frame_callstack_info (l_frame))
								l_frame.clean_on_dispose
								i := i + 1
							end
							l_enum_frames.clean_on_dispose
						end
						l_chain.clean_on_dispose
					end
					c := c + 1
				end
				l_enum_chain.clean_on_dispose
			end

			io.put_new_line
			io.put_new_line
			io.put_string (l_output)
			io.put_new_line
		end

feature -- Object Keeper

	keep_only_objects (a_addresses: LIST [STRING]) is
			-- Remove all ref kept, and keep only the ones contained in `a_addresses'
		do
			Eifnet_debugger.keep_only_objects (a_addresses)
		end

	kept_object_item (a_address: STRING): ABSTRACT_DEBUG_VALUE is
			-- Keep this object addressed by `a_address'
		require
			know_about_object: know_about_kept_object (a_address)
		do
			Result := Eifnet_debugger.kept_object_item (a_address)
		end

	know_about_kept_object (a_address: STRING): BOOLEAN is
			-- Do we have a reference for the object addressed by `a_address' ?
		do
			Result := Eifnet_debugger.know_about_kept_object (a_address)
		end

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

end
