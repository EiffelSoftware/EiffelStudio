indexing
	description: "Objects that represents a debugger"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	author: "$Author$"
	date: "$Date$"
	revision: "$Revision$"

class
	DEBUGGER_MANAGER

inherit

	SHARED_EIFFEL_PROJECT

	PROJECT_CONTEXT

	SYSTEM_CONSTANTS

	EXECUTION_ENVIRONMENT

	BREAKPOINTS_MANAGER
		redefine
			clear_debugging_information
		end

create
	make

feature {NONE} -- Initialization

	make is
		do
			can_debug := True
			set_default_parameters

			create application_quit_actions
			create debug_info.make
			create controller.make (Current)
			create observers.make (3)
			create implementation.make (Current)
		end

	set_default_parameters is
		do
			set_slices (0, 50)
			set_displayed_string_size (60)
			set_critical_stack_depth (-1) --| Dft: 1000
			set_interrupt_number (1)
			set_maximum_stack_depth (100)
			set_max_evaluation_duration (5)
		end

feature -- Application execution

	create_application is
			-- Create a debugger session (aka Application Execution)
		local
			app: APPLICATION_EXECUTION
		do
			debug
				print (generator + ".create_application (was initialized=" + application_initialized.out + ")%N")
			end
			if is_dotnet_project then
				create {APPLICATION_EXECUTION_DOTNET} app.make_with_debugger (Current)
			else
				create {APPLICATION_EXECUTION_CLASSIC} app.make_with_debugger (Current)
			end
			set_shared_application (app)
		end

	destroy_application is
		do
			if application_initialized then
				application.recycle
			end
			set_shared_application (Void)
		end

	set_shared_application (app: like application) is
		do
			application := app
			application_initialized := app /= Void
		end

	application_initialized: BOOLEAN

	application: APPLICATION_EXECUTION

feature -- Output helpers

	debugger_message (m: STRING) is
		require
			m /= Void
		do
			debugger_output_message (m)
			debugger_status_message (m)
		end

	debugger_output_message (msg: STRING) is
		require
			msg /= Void
		do
		end

	debugger_warning_message (msg: STRING) is
		require
			msg /= Void
		do
			debugger_output_message (msg)
		end

	debugger_status_message (msg: STRING_GENERAL) is
		require
			msg /= Void
		do
		end

	display_application_status is
		do
		end

	display_system_info	is
		do
		end

	display_debugger_info is
		do
		end

feature -- Change

	set_error_message (s: STRING) is
		require
			s /= Void
		do
		end

feature -- Dump value factory

	Dump_value_factory: DUMP_VALUE_FACTORY is
		once
			create Result.make (Current)
		end

feature -- Debug info access

	debug_info_filename: FILE_NAME is
		do
			create Result.make
			Result.set_directory (project_location.workbench_path)
			Result.set_file_name (Debug_info_name)
			Result.add_extension (Debug_info_extension)
		end

	load_debug_info is
			-- Load debug information (so far only the breakpoints)
		do
			if debug_info = Void then
				create debug_info.make
			end
			debug_info.load (debug_info_filename)
			implementation.load_system_dependent_debug_info
			resynchronize_breakpoints
		end

	save_debug_info is
			-- Save debug information (so far only the breakpoints)
		do
			if debug_info = Void then
				create debug_info.make
			end
			debug_info.save (debug_info_filename)
		rescue
			set_error_message ("Unable to save project properties%N%
					%Cause: Unable to open " + debug_info_filename + " for writing")
		end

feature -- Breakpoints change

	clear_debugging_information	is
		do
			if application_is_executing then
					-- Need to individually remove the breakpoints
					-- since the sent_bp must be updated to
					-- not stop.
				Precursor {BREAKPOINTS_MANAGER}
			else
				debug_info.wipe_out
			end
		end

	notify_newbreakpoint is
		do
			if application_is_executing and then not application_is_stopped then
				-- If the application is running (and not stopped), we
				-- must notify it to take the new breakpoint into account.
				application.notify_newbreakpoint
			end
		end

feature -- Properties

	debug_info: DEBUG_INFO
			-- Debugger information (mainly breakpoints).

	controller: DEBUGGER_CONTROLLER
			-- Debugger controller for run, resume ...

	can_debug: BOOLEAN
			-- Is debugging allowed?

	is_classic_project: BOOLEAN is
			-- Is this project a classic system ?
		require
			system_defined: Eiffel_project.system_defined
		do
			Result := not is_dotnet_project
		end

	is_dotnet_project: BOOLEAN is
			-- Is this project a dotnet system ?
		require
			system_defined: Eiffel_project.system_defined
		do
			Result := Eiffel_project.workbench.system.il_generation
		end

feature -- Parameters

	min_slice: INTEGER
			-- Minimum bound asked for special objects.			


	max_slice: INTEGER
			-- Maximum bound asked for special objects.			

	displayed_string_size: INTEGER
			-- Size of string to be retrieved from the application
			-- when debugging (size of `string_value' in ABSTRACT_REFERENCE_VALUE)
			-- (Default value is 50)

	interrupt_number: INTEGER
			-- Number that specifies the `n' breakable points in	
			-- which the application will check if an interrupt was pressed

	critical_stack_depth: INTEGER
			-- Call stack depth at which we warn the user against a possible stack overflow.

	maximum_stack_depth: INTEGER
			-- Maximum number of call stack elements displayed.
			-- -1 means display all elements.

	max_evaluation_duration: INTEGER
			-- Maximum number of seconds to wait before cancelling an evaluation.
			-- A negative value means no cancellation will be done.


feature -- Exception handling

	exceptions_handler: DBG_EXCEPTION_HANDLER is
			-- Exception handler used during debugging.
		do
			Result := internal_exceptions_handler
			if Result = Void then
				if is_classic_project then
					create Result.make_handling_by_code
				elseif is_dotnet_project then
					create Result.make_handling_by_name
				else
					check False end
				end
				internal_exceptions_handler := Result
			end
		end

	internal_exceptions_handler: like exceptions_handler

feature -- Events helpers

	new_timer: DEBUGGER_TIMER is
		do
			check to_be_implemented: False end
		end

	add_idle_action (v: PROCEDURE [ANY, TUPLE]) is
		require
			v_not_void: v /= Void
		do
			check to_be_implemented: False end
		end

	remove_idle_action (v: PROCEDURE [ANY, TUPLE]) is
		require
			v_not_void: v /= Void
		do
			check to_be_implemented: False end
		end

feature {DEBUGGER_OBSERVER} -- Observer implementation

	add_observer (o: DEBUGGER_OBSERVER) is
		do
			observers.force (o)
		end

	remove_observer (o: DEBUGGER_OBSERVER) is
		do
			observers.prune_all (o)
		end

feature {DEBUGGER_MANAGER} -- Observer implementation

	observers: ARRAYED_LIST [DEBUGGER_OBSERVER]
			-- List of observers of `Current'.

feature -- Settings

	classic_debugger_timeout: INTEGER is
			-- Timeout use in IPC protocol between ewb and ecdbgd and application
			-- if zero use the default value set in runtime
		do
			Result := 0 --| Use default settings in runtime
		end

	classic_debugger_location: STRING is
			-- Path to ecdbgd executable
			-- If Void use the default executable located in ISE_EIFFEL ... bin
		do
			Result := Void --| Use default settings in runtime
		end

	classic_close_dbg_daemon_on_end_of_debugging: BOOLEAN is
			-- Close ecdbgd process after each end of debugging ?
			-- or keep the same process alive ?
		do
			Result := True --| Default behavior for general debugging use
		end

	dotnet_keep_stepping_info_non_eiffel_feature_pref: BOOLEAN_PREFERENCE is
			-- Keep stepping into feature including non Eiffel feature (useful to step into agent call) ?
		do
			Result := Void --| Lazy behavior
		end

feature -- Access

	application_status: APPLICATION_STATUS is
		require
			application_not_void: application_initialized
		do
			Result := application.status
		end

	safe_application_is_stopped: BOOLEAN is
			-- Is application stopped during execution ?
		do
			Result := application_is_executing and then application_is_stopped
		end

	application_is_executing: BOOLEAN is
		do
			Result := application_initialized and then application.is_running
		end

	application_is_stopped: BOOLEAN is
		require
			application_is_executing
		do
			Result := application.is_stopped
		end

	windows_handle: POINTER is
		require
			is_windows_platform: (create {PLATFORM}).is_windows
		do
		end

	application_active_thread_id: INTEGER is
		require
			application_is_executing: application_is_executing
		do
			Result := application_status.active_thread_id
		end

	application_current_thread_id: INTEGER is
		require
			application_is_executing: application_is_executing
		do
			Result := application_status.current_thread_id
		end

	environment_variables_table: HASH_TABLE [STRING_32, STRING_32] is
		local
			l_envs: HASH_TABLE [STRING_GENERAL, STRING_GENERAL]
		do
			l_envs := starting_environment_variables
			from
				create Result.make (l_envs.count)
				l_envs.start
			until
				l_envs.after
			loop
				Result.force (l_envs.item_for_iteration, l_envs.key_for_iteration)
				l_envs.forth
			end
		ensure
			Result /= Void
		end

	sorted_comparable_string32_keys_from (env: like environment_variables_table): DS_LIST [STRING_32] is
		local
			k: STRING_32
			l_comp: KL_COMPARABLE_COMPARATOR [STRING_32]

		do
			if env /= Void and then not env.is_empty then
				from
					create {DS_ARRAYED_LIST [STRING_32]} Result.make (env.count)
					env.start
				until
					env.after
				loop
					k := env.key_for_iteration
					if k /= Void and then not k.is_empty then
						Result.put_last (k)
					end
					env.forth
				end
				create l_comp.make

				Result.sort (create {DS_QUICK_SORTER [STRING_32]}.make (l_comp))
			end
		end

feature -- Helpers

	current_debugging_feature_as: FEATURE_AS is
			-- Debugging feature.
		local
			f: E_FEATURE
		do
			f := current_debugging_feature
			if f /= Void then
				Result := f.ast
			end
		end

	current_debugging_breakable_index: INTEGER is
			-- Debugging feature.
		do
			if safe_application_is_stopped and then not application.current_call_stack_is_empty then
				Result := application_status.break_index
			end
		end

	current_debugging_feature: E_FEATURE is
			-- Debugging feature.
		local
			ecse: EIFFEL_CALL_STACK_ELEMENT
		do
			if safe_application_is_stopped and then not application.current_call_stack_is_empty then
				ecse ?= application_status.current_call_stack_element
				if ecse /= Void then
					Result := ecse.routine
				end
			end
		end

	current_debugging_class_c: CLASS_C is
			-- Debugging feature.
		local
			ecse: EIFFEL_CALL_STACK_ELEMENT
		do
			if safe_application_is_stopped and not application.current_call_stack_is_empty then
				ecse ?= application_status.current_call_stack_element
				if ecse /= Void then
					Result := ecse.dynamic_class
				end
			end
		end

feature -- Bridge to compiler data

	compiler_data: DEBUGGER_DATA_FROM_COMPILER

feature {NONE} -- Bridge to compiler data implementation

	compute_class_c_data is
		require
			defined: Eiffel_project.system_defined
			compiler_data_void: compiler_data = Void
		do
			create compiler_data.make
		ensure
			compiler_data_not_void: compiler_data /= Void
		end

	reset_class_c_data is
		do
			compiler_data := Void
		ensure
			compiler_data_void: compiler_data = Void
		end

feature -- Change

	change_current_thread_id (tid: INTEGER) is
			-- Set Current thread id to `tid'
		local
			s: APPLICATION_STATUS
		do
			if application_current_thread_id /= tid then
				s := application_status
				s.set_current_thread_id (tid)
				s.switch_to_current_thread_id
				s.reload_current_call_stack
			end
		end

	set_slices (i,j: INTEGER) is
			-- set minimum and maximum slices
		do
			min_slice := i
			max_slice := j
		end

	set_interrupt_number (a_nbr: like interrupt_number) is
			-- Set `interrupt_number' to `a_nbr'.
		require
			non_negative_nbr: a_nbr >= 0
		do
			interrupt_number := a_nbr
		ensure
			set: interrupt_number = a_nbr
		end

	set_critical_stack_depth (d: INTEGER) is
			-- Call stack depth at which we warn the user against a possible stack overflow.
			-- -1 never warns the user.
		require
			valid_depth: d = -1 or d > 0
		do
			critical_stack_depth := d
			if application_is_executing then
				application.update_critical_stack_depth (d)
			end
		end

	set_displayed_string_size (i: like displayed_string_size) is
			-- Set `displayed_string_size' to `i'.
		require
			positive_i_or_all_string: i > 0 or i = -1
		do
			displayed_string_size := i
		ensure
			set: displayed_string_size = i
		end

	set_maximum_stack_depth (nb: INTEGER) is
			-- Set the maximum number of stack elements to be displayed to `nb'.
		require
			valid_nb: nb = -1 or nb > 0
		do
			maximum_stack_depth := nb
		end

	set_max_evaluation_duration (v: like max_evaluation_duration) is
			-- Set `max_evaluation_duration' with `v'.
		do
			max_evaluation_duration := v
		ensure
			max_evaluation_duration_set: max_evaluation_duration = v
		end

	notify_breakpoints_changes is
		do
		end

	enable_debug is
			-- Allow debugging.
		do
		ensure
			can_debug
		end

	disable_debug is
			-- Disallow debugging.
		do
		ensure
			not can_debug
		end

feature -- Debugging events

	debugging_operation_id: NATURAL_32

	incremente_debugging_operation_id is
		do
			if debugging_operation_id < {NATURAL_32}.max_value then
				debugging_operation_id := (debugging_operation_id + 1)
			else
				debugging_operation_id := 1
			end
		end

	on_application_before_launching is
		do
			debugging_operation_id := 0
			compute_class_c_data
		end

	on_application_launched is
		do
			incremente_debugging_operation_id
			application_status.set_max_depth (maximum_stack_depth)

			check application_initialized end
			if application.execution_mode = {EXEC_MODES}.No_stop_points then
				debugger_status_message (debugger_names.t_Running_no_stop_points)
			else
				debugger_status_message (debugger_names.t_Running)
			end

				--| Observers
			observers.do_all (agent {DEBUGGER_OBSERVER}.on_application_launched)

				--| Output information			
			display_application_status
		end

	on_application_before_stopped is
		do
			debug("debugger_trace_synchro")
				io.put_string (generator + ".on_application_before_stopped %N")
			end
			if application_is_executing and then application_is_stopped then
					-- Display the callstack, the current object & the current stop point.
				application.set_current_execution_stack_number (1)	-- go on top of stack
			end
			debug ("debugger_trace_synchro")
				io.put_string (generator + ".on_application_before_stopped : done%N")
			end
		end

	on_application_just_stopped is
		require
			app_is_executing: safe_application_is_stopped
		do
			incremente_debugging_operation_id
			if has_stopped_action then
				stopped_actions.call (Void)
			end
				--| Reset current stack number to 1 (top level)
			application.set_current_execution_stack_number (1)

				--| Observers
			observers.do_all (agent {DEBUGGER_OBSERVER}.on_application_stopped)
		end

	on_application_before_resuming is
		require
			app_is_executing: safe_application_is_stopped
		do
		end

	on_application_resumed is
		require
			app_is_executing: application_is_executing and then not application_is_stopped
		do
			incremente_debugging_operation_id
			if application.execution_mode = {EXEC_MODES}.No_stop_points then
--<<<<<<< .mine
--				debugger_status_message (Interface_names.e_Running_no_stop_points)
--				debugger_output_message (Interface_names.ee_Running_no_stop_points)
--=======
				debugger_status_message (debugger_names.t_Running_no_stop_points)
				debugger_output_message (debugger_names.t_Running_no_stop_points)
-->>>>>>> .r65512
			else
--<<<<<<< .mine
--				debugger_status_message (Interface_names.e_Running)
--				debugger_output_message (Interface_names.ee_Running)
--=======
				debugger_status_message (debugger_names.t_Running)
				debugger_output_message (debugger_names.t_Running)
-->>>>>>> .r65512
			end

				--| Observers
			observers.do_all (agent {DEBUGGER_OBSERVER}.on_application_resumed)
		end

	on_application_quit is
		do
			debug("debugger_trace_synchro")
				io.put_string (generator + ".on_application_quit %N")
			end

			incremente_debugging_operation_id

			if application_is_executing then
				debugger_status_message (debugger_names.t_not_running)
				display_system_info

					--| Observers
				observers.do_all (agent {DEBUGGER_OBSERVER}.on_application_quit)
					--| Kept objects
				application_status.clear_kept_objects

					--| Save debug info
				save_debug_info
			end

			if has_stopped_action then
				stopped_actions.call (Void)
			end

			application_quit_actions.call (Void)

			destroy_application
			reset_class_c_data

			debug ("debugger_trace_synchro")
				io.put_string (generator + ".on_application_quit : done%N")
			end
		end

feature -- Actions

	application_quit_actions: ACTION_SEQUENCE [TUPLE]

feature {NONE} -- Implementation

	stopped_actions: ACTION_SEQUENCE [TUPLE]
			-- Actions called when application has stopped.

feature -- One time action

	has_stopped_action: BOOLEAN is
			-- Has `stopped_actions' some actions to be executed?
		do
			Result := stopped_actions /= Void and then not stopped_actions.is_empty
		ensure
			has_stopped_actions_definition:
				Result = (stopped_actions /= Void and then not stopped_actions.is_empty)
		end

	add_on_stopped_action (p: PROCEDURE [ANY, TUPLE]; is_kamikaze: BOOLEAN) is
			-- Add `p' to `stopped_actions' with `p'.
		require
			p_not_void: p /= Void
		do
			if stopped_actions = Void then
				create stopped_actions
			end
			stopped_actions.extend (p)
			if is_kamikaze then
				stopped_actions.prune_when_called (p)
			end
		ensure
			stopped_actions_not_void: stopped_actions /= Void
			has_stopped_actions: has_stopped_action
			stopped_actions_set: stopped_actions.has (p)
		end

feature -- Debuggee Objects management

	release_object_references (kobjs: LIST [STRING]) is
		local
			st: APPLICATION_STATUS
		do
			if application_is_executing then
				st := application_status
				from
					kobjs.start
				until
					kobjs.after
				loop
					st.release_object (kobjs.item)
					kobjs.forth
				end
			end
		end

feature {APPLICATION_EXECUTION} -- specific implementation

	debugger_names: DEBUGGER_NAMES is
		once
			create Result
		end

	implementation: DEBUGGER_MANAGER_IMP;

invariant

	implementation /= Void
	controller /= Void

	application_initialized_not_void: application_initialized implies application /= Void
	application /= Void implies application.debugger_manager = Current
	debug_info /= Void

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
