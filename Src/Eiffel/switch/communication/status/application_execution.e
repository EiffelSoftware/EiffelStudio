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

	on_resumed is
			-- Clean cached data valid only during the current stepping
		do
			debugger_manager.object_manager.reset
		end

	recycle is
			-- Clean debugging session data
		do
			debugger_manager.object_manager.reset
			if is_running then
				destroy_status
			end
		end

feature -- Execution event callbacks

	on_application_before_launching is
		require
			Debugger_manager_not_void: debugger_manager /= Void
		do
			Debugger_manager.on_application_before_launching
		end

	on_application_launched is
		require
			Debugger_manager_not_void: debugger_manager /= Void
		do
			Debugger_manager.on_application_launched
		end

	on_application_before_resuming is
		require
			Debugger_manager_not_void: debugger_manager /= Void
		do
			Debugger_manager.on_application_before_resuming
		end

	on_application_resumed is
		require
			Debugger_manager_not_void: debugger_manager /= Void
		do
			on_resumed
			Debugger_manager.on_application_resumed
		end

	on_application_before_stopped is
		require
			Debugger_manager_not_void: debugger_manager /= Void
		do
			Debugger_manager.on_application_before_stopped
		end

	on_application_just_stopped is
		require
			Debugger_manager_not_void: debugger_manager /= Void
		do
			Debugger_manager.on_application_just_stopped
		end

	on_application_quit is
		require
			Debugger_manager_not_void: debugger_manager /= Void
		do
			Debugger_manager.on_application_quit
		end

feature -- Properties

	status: APPLICATION_STATUS
			-- Status of the running application

	execution_mode: INTEGER
			-- Execution mode (Step by step, stop at stoop points, ...)

	current_execution_stack_number: INTEGER
			-- Stack number currently displaying the locals and arguments

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
		local
			ecs: EIFFEL_CALL_STACK
		do
			ecs := status.current_call_stack
			if ecs /= Void then
				Result := ecs.count
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
			inspect execution_mode
			when {EXEC_MODES}.no_stop_points then
					-- remove all breakpoints set by the application.
					-- without changing their status under bench				
				debug("debugger_trace_breakpoint")
					print ("No stop point.%N")
				end
				send_no_breakpoints
			when {EXEC_MODES}.User_stop_points then
					-- Execution with no stop points set.
				update_breakpoints
			when {EXEC_MODES}.step_into,
			 	 {EXEC_MODES}.step_by_step,
			 	 {EXEC_MODES}.out_of_routine then
				send_breakpoints_for_stepping (execution_mode)
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

	notify_newbreakpoint is
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

	activate_execution_replay_recording (b: BOOLEAN) is
			-- Activate or Deactivate execution recording mode
		do
			check execution_replay_recording_not_b: b /= status.replay_recording end
			status.set_replay_recording (b)
			check status.replay_recording = b end
		ensure
			execution_replay_recording: status.replay_recording = b
		end

	activate_execution_replay_mode (b: BOOLEAN) is
			-- Activate or Deactivate execution replay mode
		require
			turned_on_when_stopped: b implies status.is_stopped
			replay_activation_change: b /= status.replay_activated
		local
			d: INTEGER
			r: BOOLEAN
		do
			if b then
				status.set_replay_activated (True)
				check status.replay_depth = 0 end
				d := query_replay_status (Rtdbg_op_replay_back)
				status.set_replay_depth_limit (d)
			else
				from
					r := True
					d := status.replay_depth
				until
					d = 0 or not r
				loop
					r := replay (Rtdbg_op_replay_forth)
					d := d - 1
				end

				status.set_replay_activated (False)

				check
					r and status.replay_depth = 0
				end
			end
		ensure
			replay_activated: status.replay_activated = b
			replay_depth_is_zero: status.replay_depth = 0
		end

	replay (direction: INTEGER): BOOLEAN is
		require
			app_is_stopped: is_stopped
			replay_activated: status.replay_activated
		local
			d: INTEGER
		do
			d := status.replay_depth
			inspect direction
			when Rtdbg_op_replay_back then
				d := d + 1
			when Rtdbg_op_replay_forth then
				d := d - 1
			else
			end
			status.set_replay_depth (d)
			Result := True
		end

	query_replay_status (direction: INTEGER): INTEGER is
			-- Query number of available steps in `direction'.
		deferred
		end

	remote_rt_object: ABSTRACT_DEBUG_VALUE is
			-- Return the remote rt_object
		deferred
		end

	remotely_store_object (oa: STRING; fn: STRING): BOOLEAN is
		deferred
		end

	remotely_loaded_object (oa: STRING; fn: STRING): ABSTRACT_DEBUG_VALUE is
		deferred
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

	send_breakpoints_for_stepping (a_execution_mode: INTEGER) is
			-- Send breakpoints for step operation
			-- called by `send_breakpoints'
			-- DO NOT CALL DIRECTLY
		deferred
		end

	send_no_breakpoints is
			-- Application execution without any breakpoint	
			-- Remove BreakPoints from the application ones in execution
			-- to perform a NoStopPoint operation
		local
			bps: BREAK_LIST
			loc: BREAKPOINT_LOCATION
		do
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
			last_assertion_check_stack_not_empty: not last_assertion_check_stack.is_empty
		local
			b: BOOLEAN
		do
			b := last_assertion_check_stack.item
			last_assertion_check_stack.remove
			b := impl_check_assert (b)
		end

	last_assertion_check_stack: LINKED_STACK [BOOLEAN]
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

feature -- Parameters

	parameters: DEBUGGER_EXECUTION_PARAMETERS
			-- Parameters used to run Application

feature -- Setting

	set_execution_mode (exec_mode: like execution_mode) is
			-- Set `exec_mode' the new execution mode.
		require
			valid_exec_mode: exec_mode >= {EXEC_MODES}.No_stop_points and then
					exec_mode <= {EXEC_MODES}.Out_of_routine
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
