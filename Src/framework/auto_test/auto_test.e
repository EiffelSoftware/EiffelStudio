indexing

	description:

		"'auto_test' command line tool"

	copyright: "Copyright (c) 2005, Andreas Leitner and others"
	license: "Eiffel Forum License v2 (see forum.txt)"
	date: "$Date$"
	revision: "$Revision$"

class AUTO_TEST

inherit

	AUTO_TEST_COMMAND_LINE_PARSER
		export {NONE} all end

	AUT_SHARED_CONSTANTS
		export {NONE} all end

	ERL_G_TYPE_ROUTINES
		export {NONE} all end

	DT_SHARED_SYSTEM_CLOCK
		export {NONE} all end

	KL_SHARED_STRING_EQUALITY_TESTER
		export {NONE} all end

	KL_SHARED_EXECUTION_ENVIRONMENT
		export {NONE} all end

	KL_SHARED_STREAMS
		export {NONE} all end

	KL_SHARED_FILE_SYSTEM
		export {NONE} all end

	UT_SHARED_ISE_VERSIONS
		export {NONE} all end

	EIFFEL_ENV
		export {NONE} all end

	AUT_SHARED_TYPE_FORMATTER
		export {NONE} all end

	AUT_SHARED_INTERPRETER_INFO

	ERL_CONSTANTS

create

	execute

feature -- Execution

	execute (a_project: E_PROJECT; a_arguments: DS_LIST [STRING]; a_project_helper: like project_helper) is
			-- Start testing.
		do
			project_helper := a_project_helper
			system := a_project.system.system
				-- Setup environment.
			check_environment_variable
			set_precompile (False)
			Arguments.set_program_name ("auto_test")
			output_dirname := file_system.pathname (system.eiffel_project.project_directory.eifgens_cluster_path, "auto_test_gen")
			create time_out.make (0, 0, 0, 0, 15, 0)
			create error_handler.make (system)
			error_handler.set_start_time (system_clock.date_time_now)

				-- Argument processing
			process_arguments (a_arguments)

			if should_display_help_message then
					-- Display help message.
				error_handler.report_info_message (help_message)
			else
					-- Generate interpreter.			
				generate_interpreter

				if interpreter /= Void then
					update_remaining_time
					if time_out.second_count > 0 and then error_handler.remaining_time.second <= 0 then
							error_handler.report_no_time_for_testing (time_out)
					else
							-- Generate and run test cases.
						build_types_and_classes_under_test
						execute_tests

							-- Analyze test results.
						build_result_repository
						generate_pre_minimize_statistics

							-- Test case minimization.
						if is_minimization_enabled then
							minimize_witnesses
						end
						interpreter.cleanup
						generate_statistics
					end
				end
			end
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
			system.make_update (False)

				-- Generate interpreter.
			factory.create_interpreter (interpreter_base_dirname, log_dirname, error_handler)
			interpreter := factory.last_interpreter
			if interpreter /= Void and then proxy_time_out > 0 then
				interpreter.set_timeout (proxy_time_out)
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
			if project_helper.can_compile then
				project_helper.compile
			end
			system.remove_explicit_root (a_root_class, a_root_feature)
		end

feature{NONE} -- Test case generation and execution

	build_types_and_classes_under_test is
			-- Build `types_under_test' and `classes_under_test' from `class_names'.
		require
			system_attached: system /= Void
		local
			l_class_type: CL_TYPE_A
			tester: AUT_CLASS_EQUALITY_TESTER
			l_class_set: DS_HASH_SET [CLASS_I]
			l_class_cur: DS_HASH_SET_CURSOR [CLASS_I]
			l_type: TYPE_A
			l_class_name_set: DS_HASH_SET [STRING]
			l_name_cur: DS_HASH_SET_CURSOR [STRING]
			l_gen_type: GEN_TYPE_A
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
							l_gen_type ?= l_type
							if l_gen_type = Void then
								l_gen_type ?= l_type.associated_class.actual_type
								check l_gen_type /= Void end
								l_gen_type ?= generic_derivation_of_type (l_gen_type, l_gen_type.associated_class)
							end
							l_class_type := l_gen_type
						else
							l_class_type ?= l_type
						end

							-- Only compiled classes are taken into consideration.
						if l_class_type.associated_class /= Void then
							if not interpreter_related_classes.has (l_class_type.name) then
								types_under_test.force_last (l_class_type)
							end
						end
					end
					l_name_cur.forth
				end
				l_class_name_set.start
			end
		end

	execute_tests is
			-- Execute testing strategies.
		do
--			if is_manual_testing_enabled then
--				error_handler.report_manual_testing
--				execute_manual_tests
--			end
			if is_automatic_testing_enabled then
				error_handler.report_random_testing
				execute_random_tests
			end
			if is_replay_enabled then
				replay_log (log_to_replay)
			end
			if interpreter.is_running then
				interpreter.stop
			end
		end

--	build_manual_test_cases is
--			-- Create and populate `manual_test_cases' with those
--			-- manual unit test cases that are clients of any class
--			-- under test.
--		require
--			universe_not_empty: universe /= Void
--			classes_under_test_not_void: classes_under_test /= Void
--			no_class_under_test_void: not classes_under_test.has (Void)
--		local
--			test_case_locator: AUT_MANUAL_TEST_CASE_LOCATOR
--		do
--			create test_case_locator.make (universe)
--			test_case_locator.locate (classes_under_test, is_deep_relevancy_enabled)
--			manual_unit_tests := test_case_locator.relevant_test_case_classes
--		ensure
--			manual_unit_tests_not_void: manual_unit_tests /= Void
--			no_manual_unit_test_void: not manual_unit_tests.has (Void)
--		end

--	execute_manual_tests is
--			-- Execute manually written tests.
--		require
--			universe_not_empty: universe /= Void
--			interpreter_not_void: interpreter /= Void
--			manual_unit_tests_not_void: manual_unit_tests /= Void
--			no_manual_unit_test_void: not manual_unit_tests.has (Void)
--		local
--			strategy: AUT_MANUAL_STRATEGY
--		do
--			create strategy.make (manual_unit_tests, universe, interpreter, error_handler)
--			execute_task_until_time_out (strategy)
--		end

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
			execute_task_until_time_out (strategy)
		end

	execute_task (a_task: AUT_TASK) is
			-- Execute task `a_task'.
		require
			a_task_not_void: a_task /= Void
		do
			from
				a_task.start
			until
				not a_task.has_next_step
			loop
				a_task.step
				update_remaining_time
			end
		end

	execute_task_until_time_out (a_task: AUT_TASK) is
			-- Execute task `a_task', but abort if we reach the time-out.
		require
			a_task_not_void: a_task /= Void
		do
			update_remaining_time
			from
				a_task.start
			until
				(not a_task.has_next_step) or error_handler.remaining_time.second_count <= 0
			loop
				a_task.step
				update_remaining_time
			end
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
			execute_task (l_replay_strategy)
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

	minimize_witnesses
			-- Minimize witnesses for bugs (i.e. bug reproducing examples).
		require
			result_repository_not_void: result_repository /= Void
		local
			cs: DS_LINEAR_CURSOR [AUT_WITNESS]
			slice_name_generator: AUT_UNIQUE_NAME_GENERATOR
			ddmin_name_generator: AUT_UNIQUE_NAME_GENERATOR
			ddmin_step_name_generator: AUT_UNIQUE_NAME_GENERATOR
		do
			interpreter.set_is_logging_enabled (False)
			interpreter.set_is_in_replay_mode (True)
			from
				create player.make (system, interpreter)
				create slicer.make
				create ddminer.make (system, player, error_handler)
				create printer.make_null (system)
				create slice_name_generator.make_with_string_stream ("slice_")
				create ddmin_name_generator.make_with_string_stream ("ddmin_")
				create ddmin_step_name_generator.make_with_string_stream ("ddmin_step_")
				create successfully_minimized_witnesses.make_default
				cs := result_repository.witnesses.new_cursor
				cs.start
			until
				cs.off
			loop
				if cs.item.is_fail then
					last_witness := cs.item
					if is_slicing_enabled then
						slice_witness (last_witness, slice_name_generator)
					end
					if is_ddmin_enabled then
						ddmin_witness (last_witness, ddmin_name_generator, ddmin_step_name_generator)
					end
				end
				cs.forth
			end
			if interpreter.is_running then
				interpreter.stop
			end
			from
				successfully_minimized_witnesses.start
			until
				successfully_minimized_witnesses.after
			loop
				result_repository.add_witness (successfully_minimized_witnesses.item_for_iteration)
				successfully_minimized_witnesses.forth
			end
		end

	last_witness: AUT_WITNESS
			-- Last witness minimized

	slicer: AUT_SLICER
	player: AUT_REQUEST_PLAYER
	printer: AUT_TEST_CASE_PRINTER
	ddminer: AUT_DD_MINIMIZER

	slice_witness (a_witness: AUT_WITNESS; a_name_generator: AUT_UNIQUE_NAME_GENERATOR) is
			-- Slice witness and make minimzied version available via `last_witness'.
		require
			a_witness_not_void: a_witness /= Void
			a_witness_is_fail: a_witness.is_fail
			a_name_generator_not_void: a_name_generator /= Void
			player_not_void: player /= Void
			printer_not_void: printer /= Void
			slicer_not_void: slicer /= Void
		local
			file: KL_TEXT_OUTPUT_FILE
			timer_total: AUT_TIMER
			timer_execution: AUT_TIMER
			sliced_witness: AUT_WITNESS
			last_all_used_vars: DS_HASH_TABLE [TUPLE [STRING, BOOLEAN], ITP_VARIABLE]
			response_printer: AUT_RESPONSE_LOG_PRINTER
		do
			create timer_total.make
			create timer_execution.make
			error_handler.report_minimization_task
			timer_total.start
			slicer.extract_backward_slice (a_witness)
			timer_total.calculate_duration
			error_handler.report_benchmark_message ("slice extraction time: " + timer_total.last_duration.second_count.out + "s, " + timer_total.last_duration.millisecond_count.out + " ms.")
			a_name_generator.output_string.wipe_out
			a_name_generator.generate_new_name
			player.set_request_list (slicer.last_slice)
			timer_execution.start
			execute_task (player)
			timer_execution.calculate_duration
			timer_total.calculate_duration
			create sliced_witness.make_default (slicer.last_slice)
			create file.make (file_system.nested_pathname (output_dirname, <<"log", a_name_generator.output_string >>))
			if sliced_witness.is_fail and then sliced_witness.is_same_bug (a_witness) then
				last_witness := sliced_witness
				last_all_used_vars := all_used_vars (slicer.last_slice)
				last_witness.set_used_vars (last_all_used_vars)
				successfully_minimized_witnesses.force_last (last_witness)
				file.open_write
				if file.is_open_write then
					create response_printer.make (file)
					printer.set_output_stream (file)
					printer.print_test_case (a_witness.request_list, Void)
					a_witness.item (a_witness.count).response.process (response_printer)
					printer.print_test_case (slicer.last_slice, last_all_used_vars)
					if sliced_witness.item (sliced_witness.count).response /= Void then
						sliced_witness.item (sliced_witness.count).response.process (response_printer)
					end
					printer.set_output_stream (null_output_stream)
					file.close
				else
					error_handler.report_cannot_read_error (file.name)
				end
			end
			error_handler.report_benchmark_message ("slice execution time: " + timer_execution.last_duration.second_count.out + "s, " + timer_execution.last_duration.millisecond_count.out + "ms.")
			error_handler.report_benchmark_message ("slice minimization time total: " + timer_total.last_duration.second_count.out + "s, " + timer_total.last_duration.millisecond_count.out + "ms.")
			error_handler.report_benchmark_message ("slice fn: " + file.name)
			error_handler.report_benchmark_message ("slice original loc: " + a_witness.count.out)
			error_handler.report_benchmark_message ("slice minimized loc: " + last_witness.count.out)
			error_handler.report_benchmark_message ("slice successful: " + (sliced_witness.is_fail and then a_witness.is_same_bug (sliced_witness)).out)
		end

	ddmin_witness (a_witness: AUT_WITNESS; a_name_generator: AUT_UNIQUE_NAME_GENERATOR; a_step_name_generator: AUT_UNIQUE_NAME_GENERATOR) is
			-- Use ddmin to minimize witness `a_witness' (using ddmin algorithm by Andreas Zeller).
		require
			a_witness_not_void: a_witness /= Void
			a_witness_is_fail: a_witness.is_fail
			a_name_generator_not_void: a_name_generator /= Void
			a_step_name_generator_not_void: a_step_name_generator /= Void
			player_not_void: player /= Void
			printer_not_void: printer /= Void
			ddminer_not_void: ddminer /= Void
		local
			file: KL_TEXT_OUTPUT_FILE
			steps_file: KL_TEXT_OUTPUT_FILE
			minimized_witness: AUT_WITNESS
			response_printer: AUT_RESPONSE_LOG_PRINTER
		do
			error_handler.report_minimization_task
			a_step_name_generator.output_string.wipe_out
			a_step_name_generator.generate_new_name
			create steps_file.make (file_system.nested_pathname (output_dirname, <<"log", a_step_name_generator.output_string >>))
			steps_file.open_write
			if steps_file.is_open_write then
				ddminer.minimize (a_witness, steps_file)
				minimized_witness := ddminer.last_result
				a_name_generator.output_string.wipe_out
				a_name_generator.generate_new_name
				create file.make (file_system.nested_pathname (output_dirname, <<"log", a_name_generator.output_string >>))
				file.open_write
				if file.is_open_write then
					create response_printer.make (file)
					printer.set_output_stream (file)
					printer.print_test_case (a_witness.request_list, Void)
					a_witness.item (a_witness.count).response.process (response_printer)
					printer.print_test_case (ddminer.last_result.request_list, Void)
					minimized_witness.item (minimized_witness.count).response.process (response_printer)
					printer.set_output_stream (null_output_stream)
					file.close
				else
					error_handler.report_cannot_write_error (file.name)
				end
				error_handler.report_benchmark_message ("ddmin total time: " + ddminer.total_time.second_count.out + "s, " + ddminer.total_time.millisecond_count.out + "ms.")
				error_handler.report_benchmark_message ("ddmin execution time: " + ddminer.execution_time.second_count.out + "s, " + ddminer.execution_time.millisecond_count.out + "ms.")
				error_handler.report_benchmark_message ("ddmin number of executions: " + ddminer.execution_count.out)
				if ddminer.execution_count > 0 then
					error_handler.report_benchmark_message ("ddmin avg. execution time: " + (ddminer.execution_time.second_count / ddminer.execution_count).out + "s, " + (ddminer.execution_time.millisecond_count / ddminer.execution_count).out + "ms.")
				else
					error_handler.report_benchmark_message ("ddmin avg. execution time: 0s, 0ms.")
				end
				error_handler.report_benchmark_message ("ddmin fn: " + file.name)
				error_handler.report_benchmark_message ("ddmin original loc: " + a_witness.count.out)
				error_handler.report_benchmark_message ("ddmin minimized loc: " + minimized_witness.count.out)
				error_handler.report_benchmark_message ("ddmin successful: " + (minimized_witness.is_fail and then minimized_witness.is_same_bug (minimized_witness)).out)
			else
				error_handler.report_cannot_write_error (steps_file.name)
			end
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

feature {NONE} -- Implementation

	successfully_minimized_witnesses: DS_ARRAYED_LIST [AUT_WITNESS]
			-- List of witnesses that could be minimized and are added to the result repository

	all_used_vars (a_req_list: DS_LIST [AUT_REQUEST]): DS_HASH_TABLE [TUPLE [STRING, BOOLEAN], ITP_VARIABLE] is
			-- All variables used in the request list `a_req_list' with the names of their types
		require
			a_req_list_not_void: a_req_list /= Void
		local
			all_used_vars_updater: AUT_ALL_USED_VARIABLES_UPDATER
			request: AUT_REQUEST
			i: INTEGER
			l_type_name: STRING
		do
			from
				create all_used_vars_updater.make (system)
				i := 1
			until
				i > a_req_list.count
			loop
				request := a_req_list.item (i)
				request.process (all_used_vars_updater)
				i := i + 1
			end
			Result := all_used_vars_updater.variables
			from
				Result.start
			until
				Result.after
			loop
				if Result.item_for_iteration.item (1) = Void or Result.item_for_iteration.item (2).is_equal (True) then
					if interpreter.variable_table.is_variable_defined (Result.key_for_iteration) then
						if interpreter.variable_table.variable_type (Result.key_for_iteration) /= Void then
							l_type_name := type_name_with_context (interpreter.variable_table.variable_type (Result.key_for_iteration), interpreter.interpreter_root_class, Void)
						else
							interpreter.retrieve_type_of_variable (Result.key_for_iteration)
							if interpreter.variable_table.variable_type (Result.key_for_iteration) = Void then
								l_type_name := none_type_name
							else
								l_type_name := type_name_with_context (interpreter.variable_table.variable_type (Result.key_for_iteration), interpreter.interpreter_root_class, Void)
							end
						end
					else
						l_type_name := none_type_name
					end
					if Result.item_for_iteration.item (1) /= Void and Result.item_for_iteration.item (2).is_equal (True) and
						l_type_name.is_equal (none_type_name) then
							-- Do nothing.
					else
						Result.force ([l_type_name, False], Result.key_for_iteration)
					end
				end
				Result.forth
			end
		end

	system: SYSTEM_I
			-- System under test

	interpreter: AUT_INTERPRETER_PROXY
			-- Interpreter for system under test

	types_under_test: DS_ARRAYED_LIST [CL_TYPE_A]
			-- Types under test

	classes_under_test: DS_ARRAYED_LIST [CLASS_C]
			-- Classes under test

	manual_unit_tests: DS_HASH_SET [CLASS_C]
			-- Set of selected manual unit tests

	times_duration_logged: INTEGER
			-- Number of times that elapsed time has been recorded to proxy file

	result_repository: AUT_TEST_CASE_RESULT_REPOSITORY
			-- Repository storing test case results

	application_name: STRING is "ec"
			-- Name of EiffelStudio exe;
			-- Needed to locate the correct registry keys on windows
			-- in order to find it's install path.

	project_helper: TEST_PROJECT_HELPER_I
			-- Project helper for compiling `project'

end
