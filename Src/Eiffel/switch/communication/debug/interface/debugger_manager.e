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
			clear_breakpoints
		end

	SHARED_BENCH_NAMES

create
	make

feature {NONE} -- Initialization

	make is
		do
			can_debug := True
			set_default_parameters
			create observers.make (3)
			create controller.make (Current)
			create application_quit_actions
			create application_prelaunching_actions
			create debugger_data.make
			create implementation.make (Current)
		end

	is_initialized: BOOLEAN
			-- Is fully initialized ?

	initialize is
		do
			if not is_initialized then
				is_initialized := True
				create dump_value_factory.make (Current)
				create object_manager.make (Current)
			end
		end

	set_default_parameters is
			-- Set hard coded default parameters values
		do
			set_slices (0, 50)
			set_displayed_string_size (60)
			set_critical_stack_depth (1000) --| Dft: 1000
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
			if not is_initialized then
				initialize
			end
			debug
				print (generator + ".create_application (was initialized=" + application_initialized.out + ")%N")
			end
			if is_dotnet_project then
				create {APPLICATION_EXECUTION_DOTNET} app.make_with_debugger (Current)
				set_shared_application (app)
			else
				create {APPLICATION_EXECUTION_CLASSIC} app.make_with_debugger (Current)
				set_shared_application (app)
			end
		end

	init_application is
			-- Initialize application
		require
			application_not_void: application /= Void
		do
			if is_dotnet_project then
				create {DBG_EVALUATOR_DOTNET} dbg_evaluator.make
			else
				create {DBG_EVALUATOR_CLASSIC} dbg_evaluator.make
			end
		end

	destroy_application is
		do
			if application_initialized then
				application.recycle
			end
			if dbg_evaluator /= Void then
				reset_dbg_evaluator
				dbg_evaluator := Void
			end
			set_shared_application (Void)
		end

	set_shared_application (app: like application) is
		do
			application := app
			application_initialized := app /= Void
		end

	application_initialized: BOOLEAN

	application_launching_in_progress: BOOLEAN

	application: APPLICATION_EXECUTION

	dbg_evaluator: DBG_EVALUATOR

feature -- Output helpers

	debugger_message (m: STRING_GENERAL) is
		require
			m /= Void
		do
			debugger_output_message (m)
			debugger_status_message (m)
		end

	debugger_output_message (msg: STRING_GENERAL) is
		require
			msg /= Void
		do
		end

	debugger_warning_message (msg: STRING_GENERAL) is
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

	display_debugger_info (param: DEBUGGER_EXECUTION_PARAMETERS) is
		do
		end

feature -- Change

	reset_dbg_evaluator is
			-- Reset `dbg_evaluator'
		do
			if dbg_evaluator /= Void then
				dbg_evaluator.reset
			end
		end

	set_error_message (s: STRING) is
		require
			s /= Void
		do
		end

feature -- Debug info access

	debug_info_filename: FILE_NAME is
		do
			create Result.make
			Result.set_directory (project_location.workbench_path)
			Result.set_file_name (Debug_info_name)
			Result.add_extension (Debug_info_extension)
		end

	load_debugger_data is
			-- Load debug information (so far only the breakpoints)
		do
			if debugger_data = Void then
				create debugger_data.make
			end
			debugger_data.load (debug_info_filename)
			implementation.load_system_dependent_debug_info
			resynchronize_breakpoints
		end

	save_debugger_data is
			-- Save debug information (so far only the breakpoints)
		do
			if debugger_data = Void then
				create debugger_data.make
			end
			debugger_data.save (debug_info_filename)
		rescue
			set_error_message ("Unable to save project properties%N%
					%Cause: Unable to open " + debug_info_filename + " for writing")
		end

feature -- Breakpoints management

	process_breakpoint (bp: BREAKPOINT): BOOLEAN is
			-- Process `bp'
			-- and return True in `a_stopped_execution' if application has to stop.
		local
			expr: EB_EXPRESSION
			evaluator: DBG_EXPRESSION_EVALUATOR
			bp_reached: BOOLEAN
			bp_continue: BOOLEAN
		do
			bp_reached := True
			if bp.has_condition then
				expr := bp.condition
				check expr /= Void end
				expr.evaluate
				evaluator := expr.expression_evaluator
				if evaluator.error_occurred then
					debugger_message ("Conditional breakpoint failed to evaluate %"" + expr.expression + "%".")
				end
				bp_reached := bp.condition_respected --| evaluator.final_result_is_true_boolean_value				
			end

			bp_continue := bp.continue_execution
			if bp_reached then
				bp.increase_hits_count

				if bp_reached and bp.hits_count_condition /= Void then
					inspect bp.hits_count_condition.mode
					when {BREAKPOINT}.hits_count_condition_always then
					when {BREAKPOINT}.hits_count_condition_equal then
						bp_reached := bp.hits_count = bp.hits_count_condition.value
					when {BREAKPOINT}.hits_count_condition_multiple then
						bp_reached := bp.hits_count_condition.value = 0
									or else (bp.hits_count \\ bp.hits_count_condition.value = 0)
					when {BREAKPOINT}.hits_count_condition_greater then
						bp_reached := bp.hits_count >= bp.hits_count_condition.value
					when {BREAKPOINT}.hits_count_condition_continue_execution then
						bp_reached := True
						bp_continue := True
					else
					end
				end

				if bp_reached and bp.has_message then
					debugger_message (computed_breakpoint_message (bp))
				end
			end
			Result := bp_reached and not bp_continue
		end

	computed_breakpoint_message (bp: BREAKPOINT): STRING is
			-- Computed message from breakpoint message `bp.message'.
		require
			bp_not_void: bp /= Void
			bp_message_not_void: bp.message /= Void
		local
			m: STRING
			m_area: SPECIAL [CHARACTER]
			m_max: INTEGER
			cse: CALL_STACK_ELEMENT
			expr: EB_EXPRESSION
			i: INTEGER
			c: CHARACTER
			s: STRING
			v: STRING
			is_escaped,
			in_expression,
			in_keyword: BOOLEAN
			retried: BOOLEAN
		do
			if not retried then
				m := bp.message
				from
					i := 0 --| iterate on SPECIAL
					s := character_routines.unescaped_string (m)
					if not character_routines.last_unescaping_raised_error then
						m := s
					end
					m_area := m.area
					m_max := m.count - 1
					create s.make (m_max + 1)
					create v.make_empty
				until
					i > m_max
				loop
					is_escaped := False
					c := m_area[i]
					if c = '\' and i < m_max then
						inspect m_area[i + 1]
						when '{', '$', '\' then
							i := i + 1
							c := m_area[i]
							is_escaped := True
						else
							-- keep c as '\'
						end
					end
					if in_keyword then
						if not c.is_alpha or else i = m_max then
							if not c.is_alpha then
								in_keyword := False
							else
								v.append_character (c)
							end

							if cse = Void then
								cse := application_status.current_call_stack_element
							end
							if cse /= Void then
								if v.is_case_insensitive_equal ("THREADID") then
									s.append (cse.thread_id.out)
								elseif v.is_case_insensitive_equal ("CALL") then
									s.append (cse.to_string)
								elseif v.is_case_insensitive_equal ("CALLSTACK") then
									application_status.reload_current_call_stack
									s.append (application_status.current_call_stack.to_string)
								elseif v.is_case_insensitive_equal ("CLASS") and then cse.class_name /= Void then
									s.append (cse.class_name)
								elseif v.is_case_insensitive_equal ("FEATURE") and then cse.routine_name /= Void then
									s.append (cse.routine_name)
								elseif v.is_case_insensitive_equal ("ADDRESS") and then cse.object_address /= Void then
									s.append (cse.object_address)
								elseif v.is_case_insensitive_equal ("HITCOUNT") then
									s.append_integer (bp.hits_count)
								else
									s.append ("$" + v.as_upper)
								end
							end
							if not in_keyword then
								s.append_character (c)
							else
								in_keyword := False
							end
						else
							v.append_character (c)
						end
					elseif in_expression then
						if c = '}' then
							in_expression := False
							create expr.make_for_context (v)
							expr.evaluate
							if not expr.error_occurred then
								s.append (expr.expression_evaluator.final_result_value.output_for_debugger)
							end
						else
							v.append_character (c)
						end
					else
						if c = '$' and not is_escaped then
							if i = 0 or else m_area[i - 1] /= '\' then
								in_keyword := True
								v.wipe_out
							end
						elseif c = '{' and not is_escaped then
							if i = 0 or else m_area[i - 1] /= '\' then
								in_expression := True
								v.wipe_out
							end
						else
							s.append_character (c)
						end
					end
					i := i + 1
				end
				Result := s
			else
				Result := m
			end
		ensure
			Result_not_void: Result /= Void
		rescue
			retried := True
			retry
		end

	clear_breakpoints is
		do
			if application_is_executing then
					-- Need to individually remove the breakpoints
					-- since the sent_bp must be updated to
					-- not stop.
				Precursor {BREAKPOINTS_MANAGER}
			else
				debugger_data.wipe_out_all_breakpoints
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

	debugger_data: DEBUGGER_DATA
			-- Debugger information (mainly breakpoints).

	object_manager: DEBUGGED_OBJECT_MANAGER
			-- Debugged object manager

	controller: DEBUGGER_CONTROLLER
			-- Debugger controller for run, resume ...

	dump_value_factory: DUMP_VALUE_FACTORY
			-- Dump value factory

feature -- Status

	can_debug: BOOLEAN
			-- Is debugging allowed?

	system_defined: BOOLEAN is
		do
			Result := Eiffel_project.system_defined
		end

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

	rt_extension_available: BOOLEAN
			-- is RT_EXTENSION available ?
			-- Value valid only during the debugging session.
			-- Initially set just before the launching, and reset when terminated

feature -- Parameters context

--| This code may be used later to enhance display of string ...
--	previous_parameters: ARRAY [INTEGER]
--
--	push_parameters (a_slice_min, a_slice_max, a_disp_str_size: INTEGER) is
--		require
--			previous_parameters = Void
--				or else (previous_parameters[1] = 0 and previous_parameters[2] = 0 and previous_parameters[3] = 0)
--		do
--			if previous_parameters = Void then
--				create previous_parameters.make (1,3)
--			end
--			previous_parameters[1] := min_slice
--			previous_parameters[2] := max_slice
--			previous_parameters[3] := displayed_string_size
--		end
--
--	restore_parameters is
--		require
--			previous_parameters /= Void
--				and then (previous_parameters[1] > 0 and previous_parameters[2] > 0 and previous_parameters[3] /= 0)
--		do
--			min_slice := previous_parameters[1]
--			max_slice := previous_parameters[2]
--			displayed_string_size := previous_parameters[3]
--			previous_parameters[1] := 0
--			previous_parameters[2] := 0
--			previous_parameters[3] := 0
--		end

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

	process_exception: BOOLEAN is
			-- Exception catched ?
		require
			application_is_executing and then application_status.exception_occurred
		local
			l_code: INTEGER
			l_name: STRING
		do
			Result := True
			if exceptions_handler.enabled then
				if exceptions_handler.handling_mode_is_by_code then
					l_code := application_status.exception_code
					Result := exceptions_handler.exception_catched_by_code (l_code)
					if not Result then
						debugger_message ("Ignoring exception code: " + l_code.out)
					end
				elseif exceptions_handler.handling_mode_is_by_name then
					l_name := application_status.exception_class_name
					Result := exceptions_handler.exception_catched_by_name (l_name)
					if not Result then
						debugger_message ("Ignoring exception class name: " + l_name.out)
					end
				end
			end
		end

	exceptions_handler: DBG_EXCEPTION_HANDLER is
			-- Exception handler used during debugging.
		do
			Result := debugger_data.exceptions_handler
			if Result = Void then
				if is_classic_project then
					create Result.make_handling_by_code
				elseif is_dotnet_project then
					create Result.make_handling_by_name
				else
					check False end
				end
				debugger_data.set_exceptions_handler (Result)
			end
		ensure
			Result_not_void: Result /= Void
		end

feature -- Events/Timers helpers

	events_handler: DEBUGGER_EVENTS_HANDLER
			-- Events handler to process debugger's timers.

	set_events_handler (e: like events_handler) is
			-- Set `events_handler'
		do
			if events_handler /= Void and then events_handler /= e then
				events_handler.recycle
			end
			events_handler := e
		ensure
			events_handler = e
		end

	windows_handle: POINTER is
		require
			is_windows_platform: (create {PLATFORM}).is_windows
			events_handler_not_void: events_handler /= Void
		do
			Result := events_handler.timer_win32_handle
		end

	new_timer: DEBUGGER_TIMER is
		require
			events_handler_not_void: events_handler /= Void
		do
			Result := events_handler.new_timer
		end

	add_idle_action (v: PROCEDURE [ANY, TUPLE]) is
		require
			events_handler_not_void: events_handler /= Void
		do
			events_handler.add_idle_action (v)
		end

	remove_idle_action (v: PROCEDURE [ANY, TUPLE]) is
		require
			events_handler_not_void: events_handler /= Void
		do
			events_handler.remove_idle_action (v)
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
		do
			if application /= Void then
				Result := application.status
			end
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

	set_displayed_string_size (i: like displayed_string_size) is
			-- Set `displayed_string_size' to `i'.
		require
			positive_i_or_all_string: i > 0 or i = -1
		do
			displayed_string_size := i
		ensure
			set: displayed_string_size = i
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
			can_debug := True
		ensure
			can_debug
		end

	disable_debug is
			-- Disallow debugging.
		do
			can_debug := False
		ensure
			not can_debug
		end

feature -- Debugging events

	debugging_operation_id: NATURAL_32

	incremente_debugging_operation_id is
		do
			if debugging_operation_id < {NATURAL_32}.max_value then
				debugging_operation_id := debugging_operation_id + 1
			else
				debugging_operation_id := 1
			end
		end

	on_application_before_launching is
		local
			bl: BREAK_LIST
		do
			debugging_operation_id := 0
			compute_class_c_data
			from
				bl := debugger_data.breakpoints
				bl.start
			until
				bl.after
			loop
				bl.item_for_iteration.reset_session_data
				bl.forth
			end
			save_debugger_data
			rt_extension_available := Eiffel_system.system.rt_extension_class /= Void
			application_launching_in_progress := True
			application_prelaunching_actions.call (Void)
		end

	on_application_launched is
		local
			s: STRING_GENERAL
		do
			application_launching_in_progress := False
			incremente_debugging_operation_id
			application_status.set_max_depth (maximum_stack_depth)

			check application_initialized end
			s := debugger_names.t_Application_launched.twin
			if application.execution_mode = {EXEC_MODES}.No_stop_points then
				s.append (debugger_names.t_space_application_ignoring_breakpoints)
			end
			debugger_status_message (s)
			debugger_output_message (s)

				--| Observers
			observers.do_all (agent {DEBUGGER_OBSERVER}.on_application_launched (Current))

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
			debugger_status_message (debugger_names.t_Paused)

				--| Reset current stack number to 1 (top level)
			application.set_current_execution_stack_number (1)

			if has_stopped_action then
				stopped_actions.call ([Current])
			end

				--| Observers
			observers.do_all (agent {DEBUGGER_OBSERVER}.on_application_stopped (Current))
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
				--| Display running mode, only if ignoring bp
			if application.execution_mode = {EXEC_MODES}.No_stop_points then
				debugger_status_message (debugger_names.t_Running_no_stop_points)
			else
				debugger_status_message (debugger_names.t_Running)
			end

				--| Observers
			observers.do_all (agent {DEBUGGER_OBSERVER}.on_application_resumed (Current))
		end

	frozen on_application_quit is
		local
			was_executing: BOOLEAN
		do
			debug("debugger_trace_synchro")
				io.put_string (generator + ".on_application_quit %N")
			end
			application_launching_in_progress := False
			incremente_debugging_operation_id

			was_executing := application_is_executing
			if was_executing then
				debugger_output_message (debugger_names.t_Application_exited)
				debugger_status_message (debugger_names.t_Application_exited)

					--| Observers
				observers.do_all (agent {DEBUGGER_OBSERVER}.on_application_quit (Current))
					--| Kept objects
				application_status.clear_kept_objects
			end

			if has_stopped_action then
				stopped_actions.call ([Current])
			end
				--| Save debug info
			save_debugger_data

			destroy_application
			reset_class_c_data

			on_debugging_terminated (was_executing)
			debug ("debugger_trace_synchro")
				io.put_string (generator + ".on_application_quit : done%N")
			end
		end

	on_debugging_terminated (was_executing: BOOLEAN) is
			-- Called at the very end of debuggging session
			-- after `on_application_quit'
		do
			-- do_nothing
			application_quit_actions.call (Void)
			rt_extension_available := False
		end

feature -- Actions

	application_prelaunching_actions: ACTION_SEQUENCE [TUPLE]
			-- Actions to be process just before starting the debuggee.

	application_quit_actions: ACTION_SEQUENCE [TUPLE]
			-- Actions to be process when the debuggee exits.

feature {NONE} -- Implementation

	stopped_actions: ACTION_SEQUENCE [TUPLE [DEBUGGER_MANAGER]]
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

	add_on_stopped_action (p: PROCEDURE [ANY, TUPLE [DEBUGGER_MANAGER]]; is_kamikaze: BOOLEAN) is
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

	Character_routines: CHARACTER_ROUTINES is
		once
			create Result
		end

	implementation: DEBUGGER_MANAGER_IMP;

invariant

	implementation /= Void
	controller /= Void

	application_initialized_not_void: application_initialized implies application /= Void
	application /= Void implies application.debugger_manager = Current
	debugger_data /= Void

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
