indexing
	description: "Summary description for {TEST_GENERATOR}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	TEST_GENERATOR

inherit
	TEST_GENERATOR_I

	TEST_CREATOR
		redefine
			make,
			is_valid_typed_configuration,
			stop_process
		end

-- Following ancestors copied from {AUTO_TEST}

	EIFFEL_ENV
		export
			{NONE} all
		end

	AUTO_TEST_COMMAND_LINE_PARSER
		export
			{NONE} all
		end

	AUT_SHARED_INTERPRETER_INFO
		export
			{NONE} all
		end

	AUT_SHARED_TYPE_FORMATTER
		export
			{NONE} all
		end

	AUT_SHARED_CONSTANTS
		export
			{NONE} all
		end

	ERL_G_TYPE_ROUTINES
		export
			{NONE} all
		end

	ERL_CONSTANTS
		export
			{NONE}
		end

	KL_SHARED_FILE_SYSTEM
		export
			{NONE} all
		end

	DT_SHARED_SYSTEM_CLOCK
		export
			{NONE} all
		end

	KL_SHARED_STREAMS
		export
			{NONE} all
		end

create
	make

feature {NONE} -- Initialization

	make (a_test_suite: like test_suite)
			-- <Precursor>
		do
			Precursor (a_test_suite)
			create source_writer
		end

feature {NONE} -- Access

	status: NATURAL
			-- Current status

	current_task: ?AUT_TASK
			-- Task `Current' works on every time `proceed' is called.

	current_class: ?CLASS_C
			-- Class for which test routines are currently created

	source_writer: !TEST_GENERATED_SOURCE_WRITER
			-- Source writer used for creating test classes

feature -- Status report

	is_compiling: BOOLEAN
			-- <Precursor>
		do
			Result := status = compile_status_code
		end

	is_executing: BOOLEAN
			-- <Precursor>
		do
			Result := status = execute_status_code
		end

	is_replaying_log: BOOLEAN
			-- <Precursor>
		do
			Result := status = replay_status_code
		end

	is_minimizing_witnesses: BOOLEAN
			-- <Precursor>
		do
			Result := status = minimize_status_code
		end

	is_generating_statistics: BOOLEAN
			-- <Precursor>
		do
			Result := status = statistic_status_code
		end

feature {NONE} -- Status report

	is_creating_new_class: BOOLEAN
			-- <Precursor>
		do
			Result := current_class /= Void
		ensure then
			definition: Result = (current_class /= Void)
		end

feature {NONE} -- Query

	is_valid_typed_configuration (a_arg: like conf_type): BOOLEAN
			-- <Precursor>
		do
			Result := Precursor (a_arg) and then a_arg.is_multiple_new_classes
		end

feature {NONE} -- Basic operations

	proceed_process
			-- <Precursor>
		do
			is_finished := is_stop_requested
			if current_task /= Void and then current_task.has_next_step then
				update_remaining_time
				if is_stop_requested or (is_executing and then error_handler.remaining_time.second_count <= 0) then
					current_task.cancel
				else
					current_task.step
					update_remaining_time
				end
			elseif is_compiling then
				prepare
				status := execute_status_code
				internal_progress := {REAL} 0.25
			elseif is_executing then
				if current_task = Void then
					error_handler.report_random_testing
					execute_random_tests
				else
					current_task := Void
					if is_replay_enabled then
						status := replay_status_code
					else
						status := minimize_status_code
					end
				end
				internal_progress := {REAL} 0.5
			elseif is_replaying_log then
				if current_task = Void then
					replay_log (log_to_replay)
				else
					current_task := Void
					status := minimize_status_code
				end
				internal_progress := {REAL} 0.6
			elseif is_minimizing_witnesses then
				if current_task = Void then
					if interpreter.is_running then
						interpreter.stop
					end
					build_result_repository
					generate_pre_minimize_statistics
					if is_minimization_enabled then
						prepare_witness_minimization
					else
						status := statistic_status_code
					end
				else
					current_task := Void
					status := statistic_status_code
				end
				internal_progress := {REAL} 0.75
			elseif is_generating_statistics then
				generate_statistics
				generate_test_class
				is_finished := True
			end

			if is_finished then
					-- Cleanup
				if interpreter /= Void then
					interpreter.cleanup
					interpreter := Void
				end
				current_task := Void
				types_under_test := Void
				classes_under_test := Void
				result_repository := Void
			end
		end

	stop_process
			-- <Precursor>
		do
			Precursor
			status := compile_status_code
		end

feature {NONE} -- Implementation

	prepare
		do
			check_environment_variable
			set_precompile (False)
			output_dirname := file_system.pathname (system.eiffel_project.project_directory.testing_results_path, "auto_test")
			create time_out.make (0, 0, 0, 0, 15, 0)
			create error_handler.make (system)

			process_configuration

			if should_display_help_message then
				error_handler.report_info_message (help_message)
				is_finished := True
			else

				generate_interpreter

				if not is_finished and interpreter /= Void then
							-- Generate and run test cases.
					build_types_and_classes_under_test
					error_handler.set_start_time (system_clock.date_time_now)
				else
					test_suite.propagate_error ("Not able to use workbench executable for interpreter", [], Current)
					is_finished := True
				end
			end
		end

	process_configuration
			-- use `configuration' to initialize AutoTest settings
		do
			error_handler.enable_verbose

			is_slicing_enabled := configuration.is_slicing_enabled
			is_ddmin_enabled := configuration.is_ddmin_enabled
			is_minimization_enabled := is_slicing_enabled or is_ddmin_enabled

			create time_out.make (0, 0, 0, 0, configuration.time_out.as_integer_32, 0)

			if configuration.seed > 0 then
				random.set_seed (configuration.seed.to_integer_32)
			else
				random.set_seed ((create {TIME}.make_now).milli_second)
			end

			is_text_statistics_format_enabled := True
			is_html_statistics_format_enabled := configuration.is_html_output

			proxy_time_out := configuration.proxy_time_out.as_integer_32

			create {DS_ARRAYED_LIST [STRING]} class_names.make_from_linear (configuration.types)
		end

	prepare_witness_minimization
			-- Create and launch task for witness minimization
		local
			l_task: AUT_WITNESS_MINIMIZER
		do
			create l_task.make (result_repository, interpreter, error_handler, system, output_dirname, is_ddmin_enabled, is_slicing_enabled)
			launch_task (l_task)
		end

feature {NONE} -- Interpreter generation

	generate_interpreter
			-- Generate interpreter for `a_project' and store result in `interpreter'.		
			-- The generated interpreter classes will be located in auto_test_gen directory in project directoryin EIFGENs
			-- for example EIFGENs/project01/auto_test_gen
		require
			system_compiled: system.workbench /= Void
		local
			factory: AUT_INTERPRETER_GENERATOR
			interpreter_base_dirname: STRING
			log_dirname: STRING
		do
				-- Setup paths for interpreter generation.		
			interpreter_base_dirname := file_system.pathname (output_dirname, "aut_interpreter")
			log_dirname := file_system.pathname (output_dirname, "log")

			create factory.make (system)
				-- We generate the skeleton of the interpreter when asked.
				-- Interpreter skeleton only need to be generated once.				
			if not just_test then
				--factory.generate_interpreter_skeleton (interpreter_base_dirname)
			end

				-- Melt system with interpreter as its new root.			
			compile_project (interpreter_root_class_name, interpreter_root_feature_name)
			if system.eiffel_project.successful then
				system.make_update (False)

					-- Generate interpreter.
				factory.create_interpreter (interpreter_base_dirname, log_dirname, error_handler)
				interpreter := factory.last_interpreter
				if interpreter /= Void and then proxy_time_out > 0 then
					interpreter.set_timeout (proxy_time_out)
				end
			else
				is_finished := True
			end
		end

	compile_project (a_root_class: STRING; a_root_feature: STRING) is
			-- Compile `a_project' with new `a_root_class' and `a_root_feature'.
		require
			a_root_class_attached: a_root_class /= Void
			not_a_root_class_is_empty: not a_root_class.is_empty
			a_root_feature_attached: a_root_feature /= Void
			not_a_root_feature_is_empty: not a_root_feature.is_empty
		do
			if not system.is_explicit_root (a_root_class, a_root_feature) then
				system.add_explicit_root (Void, a_root_class, a_root_feature)
			end
			if test_suite.eiffel_project_helper.can_compile then
				test_suite.eiffel_project_helper.compile
			end
			system.remove_explicit_root (a_root_class, a_root_feature)
		end

feature{NONE} -- Test case generation and execution

	build_types_and_classes_under_test is
			-- Build `types_under_test' and `classes_under_test' from `types'.
		require
			system_attached: system /= Void
		local
			tester: AUT_CLASS_EQUALITY_TESTER
			l_class_set: DS_HASH_SET [CLASS_I]
			l_class_cur: DS_HASH_SET_CURSOR [CLASS_I]
			l_type: TYPE_A
			l_class_name_set: DS_HASH_SET [STRING]
			l_name_cur: DS_HASH_SET_CURSOR [STRING]
		do
			create types_under_test.make (class_names.count)
			create classes_under_test.make (class_names.count)
			create tester.make
			classes_under_test.set_equality_tester (tester)

				-- Get list of type names which are to be tested
				-- For generic classes, the actual generic parameter can be given or not.
				-- If actual generic parameter is given, that particular generic derivation is testes,
				-- otherwise, the default generic parameter constraint is used to get a valid generic derivation.
			create l_class_name_set.make (50)
			l_class_name_set.set_equality_tester (
				create {AGENT_BASED_EQUALITY_TESTER [STRING]}.make (
					agent (a_str, b_str: STRING): BOOLEAN
						do
							Result := a_str.is_equal (b_str)
						end))
			if class_names.count > 0 then
					-- If type names are given explicitly (either from command line or from compiler,
					-- we only test those classes, of course their supplier classes will also be tested in passing.
				class_names.do_all (agent l_class_name_set.force_last)
			else
					-- If no type name is given explictly, we test all compiled classes in the system.
				l_class_set := system.universe.all_classes.twin
				from
					l_class_cur := l_class_set.new_cursor
					l_class_cur.start
				until
					l_class_cur.after
				loop
					l_class_name_set.force_last (l_class_cur.item.name)
					l_class_cur.forth
				end
			end

			if not l_class_name_set.is_empty then
				from
					l_name_cur := l_class_name_set.new_cursor
					l_name_cur.start
				until
					l_name_cur.after
				loop
					l_type := base_type (l_name_cur.item, interpreter_root_class)
					if l_type /= Void then
						if l_type.associated_class.is_generic then
							if not {l_gen_type: GEN_TYPE_A} l_type then
								if {l_gen_type2: GEN_TYPE_A} l_type.associated_class.actual_type then
									l_type := generic_derivation_of_type (l_gen_type2, l_gen_type2.associated_class)
								else
									check
										dead_end: False
									end
								end
							end
						end
						if {l_class_type: CL_TYPE_A} l_type then
								-- Only compiled classes are taken into consideration.
							if l_class_type.associated_class /= Void then
								if not interpreter_related_classes.has (l_class_type.name) then
									types_under_test.force_last (l_class_type)
								end
							end
						else
							check
								dead_end: False
							end
						end
					end
					l_name_cur.forth
				end
				l_class_name_set.start
			end
		end

	execute_random_tests is
			-- Execute random tests.
		require
			system_not_empty: system /= Void
			interpreter_not_void: interpreter /= Void
			types_under_test_not_void: types_under_test /= Void
			no_type_under_test_void: not types_under_test.has (Void)
		local
			cs: DS_LINEAR_CURSOR [CL_TYPE_A]
			strategy: AUT_RANDOM_STRATEGY
		do
			interpreter.set_is_in_replay_mode (False)
			create strategy.make (system, interpreter, error_handler)
			from
				cs := types_under_test.new_cursor
				cs.start
			until
				cs.off
			loop
				strategy.queue.set_static_priority_of_type (cs.item, 10)
				cs.forth
			end
			launch_task (strategy)
		end

	launch_task (a_task: like current_task)
			-- Launch `a_task' and set `current_task' to `a_task'.
		require
			a_task_not_launched: not a_task.has_next_step
		do
			a_task.start
			current_task := a_task
		end

	update_remaining_time is
			-- Update `error_handler.remaining_time' and mark in the proxy log every elapsed minute.
		local
			duration: DT_DATE_TIME_DURATION
			time_left: DT_DATE_TIME_DURATION
			elapsed_minutes: INTEGER
		do
			duration := error_handler.duration_to_now

			elapsed_minutes := (duration.second_count / 60).floor
			if elapsed_minutes /= times_duration_logged then
				interpreter.log_line (time_passed_mark + duration.second_count.out)
				times_duration_logged := times_duration_logged + 1
			end

			time_left := time_out - duration
			time_left.set_time_canonical
			if time_left.second_count < 0 then
				create time_left.make (0, 0, 0, 0, 0, 0)
			end
			error_handler.set_remaining_time (time_left)
		ensure
			remaining_time_set: error_handler.remaining_time /= Void
		end

feature{NONE} -- Test result analyizing

	replay_log (a_log_file: STRING) is
			-- Replay log stored in `a_log_file'.
		local
			l_replay_strategy: AUT_REQUEST_PLAYER
		do
			interpreter.set_is_in_replay_mode (True)
			create l_replay_strategy.make (system, interpreter)
			l_replay_strategy.set_request_list (requests_from_file (a_log_file, create {AUT_LOG_PARSER}.make (system, error_handler)))
			l_replay_strategy.set_is_interpreter_started_by_default (False)
			launch_task (l_replay_strategy)
		end

	requests_from_file (a_log_file_name: STRING; a_log_loader: AUT_LOG_PARSER): DS_ARRAYED_LIST [AUT_REQUEST] is
			-- Result repository from log file `a_log_file_name' loaded by `a_log_loader'
		require
			a_log_file_name_attached: a_log_file_name /= Void
			a_log_loader_attached: a_log_loader /= Void
		local
			log_stream: KL_TEXT_INPUT_FILE
			repository: AUT_TEST_CASE_RESULT_REPOSITORY
		do
			create repository.make
			create log_stream.make (a_log_file_name)
			log_stream.open_read
			if not log_stream.is_open_read then
				error_handler.report_cannot_read_error (a_log_file_name)
				create Result.make (0)
			else
				a_log_loader.parse_stream (log_stream)
				Result := a_log_loader.request_history
			end
			log_stream.close
		ensure
			result_attached: Result /= Void
		end

	build_result_repository is
			-- Build result repository from log file.
		local
			log_stream: KL_TEXT_INPUT_FILE
			builder: AUT_RESULT_REPOSITORY_BUILDER
		do
			create result_repository.make
			create log_stream.make (interpreter.proxy_log_filename)
			log_stream.open_read
			if not log_stream.is_open_read then
				error_handler.report_cannot_read_error (interpreter.proxy_log_filename)
			else
				create builder.make  (system, error_handler)
				builder.build (log_stream)
				result_repository := builder.last_result_repository
				log_stream.close
			end

		ensure
			result_repository_not_void: result_repository /= Void
		end

	generate_pre_minimize_statistics is
			-- Generate statistics about executed tests.
		require
			result_repository_not_void: result_repository /= Void
		local
			text_generator: AUT_TEXT_STATISTICS_GENERATOR
		do
			if is_text_statistics_format_enabled then
				create text_generator.make ("pre_minimization_", file_system.pathname (output_dirname, "result"), system, classes_under_test)
				text_generator.generate (result_repository)
				if text_generator.has_fatal_error then
					error_handler.report_text_generation_error
				else
					error_handler.report_text_generation_finished (text_generator.absolute_index_filename)
				end
			end
		end

	generate_statistics is
			-- Generate statistics about executed tests.
		require
			result_repository_not_void: result_repository /= Void
		local
			html_generator: AUT_HTML_STATISTICS_GENERATOR
			text_generator: AUT_TEXT_STATISTICS_GENERATOR
		do
			if is_text_statistics_format_enabled then
				create text_generator.make ("", file_system.pathname (output_dirname, "result"), system, classes_under_test)
				text_generator.generate (result_repository)
				if text_generator.has_fatal_error then
					error_handler.report_text_generation_error
				else
					error_handler.report_text_generation_finished (text_generator.absolute_index_filename)
				end
			end
			if is_html_statistics_format_enabled then
				create html_generator.make (file_system.pathname (output_dirname, "result"), system, classes_under_test)
				html_generator.generate (result_repository)
				if html_generator.has_fatal_error then
					error_handler.report_html_generation_error
				else
					error_handler.report_html_generation_finished (html_generator.absolute_index_filename)
				end
			end
		end

	generate_test_class
			-- Generate resulting {EQA_TEST_SET} class
		local
			l_class_cursor: DS_LINEAR_CURSOR [CLASS_C]
		do
			from
				l_class_cursor := result_repository.classes.new_cursor
				l_class_cursor.start
			until
				l_class_cursor.after
			loop
				current_class := l_class_cursor.item
				create_new_class
				current_class := Void
				l_class_cursor.forth
			end
		end

	print_new_class (a_file: !KL_TEXT_OUTPUT_FILE; a_class_name: !STRING)
			-- <Precursor>
		local
			l_res_cursor: DS_LINEAR_CURSOR [AUT_TEST_CASE_RESULT]
			l_feat_table: FEATURE_TABLE
			l_set: AUT_TEST_CASE_RESULT_SET
			l_feat: FEATURE_I
			l_contains_test: BOOLEAN
			l_system: SYSTEM_I
			l_class_name: STRING
		do
			l_system := test_suite.eiffel_project.system.system
			l_class_name := current_class.name
			check l_system /= Void and l_class_name /= Void end
			source_writer.prepare (a_file, a_class_name, l_system, l_class_name)
			from
				l_feat_table := current_class.feature_table
				l_feat_table.start
			until
				l_feat_table.after
			loop
				l_feat := l_feat_table.item_for_iteration
				if l_feat /= Void and then
				   --not (l_feat.is_attribute or l_feat.is_function) and
				   not l_feat.is_prefix and
				   not l_feat.is_infix and
				   not l_feat.written_class.name.is_equal ("ANY")
				then
					l_set := result_repository.results_by_feature_and_class (l_feat, current_class)
					if not (l_set.is_pass or l_set.is_untested) then
						from
							l_res_cursor := l_set.list.new_cursor
							l_res_cursor.start
						until
							l_res_cursor.after
						loop
							if l_res_cursor.item.is_fail then
								if {l_var_list: DS_HASH_TABLE [TUPLE [STRING, BOOLEAN], ITP_VARIABLE]} l_res_cursor.item.witness.used_vars and
								   {l_request_list: DS_LINEAR [AUT_REQUEST]} l_res_cursor.item.witness.request_list
								then
									l_contains_test := True
									source_writer.print_test_routine (l_request_list, l_var_list)
								end
							end
							l_res_cursor.forth
						end
					end
				end
				l_feat_table.forth
			end
			source_writer.finish
			if not l_contains_test then
				if a_file.is_closable then
					a_file.close
				end
				a_file.delete
			end
		end

feature {NONE} -- Implementation

	system: SYSTEM_I
			-- System under test
			--
			-- Note: unfortunately the current design does not let us check whether the project is available
--		require
--			test_suite_valid: is_test_suite_valid
--			project_initialized: test_suite.is_project_initialized
		do
			Result := test_suite.eiffel_project.system.system
		end

	interpreter: AUT_INTERPRETER_PROXY
			-- Interpreter for system under test

	types_under_test: DS_ARRAYED_LIST [CL_TYPE_A]
			-- Types under test

	classes_under_test: DS_ARRAYED_LIST [CLASS_C]
			-- Classes under test

	times_duration_logged: INTEGER
			-- Number of times that elapsed time has been recorded to proxy file

	result_repository: AUT_TEST_CASE_RESULT_REPOSITORY
			-- Repository storing test case results

feature {NONE} -- Constants

	application_name: STRING is "ec"
			-- Name of EiffelStudio exe;
			-- Needed to locate the correct registry keys on windows
			-- in order to find it's install path.

	compile_status_code: NATURAL = 0
	execute_status_code: NATURAL = 1
	replay_status_code: NATURAL = 2
	minimize_status_code: NATURAL = 3
	statistic_status_code: NATURAL = 4

invariant
	not_running_implies_status_compiling: not is_running implies (status = compile_status_code)

end
