indexing
	description: "Objects that represents a debugger"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	author: "$Author$"
	date: "$Date$"
	revision: "$Revision$"

deferred class
	DEBUGGER_MANAGER

inherit
	BREAKPOINTS_OBSERVER

	SHARED_EIFFEL_PROJECT

	PROJECT_CONTEXT

	SYSTEM_CONSTANTS

	EXECUTION_ENVIRONMENT

	SHARED_BENCH_NAMES

--create
--	make

feature {NONE} -- Initialization

	make is
		do
			can_debug := True
			set_default_parameters
			create observers.make (3)

			create implementation.make (Current)
			create controller.make (Current)
			create observer_provider.make;
			observer_provider.attach_to_debugger (Current)

			create application_quit_actions
			create application_prelaunching_actions

			create profiles.make (10)
			create breakpoints_manager.make (Void)

			breakpoints_manager.add_observer (Current)
			initialize_storage
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

	initialize_storage is
			-- Initialize `dbg_storage'
		require
			dbg_storage_not_attached: dbg_storage = Void
		deferred
		ensure
			dbg_storage_attached: dbg_storage /= Void
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

feature -- Registering

	register is
			-- Register Current, and the shared debugger manager
		do
			(create {SHARED_DEBUGGER_MANAGER}).set_debugger_manager (Current)
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
			-- Initialize application environment
		require
			application_not_void: application /= Void
		do
			if is_dotnet_project then
				create {DBG_EVALUATOR_DOTNET} dbg_evaluator.make (Current)
			else
				create {DBG_EVALUATOR_CLASSIC} dbg_evaluator.make (Current)
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
			-- Is application execution initialized ?

	application_launching_in_progress: BOOLEAN
			-- Is application launching in progress ?

	application: APPLICATION_EXECUTION
			-- Application associated to current execution.

	dbg_evaluator: DBG_EVALUATOR
			-- Debugger expression evaluator.

	dbg_storage: DEBUGGER_STORAGE
			-- Debugger's storage engine

	is_debugging: BOOLEAN is
			-- Is debugger currently debugging ?
		do
			Result := application_launching_in_progress or application_initialized
		end

feature -- Output helpers

	debugger_message (m: STRING_GENERAL) is
			-- Display debugger message `m'
		require
			m_not_void: m /= Void
		do
			debugger_output_message (m)
			debugger_status_message (m)
		end

	debugger_output_message (m: STRING_GENERAL) is
			-- Display debugger message `m' on the output
		require
			m_not_void: m /= Void
		do
		end

	debugger_warning_message (m: STRING_GENERAL) is
			-- Display debugger warning message `m'
		require
			m_not_void: m /= Void
		do
			debugger_output_message (m)
		end

	debugger_error_message (m: STRING_GENERAL) is
			-- Display debugger error message `m'
		require
			m_not_void: m /= Void
		do
			debugger_output_message (m)
		end

	debugger_status_message (m: STRING_GENERAL) is
			-- Display debugger message `m' on the status output
		require
			m_not_void: m /= Void
		do
		end

	display_application_status is
			-- Display application status info
		do
		end

	display_system_info	is
			-- Display system info
		do
		end

	display_debugger_info (param: DEBUGGER_EXECUTION_PARAMETERS) is
			-- Display execution parameters information	
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

feature -- Debugger data change		

	load_all_debugger_data is
			-- Load debug information
		local
			rescued: BOOLEAN
		do
			if not rescued then
				load_profiles_data
				load_breakpoints_data
				load_exceptions_handler_data

				implementation.load_system_dependent_debug_info
			else
				check should_not_occurs: False end
			end
		rescue
			rescued := True
			retry
		end

	load_breakpoints_data is
			-- Load breakpoints data
		local
			bplst: BREAK_LIST
			rescued, loading_rescued: BOOLEAN
		do
			if not rescued then
				if not loading_rescued then
					bplst := dbg_storage.breakpoints_data_from_storage

					breakpoints_manager.set_breakpoints (bplst)
							-- Reset information about the application
							-- contained in the breakpoints (if any).
					breakpoints_manager.restore
					breakpoints_manager.breakpoints.reload

				else
					-- Loading Issue !
				end

					--| Effective file loading done, now process the applicative loading				
				breakpoints_manager.update_breakpoints_tags_provider
				breakpoints_manager.resynchronize_breakpoints
			else
				-- Issue !
			end
		rescue
			bplst := Void
			if not loading_rescued then
				loading_rescued := True
			else
				rescued := True
			end
			retry
		end

	load_exceptions_handler_data is
			-- Load exceptions_handler data
		local
			loading_rescued: BOOLEAN
		do
			if not loading_rescued then
				internal_exceptions_handler := dbg_storage.exceptions_handler_data_from_storage
			else
				-- Issue !
			end
		rescue
			loading_rescued := True
			retry
		end

	load_profiles_data is
			-- Load profiles
		local
			prof: like profiles
			rescued: BOOLEAN
		do
			if not rescued then
				prof := dbg_storage.profiles_data_from_storage
				if prof /= Void then
					profiles := prof
				else
					check profiles /= Void end
				end
			else
				-- Issue !
			end
		rescue
			rescued := True
			retry
		end

	save_all_debugger_data is
			-- Save debug informations into the file `raw_filename'.
		do
			save_profiles_data
			save_breakpoints_data
			save_exceptions_handler_data
		end

	save_breakpoints_data is
			-- Save breakpoints and exceptions_handler data
		local
			retried: BOOLEAN
			bplst: BREAK_LIST
			old_bplist: BREAK_LIST
		do
			if not retried then
					-- backup current list
				old_bplist := breakpoints_manager.breakpoints
				bplst := old_bplist.duplication

				breakpoints_manager.set_breakpoints (bplst)

					-- Reset information about the application
					-- contained in the breakpoints.
				bplst.restore

				dbg_storage.breakpoints_data_to_storage (bplst)

				bplst := Void

				breakpoints_manager.set_breakpoints (old_bplist)
			else
				set_error_message ("Unable to save debugger's breakpoints%N")
			end
		rescue
			if old_bplist /= Void then
				breakpoints_manager.set_breakpoints (old_bplist)
				old_bplist := Void
			end
			retried := True
			retry
		end

	save_exceptions_handler_data is
			-- Save exceptions_handler data
		local
			retried: BOOLEAN
		do
			if not retried then
				dbg_storage.exceptions_handler_data_to_storage (internal_exceptions_handler)
			else
				set_error_message ("Unable to save exceptions handler's data%N")
			end
		rescue
			retried := True
			retry
		end

	save_profiles_data is
			-- Save profiles
		local
			retried: BOOLEAN
		do
			if not retried then
				dbg_storage.profiles_data_to_storage (profiles)
			else
				set_error_message ("Unable to save debugger's profiles%N")
			end
		rescue
			retried := True
			retry
		end

	restore_debugger_data is
			-- Restore debugger data
		do
			breakpoints_manager.restore
		end

feature -- Breakpoints management

	breakpoints_manager: BREAKPOINTS_MANAGER
			-- Breakpoints manager.

	process_breakpoint (bp: BREAKPOINT): BOOLEAN is
			-- Process `bp'
			-- and return True in `a_stopped_execution' if application has to stop.
		require
			bp_not_void: bp /= Void
		local
			expr: DBG_EXPRESSION
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

				if bp_reached and bp.has_when_hits_action then
					bp.when_hits_actions.do_all (agent {BREAKPOINT_WHEN_HITS_ACTION_I}.execute (bp, Current))
				end
			end
			Result := bp_reached and not bp_continue
		end

	computed_breakpoint_message (bp: BREAKPOINT; a_msg: STRING): STRING is
			-- Computed message from breakpoint message `bp.message'.
		require
			bp_not_void: bp /= Void
			bp_message_not_void: a_msg /= Void
		local
			m: STRING
			m_area: SPECIAL [CHARACTER]
			m_max: INTEGER
			cse: CALL_STACK_ELEMENT
			dv: DUMP_VALUE
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
				m := a_msg
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
							dv := expression_evaluation (v)
							if dv /= Void then
								s.append (dv.output_for_debugger)
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
				breakpoints_manager.clear_breakpoints (True)
			else
				breakpoints_manager.clear_breakpoints_at_once
			end
			breakpoints_manager.notify_breakpoints_changes
		end

feature {NONE} -- Breakpoints events

	on_breakpoints_change_event is
			-- <Precursor>	
		do
				--| For now, let's notify as new breakpoint event
				--| Later we might try to optimize.
			on_breakpoints_creation_or_removal_event
		end

	on_breakpoints_creation_or_removal_event is
			-- <Precursor>
		do
			if application_is_executing and then not application_is_stopped then
				-- If the application is running (and not stopped), we
				-- must notify it to take the new breakpoint into account.
				application.notify_breakpoints_change
			end
		end

feature -- Properties

	profiles: DEBUGGER_PROFILES
			-- Execution profiles

	object_manager: DEBUGGED_OBJECT_MANAGER
			-- Debugged object manager

	controller: DEBUGGER_CONTROLLER
			-- Debugger controller for run, resume ...

	observer_provider: DEBUGGER_OBSERVER_PROVIDER
			-- Debugger event observer service			

	dump_value_factory: DUMP_VALUE_FACTORY
			-- Dump value factory

feature -- Access

	current_execution_parameters: DEBUGGER_EXECUTION_PARAMETERS is
			-- Current resolved execution parameters
		local
			t: TUPLE [title: STRING_32; params: DEBUGGER_EXECUTION_PARAMETERS]
			params: like current_execution_parameters
		do
			t := profiles.last_profile
			if t /= Void then
				params := t.params
			end
			Result := resolved_execution_parameters (params)
		ensure
			result_not_void: Result /= Void
		end

	resolved_execution_parameters (params: DEBUGGER_EXECUTION_PARAMETERS): DEBUGGER_EXECUTION_PARAMETERS is
			-- Resolved execution parameters from `params'
			-- i.e: check the validity of parameters, and either correct them, of fill with default values.
		local
			envi: ENV_INTERP
			shared_eiffel: SHARED_EIFFEL_PROJECT
			wd: STRING
			l_dir: DIRECTORY
		do
			create Result

			create envi
			create shared_eiffel

				--| arguments			
			if params /= Void and then params.arguments /= Void and then not params.arguments.is_empty then
				Result.set_arguments (envi.interpreted_string (params.arguments))
			else
				Result.set_arguments ("")
			end

				--| Working_directory
			if params /= Void and then params.working_directory /= Void and then not params.working_directory.is_empty then
				wd := envi.interpreted_string (params.working_directory)
			else
				wd := shared_eiffel.Eiffel_project.lace.directory_name
			end
			wd := wd.twin; wd.left_adjust; wd.right_adjust
			if wd.count > 1 then
					-- Check if directory exists? If it does not, it might be because of
					-- an extra directory separator at the end of the name which could cause
					-- some problem. Therefore we remove it.
					-- We only do it if there is at least one character in the directory name,
					-- otherwise it does not make sense.
				create l_dir.make (wd)
				if not l_dir.exists and then wd.item (wd.count) = (create {OPERATING_ENVIRONMENT}).directory_separator then
					wd.remove_tail (1)
					create l_dir.make (wd)
					if not l_dir.exists then
							-- Revert back to the original string.
						wd.extend ((create {OPERATING_ENVIRONMENT}).directory_separator)
					end
				end
			end
			Result.set_working_directory (wd)

				--| environment_variables
			if params /= Void and then params.environment_variables /= Void and then not params.environment_variables.is_empty then
				Result.set_environment_variables (params.environment_variables.twin)
			end
		ensure
			result_not_void: Result /= Void
		end

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

	execution_ignoring_breakpoints: BOOLEAN assign set_execution_ignoring_breakpoints
			-- Is execution ignore breakpoints ?

	execution_replay_recording_enabled: BOOLEAN
			-- Is execution replay recording enabled ?

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
			l_name: STRING
		do
			Result := True
			if exceptions_handler.enabled then
				application_status.update_on_pre_stopped_state
				l_name := application_status.exception_type_name
				if l_name /= Void then
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
			Result := internal_exceptions_handler
			if Result = Void then
				create Result.make_handling_by_name
				internal_exceptions_handler := Result
			end
		ensure
			Result_not_void: Result /= Void
		end

feature {NONE} -- Internal data

	internal_exceptions_handler: like exceptions_handler
			-- Once perobject: exceptions_handler

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
		ensure
			o_is_attached: o.is_attached_to (Current)
		end

	remove_observer (o: DEBUGGER_OBSERVER) is
		require
			o_is_attached: o.is_attached_to (Current)
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

	confirm_ignore_all_breakpoints_preference_string: STRING is
			-- Preference string for discardable promt related to ignore all breakpoints command
		do
			Result := Void
		end

	dotnet_keep_stepping_info_non_eiffel_feature: BOOLEAN is
			-- Keep stepping into feature including non Eiffel feature (useful to step into agent call) ?
			-- turning this on will have impact on debugging performance (since most of the time,
			-- we don't want to step into non eiffel feature)
		do
			Result := False
		end

	dotnet_debugger_entries: ARRAY [STRING] is
			-- Which dotnet debugger is used?
		do
			Result := <<>>
		end

	is_true_boolean_value (a_string: STRING): BOOLEAN is
			-- Boolean preferences associated to `a_string'
		do
			Result := False
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

feature -- Expression evaluation

	expression_evaluation (a_expr: STRING): DUMP_VALUE is
			-- Expression evaluation's result for `a_expr' in current context
			-- (note: Result = Void implies an error occurred)
		require
			safe_application_is_stopped: safe_application_is_stopped
		local
			exp: DBG_EXPRESSION
		do
			if safe_application_is_stopped then
				create exp.make_for_context (a_expr)
				if not exp.error_occurred then
					exp.evaluate_with_settings (False)
					if not exp.error_occurred then
						Result := exp.expression_evaluator.final_result_value
					end
				end
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

	update_rt_extension_available is
			-- Update value of `rt_extension_available'
		do
				--| Check if RT_EXTENSION is available
			rt_extension_available := Eiffel_project.system_defined and then
							{cl_i: CLASS_I} Eiffel_system.system.rt_extension_class and then
							cl_i.is_compiled
		end

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

feature -- Application change

	do_not_stop_at_breakpoints is
			-- Ignore breakpoints
		do
			set_execution_ignoring_breakpoints (True)
		end

	stop_at_breakpoints is
			-- Stop at breakpoints
		do
			set_execution_ignoring_breakpoints (False)
		end

	set_execution_ignoring_breakpoints (b: like execution_ignoring_breakpoints) is
			-- Set `execution_ignoring_breakpoints'
		do
			if execution_ignoring_breakpoints /= b then
				execution_ignoring_breakpoints := b
				if application_initialized then
					application.ignore_breakpoints (b)
					if not application_is_stopped then
						if b then
							debugger_status_message (debugger_names.t_Running_no_stop_points)
						else
							debugger_status_message (debugger_names.t_Running)
						end
					end
				end
			end
		end

	activate_execution_replay_recording (b: BOOLEAN) is
			-- Activate or Deactivate execution replay recording
		local
			r: BOOLEAN
		do
			execution_replay_recording_enabled := b
			if safe_application_is_stopped then
				if application_status.replay_recording /= b then
					r := application.activate_execution_replay_recording (b)
					if b and not r then
							--| Let's try to stop the recording if possible.
						r := application.activate_execution_replay_recording (not b)
						execution_replay_recording_enabled := not b
					end
				end
			end
		end

	set_catcall_detection_in_console (b: BOOLEAN) is
			-- set catcall detection mode in console
		do
			set_catcall_detection_mode (b, not exceptions_handler.catcall_debugger_warning_disabled)
		end

	set_catcall_detection_in_debugger (b: BOOLEAN) is
			-- set catcall detection mode in debugger
		do
			set_catcall_detection_mode (not exceptions_handler.catcall_console_warning_disabled, b)
		end

	set_catcall_detection_mode (a_console, a_dbg: BOOLEAN) is
		do
			if {exc_hld: like exceptions_handler} exceptions_handler then
				if exc_hld.catcall_console_warning_disabled /= not a_console then
					exc_hld.set_catcall_console_warning_disabled (not a_console)
				end
				if exc_hld.catcall_debugger_warning_disabled /= not a_dbg then
					exc_hld.set_catcall_debugger_warning_disabled (not a_dbg)
				end
			end

			if application_initialized then
				safe_update_catcall_detection_mode
			end
		end

	safe_update_catcall_detection_mode is
			-- Update catcall detection mode
		require
			application_initialized: application_initialized
		do
			if safe_application_is_stopped then
				update_catcall_detection_mode
			else
				add_on_update_action (agent (adbg: DEBUGGER_MANAGER)
						require
							safe_application_is_stopped: safe_application_is_stopped
						do
							adbg.update_catcall_detection_mode
						end,
					True)
			end
		end

	update_catcall_detection_mode is
			-- pdate catcall detection mode
		require
			safe_application_is_stopped: safe_application_is_stopped
		do
			if {exc_hld: like exceptions_handler} exceptions_handler then
				application.set_catcall_detection_mode (not exc_hld.catcall_console_warning_disabled, not exc_hld.catcall_debugger_warning_disabled)
			end
		end

	disable_assertion_checking is
			-- Disable assertion checking
		require
			safe_application_is_stopped: safe_application_is_stopped
		local
			s: STRING_32
		do
			s := "Disable assertion checking"

			if application.last_assertion_check_stack.is_empty then
				--| was unchanged
			elseif application.last_assertion_check_stack.item then
				s.append_string (" (was enabled)")
			else
				s.append_string (" (was disabled)")
			end
			application.disable_assertion_check
			debugger_status_message (s)
		end

	restore_assertion_checking is
			-- Enable assertion checking	
		require
			safe_application_is_stopped: safe_application_is_stopped
		local
			s: STRING_32
		do
			s := "Restore assertion checking"
			if application.last_assertion_check_stack.is_empty then
				s.append_string (" (ignored since it was not changed).")
			else
				if application.last_assertion_check_stack.item then
					s.append_string (" (was enabled)")
				else
					s.append_string (" (was disabled)")
				end
				application.restore_assertion_check
			end
			debugger_status_message (s)
		end

feature -- Compilation events

	on_project_recompiled (is_successful: BOOLEAN) is
		do
			if is_successful then
				if
					breakpoints_manager /= Void and then
					breakpoints_manager.has_breakpoint
				then
					Degree_output.put_resynchronizing_breakpoints_message
					breakpoints_manager.resynchronize_breakpoints
				end
					-- Save breakpoint status and command line.
				save_breakpoints_data
			end
			update_rt_extension_available
		end

feature -- Debugging events

	debugging_operation_id: NATURAL_32
			-- Debugging operation id, to dentify the current status
			--| Note: might need to move this to APPLICATION_* classes

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
			bploc: BREAKPOINT_LOCATION
			bp: BREAKPOINT
		do
			debugging_operation_id := 0
			compute_class_c_data
			from
				bl := breakpoints_manager.breakpoints
				bl.start
			until
				bl.after
			loop
				bl.item_for_iteration.reset_session_data
				bl.forth
			end
			save_breakpoints_data

				--| Check if RT_EXTENSION is available
			update_rt_extension_available

			if not rt_extension_available then
				activate_execution_replay_recording (False)
			end
			if execution_replay_recording_enabled then
				--| Issue if run without breakpoints !
				bploc := breakpoints_manager.entry_breakpoint_location
				if bploc /= Void and then bploc.is_valid then
					bp := breakpoints_manager.new_hidden_breakpoint (bploc)
					bp.add_when_hits_action (create {BREAKPOINT_WHEN_HITS_ACTION_EXECUTE}.make (
							agent (abp: BREAKPOINT; adbg: DEBUGGER_MANAGER)
								do
									adbg.activate_execution_replay_recording (True)
										--| At this point, this is safe to delete it
										--| since we know there is only 1 when_hits action.
									adbg.breakpoints_manager.delete_breakpoint (abp)
									adbg.breakpoints_manager.notify_breakpoints_changes
								end
							)
						)
					bp.set_continue_execution (True)
					breakpoints_manager.add_breakpoint (bp)
				end
				add_on_stopped_action (agent (abp: BREAKPOINT; adbg: DEBUGGER_MANAGER)
								do
										--| In case, the hidden bp is not reached,
										--| but we still stop, then let's delete it
									adbg.activate_execution_replay_recording (True)
									if abp /= Void then
										adbg.breakpoints_manager.delete_breakpoint (abp)
										adbg.breakpoints_manager.notify_breakpoints_changes
									end
								end (bp, ?),
								True)
			end

			application_launching_in_progress := True
			application_prelaunching_actions.call (Void)
		end

	on_application_initialized is
			-- Application is launched but stopped at the entry point for now
			--| just before the resume. The state should not be considered as a valid stopped state
			--| but this can be used to intialized extra application parameters
		do
			update_catcall_detection_mode
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
			if application.ignoring_breakpoints then
				s.append (debugger_names.t_space_application_ignoring_breakpoints)
			end
			debugger_status_message (s)
			debugger_output_message (s)

				--| Observers
			observers.do_all (agent {DEBUGGER_OBSERVER}.on_application_launched (Current))

				--| Output information			
			display_application_status
		end

	on_application_before_paused is
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

	on_application_paused is
		require
			app_is_executing: safe_application_is_stopped
		do
				--| Observers
			observers.do_all (agent {DEBUGGER_OBSERVER}.on_application_paused (Current))
		end

	on_application_debugger_update is
		require
			app_is_executing: safe_application_is_stopped
		do
				--| Observers
			observers.do_all (agent {DEBUGGER_OBSERVER}.on_application_debugger_update (Current))
		end

	on_application_just_stopped is
		require
			app_is_executing: safe_application_is_stopped
		do
			incremente_debugging_operation_id
			debugger_status_message (debugger_names.t_Paused)

				--| Reset current stack number to 1 (top level)
			application.set_current_execution_stack_number (1)

				--| Observers
			observers.do_all (agent {DEBUGGER_OBSERVER}.on_application_stopped (Current))
		end

	on_application_before_resuming is
		require
			app_is_executing: safe_application_is_stopped
		do
			check
				execution_ignoring_breakpoints_up_to_date: execution_ignoring_breakpoints = application.ignoring_breakpoints
			end
		end

	on_application_resumed is
		require
			app_is_executing: application_is_executing and then not application_is_stopped
		do
			object_manager.reset

			incremente_debugging_operation_id
				--| Display running mode, only if ignoring bp
			if application.ignoring_breakpoints then
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
				observers.do_all (agent {DEBUGGER_OBSERVER}.on_application_exited (Current))

					--| Kept objects
				application_status.clear_kept_objects
			end

				--| Save debug info
			save_breakpoints_data

			destroy_application

			on_debugging_terminated (was_executing)
			debug ("debugger_trace_synchro")
				io.put_string (generator + ".on_application_quit : done%N")
			end
		end

	on_debugging_terminated (was_executing: BOOLEAN) is
			-- Called at the very end of debuggging session
			-- after `on_application_quit'
		local
			bl: BREAK_LIST
		do
			-- do_nothing
			application_quit_actions.call (Void)

			from
				bl := breakpoints_manager.breakpoints
				bl.start
			until
				bl.after
			loop
				bl.item_for_iteration.revert_session_data
				bl.forth
			end
			reset_class_c_data
		end

feature -- Actions

	application_prelaunching_actions: ACTION_SEQUENCE [TUPLE]
			-- Actions to be process just before starting the debuggee.

	application_quit_actions: ACTION_SEQUENCE [TUPLE]
			-- Actions to be process when the debuggee exits.

feature -- One time action

	add_on_stopped_action (p: PROCEDURE [ANY, TUPLE [DEBUGGER_MANAGER]]; is_kamikaze: BOOLEAN) is
			-- Add `p' to `stopped_actions' with `p'.
		require
			p_not_void: p /= Void
		do
			if is_kamikaze then
				observer_provider.application_stopped_actions.extend_kamikaze (p)
			else
				observer_provider.application_stopped_actions.extend (p)
			end
		end

	add_on_update_action (p: PROCEDURE [ANY, TUPLE [DEBUGGER_MANAGER]]; is_kamikaze: BOOLEAN) is
			-- Add `p' to `stopped_actions' with `p'.
		require
			p_not_void: p /= Void
		do
			if is_kamikaze then
				observer_provider.application_debugger_update_actions.extend_kamikaze (p)
			else
				observer_provider.application_debugger_update_actions.extend (p)
			end
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

feature -- Logger

	log_message (s: STRING_32) is
			-- Log message `s'
		require
			s_not_empty: s /= Void and then s.count > 0
		do
			debugger_output_message (s)
		end

feature {APPLICATION_EXECUTION} -- specific implementation

	Character_routines: CHARACTER_ROUTINES is
		once
			create Result
		end

	implementation: DEBUGGER_MANAGER_IMP;

invariant

	dbg_storage_attached: dbg_storage /= Void
	implementation_not_void: implementation /= Void
	controller_not_void: controller /= Void

	application_initialized_not_void: application_initialized implies application /= Void
	application_associated_to_current: application /= Void implies application.debugger_manager = Current

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
