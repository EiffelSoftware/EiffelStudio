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

	SHARED_DEBUGGED_OBJECT_MANAGER
		export
			{NONE} all
		end

	REFACTORING_HELPER

--create {DEBUGGER_MANAGER}
--	make_with_debugger

feature {NONE} -- Initialization

	make_with_debugger (dbg: like debugger_manager) is
		do
			debugger_manager := dbg
			current_execution_stack_number := 1
		ensure
			current_execution_stack_number_is_one: current_execution_stack_number = 1
		end

feature -- Access

	debugger_manager: DEBUGGER_MANAGER

feature -- Recylcing

	on_resumed is
			-- Clean cached data valid only during the current stepping
		do
			debugged_object_manager.reset
		end

	recycle is
			-- Clean debugging session data
		do
			Debugged_object_manager.reset
			if is_running then
				destroy_status
			end
		end

feature -- execution mode

	is_classic_system: BOOLEAN is
			-- Is this application a classic system ?
		do
			Result := debugger_manager.is_classic_project
		end

	is_dotnet_system: BOOLEAN is
			-- Is this application a dotnet system ?
		do
			Result := debugger_manager.is_dotnet_project
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

	is_ignoring_stop_points: BOOLEAN is
			-- Is the application ignoring all stop points?
		do
			Result := execution_mode = {EXEC_MODES}.No_stop_points
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
			Result := "Cannot launch system"
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
			Debugger_manager.debug_info.restore

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

	run (args, cwd: STRING; env: HASH_TABLE [STRING_32, STRING_32]) is
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
		do
			on_application_before_launching
			l_envstr := environment_variables_to_string (environment_variables_updated_with (env))
			run_with_env_string (args, cwd, l_envstr)
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

	interrupt is
			-- Send an interrupt to the application
			-- which will stop at the next breakable line number
		require
			app_is_running: is_running
			not_stopped: not is_stopped
		deferred
		end

	disable_assertion_check is
			-- Send a message to the application to disable assertion checking
		require
			app_is_running: is_running
		deferred
		end

	restore_assertion_check is
			-- Send a message to the application to restore the previous assertion check status
		require
			app_is_running: is_running
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

	environment_variables_updated_with (env: HASH_TABLE [STRING_32, STRING_32]): HASH_TABLE [STRING_32, STRING_32] is
			-- String representation of the Environment variables
		local
			k,v: STRING_32
		do
			if env /= Void and then not env.is_empty then
				Result := debugger_manager.environment_variables_table
				if Result = Void then
					fixme ("Environment_variables table should not be Void")
					create Result.make (env.count)
				end

				from
					env.start
				until
					env.after
				loop
					k := env.key_for_iteration
					v := env.item_for_iteration
					if k /= Void and then v /= Void then
						Result.force (v, k)
					end
					env.forth
				end
			end
		ensure
			Result = Void implies (env = Void or else env.is_empty)
		end

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
		deferred
		end

	run_with_env_string (args, cwd: STRING; env: STRING_GENERAL) is
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
