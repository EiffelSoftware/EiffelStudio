note
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
		redefine
			class_names
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

	current_results: ?DS_ARRAYED_LIST [!AUT_TEST_CASE_RESULT]
			-- Results printed to new test class

	source_writer: !TEST_GENERATED_SOURCE_WRITER
			-- Source writer used for creating test classes

	class_names: DS_LIST [!STRING_8]
			-- <Precursor>

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
			Result := current_results /= Void and then not current_results.is_empty
		ensure then
			definition: Result = (current_results /= Void and then not current_Results.is_empty)
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
		local
			l_total: INTEGER
			l_progress: REAL
			l_file: ?KI_TEXT_OUTPUT_STREAM
		do
			is_finished := is_stop_requested
			if current_task /= Void and then current_task.has_next_step then
				update_remaining_time

				if is_executing then
					l_total := time_out.second_count
					l_progress := {REAL} 1.0
					if l_total > 0 then
						l_progress := l_progress - error_handler.remaining_time.second_count/l_total
					end
					internal_progress := {REAL} 0.1 + ({REAL} 0.50)* (l_progress)
				end

				if is_stop_requested or (is_executing and then error_handler.remaining_time.second_count <= 0) then
					current_task.cancel
				else
					current_task.step
					update_remaining_time
				end
			elseif is_compiling then
				prepare
				status := execute_status_code
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
			elseif is_replaying_log then
				if current_task = Void then
					replay_log (log_to_replay)
				else
					current_task := Void
					status := minimize_status_code
				end
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
				if error_handler /= Void then
					l_file := error_handler.error_file
					if l_file /= Void and then l_file.is_closable then
						l_file.close
					end
					error_handler := Void
				end
				current_task := Void
				types_under_test := Void
				classes_under_test := Void
				result_repository := Void
			elseif is_replaying_log then
				internal_progress := {REAL} 0.65
			elseif is_minimizing_witnesses then
				internal_progress := {REAL} 0.75
			elseif is_generating_statistics then
				internal_progress := {REAL} 0.85
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
		local
			l_file_name: FILE_NAME
			l_file: KL_TEXT_OUTPUT_FILE
		do
			check_environment_variable
			set_precompile (False)
			output_dirname := file_system.pathname (system.eiffel_project.project_directory.testing_results_path, "auto_test")
			create time_out.make (0, 0, 0, 0, 15, 0)
			create error_handler.make (system)

			process_configuration

			create l_file_name.make_from_string (output_dirname)
			l_file_name.extend ("log")
			l_file_name.set_file_name ("error")
			l_file_name.add_extension ("log")
			create l_file.make (l_file_name)
			l_file.recursive_open_write

			if l_file.is_open_write then
				error_handler.set_error_file (l_file)
				error_handler.set_warning_file (l_file)
				error_handler.set_info_file (l_file)
			else
				error_handler.set_error_null
				error_handler.set_warning_null
				error_handler.set_info_null
			end

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
					test_suite.propagate_error ("Unable to use workbench executable for interpreter", [], Current)
					is_finished := True
				end
			end
		end

	process_configuration
			-- use `configuration' to initialize AutoTest settings
		do
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

			create {DS_ARRAYED_LIST [!STRING]} class_names.make_from_linear (configuration.types)
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
			compile_project
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

	compile_project
			-- Compile `a_project' with new `a_root_class' and `a_root_feature'.
		local
			l_dir: PROJECT_DIRECTORY
			l_file: KL_TEXT_OUTPUT_FILE
			l_file_name: FILE_NAME
			l_source_writer: TEST_INTERPRETER_SOURCE_WRITER
			l_types: DS_LINEAR [!STRING]
			l_system: SYSTEM_I
		do
			l_system := system
			check l_system /= Void end
				-- Create actual root class in EIFGENs cluster
			l_dir := l_system.project_location
			create l_file_name.make_from_string (l_dir.eifgens_cluster_path)
			l_file_name.set_file_name (interpreter_root_class_name.as_lower)
			l_file_name.add_extension ("e")
			create l_file.make (l_file_name)
			if not l_file.exists then
				l_system.force_rebuild
			end
			l_file.recursive_open_write
			l_types := class_names
			create l_source_writer
			if l_file.is_open_write and l_types /= Void then
				l_source_writer.write_class (l_file, l_types, l_system)
				l_file.flush
				l_file.close
			end

			if not l_system.is_explicit_root (interpreter_root_class_name, interpreter_root_feature_name) then
				l_system.add_explicit_root (Void, interpreter_root_class_name, interpreter_root_feature_name)
			end
			if test_suite.eiffel_project_helper.can_compile then
				test_suite.eiffel_project_helper.compile
			end
			l_system.remove_explicit_root (interpreter_root_class_name, interpreter_root_feature_name)

				-- Print a root class without any references to avoid compiler errors
--			l_file.recursive_open_write
--			if l_file.is_open_write then
--				l_source_writer.write_class (l_file, create {DS_ARRAYED_LIST [!STRING]}.make (0), l_system)
--				l_file.flush
--				l_file.close
--			end
		end

feature{NONE} -- Test case generation and execution

	build_types_and_classes_under_test
			-- Build `types_under_test' and `classes_under_test' from `types'.
		require
			system_attached: system /= Void
		local
			tester: AUT_CLASS_EQUALITY_TESTER
			l_class_set: DS_HASH_SET [CLASS_I]
			l_class_cur: DS_HASH_SET_CURSOR [CLASS_I]
			l_type: TYPE_A
			l_class_name_set: DS_HASH_SET [!STRING]
			l_name_cur: DS_HASH_SET_CURSOR [STRING]
			l_name: STRING
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
			l_class_name_set.set_equality_tester (create {KL_STRING_EQUALITY_TESTER_A [!STRING]})
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
					l_name := l_class_cur.item.name
					check l_name /= Void end
					l_class_name_set.force_last (l_name)
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
					l_type := base_type (l_name_cur.item)
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

	execute_random_tests
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

	update_remaining_time
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

	replay_log (a_log_file: STRING)
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

	requests_from_file (a_log_file_name: STRING; a_log_loader: AUT_LOG_PARSER): DS_ARRAYED_LIST [AUT_REQUEST]
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

	build_result_repository
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

	generate_pre_minimize_statistics
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

	generate_statistics
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
			l_result: AUT_TEST_CASE_RESULT
			l_set: AUT_TEST_CASE_RESULT_SET
			l_all: DS_LIST_CURSOR [AUT_TEST_CASE_RESULT]
		do
			from
				l_class_cursor := result_repository.classes.new_cursor
				l_class_cursor.start
			until
				l_class_cursor.after
			loop
				create current_results.make (10)
				l_set := result_repository.results_by_class (l_class_cursor.item)
				if not (l_set.is_pass or l_set.is_untested) then
					l_all := l_set.list.new_cursor
					from
						l_all.start
					until
						l_all.after
					loop
						l_result := l_all.item
						check l_result /= Void end
						if l_result.is_fail then
							add_result (l_result)
						end
						l_all.forth
					end
					from until
						current_results.is_empty
					loop
						create_new_class
					end
				end
				current_results := Void
				l_class_cursor.forth
			end
		end

	add_result (a_result: !AUT_TEST_CASE_RESULT)
		require
			current_results_attached: current_results /= Void
			a_result_fails: a_result.is_fail
		local
			l_item: AUT_TEST_CASE_RESULT
		do
			if current_results.is_empty then
				current_results.force_last (a_result)
			else
				from
					current_results.start
				until
					current_results.after
				loop
					l_item := current_results.item_for_iteration
					if l_item.witness.is_same_bug (a_result.witness) then
						if l_item.witness.count > a_result.witness.count then
							current_results.replace_at (a_result)
						end
						current_results.go_after
					else
						current_results.forth
						if current_results.after then
							current_results.force_last (a_result)
						end
					end
				end
			end
		end

	print_new_class (a_file: !KL_TEXT_OUTPUT_FILE; a_class_name: !STRING)
			-- <Precursor>
		local
			l_system: like system
			l_count: NATURAL
		do
			l_system := system
			check l_system /= Void end
			source_writer.prepare (a_file, a_class_name, l_system)
			from
				l_count := 1
			until
				current_results.is_empty or l_count > max_tests_per_class
			loop
				source_writer.print_test_routine (current_results.last)
				current_results.remove_last
			end
			source_writer.finish
		ensure then
			results_decreased: current_results.count < old current_results.count
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

	application_name: STRING = "ec"
			-- Name of EiffelStudio exe;
			-- Needed to locate the correct registry keys on windows
			-- in order to find it's install path.

	compile_status_code: NATURAL = 0
	execute_status_code: NATURAL = 1
	replay_status_code: NATURAL = 2
	minimize_status_code: NATURAL = 3
	statistic_status_code: NATURAL = 4

	max_tests_per_class: NATURAL = 9
			-- Maximal number of test routines in a single class

invariant
	not_running_implies_status_compiling: not is_running implies (status = compile_status_code)

note
	copyright: "Copyright (c) 1984-2008, Eiffel Software"
	license:   "GPL version 2 (see http://www.eiffel.com/licensing/gpl.txt)"
	licensing_options: "http://www.eiffel.com/licensing"
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
