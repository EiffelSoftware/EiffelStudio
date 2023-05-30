note
	description: "Controls execution of debugged application."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

deferred class APPLICATION_EXECUTION

inherit
	PROJECT_CONTEXT
		export
			{NONE} all
		end

	SHARED_EIFFEL_PROJECT
		export
			{NONE} all
			{ANY} Eiffel_project, Eiffel_system
		end

	SAFE_PATH_BUILDER
		export
			{NONE} all
		end

	SHARED_BENCH_NAMES

	REFACTORING_HELPER

--create {DEBUGGER_MANAGER}
--	make_with_debugger

feature {NONE} -- Initialization

	make_with_debugger (dbg: like debugger_manager)
		do
			debugger_manager := dbg
			current_execution_stack_number := 1
			create last_assertion_check_stack.make
		ensure
			current_execution_stack_number_is_one: current_execution_stack_number = 1
		end

feature -- Access

	debugger_manager: DEBUGGER_MANAGER
			-- Associated debugger manager.

feature -- Recylcing

	recycle
			-- Clean debugging session data
		do
			clear_internals
			debugger_manager.object_manager.reset
			if is_running then
				destroy_status
			end
		end

feature -- Execution event callbacks

	frozen on_application_before_resuming
		require
			Debugger_manager_not_void: debugger_manager /= Void
		do
			Debugger_manager.on_application_before_resuming
		end

	frozen on_application_resumed
		require
			Debugger_manager_not_void: debugger_manager /= Void
		do
			status.resume_execution
			Debugger_manager.on_application_resumed
		end

	frozen on_application_before_paused
		require
			Debugger_manager_not_void: debugger_manager /= Void
		do
			Debugger_manager.on_application_before_paused
		end

	frozen on_application_paused
		require
			Debugger_manager_not_void: debugger_manager /= Void
		do
			Debugger_manager.on_application_paused
		end

	frozen on_application_just_stopped
		require
			Debugger_manager_not_void: debugger_manager /= Void
		do
			status.pause_execution
			Debugger_manager.on_application_just_stopped
		end

	frozen on_application_quit
		require
			Debugger_manager_not_void: debugger_manager /= Void
		do
			status.quit_execution
			Debugger_manager.on_application_quit
		end

	frozen on_application_debugger_update
		require
			Debugger_manager_not_void: debugger_manager /= Void
		do
			Debugger_manager.on_application_debugger_update
		end

feature -- Properties

	status: APPLICATION_STATUS
			-- Status of the running application

	execution_mode: INTEGER
			-- Execution mode (Step by step, stop at stoop points, ...)

	ignoring_breakpoints: BOOLEAN
			-- Is application ignoring breakpoints ?			

	error_reported: BOOLEAN
			-- Has error been reported during debugging?

	current_execution_stack_number: INTEGER
			-- Stack number currently displaying the locals and arguments

feature -- Status

	is_running: BOOLEAN
			-- Is the application running?
		require
			Debugger_manager_not_void: debugger_manager /= Void
		do
			Result := status /= Void
		ensure
			yes_implies_non_void_status: Result implies status /= Void
		end

	is_stopped: BOOLEAN
			-- Is the application stopped in its execution?
		require
			Debugger_manager_not_void: debugger_manager /= Void
			is_running: is_running
		do
			Result := status.is_stopped
		ensure
			yes_implies_status_is_stop: Result implies status.is_stopped
		end

	exists: BOOLEAN
			-- Does the application file exists?
		local
			u: FILE_UTILITIES
		do
			Result := u.file_path_exists (Eiffel_system.application_name (True))
		end

	is_valid_and_known_object_address (addr: DBG_ADDRESS): BOOLEAN
			-- Is object address `addr' valid?
			-- (i.e Does bench know about it)
		require
			is_running: is_running
			is_stopped: is_stopped
		do
			Result := addr /= Void and then	not addr.is_void
		end

feature -- Access

	can_not_launch_system_message: STRING_32
			-- Message displayed when estudio is unable to launch the system
		do
			Result := debugger_names.w_Cannot_launch_system
		end

	can_not_attach_system_message (a_port: INTEGER): STRING_32
			-- Message displayed when estudio is unable to attach the system
		do
			Result := debugger_names.w_Cannot_attach_system (a_port)
		end

	number_of_stack_elements: INTEGER
			-- Total number of the call stack elements in
			-- exception stack
		require
			is_running: is_running
			is_stopped: is_stopped
		do
			if attached status.current_call_stack as ecs then
				Result := ecs.count
			end
		end

	current_call_stack_depth: INTEGER
			-- Current call stack's depth
		require
			is_running: is_running
			is_stopped: is_stopped
		do
			if attached status.current_call_stack as ecs then
				Result := ecs.stack_depth
			end
		end

	current_call_stack_is_empty: BOOLEAN
			-- Is Class stack empty ?
		do
			Result := number_of_stack_elements = 0
		end

feature {DEAD_HDLR, STOPPED_HDLR, SHARED_DEBUGGER_MANAGER, APPLICATION_EXECUTION} -- Implementation

	process_termination
			-- Process the termination of the executed
			-- application. Also execute the `termination_command'.
		do
			Debugger_manager.restore_debugger_data
			if is_running then
				clean_on_process_termination
			end

			on_application_quit

			status := Void --| then is_running = False  (status /= Void)
			current_execution_stack_number := 1
debug ("DEBUGGER_TRACE")
	io.error.put_string ("terminating project%N")
end
		ensure
			not_running: not is_running
			reset_current_execution_stack_number:
					current_execution_stack_number = 1
		end

feature -- Execution

	run (params: DEBUGGER_EXECUTION_RESOLVED_PROFILE)
			-- Run application with arguments `args' in directory `cwd'.
			-- If `is_running' is false after the
			-- execution of this routine, it means that
			-- the application was unable to be launched
			-- due to the time_out (see `eiffel_timeout_message').
			-- Before running the application you must check
			-- to see if the debugged information is up to date.
		require
			app_not_running: not is_running
			application_exists: exists
			non_negative_interrupt: debugger_manager.interrupt_number >= 0
		local
			l_envstr: NATIVE_STRING
			env: HASH_TABLE [STRING_32, STRING_32]
			ctlr: DEBUGGER_CONTROLLER
		do
			parameters := params
			ctlr := debugger_manager.controller
			env := ctlr.environment_variables_updated_with (params.environment_variables, True)
			l_envstr := environment_variables_to_native_string (env)

			-- FIXME: update if/when Eiffel_system.application_name becomes a PATH
			run_with_env_string (Eiffel_system.application_name (True), params.arguments, params.working_directory, l_envstr)
		ensure
			successful_app_is_not_stopped: is_running implies not is_stopped
		end

	attach (a_port: INTEGER)
			-- Attach application using port `a_port'
			-- If `is_running' is false after the
			-- execution of this routine, it means that
			-- the application was unable to be attached
			-- due to the time_out (see `eiffel_timeout_message').
			-- Before attaching the application you must check
			-- to see if the debugged information is up to date.
			--
			--| See http://www.iana.org/assignments/service-names-port-numbers/service-names-port-numbers.xhtml
			--| for available port number if needed.
		require
			app_not_running: not is_running
			application_exists: exists
			non_negative_interrupt: debugger_manager.interrupt_number >= 0
		local
			ctlr: DEBUGGER_CONTROLLER
		do
			parameters := Void
			ctlr := debugger_manager.controller
			attach_using_port (Eiffel_system.application_name (True), a_port)
		ensure
			successful_app_is_not_stopped: is_running implies not is_stopped
		end

	release_all_but_kept_object
			-- keep the objects addresses in `kept_objects'.
			-- Objects that are not in `kept_objects' will be removed
			-- and will be not under the control of bench.
			-- Therefore, these addresses cannot be
			-- referenced the next time we stop the application.
		require
			is_running: is_running
		do
			debug ("debugger_trace_cache")
				print (generator + ".release_all_but_kept_object %N")
			end
			keep_only_objects (status.kept_objects)
		end

	continue
			-- Continue the running of the application and keep the
			-- objects addresses in `kept_objects'. Objects that are not in
			-- `kept_objects' will be removed and will be not under the
			-- control of bench. Therefore, these addresses cannot be
			-- referenced the next time we stop the application.
		require
			is_running: is_running
			is_stopped: is_stopped
			non_negative_interrupt: debugger_manager.interrupt_number >= 0
		do
			debug ("debugger_trace")
				print (generator + ".continue %N")
			end
			clear_internals
			release_all_but_kept_object
			continue_ignoring_kept_objects
		end

	continue_ignoring_kept_objects
			-- Continue the running of the application
			-- before any debugger's operation occurred
			-- so basically, we are sure we have the same `kept_objects'
		require
			is_running: is_running
			is_stopped: is_stopped
			non_negative_interrupt: debugger_manager.interrupt_number >= 0
		deferred
		end

	send_breakpoints
			-- Send breakpoints according to the context
		local
			bpm: BREAKPOINTS_MANAGER
		do
			debug("debugger_trace_breakpoint")
				io.put_string ("sending updated breakpoints to the application%N")
			end

			bpm := Debugger_manager.breakpoints_manager
			bpm.update -- remove breakpoint that are now useless.

					--| Execution with breakpoints |--
			send_execution_information (execution_mode, ignoring_breakpoints)
			bpm.reset_breakpoints_changed
		end

	interrupt
			-- Send an interrupt to the application
			-- which will stop at the next breakable line number
		require
			app_is_running: is_running
			not_stopped: not is_stopped
		deferred
		end

	request_debugger_data_update
			-- Request the application to pause, in order to update debugger data
			-- such as new breakpoints, or other catcall detection,...
			-- mainly for classic debugging
		require
			app_is_running: is_running
			not_stopped: not is_stopped
		do
		end

	notify_breakpoints_change
			-- Send an interrupt to the application
			-- which will stop at the next breakable line number
			-- in order to record the new breakpoint(s) before
			-- automatically resuming its execution.
		require
			app_is_running: is_running
			not_stopped: not is_stopped
		deferred
		end

	kill
			-- Ask the application to terminate itself.
		require
			app_is_running: is_running
		deferred
		end

	terminate_debugging
			-- Terminate debugging, and clean what needs to be cleaned
		do
			process_termination
		end

	detach
			-- Ask the application to detach itself.
		require
			app_is_running: is_running
		deferred
		end

	clear_internals
			-- Clear internal values
		do
			set_error_reported (False)
			if attached internal_remote_rt_object as rto then
				rto.recycle
				internal_remote_rt_object := Void
			end
			if attached internal_remote_rt_execution_recorder as rt_recorder then
				rt_recorder.recycle
				internal_remote_rt_execution_recorder := Void
			end
		end

feature -- Access: Remote access to RT_

	remote_rt_object: detachable DBG_RT_EXTENSION_PROXY
			-- Return the remote rt_object
		do
			Result := internal_remote_rt_object
			if Result = Void and then attached imp_remote_rt_object as rto then
				create Result.make (rto, Current)
				internal_remote_rt_object := Result
			end
		end

feature {NONE} -- Implementation: Remote

	imp_remote_rt_object: detachable ABSTRACT_REFERENCE_VALUE
			-- Return the remote rt_object
		deferred
		end

	internal_remote_rt_object: like remote_rt_object
			-- Cached value of `remote_rt_object'.

	internal_remote_rt_execution_recorder: like remote_rt_execution_recorder
			-- Cached value of `remote_rt_execution_recorder'.

feature -- Remote: execution recorder on RT_

	remote_rt_execution_recorder: detachable DBG_RT_EXECUTION_RECORDER_PROXY
			-- Return the remote rt_object.execution_recorder
		do
			Result := internal_remote_rt_execution_recorder
			if Result = Void and then attached remote_rt_object as rto then
				Result := rto.execution_recorder
				internal_remote_rt_execution_recorder := Result
			end
		end

	activate_execution_replay_recording (b: BOOLEAN): BOOLEAN
			-- Activate Execution replay recording on debuggee depending of `b'
		local
			ct: CLASS_TYPE
			fi: FEATURE_I
			ref: DUMP_VALUE
			cid,fid,dep,line: INTEGER
		do
			check execution_replay_recording_not_b: b /= status.replay_recording end
			status.set_replay_recording (b)
			check status.replay_recording = b end

			if attached remote_rt_object as rto then
				cid := 0
				fid := 0
				dep := 1
				line := 0
				if b then
					if attached status.current_eiffel_call_stack_element as ecse then
						if attached ecse.current_object_value as adv then
							ref := adv.dump_value
						end
						ct := ecse.dynamic_type
						fi := ecse.routine_i

							--| Don't forget to withdraw "-1" to convert compiler id to runtime id !
						cid := ct.type_id - 1
						fid := fi.real_body_index (ct)
						if fid /= 0 then
							fid := fid - 1
						else
							fid := fi.body_index - 1
						end
						line := ecse.break_index
					end
					dep := dep.max (current_call_stack_depth)
				end

				Result := rto.activate_execution_replay_recording (b, ref, cid, fid, dep, line)
			end
		ensure
			execution_replay_recording: status.replay_recording = b
		end

	activate_execution_replay_mode (b: BOOLEAN)
			-- Activate or Deactivate execution replay mode
		require
			turned_on_when_stopped: b implies status.is_stopped
			replay_depth_is_valid: (b and status.replayed_depth = 0) or (not b and status.replayed_depth <= current_call_stack_depth)
		local
			sd,d: INTEGER
		do
			if b then
				status.set_replay_activated (True)
				check status.replayed_depth = 0 end

				remote_activate_replay (True)

				d := query_replay_status (Rtdbg_op_replay_back)
				status.set_replay_level_limit (d)
			else
				d := status.replayed_depth
				remote_activate_replay (False)
					--| Reset data of replayed stacks
				if attached status.current_call_stack as ccs then
					from
						sd := ccs.stack_depth
					until
						d > sd
					loop
						ccs.reset_call_stack_depth (d)
						d := d + 1
					end
				end
				debugger_manager.incremente_debugging_operation_id
				status.set_replay_activated (False)
				status.set_replay_level_limit (0)
				status.set_current_replayed_call (Void)
			end
		ensure
			replay_activated: status.replay_activated = b
			replay_depth_is_valid: (not b and status.replayed_depth = 0) or (b and status.replayed_depth = current_call_stack_depth)
		end

	remote_activate_replay (b: BOOLEAN)
			-- Remotely Activate replay
		do
			if attached remote_rt_execution_recorder as rt_recorder then
				rt_recorder.activate_replay (b)
			end
		end

	replay (direction: INTEGER): BOOLEAN
			-- Replay execution in `direction'
			-- and return True if operation succeed.
		require
			app_is_stopped: is_stopped
			replay_activated: status.replay_activated
		do
			if attached remote_rt_execution_recorder as rt_recorder then
				Result := rt_recorder.replay (direction)
			end
		end

	replay_to_point (a_id: STRING): BOOLEAN
			-- Replay to point identified by `a_id'
		do
			if attached remote_rt_execution_recorder as rt_recorder then
				Result := rt_recorder.replay_to_point (a_id)
			end
		end

	query_replay_status (direction: INTEGER): INTEGER
			-- Query exec replay status for direction `direction'
			-- Return the number of available steps.
		do
			if attached remote_rt_execution_recorder as rt_recorder then
				Result := rt_recorder.query_replay_status (direction)
			end
		end

	current_replayed_call: REPLAYED_CALL_STACK_ELEMENT
			-- Current replayed call representation
		do
			if attached remote_rt_execution_recorder as rt_recorder then
				Result := rt_recorder.current_replayed_call
			end
		end

	replay_callstack_details (a_id: STRING; nb: INTEGER): detachable REPLAYED_CALL_STACK_ELEMENT
			-- Details related to replayed callstack identified by `a_id'
			-- get the information for `nb' levels
		do
			if attached remote_rt_execution_recorder as rt_recorder then
				Result := rt_recorder.replay_callstack_details (a_id, nb)
			end
		end

feature -- Remote: Store/Load object on RT_

	remotely_store_object (oa: DBG_ADDRESS; fn: PATH): BOOLEAN
			-- Store in file `fn' on the application the object addressed by `oa'
			-- Return True is succeed.
		do
			if attached remote_rt_object as rto then
				Result := rto.store_object (oa, fn)
			end
		end

	remotely_loaded_object (oa: DBG_ADDRESS; fn: PATH): detachable DUMP_VALUE
			-- Debug value related to remote loaded object from file `fn'.
			-- and if `oa' is not Void, copy the value inside object addressed by `oa'.
		do
			if attached remote_rt_object as rto then
				Result := rto.loaded_object (oa, fn)
			end
		end

feature -- Remote access to Exceptions

	remote_current_exception_value: EXCEPTION_DEBUG_VALUE
			-- `{EXCEPTION_MANAGER}.last_exception' value.
		require
			exception_occurred: status.exception_occurred
		deferred
		ensure
			Result_not_void: Result /= Void
		end

feature -- Debuggee: runtime

	debugger_type_string_evaluation (a_value: DUMP_VALUE; error_handler: detachable DBG_ERROR_HANDLER): STRING_32
			-- Get the `generating_type' as STRING by evaluation on the debuggee
		require
			a_value_attached: a_value /= Void
		do
			if a_value.is_void then
				Result := "NONE"
			else
				if
					attached remote_rt_object as rto and then
					attached rto.debugger_type_string_evaluation (a_value, error_handler) as s
				then
					Result := s
				else
					create Result.make_empty
				end
			end
		ensure
			result_attached: Result /= Void
		end

feature -- Debuggee: evaluation

	tilda_equal_evaluation (a_value, a_other_value: DBG_EVALUATED_VALUE; error_handler: detachable DBG_ERROR_HANDLER): BOOLEAN
		require
			a_value_attached: a_value /= Void and then a_value.has_value
			a_other_value_attached: a_other_value /= Void and then a_other_value.has_value
		do
			if attached remote_rt_object as rto then
				if
					attached a_value.value as l_value and
					attached a_other_value.value as l_other_value
				then
					Result := rto.tilda_equal_evaluation (l_value, l_other_value, error_handler)
				elseif attached error_handler then
					error_handler.notify_error_evaluation_report_to_support (Void)
				end
			end
		end

	is_equal_evaluation (a_value, a_other_value: DBG_EVALUATED_VALUE; error_handler: detachable DBG_ERROR_HANDLER): BOOLEAN
		require
			a_value_attached: a_value /= Void
			a_other_value_attached: a_other_value /= Void
		do
			if attached remote_rt_object as rto then
				if
					attached a_value.value as l_value and
					attached a_other_value.value as l_other_value
				then
					Result := rto.is_equal_evaluation (l_value, l_other_value, error_handler)
				elseif attached error_handler then
					error_handler.notify_error_evaluation_report_to_support (Void)
				end
			end
		end

	equal_sign_evaluation (a_value, a_other_value: DBG_EVALUATED_VALUE; error_handler: detachable DBG_ERROR_HANDLER): BOOLEAN
		require
			a_value_attached: a_value /= Void
			a_other_value_attached: a_other_value /= Void
		do
			if attached remote_rt_object as rto then
				if
					attached a_value.value as l_value and
					attached a_other_value.value as l_other_value
				then
					Result := rto.equal_sign_evaluation (l_value, l_other_value, error_handler)
				elseif attached error_handler then
					error_handler.notify_error_evaluation_report_to_support (Void)
				end
			end
		end

feature -- Expression evaluation

	string_field_evaluation_on (e: ABSTRACT_REFERENCE_VALUE; edv: DUMP_VALUE; cl: CLASS_C; fname: STRING): detachable STRING_32
			-- String representation of `{cl}.fname' evaluated on `edv'.
		require
			target_not_void: e /= Void or edv /= Void
			cl_not_void: cl /= Void
		local
			dv: DUMP_VALUE
		do
			dv := query_evaluation_on (e, edv, cl, fname, Void)
			if dv /= Void and then dv.has_formatted_output then
				Result := dv.string_representation
			end
		end

	query_evaluation_on (e: ABSTRACT_REFERENCE_VALUE; edv: DUMP_VALUE; cl: CLASS_C; fname: STRING; params: LIST [DUMP_VALUE]): detachable DUMP_VALUE
			-- command `{cl}.fname' evaluation on `edv'
			-- using `params' as argument if any
		require
			target_not_void: e /= Void or edv /= Void
			fname_not_void: fname /= Void
			cl_not_void: cl /= Void
		local
			f: FEATURE_I
			dv: DUMP_VALUE
		do
			if is_stopped and cl /= Void then
				f := cl.feature_named_32 (fname)
				if f /= Void then
					dv := edv
					if dv = Void and e /= Void then
						dv := e.dump_value
					end
					if f.is_function then
						Result := function_evaluation_on (e, dv, f, cl, params)
					elseif f.is_attribute then
						Result := attribute_evaluation_on (e, dv, f, cl)
					end
				end
			end
		end

	command_evaluation_on (e: ABSTRACT_REFERENCE_VALUE; edv: DUMP_VALUE; cl: CLASS_C; fname: STRING; params: LIST [DUMP_VALUE]): BOOLEAN
			-- method `{cl}.fname' evaluation on `edv'
			-- using `params' as argument if any
		require
			target_not_void: e /= Void or edv /= Void
			fname_not_void: fname /= Void
			cl_not_void: cl /= Void
		local
			f: FEATURE_I
			dv: DUMP_VALUE
		do
			if is_stopped and cl /= Void then
				f := cl.feature_named_32 (fname)
				if f /= Void then
					dv := edv
					if dv = Void and e /= Void then
						dv := e.dump_value
					end
					if f.is_routine then
						Result := routine_evaluation_on  (e, dv, f, cl, params)
					end
				end
			end
		end

	attribute_evaluation_on (e: detachable ABSTRACT_REFERENCE_VALUE; obj: detachable DUMP_VALUE; f: FEATURE_I; cl: CLASS_C): DUMP_VALUE
			-- Evaluation's result for `a_expr' in current context
			-- (note: Result = Void implies an error occurred)
		require
			is_stopped: is_stopped
			target_not_void: e /= Void or obj /= Void
		local
			dbg_eval: DBG_EVALUATOR
			tgt: DUMP_VALUE
			rescued: BOOLEAN
		do
			if rescued then
				restore_assertion_check
				if dbg_eval /= Void then
					dbg_eval.reset
				end
			elseif is_stopped then
				tgt := obj
				if tgt = Void and e /= Void then
					tgt := e.dump_value
				end
				dbg_eval := debugger_manager.dbg_evaluator
				dbg_eval.reset
				dbg_eval.evaluate_attribute (Void, tgt, cl, f)
				if not dbg_eval.error_occurred then
					Result := dbg_eval.last_result_value
				end
				dbg_eval.reset
			end
		rescue
			rescued := True
			retry
		end

	function_evaluation_on (e: ABSTRACT_REFERENCE_VALUE; obj: DUMP_VALUE; f: FEATURE_I; cl: CLASS_C; params: LIST [DUMP_VALUE]): DUMP_VALUE
			-- Evaluation's result for `a_expr' in current context
			-- (note: Result = Void implies an error occurred)
		require
			is_stopped: is_stopped
			f_is_function: f.is_function
		local
			dbg_eval: DBG_EVALUATOR
			tgt: DUMP_VALUE
			rescued: BOOLEAN
		do
			if rescued then
				restore_assertion_check
				if dbg_eval /= Void then
					dbg_eval.reset
				end
			elseif is_stopped then
				tgt := obj
				if tgt = Void and e /= Void then
					tgt := e.dump_value
				end
				dbg_eval := debugger_manager.dbg_evaluator
				dbg_eval.reset
				disable_assertion_check
				if f.is_process_or_thread_relative_once then
					dbg_eval.evaluate_once (f)
				elseif f.is_object_relative_once then
					dbg_eval.evaluate_object_relative_once (Void, tgt, cl, f)
				else
					if tgt = Void then
						dbg_eval.evaluate_static_function (f, cl, params)
					else
						dbg_eval.evaluate_routine (Void, tgt, cl, f, params, tgt = Void)
					end
				end
				if not dbg_eval.error_occurred then
					Result := dbg_eval.last_result_value
				end
				restore_assertion_check
				dbg_eval.reset
			end
		rescue
			rescued := True
			retry
		end

	routine_evaluation_on (e: ABSTRACT_REFERENCE_VALUE; obj: DUMP_VALUE; f: FEATURE_I; cl: CLASS_C; params: LIST [DUMP_VALUE]): BOOLEAN
			-- Evaluation's result for `a_expr' in current context
			-- (note: Result = False implies an error occurred)
		require
			is_stopped: is_stopped
			f_is_routine: f.is_routine
		local
			dbg_eval: DBG_EVALUATOR
			tgt: DUMP_VALUE
			rescued: BOOLEAN
		do
			if rescued then
				restore_assertion_check
				if dbg_eval /= Void then
					dbg_eval.reset
				end
				Result := False
			elseif is_stopped then
				tgt := obj
				if tgt = Void and e /= Void then
					tgt := e.dump_value
				end

				dbg_eval := debugger_manager.dbg_evaluator
				dbg_eval.reset
				disable_assertion_check
				if f.is_process_or_thread_relative_once then
					dbg_eval.evaluate_once (f)
				elseif f.is_object_relative_once then
					dbg_eval.evaluate_object_relative_once (Void, tgt, cl, f)
					Result := not dbg_eval.error_occurred
				else
					if tgt = Void then
						dbg_eval.evaluate_static_function (f, cl, params)
					else
						dbg_eval.evaluate_routine (Void, tgt, cl, f, params, tgt = Void)
					end
					Result := not dbg_eval.error_occurred
				end
				restore_assertion_check
				dbg_eval.reset
			end
		rescue
			rescued := True
			retry
		end

feature {NONE} -- Breakpoints implementation

	update_breakpoints
			-- Synchronize breakpoints status between application and $EiffelGraphicalCompiler$.
		local
			lst: HASH_TABLE [INTEGER_32, BREAKPOINT_LOCATION] -- {BP_LOC => status}
		do
			debug ("debugger_trace_breakpoint")
				print (generator + ".update_breakpoints %N")
			end
			lst := Debugger_manager.breakpoints_manager.updated_breakpoints_locations_status
			if lst /= Void then
				from
					lst.start
				until
					lst.off
				loop
					update_breakpoint (lst.key_for_iteration, lst.item_for_iteration)
					lst.forth
				end
			end
		end

	send_execution_information (a_execution_mode: INTEGER; ign_bp: BOOLEAN)
			-- Send execution information
			-- mainly breakpoints for step operation
			-- and various call stack values
			-- called by `send_breakpoints'
			-- DO NOT CALL DIRECTLY
		do
			if ign_bp then
					-- remove all breakpoints set by the application.
					-- without changing their status under bench				
				debug("debugger_trace_breakpoint")
					print ("Ignoring breakpoints.%N")
				end
				send_no_breakpoints
			else
				update_breakpoints
			end
		end

	send_no_breakpoints
			-- Application execution without any breakpoint	
			-- Remove BreakPoints from the application ones in execution
			-- to perform a NoStopPoint operation
		local
			bps: BREAK_LIST
			loc: BREAKPOINT_LOCATION
		do
			debug("debugger_trace_breakpoint")
				print ("Ignoring breakpoints.%N")
			end
			bps := Debugger_manager.breakpoints_manager.breakpoints
			from
				bps.start
			until
				bps.off
			loop
				loc := bps.item_for_iteration.location
				if loc.is_set_for_application then
					debug ("debugger_trace_breakpoint")
						io.put_string_32 ({STRING_32} "REMOVE APPLICATION BP :: " + loc.debug_output + "%N")
					end
					unset_application_breakpoint (loc)
					-- then next time we go with StopPoint enable ... we'll add them again
				end
				bps.forth
			end
		end

	update_breakpoint (loc: BREAKPOINT_LOCATION; bp_mode: INTEGER)
			-- send a breakpoint to the application, and update the
			-- status of the sent breakpoint
		do
			inspect
				bp_mode
			when {BREAKPOINT}.breakpoint_to_add then
				debug("debugger_trace_breakpoint")
					io.put_string_32 ({STRING_32} "ADD BP :: " + loc.debug_output + "%N")
				end
				if loc.is_valid then
					set_application_breakpoint (loc)
				end
			when {BREAKPOINT}.Breakpoint_to_remove then
				debug ("debugger_trace_breakpoint")
					io.put_string_32 ({STRING_32} "DEL BP :: " + loc.debug_output + "%N")
				end
				unset_application_breakpoint (loc)
			else
				check bp_mode = {BREAKPOINT}.Breakpoint_do_nothing end
				debug ("debugger_trace_breakpoint")
					print ("KEEP BP %N")
				end
			end
		end

	set_application_breakpoint (loc: BREAKPOINT_LOCATION)
			-- enable breakpoint at `loc'
			-- if no breakpoint already exists at `loc' a breakpoint is created
		deferred
		end

	unset_application_breakpoint (loc: BREAKPOINT_LOCATION)
			-- remove breakpoint at `loc'
		deferred
		end

feature -- RT_EXTENSION constants (note: maybe this should be in a RTDBG_CONSTANTS class)

	Rtdbg_op_replay_record: INTEGER 	= 0	-- See eif_debug.h:RTDBG_OP_REPLAY_RECORD	+ {RT_EXTENSION}.Op_exec_replay_record 		
	Rtdbg_op_replay_back: INTEGER 		= 1	-- See eif_debug.h:RTDBG_OP_REPLAY_BACK		+ {RT_DBG_EXECUTION_RECORDER}.Direction_back 	
	Rtdbg_op_replay_forth: INTEGER 		= 2	-- See eif_debug.h:RTDBG_OP_REPLAY_FORTH	+ {RT_DBG_EXECUTION_RECORDER}.Direction_forth 	
	Rtdbg_op_replay_left: INTEGER 		= 3	-- See eif_debug.h:RTDBG_OP_REPLAY_LEFT 	+ {RT_DBG_EXECUTION_RECORDER}.Direction_left 	
	Rtdbg_op_replay_right: INTEGER 		= 4	-- See eif_debug.h:RTDBG_OP_REPLAY_RIGHT	+ {RT_DBG_EXECUTION_RECORDER}.Direction_right 	

feature -- Breakpoints control change

	ignore_breakpoints (b: BOOLEAN)
			-- If `b' then ignore breakpoints during execution
		do
			if ignoring_breakpoints /= b then
				ignoring_breakpoints := b
				if is_running and then not is_stopped then
					notify_breakpoints_change
				end
			end
		end

feature -- Catcall detection change

	set_catcall_detection_mode (a_console, a_dbg: BOOLEAN)
			-- Send a message to the application to set catcall detection mode
		require
			is_stopped: is_stopped
		deferred
		end

feature -- Assertion change

	disable_assertion_check
			-- Send a message to the application to disable assertion checking
		do
			last_assertion_check_stack.extend (impl_check_assert (False))
		end

	restore_assertion_check
			-- Send a message to the application to restore the previous assertion check status
		require
			restore_assertion_check_available: restore_assertion_check_available
		local
			b: BOOLEAN
		do
			b := last_assertion_check_stack.item
			last_assertion_check_stack.remove
			b := impl_check_assert (b)
		end

	restore_assertion_check_available: BOOLEAN
			-- Is `restore_assertion_check' available ?
		do
			Result := not last_assertion_check_stack.is_empty
		end

	last_assertion_check_stack: attached LINKED_STACK [BOOLEAN]
			-- Last assertion check value when it had been disabled by `disable_assertion_check'.

feature -- Assertion violation processing

	ignore_current_assertion_violation
			-- Send a message to the application to ignore current assertion violation
		do
			impl_ignore_current_assertion_violation (True)
		end

	unignore_current_assertion_violation
			-- Send a message to the application to unignore current assertion violation	
			-- i.e: normal processing of assertion violation (enter rescue if any)
		do
			impl_ignore_current_assertion_violation (False)
		end

feature {NONE} -- Assertion change Implementation

	impl_check_assert (b: BOOLEAN): BOOLEAN
			-- `check_assert (b)' on debuggee
			-- return previous assertion checking status
		deferred
		end

feature {NONE} -- Assertion violation processing		

	impl_ignore_current_assertion_violation (b: BOOLEAN)
			-- Tell the debuggee to ignore (or not) current assertion violation
		deferred
		end

feature -- Query

	onces_values (flist: LIST [E_FEATURE]; a_addr: DBG_ADDRESS; a_cl: CLASS_C): SPECIAL [ABSTRACT_DEBUG_VALUE]
			-- List of onces' value
		require
			flist_not_empty: flist /= Void and then not flist.is_empty
		deferred
		end

	object_relative_once_data (a_feat: FEATURE_I; a_addr: DBG_ADDRESS; a_cl: CLASS_C): TUPLE [called: BOOLEAN; exc: EXCEPTION_DEBUG_VALUE; res: ABSTRACT_DEBUG_VALUE]
			-- Data related to object relative once
		require
			feat_attached: a_feat /= Void
			cl_attached: a_cl /= Void
			is_object_relative_once: a_feat.is_object_relative_once
			addr_not_void: a_addr /= Void and then not a_addr.is_void
		deferred
		end

	dump_value_at_address (a_addr: DBG_ADDRESS): DUMP_VALUE
		require
			a_addr /= Void
		deferred
		end

	debug_value_at_address (a_addr: DBG_ADDRESS): ABSTRACT_DEBUG_VALUE
		require
			a_addr /= Void
		deferred
		end

	get_exception_value_details	(e: EXCEPTION_DEBUG_VALUE; a_details_level: INTEGER)
			-- Code, Tag, Message from `val'.
		require
			e_not_void: e /= Void
			e_has_value: e.has_value
		deferred
		end

	object_internal_info (a_value: DUMP_VALUE): detachable SPECIAL [TUPLE [name: STRING_32; value: STRING_32]]
			-- Get the `generating_type' as STRING by evaluation on the debuggee
		require
			a_value_attached: a_value /= Void
		local
			i,p: INTEGER
			s,n,v: STRING_32
		do
			if a_value.is_void then
				Result := Void
			else
				if
					attached remote_rt_object as rto and then
					attached rto.object_runtime_info_string_evaluation (a_value, Void) as l_representation
				then
					create Result.make_empty (l_representation.occurrences (';') + 1)
					i := 0
					across
						l_representation.split (';') as ic
					loop
						s := ic.item
						p := s.index_of ('=', 1)
						if p > 0 then
							n := s.head (p - 1)
							n.adjust
							v := s.substring (p + 1, s.count)
							v.adjust
							Result.extend ([n, v])
						end
					end
				else
					create Result.make_empty (0)
				end
			end
		ensure
			result_attached: Result /= Void
		end

	internal_type_name_of_type (a_type_id: INTEGER): detachable STRING_32
			-- Internal type_name_of_type for `a_type_id'
			--| note: a_type_id is the runtime type_id (so don't forget to -1 from eiffel type id)
		require
			is_stopped: is_stopped
		local
			l_type_value: DUMP_VALUE
			l_int, l_dv: DUMP_VALUE
			eval: DBG_EVALUATOR
			f: FEATURE_I
			params: ARRAYED_LIST [DUMP_VALUE]
			dbg: like debugger_manager
		do
				-- FIXME(sept2014): probably reuse remote_rt_object
				-- and avoid creating new instance of REFLECTOR
			dbg := debugger_manager
			if attached dbg.compiler_data.reflector_class_c as l_reflector_cl then
				eval := dbg.dbg_evaluator
				eval.reset
				eval.create_empty_instance_of (l_reflector_cl.actual_type)
				if not eval.error_occurred then
					l_int := eval.last_result_value
					eval.reset
					if l_int /= Void then
						create params.make (1)
						l_type_value := dbg.dump_value_factory.new_integer_32_value (a_type_id, dbg.compiler_data.integer_32_class_c)
						params.extend (l_type_value)
						f := l_reflector_cl.feature_named_32 ("type_name_of_type")
						if f /= Void then
							eval.reset
							eval.evaluate_routine (Void, l_int, l_reflector_cl, f, params, False)
							if not eval.error_occurred then
								l_dv := eval.last_result_value
								if l_dv /= Void then
									Result := l_dv.string_representation
								end
							end
							eval.reset
						end
					end
				end
			end
		end

feature -- Parameters

	parameters: DEBUGGER_EXECUTION_RESOLVED_PROFILE
			-- Parameters used to run Application

feature -- Setting

	frozen set_execution_mode (exec_mode: like execution_mode)
			-- Set `exec_mode' the new execution mode.
		require
			valid_exec_mode: (create {EXEC_MODES}).is_valid_mode (exec_mode)
		do
			execution_mode := exec_mode
		ensure
			set: execution_mode = exec_mode
		end

	report_error
		do
			set_error_reported (True)
		end

	set_error_reported (b: BOOLEAN)
		do
			error_reported := b
		end

	set_current_execution_stack_number (i: INTEGER)
			-- Set the `current_execution_stack_number' to `i'.
			--| If `current_execution_stack_number' is greater than
			--| the number of stack elements then
			--| `current_execution_stack_number' will be set
			--| to the last element.
		require
			is_stopped: is_stopped
--			positive_i: i > 0
			small_enough: (i = 1) or else (i <= number_of_stack_elements)
		do
			current_execution_stack_number := i
		ensure
			set: current_execution_stack_number = i
		end

	update_critical_stack_depth (d: INTEGER)
			-- Call stack depth at which we warn the user against a possible stack overflow.
			-- -1 never warns the user.
		require
			valid_depth: d = -1 or d > 0
		do
		end

feature -- Environment related

	environment_variables_to_native_string (env: detachable HASH_TABLE [STRING_32, STRING_32]): detachable NATIVE_STRING
			-- String representation of the Environment variables
		local
			s32: STRING_32
			k,v: STRING_32
			lst: LIST [STRING_32]
		do
			if env /= Void then
				lst := Debugger_manager.sorted_comparable_string32_keys_from (env)

				create s32.make (512)
				from
					lst.start
				until
					lst.after
				loop
					k := lst.item_for_iteration
					v := env.item (k)
					if k /= Void and then v /= Void then
						s32.append (k)
						s32.append_character ('=')
						s32.append (v)
						s32.append_character ('%U')
					end
					lst.forth
				end
				s32.append_character ('%U')
				create Result.make (s32)
			end
		ensure
			Result = Void implies (env = Void or else env.is_empty)
		end

feature {DEAD_HDLR, EWB_REQUEST} -- Setting

	build_status
			-- Build associated `status'
			-- (ie: the application is running)
		require
			is_not_running: not is_running
		deferred
		ensure
			is_running: is_running
		end

	destroy_status
		require
			is_running: is_running
		do
			status := Void
		ensure
			is_not_running: not is_running
		end

feature {NONE} -- fake

	clean_on_process_termination
			-- Process the termination of the executed
			-- application. Also execute the `termination_command'.
		require
			is_running: is_running
		do
			last_assertion_check_stack.wipe_out
		end

	run_with_env_string (app: PATH; args: READABLE_STRING_32; wd: detachable PATH; env: detachable NATIVE_STRING)
			-- Run application with arguments `args' in directory `wd'.
			-- If `is_running' is false after the
			-- execution of this routine, it means that
			-- the application was unable to be launched
			-- due to the time_out (see `eiffel_timeout_message').
			-- Before running the application you must check
			-- to see if the debugged information is up to date.
		require
			app_not_void: app /= Void
			args_attached: args /= Void
			application_not_running: not is_running
			application_exists: exists
			non_negative_interrupt: debugger_manager.interrupt_number >= 0
		deferred
		ensure
			successful_app_is_not_stopped: is_running implies not is_stopped
		end

	attach_using_port (app: PATH; a_port: INTEGER)
		require
			app_not_void: app /= Void
			application_not_running: not is_running
			application_exists: exists
			non_negative_interrupt: debugger_manager.interrupt_number >= 0
		deferred
		ensure
			successful_app_is_not_stopped: is_running implies not is_stopped
		end

	keep_only_objects (kept_objects: LIST [DBG_ADDRESS])
			-- Remove all ref kept, and keep only the ones contained in `a_addresses'
		deferred
		end

note
	copyright:	"Copyright (c) 1984-2023, Eiffel Software"
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
