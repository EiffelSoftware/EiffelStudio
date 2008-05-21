indexing
	description	: "Controls execution of debugged application."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date		: "$Date$"
	revision	: "$Revision $"

deferred
class APPLICATION_EXECUTION

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

	make_with_debugger (dbg: like debugger_manager) is
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

	recycle is
			-- Clean debugging session data
		do
			debugger_manager.object_manager.reset
			if is_running then
				destroy_status
			end
		end

feature -- Execution event callbacks

	frozen on_application_before_resuming is
		require
			Debugger_manager_not_void: debugger_manager /= Void
		do
			Debugger_manager.on_application_before_resuming
		end

	frozen on_application_resumed is
		require
			Debugger_manager_not_void: debugger_manager /= Void
		do
			Debugger_manager.on_application_resumed
		end

	frozen on_application_before_paused is
		require
			Debugger_manager_not_void: debugger_manager /= Void
		do
			Debugger_manager.on_application_before_paused
		end

	frozen on_application_paused is
		require
			Debugger_manager_not_void: debugger_manager /= Void
		do
			Debugger_manager.on_application_paused
		end

	frozen on_application_just_stopped is
		require
			Debugger_manager_not_void: debugger_manager /= Void
		do
			Debugger_manager.on_application_just_stopped
		end

	frozen on_application_quit is
		require
			Debugger_manager_not_void: debugger_manager /= Void
		do
			Debugger_manager.on_application_quit
		end

	frozen on_application_debugger_update is
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

	current_execution_stack_number: INTEGER
			-- Stack number currently displaying the locals and arguments

feature -- Status

	is_running: BOOLEAN is
			-- Is the application running?
		require
			Debugger_manager_not_void: debugger_manager /= Void
		do
			Result := status /= Void
		ensure
			yes_implies_non_void_status: Result implies status /= Void
		end

	is_stopped: BOOLEAN is
			-- Is the application stopped in its execution?
		require
			Debugger_manager_not_void: debugger_manager /= Void
			is_running: is_running
		do
			Result := status.is_stopped
		ensure
			yes_implies_status_is_stop: Result implies status.is_stopped
		end

	exists: BOOLEAN is
			-- Does the application file exists?
		local
			f: PLAIN_TEXT_FILE
		do
			create f.make (Eiffel_system.application_name (True))
			Result := f.exists
		end

	is_valid_object_address (addr: STRING): BOOLEAN is
			-- Is object address `addr' valid?
			-- (i.e Does bench know about it)
		require
			is_running: is_running
			is_stopped: is_stopped
		do
			Result := addr /= Void
		end

feature -- Access

	can_not_launch_system_message: STRING is
			-- Message displayed when estudio is unable to launch the system
		do
			Result := debugger_names.w_Cannot_launch_system.as_string_8
		end

	number_of_stack_elements: INTEGER is
			-- Total number of the call stack elements in
			-- exception stack
		require
			is_running: is_running
			is_stopped: is_stopped
		do
			if {ecs: EIFFEL_CALL_STACK} status.current_call_stack then
				Result := ecs.count
			end
		end

	current_call_stack_depth: INTEGER is
			-- Current call stack's depth
		require
			is_running: is_running
			is_stopped: is_stopped
		do
			if {ecs: EIFFEL_CALL_STACK} status.current_call_stack then
				Result := ecs.stack_depth
			end
		end

	current_call_stack_is_empty: BOOLEAN is
			-- Is Class stack empty ?
		do
			Result := number_of_stack_elements = 0
		end

feature {DEAD_HDLR, STOPPED_HDLR, SHARED_DEBUGGER_MANAGER, APPLICATION_EXECUTION} -- Implemenation

	process_termination is
			-- Process the termination of the executed
			-- application. Also execute the `termination_command'.
		require
			is_running: is_running
		do
			Debugger_manager.restore_debugger_data

			clean_on_process_termination

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

	run (params: DEBUGGER_EXECUTION_PARAMETERS) is
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
			l_envstr: STRING_32
			env: HASH_TABLE [STRING_32, STRING_32]
			args, app: STRING
			ctlr: DEBUGGER_CONTROLLER
		do
			parameters := params
			ctlr := debugger_manager.controller
			args := params.arguments
			if args = Void then
				create args.make_empty
			end
			env := ctlr.environment_variables_updated_with (params.environment_variables, True)
			l_envstr := environment_variables_to_string (env)
			app := Eiffel_system.application_name (True)
			run_with_env_string (app, args, params.working_directory, l_envstr)
		ensure
			successful_app_is_not_stopped: is_running implies not is_stopped
		end

	release_all_but_kept_object is
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

	continue is
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
			release_all_but_kept_object
			continue_ignoring_kept_objects
		end

	continue_ignoring_kept_objects is
			-- Continue the running of the application
			-- before any debugger's operation occurred
			-- so basically, we are sure we have the same `kept_objects'
		require
			is_running: is_running
			is_stopped: is_stopped
			non_negative_interrupt: debugger_manager.interrupt_number >= 0
		deferred
		end

	send_breakpoints is
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
			inspect execution_mode
			when {EXEC_MODES}.Run then
				if ignoring_breakpoints then
						-- remove all breakpoints set by the application.
						-- without changing their status under bench				
					debug("debugger_trace_breakpoint")
						print ("Ignoring breakpoints.%N")
					end
					send_no_breakpoints
				else
					update_breakpoints
				end
			when {EXEC_MODES}.step_into,
			 	 {EXEC_MODES}.Step_next,
			 	 {EXEC_MODES}.step_out then
				send_breakpoints_for_stepping (execution_mode, ignoring_breakpoints)
			else
				-- Unknown execution mode. Do nothing.
			end
			bpm.reset_breakpoints_changed
		end

	interrupt is
			-- Send an interrupt to the application
			-- which will stop at the next breakable line number
		require
			app_is_running: is_running
			not_stopped: not is_stopped
		deferred
		end

	request_debugger_data_update is
			-- Request the application to pause, in order to update debugger data
			-- such as new breakpoints, or other catcall detection,...
			-- mainly for classic debugging
		do
		end

	notify_breakpoints_change is
			-- Send an interrupt to the application
			-- which will stop at the next breakable line number
			-- in order to record the new breakpoint(s) before
			-- automatically resuming its execution.
		require
			app_is_running: is_running
			not_stopped: not is_stopped
		deferred
		end

	kill is
			-- Ask the application to terminate itself.
		require
			app_is_running: is_running
		deferred
		end

feature -- Remote access to RT_

	remote_rt_object: ABSTRACT_DEBUG_VALUE is
			-- Return the remote rt_object
		deferred
		end

	remote_rt_execution_recorder_value: DUMP_VALUE is
			-- Return the remote rt_object.execution_recorder
		do
			if {rto: ABSTRACT_REFERENCE_VALUE} remote_rt_object then
				Result := query_evaluation_on (rto, Void, rto.dynamic_class, "execution_recorder", Void)
			end
		end

	activate_execution_replay_recording (b: BOOLEAN): BOOLEAN is
			-- Activate Execution replay recording on debuggee depending of `b'
		local
			params: ARRAYED_LIST [DUMP_VALUE]
			dv_fact: DUMP_VALUE_FACTORY
			ct: CLASS_TYPE
			fi: FEATURE_I
			i32cl: CLASS_C
			ref: DUMP_VALUE
			cid,fid,dep,line: INTEGER
			dbg: DEBUGGER_MANAGER
		do
			check execution_replay_recording_not_b: b /= status.replay_recording end
			status.set_replay_recording (b)
			check status.replay_recording = b end

			if {rto: ABSTRACT_REFERENCE_VALUE} remote_rt_object then
				dbg := debugger_manager
				dv_fact := dbg.dump_value_factory
				i32cl := dbg.compiler_data.integer_32_class_c

				cid := 0
				fid := 0
				dep := 1
				line := 0
				if b then
					if {ecse: EIFFEL_CALL_STACK_ELEMENT} status.current_eiffel_call_stack_element then
						if {adv: ABSTRACT_DEBUG_VALUE} ecse.current_object_value then
							ref := adv.dump_value
						end
						ct := ecse.dynamic_type
						fi := ecse.routine_i

							--| Don't forget to withdraw "-1" to convert compiler id to runtime id !
						cid := ct.type_id - 1
						if fi.valid_body_id then
							fid := fi.real_body_id (ct) - 1
						else
							fid := fi.body_index - 1
						end
						line := ecse.break_index
					end
					dep := dep.max (current_call_stack_depth)
				end
				if ref = Void then
					ref := dv_fact.new_void_value (dbg.compiler_data.any_class_c)
				end
				create params.make (6) -- 	(b: BOOLEAN; ref: ANY; cid: INTEGER; fid: INTEGER; dep: INTEGER; break_index: INTEGER)
				params.extend (dv_fact.new_boolean_value (b, debugger_manager.compiler_data.boolean_class_c))
				params.extend (ref) -- ref				
				params.extend (dv_fact.new_integer_32_value (cid, i32cl)) -- cid
				params.extend (dv_fact.new_integer_32_value (fid, i32cl)) -- fid
				params.extend (dv_fact.new_integer_32_value (dep, i32cl)) -- dep
				params.extend (dv_fact.new_integer_32_value (line, i32cl)) -- break_index

				Result := command_evaluation_on (rto, Void, rto.dynamic_class, "activate_execution_replay_recording", params)
			end
		ensure
			execution_replay_recording: status.replay_recording = b
		end

	activate_execution_replay_mode (b: BOOLEAN) is
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
				if {ccs: EIFFEL_CALL_STACK} status.current_call_stack then
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

	remote_activate_replay (b: BOOLEAN) is
			-- Remotely Activate replay
		local
			params: ARRAYED_LIST [DUMP_VALUE]
			dv_fact: DUMP_VALUE_FACTORY
			dbg: DEBUGGER_MANAGER
			res: BOOLEAN
		do
			if {ex_rec_dv: DUMP_VALUE} remote_rt_execution_recorder_value and then not ex_rec_dv.is_void then
				dbg := debugger_manager
				dv_fact := dbg.dump_value_factory
				create params.make (1)
				params.extend (dv_fact.new_boolean_value (b, dbg.compiler_data.boolean_class_c))
				res := command_evaluation_on (Void, ex_rec_dv, ex_rec_dv.dynamic_class, "activate_replay", params)
				if res and then {rcse: REPLAYED_CALL_STACK_ELEMENT} current_replayed_call then
					status.set_current_replayed_call (rcse)
				else
					status.set_current_replayed_call (Void)
				end
			end
		end

	replay (direction: INTEGER): BOOLEAN is
			-- Replay execution in `direction'
			-- and return True if operation succeed.
		require
			app_is_stopped: is_stopped
			replay_activated: status.replay_activated
		local
			prev_d, d: INTEGER
			params: ARRAYED_LIST [DUMP_VALUE]
			dv_fact: DUMP_VALUE_FACTORY
			i32cl: CLASS_C
			dir, nb: INTEGER
			dbg: DEBUGGER_MANAGER
		do
			dir := direction
			prev_d := status.replayed_depth

			nb := 1

			if {ex_rec_dv: DUMP_VALUE} remote_rt_execution_recorder_value and then not ex_rec_dv.is_void then
				dbg := debugger_manager
				dv_fact := dbg.dump_value_factory
				i32cl := dbg.compiler_data.integer_32_class_c
				create params.make (2)
				params.extend (dv_fact.new_integer_32_value (dir, i32cl))
				params.extend (dv_fact.new_integer_32_value (nb, i32cl))

				if {ccs: EIFFEL_CALL_STACK} status.current_call_stack then
					ccs.reset_call_stack_depth (prev_d)
					Result := command_evaluation_on (Void, ex_rec_dv, ex_rec_dv.dynamic_class, "replay", params)
					if Result then
						if {rcse: REPLAYED_CALL_STACK_ELEMENT} current_replayed_call then
							status.set_current_replayed_call (rcse)
						else
							check should_not_occur: False end
						end
					else
						--| Error, so keep current data
						--| Note: or maybe ... popup error message, and exit debugging ..?
--						status.set_current_replayed_call (Void)
					end
					d := status.replayed_depth
					if d > 0 then
						ccs.reset_call_stack_depth (d)
					end
					debugger_manager.incremente_debugging_operation_id
				end
			end
		end

	replay_to_point (a_id: STRING): BOOLEAN is
			-- Replay to point identified by `a_id'
		local
			params: ARRAYED_LIST [DUMP_VALUE]
			dv_fact: DUMP_VALUE_FACTORY
			dbg: DEBUGGER_MANAGER
			prev_d,d1,d2: INTEGER
		do
			if {ex_rec_dv: DUMP_VALUE} remote_rt_execution_recorder_value and then not ex_rec_dv.is_void then
				prev_d := status.replayed_depth

				dbg := debugger_manager
				dv_fact := dbg.dump_value_factory
				create params.make (1)
				params.extend (dv_fact.new_manifest_string_value (a_id, dbg.compiler_data.string_8_class_c))
				Result := command_evaluation_on (Void, ex_rec_dv, ex_rec_dv.dynamic_class, "replay_to_point", params)
				if Result then
					if {rcse: REPLAYED_CALL_STACK_ELEMENT} current_replayed_call then
						status.set_current_replayed_call (rcse)
					else
						check should_not_occur: False end
					end
				else
					--| Error, so keep current data
					--| Note: or maybe ... popup error message, and exit debugging ..?
--						status.set_current_replayed_call (Void)
				end
				if {ccs: EIFFEL_CALL_STACK} status.current_call_stack then
					from
						d2 := status.replayed_depth
						if d2 > prev_d then
							d1 := prev_d
						else
							d1 := d2
							d2 := prev_d
						end
					until
						d1 > d2
					loop
						ccs.reset_call_stack_depth (d1)
						d1 := d1 + 1
					end
				end
				debugger_manager.incremente_debugging_operation_id
			end
		end

	query_replay_status (direction: INTEGER): INTEGER is
			-- Query exec replay status for direction `direction'
			-- Return the number of available steps.
		local
			params: ARRAYED_LIST [DUMP_VALUE]
			dv_fact: DUMP_VALUE_FACTORY
			i32cl: CLASS_C
			dv: DUMP_VALUE
			dir: INTEGER
			dbg: DEBUGGER_MANAGER
		do
			dir := direction
			if {ex_rec_dv: DUMP_VALUE} remote_rt_execution_recorder_value and then not ex_rec_dv.is_void then
				dbg := debugger_manager
				dv_fact := dbg.dump_value_factory
				i32cl := dbg.compiler_data.integer_32_class_c
				create params.make (1)
				params.extend (dv_fact.new_integer_32_value (dir, i32cl))
				dv := query_evaluation_on (Void, ex_rec_dv, ex_rec_dv.dynamic_class, "replay_query", params)
				if dv.is_basic then
					Result := dv.as_dump_value_basic.value_integer_32
				end
			end
		end

	current_replayed_call: REPLAYED_CALL_STACK_ELEMENT is
		local
			dv_fact: DUMP_VALUE_FACTORY
			dv: DUMP_VALUE
			dbg: DEBUGGER_MANAGER
		do
			if {ex_rec_dv: DUMP_VALUE} remote_rt_execution_recorder_value and then not ex_rec_dv.is_void then
				dbg := debugger_manager
				dv_fact := dbg.dump_value_factory
				dv := query_evaluation_on (Void, ex_rec_dv, ex_rec_dv.dynamic_class, "replayed_call_details", Void)
				if dv /= Void and then not dv.is_void then
					if {s32: STRING_32} dv.string_representation and then s32.count > 0 then
						create Result.make_from_string ("" , s32)
					end
				end
			end
		end

	replay_callstack_details (a_id: STRING; nb: INTEGER): REPLAYED_CALL_STACK_ELEMENT is
			-- Details related to replayed callstack identified by `a_id'
			-- get the information for `nb' levels
		local
			params: ARRAYED_LIST [DUMP_VALUE]
			dv_fact: DUMP_VALUE_FACTORY
			dv: DUMP_VALUE
			dbg: DEBUGGER_MANAGER
		do
			if {ex_rec_dv: DUMP_VALUE} remote_rt_execution_recorder_value and then not ex_rec_dv.is_void then
				dbg := debugger_manager
				dv_fact := dbg.dump_value_factory
				create params.make (2)
				params.extend (dv_fact.new_manifest_string_value (a_id, dbg.compiler_data.string_8_class_c))
				params.extend (dv_fact.new_integer_32_value (nb, dbg.compiler_data.integer_32_class_c))
				dv := query_evaluation_on (Void, ex_rec_dv, ex_rec_dv.dynamic_class, "callstack_record_details", params)
				if dv /= Void and then not dv.is_void then
					if {s32: STRING_32} dv.string_representation and then s32.count > 0 then
						create Result.make_from_string (a_id , s32)
					end
				end
			end
		end

	remotely_store_object (oa: STRING; fn: STRING): BOOLEAN is
			-- Store in file `fn' on the application the object addressed by `oa'
			-- Return True is succeed.
		local
			params: ARRAYED_LIST [DUMP_VALUE]
			dv_fact: DUMP_VALUE_FACTORY
			ref_dv, fn_dv: DUMP_VALUE
			dbg: DEBUGGER_MANAGER
		do
			if {rto: ABSTRACT_REFERENCE_VALUE} remote_rt_object then
				dbg := debugger_manager
				dv_fact := dbg.dump_value_factory
				ref_dv := dv_fact.new_object_value (oa, Void)
				fn_dv := dv_fact.new_manifest_string_value (fn, dbg.compiler_data.string_8_class_c)

				create params.make (2)
				params.extend (ref_dv) -- ref
				params.extend (dv_fact.new_manifest_string_value (fn, dbg.compiler_data.string_8_class_c)) -- fn

				Result := query_evaluation_on (rto, Void, rto.dynamic_class, "saved_object_to", params) /= Void
			end
		end

	remotely_loaded_object (oa: STRING; fn: STRING): DUMP_VALUE is
			-- Debug value related to remote loaded object from file `fn'.
			-- and if `oa' is not Void, copy the value inside object addressed by `oa'.
		local
			params: ARRAYED_LIST [DUMP_VALUE]
			dv_fact: DUMP_VALUE_FACTORY
			ref_dv, fn_dv: DUMP_VALUE
			dbg: DEBUGGER_MANAGER
		do
			if {rto: ABSTRACT_REFERENCE_VALUE} remote_rt_object then
				dbg := debugger_manager
				dv_fact := dbg.dump_value_factory
				if oa /= Void then
					ref_dv := dv_fact.new_object_value (oa, Void)
				else
					ref_dv := dv_fact.new_void_value (dbg.compiler_data.any_class_c)
				end
				fn_dv := dv_fact.new_manifest_string_value (fn, dbg.compiler_data.string_8_class_c)

				create params.make (2)
				params.extend (ref_dv) -- ref
				params.extend (dv_fact.new_manifest_string_value (fn, dbg.compiler_data.string_8_class_c)) -- fn

				Result := query_evaluation_on (rto, Void, rto.dynamic_class, "object_loaded_from", params)
			end
		end


feature -- Remote access to Exceptions

	remote_current_exception_value: EXCEPTION_DEBUG_VALUE is
			-- `{EXCEPTION_MANAGER}.last_exception' value.
		require
			exception_occurred: status.exception_occurred
		deferred
		ensure
			Result_not_void: Result /= Void
		end

feature -- Expression evaluation

	string_field_evaluation_on (e: ABSTRACT_REFERENCE_VALUE; edv: DUMP_VALUE; cl: CLASS_C; fname: STRING): STRING_32 is
			-- String representation of `{cl}.fname' evaluated on `edv'.
		require
			edv_not_void: edv /= Void
			cl_not_void: cl /= Void
		local
			dv: DUMP_VALUE
		do
			dv := query_evaluation_on (e, edv, cl, fname, Void)
			if dv /= Void and then dv.has_formatted_output then
				Result := dv.string_representation
			end
		end

	query_evaluation_on (e: ABSTRACT_REFERENCE_VALUE; edv: DUMP_VALUE; cl: CLASS_C; fname: STRING; params: LIST [DUMP_VALUE]): DUMP_VALUE is
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
			f := cl.feature_named (fname)
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

	command_evaluation_on (e: ABSTRACT_REFERENCE_VALUE; edv: DUMP_VALUE; cl: CLASS_C; fname: STRING; params: LIST [DUMP_VALUE]): BOOLEAN is
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
			f := cl.feature_named (fname)
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

	function_evaluation_on (e: ABSTRACT_REFERENCE_VALUE; obj: DUMP_VALUE; f: FEATURE_I; cl: CLASS_C; params: LIST [DUMP_VALUE]): DUMP_VALUE is
			-- Evaluation's result for `a_expr' in current context
			-- (note: Result = Void implies an error occurred)
		require
			is_stopped: is_stopped
			f_is_function: f.is_function
		local
			dbg_eval: DBG_EVALUATOR
			tgt: DUMP_VALUE
		do
			if is_stopped then
				tgt := obj
				if tgt = Void and e /= Void then
					tgt := e.dump_value
				end
				dbg_eval := debugger_manager.dbg_evaluator
				dbg_eval.reset
				disable_assertion_check
				if tgt = Void then
					dbg_eval.evaluate_static_function (f, cl, params)
				else
					dbg_eval.evaluate_routine (Void, tgt, cl, f, params, tgt = Void)
				end
				if not dbg_eval.error_occurred then
					Result := dbg_eval.last_result_value
				end
				restore_assertion_check
				dbg_eval.reset
			end
		end

	routine_evaluation_on (e: ABSTRACT_REFERENCE_VALUE; obj: DUMP_VALUE; f: FEATURE_I; cl: CLASS_C; params: LIST [DUMP_VALUE]): BOOLEAN is
			-- Evaluation's result for `a_expr' in current context
			-- (note: Result = Void implies an error occurred)
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
			else
				if is_stopped then
					tgt := obj
					if tgt = Void and e /= Void then
						tgt := e.dump_value
					end
					if tgt /= Void then
						disable_assertion_check
						dbg_eval := debugger_manager.dbg_evaluator
						dbg_eval.reset

						dbg_eval.evaluate_routine (Void, tgt, cl, f, params, tgt = Void)
						Result := not dbg_eval.error_occurred
						restore_assertion_check
						dbg_eval.reset
					end
				end
			end
		rescue
			rescued := True
			retry
		end

	attribute_evaluation_on (e: ABSTRACT_REFERENCE_VALUE; obj: DUMP_VALUE; f: FEATURE_I; cl: CLASS_C): DUMP_VALUE is
			-- Evaluation's result for `a_expr' in current context
			-- (note: Result = Void implies an error occurred)
		require
			is_stopped: is_stopped
		local
			dbg_eval: DBG_EVALUATOR
			tgt: DUMP_VALUE
		do
			if is_stopped then
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
		end

feature {NONE} -- Breakpoints implementation

	update_breakpoints is
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

	send_breakpoints_for_stepping (a_execution_mode: INTEGER; ign_bp: BOOLEAN) is
			-- Send breakpoints for step operation
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

	send_no_breakpoints is
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
						print ("REMOVE APPLICATION BP :: " + loc.debug_output + "%N")
					end
					unset_application_breakpoint (loc)
					-- then next time we go with StopPoint enable ... we'll add them again
				end
				bps.forth
			end
		end

	update_breakpoint (loc: BREAKPOINT_LOCATION; bp_mode: INTEGER) is
			-- send a breakpoint to the application, and update the
			-- status of the sent breakpoint
		do
			inspect
				bp_mode
			when {BREAKPOINT}.breakpoint_to_add then
				debug("debugger_trace_breakpoint")
					print ("ADD BP :: " + loc.debug_output + "%N")
				end
				if loc.is_valid then
					set_application_breakpoint (loc)
				end
			when {BREAKPOINT}.Breakpoint_to_remove then
				debug ("debugger_trace_breakpoint")
					print ("DEL BP :: " + loc.debug_output + "%N")
				end
				unset_application_breakpoint (loc)
			else
				check bp_mode = {BREAKPOINT}.Breakpoint_do_nothing end
				debug ("debugger_trace_breakpoint")
					print ("KEEP BP %N")
				end
			end
		end

	set_application_breakpoint (loc: BREAKPOINT_LOCATION) is
			-- enable breakpoint at `loc'
			-- if no breakpoint already exists at `loc' a breakpoint is created
		deferred
		end

	unset_application_breakpoint (loc: BREAKPOINT_LOCATION) is
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

	ignore_breakpoints (b: BOOLEAN) is
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

	set_catcall_detection_mode (a_console, a_dbg: BOOLEAN) is
			-- Send a message to the application to set catcall detection mode
		require
			is_stopped: is_stopped
		deferred
		end

feature -- Assertion change

	disable_assertion_check is
			-- Send a message to the application to disable assertion checking
		local
			b: BOOLEAN
		do
			b := impl_check_assert (False)
			last_assertion_check_stack.extend (b)
		end

	restore_assertion_check is
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

	restore_assertion_check_available: BOOLEAN is
			-- Is `restore_assertion_check' available ?
		do
			Result := not last_assertion_check_stack.is_empty
		end

	last_assertion_check_stack: !LINKED_STACK [BOOLEAN]
			-- Last assertion check value when it had been disabled by `disable_assertion_check'.

feature {NONE} -- Assertion change Implementation

	impl_check_assert (b: BOOLEAN): BOOLEAN is
			-- `check_assert (b)' on debuggee
		deferred
		end

feature -- Query

	onces_values (flist: LIST [E_FEATURE]; a_addr: STRING; a_cl: CLASS_C): ARRAY [ABSTRACT_DEBUG_VALUE] is
		require
			flist_not_empty: flist /= Void and then not flist.is_empty
		deferred
		end

	dump_value_at_address_with_class (a_addr: STRING; a_cl: CLASS_C): DUMP_VALUE is
		require
			a_addr /= Void
		deferred
		end

	debug_value_at_address_with_class (a_addr: STRING; a_cl: CLASS_C): ABSTRACT_DEBUG_VALUE is
		require
			a_addr /= Void
		deferred
		end

	get_exception_value_details	(e: EXCEPTION_DEBUG_VALUE; full_details: BOOLEAN) is
			-- Code, Tag, Message from `val'.
		require
			e_not_void: e /= Void
			e_has_value: e.has_value
		deferred
		end

	internal_info (a_value: DUMP_VALUE): ARRAY [TUPLE [name: STRING; value: DUMP_VALUE]] is
			-- Internal info for `a_addr'
		require
			is_stopped: is_stopped
		local
			l_int, l_dv: DUMP_VALUE
			l_int_cl: CLASS_C
			eval: DBG_EVALUATOR
			n: STRING
			f: FEATURE_I
			params: ARRAYED_LIST [DUMP_VALUE]
			l_info: ARRAY [STRING]
			i: INTEGER
		do
			l_int_cl := debugger_manager.compiler_data.internal_class_c
			eval := debugger_manager.dbg_evaluator

			eval.reset
			eval.create_empty_instance_of (l_int_cl.actual_type)
			if not eval.error_occurred then
				l_int := eval.last_result_value
				eval.reset
				if l_int /= Void then
					l_info := <<
								"class_name",
								"type_name",
								"dynamic_type",
								"field_count",
								"deep_physical_size",
								"physical_size"
								>>
					create Result.make (l_info.lower, l_info.upper)
					from
						create params.make (1)
						params.extend (a_value)

						i := l_info.lower
					until
						i > l_info.upper
					loop
						n := l_info[i]
						f := l_int_cl.feature_named (n)
						l_dv := Void
						if f /= Void then
							eval.reset
							eval.evaluate_routine (Void, l_int, l_int_cl, f, params, False)
							if not eval.error_occurred then
								l_dv := eval.last_result_value
							end
							eval.reset
						end
						Result[i] := [n, l_dv]
						i := i + 1
					end
				end
			end
		end

	internal_type_name_of_type (a_type_id: INTEGER): STRING is
			-- Internal type_name_of_type for `a_type_id'
			--| note: a_type_id is the runtime type_id (so don't forget to -1 from eiffel type id)
		require
			is_stopped: is_stopped
		local
			l_type_value: DUMP_VALUE
			l_int, l_dv: DUMP_VALUE
			l_int_cl: CLASS_C
			eval: DBG_EVALUATOR
			f: FEATURE_I
			params: ARRAYED_LIST [DUMP_VALUE]
			dbg: like debugger_manager
		do
			dbg := debugger_manager
			l_int_cl := dbg.compiler_data.internal_class_c
			eval := dbg.dbg_evaluator

			eval.reset
			eval.create_empty_instance_of (l_int_cl.actual_type)
			if not eval.error_occurred then
				l_int := eval.last_result_value
				eval.reset
				if l_int /= Void then
					create params.make (1)
					l_type_value := dbg.dump_value_factory.new_integer_32_value (a_type_id, dbg.compiler_data.integer_32_class_c)
					params.extend (l_type_value)
					f := l_int_cl.feature_named ("type_name_of_type")
					if f /= Void then
						eval.reset
						eval.evaluate_routine (Void, l_int, l_int_cl, f, params, False)
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

feature -- Parameters

	parameters: DEBUGGER_EXECUTION_PARAMETERS
			-- Parameters used to run Application

feature -- Setting

	frozen set_execution_mode (exec_mode: like execution_mode) is
			-- Set `exec_mode' the new execution mode.
		require
			valid_exec_mode: (create {EXEC_MODES}).is_valid_mode (exec_mode)
		do
			execution_mode := exec_mode
		ensure
			set: execution_mode = exec_mode
		end

	set_current_execution_stack_number (i: INTEGER) is
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

	update_critical_stack_depth (d: INTEGER) is
			-- Call stack depth at which we warn the user against a possible stack overflow.
			-- -1 never warns the user.
		require
			valid_depth: d = -1 or d > 0
		do
		end

feature -- Environment related

	environment_variables_to_string (env: HASH_TABLE [STRING_32, STRING_32]): STRING_32 is
			-- String representation of the Environment variables
		local
			k,v: STRING_32
			lst: DS_LIST [STRING_32]
		do
			if env /= Void and then not env.is_empty then
				lst := Debugger_manager.sorted_comparable_string32_keys_from (env)

				create Result.make (512)
				from
					lst.start
				until
					lst.after
				loop
					k := lst.item_for_iteration
					v := env.item (k)
					if k /= Void and then v /= Void then
						Result.append (k)
						Result.append_character ('=')
						Result.append (v)
						Result.append_character ('%U')
					end
					lst.forth
				end
				Result.append_character ('%U')
			end
		ensure
			Result = Void implies (env = Void or else env.is_empty)
		end

feature {DEAD_HDLR, RUN_REQUEST} -- Setting

	build_status is
			-- Build associated `status'
			-- (ie: the application is running)
		require
			is_not_running: not is_running
		deferred
		ensure
			is_running: is_running
		end

	destroy_status is
		require
			is_running: is_running
		do
			status := Void
		ensure
			is_not_running: not is_running
		end

feature {NONE} -- fake

	clean_on_process_termination is
			-- Process the termination of the executed
			-- application. Also execute the `termination_command'.
		require
			is_running: is_running
		do
			last_assertion_check_stack.wipe_out
		end

	run_with_env_string (app, args, cwd: STRING; env: STRING_GENERAL) is
			-- Run application with arguments `args' in directory `cwd'.
			-- If `is_running' is false after the
			-- execution of this routine, it means that
			-- the application was unable to be launched
			-- due to the time_out (see `eiffel_timeout_message').
			-- Before running the application you must check
			-- to see if the debugged information is up to date.
		require
			app_not_void: app /= Void
			application_not_running: not is_running
			application_exists: exists
			non_negative_interrupt: debugger_manager.interrupt_number >= 0
		deferred
		ensure
			successful_app_is_not_stopped: is_running implies not is_stopped
		end

	keep_only_objects (kept_objects: LIST [STRING]) is
			-- Remove all ref kept, and keep only the ones contained in `a_addresses'
		deferred
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
