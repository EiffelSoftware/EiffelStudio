note
	description: "Test creator representing AutoTest"
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
			start_process_internal,
			is_valid_typed_configuration,
			stop_process
		end

-- Following ancestors copied from {AUTO_TEST}

	EIFFEL_ENV
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

	session: AUT_SESSION
			-- Current AutoTest session
		require
			running: is_running
		local
			l_session: like internal_session
		do
			l_session := internal_session
			check l_session /= Void end
			Result := l_session
		end

	internal_session: detachable AUT_SESSION
			-- Internal storage for `session'

	current_results: detachable DS_ARRAYED_LIST [AUT_TEST_CASE_RESULT]
			-- Results printed to new test class

	source_writer: TEST_GENERATED_SOURCE_WRITER
			-- Source writer used for creating test classes

	class_names: DS_LIST [STRING_8]
			-- <Precursor>

feature {NONE} -- Access: tasks

	test_task: detachable AUT_STRATEGY
			-- Task running tests through an interpreter

	last_witness: detachable AUT_WITNESS
			-- Last witness derived from `test_task'

	minimize_task: detachable AUT_WITNESS_MINIMIZER
			-- Task for minimizing found witnesses

	statistics_task: detachable AUT_TASK

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

feature {TEST_PROCESSOR_SCHEDULER_I} -- Status report

	sleep_time: NATURAL = 0
			-- <Precursor>

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

	start_process_internal (a_conf: like conf_type)
			-- <Precursor>
		do
			Precursor (a_conf)
			create internal_session.make (system, configuration)
		end

	proceed_process
			-- <Precursor>
		local
			l_total, l_remaining: INTEGER
			l_totalc, l_remainingc: NATURAL
			l_progress: REAL
			l_cancel: BOOLEAN
			l_witnesses: DS_LIST [AUT_WITNESS]
			l_witness: AUT_WITNESS
			l_minimize_task: like minimize_task
			l_error_handler: AUT_ERROR_HANDLER
			l_itp: AUT_INTERPRETER_PROXY
			l_repo: AUT_TEST_CASE_RESULT_REPOSITORY
		do
			is_finished := is_stop_requested

			if is_finished then
			else
				if is_compiling then
					prepare
					status := execute_status_code
				else
					if is_executing then
						if attached minimize_task as l_task and then l_task.has_next_step then
							l_task.step
							if not l_task.has_next_step then
								l_witness := l_task.minimized_witness
								session.used_witnesses.force_last (l_witness)
								create current_results.make_from_linear (l_witness.classifications)
								create_new_class
								current_results := Void
							end
						elseif attached test_task as l_task then
							update_remaining_time
							l_error_handler := session.error_handler
							if l_task.has_next_step then
								l_total := session.options.time_out.second_count
								l_progress := {REAL} 1.0
								if l_total > 0 then
									l_remaining := l_error_handler.remaining_time.second_count
									l_progress := l_remaining/l_total
									if l_remaining <= 0 then
										l_cancel := True
									end
								end
								l_totalc := session.options.test_count
								if l_totalc > 0 then
									l_remainingc := l_error_handler.counter
									l_progress := l_progress.min (l_remainingc/l_totalc)
									if l_remainingc = 0 then
										l_cancel := True
									end
								end
								if l_total = 0 and l_totalc = 0 then
									l_progress := {REAL} 0.5
								else
									l_progress := {REAL} 1.0 - l_progress
								end
								internal_progress := {REAL} 0.1 + ({REAL} 0.5)*l_progress
								if l_cancel then
									l_task.cancel
								else
									l_task.step
									l_repo := session.result_repository_builder.result_repository
									l_witnesses := l_repo.witnesses
										-- TODO: it is possible that more than one witness is added per `step', so we need to
										--       check for the last `k' witnesses added (Arno: 05/03/2009)
									if not l_witnesses.is_empty and then l_witnesses.last /= last_witness then
										l_witness := l_witnesses.last
										if l_witness.is_fail then
											if not session.used_witnesses.there_exists (agent {AUT_WITNESS}.is_same_bug (l_witness)) then
												l_minimize_task := minimize_task
												if l_minimize_task = Void then
													l_itp := new_interpreter
													if l_itp /= Void then
														create l_minimize_task.make (l_itp, system, l_error_handler)
														minimize_task := l_minimize_task
													end
												end
												if l_minimize_task /= Void then
													l_minimize_task.set_witness (l_witness)
													l_minimize_task.start
												end
											end
										end
										last_witness := l_witness
									end
								end
							else
								status := statistic_status_code
							end
						else
							execute_random_tests
							is_finished := test_task = Void
						end
					elseif is_generating_statistics then
						if attached statistics_task as l_stask then
							if l_stask.has_next_step then
								l_stask.step
							else
								is_finished := True
							end
						else
							if attached {AUT_RANDOM_STRATEGY} test_task as l_task then
								if session.options.is_text_statistics_format_enabled then
									generate_text_statistics (session.result_repository_builder.result_repository, l_task.classes_under_test)
								end
								if session.options.is_html_statistics_format_enabled then
									generate_html_statistics (session.result_repository_builder.result_repository, l_task.classes_under_test)
								end
							end
						end
						is_finished := True
					else
						check bad: False end
					end
				end
			end

			if is_finished then

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
		local
			l_file: detachable KI_TEXT_OUTPUT_STREAM
		do
			l_file := session.error_handler.error_file
			if l_file /= Void and then l_file.is_closable then
				l_file.close
			end
			if attached test_task as l_task then
				if l_task.has_next_step then
					l_task.cancel
				end
				test_task := Void
			end
			if attached minimize_task as l_task then
				if l_task.has_next_step then
					l_task.cancel
				end
				test_task := Void
			end
			if attached statistics_task as l_task then
				if l_task.has_next_step then
					l_task.cancel
				end
				minimize_task := Void
			end
			last_witness := Void
			internal_session := Void
			status := compile_status_code

			Precursor
		end

feature {NONE} -- Implementation

	prepare
		local
			l_file_name: FILE_NAME
			l_file: KL_TEXT_OUTPUT_FILE
			l_error_handler: AUT_ERROR_HANDLER
		do
			check_environment_variable
			set_precompile (False)

			l_error_handler := session.error_handler

			create l_file_name.make_from_string (session.output_dirname)
			l_file_name.extend ("log")
			l_file_name.set_file_name ("error")
			l_file_name.add_extension ("log")
			create l_file.make (l_file_name)
			l_file.recursive_open_write

			if l_file.is_open_write then
				l_error_handler.set_error_file (l_file)
				l_error_handler.set_warning_file (l_file)
				l_error_handler.set_info_file (l_file)
				if configuration.is_debugging then
					l_error_handler.set_debug_to_file (l_file)
				end
			else
				l_error_handler.set_error_null
				l_error_handler.set_warning_null
				l_error_handler.set_info_null
				l_error_handler.set_debug_null
			end

			if session.options.should_display_help_message then
				l_error_handler.report_info_message (session.options.help_message)
				is_finished := True
			else

				generate_interpreter

				if is_finished then
					test_suite.propagate_error ("Unable to use workbench executable for interpreter", [], Current)
					is_finished := True
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
			--factory: AUT_INTERPRETER_GENERATOR
			interpreter_base_dirname: STRING
			log_dirname: STRING
		do
				-- Setup paths for interpreter generation.
			log_dirname := file_system.pathname (session.output_dirname, "log")

			--create factory.make (a_session)
				-- We generate the skeleton of the interpreter when asked.
				-- Interpreter skeleton only need to be generated once.				
			if not session.options.just_test then
				--factory.generate_interpreter_skeleton (interpreter_base_dirname)
			end

				-- Melt system with interpreter as its new root.			
			compile_project (session.options.class_names)
			if system.eiffel_project.successful then
				system.make_update (False)
				compute_interpreter_root_class
			else
				is_finished := True
			end
		end

	compile_project (a_class_name_list: DS_LIST [STRING_8])
			-- Compile `a_project' with new `a_root_class' and `a_root_feature'.
			--
			-- TODO: `class_names' should be retrieved from `session'
		local
			l_dir: PROJECT_DIRECTORY
			l_file: KL_TEXT_OUTPUT_FILE
			l_file_name: FILE_NAME
			l_source_writer: TEST_INTERPRETER_SOURCE_WRITER
			l_system: SYSTEM_I
		do
			l_system := session.eiffel_system
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
			create l_source_writer
			if l_file.is_open_write then
				l_source_writer.write_class (l_file, a_class_name_list, l_system)
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

	execute_random_tests
			-- Execute random tests.
		require
			system_not_empty: system /= Void
		local
			l_cursor: DS_LINEAR_CURSOR [CL_TYPE_A]
			l_strategy: AUT_RANDOM_STRATEGY
			l_itp: like new_interpreter
			l_session: like session
			l_error_handler: AUT_ERROR_HANDLER
		do
			test_task := Void
			l_itp := new_interpreter
			if l_itp /= Void then

				l_session := session
				l_error_handler := l_session.error_handler
				l_itp.add_observer (l_session.result_repository_builder)
				l_itp.set_is_logging_enabled (True)

				create l_strategy.make (l_itp, system, l_session.error_handler)
				l_strategy.add_class_names (session.options.class_names)

				l_error_handler.report_random_testing

				l_error_handler.set_start_time (system_clock.date_time_now)
				l_error_handler.reset_counters (session.options.test_count)
				update_remaining_time

				l_strategy.start
				test_task := l_strategy
			end
		end

	update_remaining_time
			-- Update `error_handler.remaining_time' and mark in the proxy log every elapsed minute.
		require
			running: is_running
			time_out_set: session.options.time_out /= Void
		local
			duration: DT_DATE_TIME_DURATION
			time_left: DT_DATE_TIME_DURATION
			elapsed_minutes: INTEGER
		do
			duration := session.error_handler.duration_to_now

			elapsed_minutes := (duration.second_count / 60).floor
			if elapsed_minutes /= times_duration_logged then
				--interpreter.log_line (time_passed_mark + duration.second_count.out)
				times_duration_logged := times_duration_logged + 1
			end

			time_left := session.options.time_out - duration
			time_left.set_time_canonical
			if time_left.second_count < 0 then
				create time_left.make (0, 0, 0, 0, 0, 0)
			end
			session.error_handler.set_remaining_time (time_left)
		ensure
			remaining_time_set: session.error_handler.remaining_time /= Void
		end

feature{NONE} -- Test result analyizing

	replay_log (a_log_file: STRING)
			-- Replay log stored in `a_log_file'.
		require
			running: is_running
		local
			l_replay_strategy: AUT_REQUEST_PLAYER
			l_itp: like new_interpreter
		do
			--interpreter.set_is_in_replay_mode (True)
			test_task := Void
			l_itp := new_interpreter
			if l_itp /= Void then
				create l_replay_strategy.make (l_itp, system, session.error_handler)
				l_replay_strategy.set_request_list (requests_from_file (a_log_file, create {AUT_LOG_PARSER}.make (system, session.error_handler)))
				l_replay_strategy.set_is_interpreter_started_by_default (False)
				l_replay_strategy.start
				test_task := l_replay_strategy
			end
		end

	requests_from_file (a_log_file_name: STRING; a_log_loader: AUT_LOG_PARSER): DS_ARRAYED_LIST [AUT_REQUEST]
			-- Result repository from log file `a_log_file_name' loaded by `a_log_loader'
		require
			a_log_file_name_attached: a_log_file_name /= Void
			a_log_loader_attached: a_log_loader /= Void
		local
			log_stream: KL_TEXT_INPUT_FILE
			l_recorder: AUT_PROXY_EVENT_RECORDER
		do
			create log_stream.make (a_log_file_name)
			log_stream.open_read
			if not log_stream.is_open_read then
				session.error_handler.report_cannot_read_error (a_log_file_name)
				create Result.make (0)
			else
				create l_recorder.make (system)
				a_log_loader.add_observer (l_recorder)
				a_log_loader.parse_stream (log_stream)
				a_log_loader.remove_observer (l_recorder)
				l_recorder.cleanup
				Result := l_recorder.request_history
			end
			log_stream.close
		ensure
			result_attached: Result /= Void
		end

	generate_pre_minimize_statistics (a_result_repository: AUT_TEST_CASE_RESULT_REPOSITORY; a_class_name_list: DS_ARRAYED_LIST [CLASS_C])
			-- Generate statistics about executed tests.
		require
			result_repository_not_void: a_result_repository /= Void
		local
			text_generator: AUT_TEXT_STATISTICS_GENERATOR
		do
			if session.options.is_text_statistics_format_enabled then
				create text_generator.make ("pre_minimization_", file_system.pathname (session.output_dirname, "result"), system, a_class_name_list)
				text_generator.generate (a_result_repository)
				if text_generator.has_fatal_error then
					session.error_handler.report_text_generation_error
				else
					session.error_handler.report_text_generation_finished (text_generator.absolute_index_filename)
				end
			end
		end

	generate_text_statistics (a_result_repository: AUT_TEST_CASE_RESULT_REPOSITORY; a_class_name_list: DS_ARRAYED_LIST [CLASS_C])
		require
			result_repository_not_void: a_result_repository /= Void
		local
			l_generator: AUT_TEXT_STATISTICS_GENERATOR
		do
			create l_generator.make ("", file_system.pathname (session.output_dirname, "result"), system, a_class_name_list)
			l_generator.generate (a_result_repository)
			if l_generator.has_fatal_error then
				session.error_handler.report_text_generation_error
			else
				session.error_handler.report_text_generation_finished (l_generator.absolute_index_filename)
			end
		end

	generate_html_statistics (a_result_repo: AUT_TEST_CASE_RESULT_REPOSITORY; a_class_name_list: DS_ARRAYED_LIST [CLASS_C])
			-- Generate statistics about executed tests.
		require
			result_repository_not_void: a_result_repo /= Void
		local
			l_generator: AUT_HTML_STATISTICS_GENERATOR
		do
			create l_generator.make (file_system.pathname (session.output_dirname, "result"), system, a_class_name_list)
			l_generator.set_repository (a_result_repo)
			l_generator.start
			statistics_task := l_generator
		end

	add_result (a_result: attached AUT_TEST_CASE_RESULT)
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

	print_new_class (a_file: attached KL_TEXT_OUTPUT_FILE; a_class_name: attached STRING)
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
		do
			Result := test_suite.eiffel_project.system.system
		end

	times_duration_logged: INTEGER
			-- Number of times that elapsed time has been recorded to proxy file

feature {NONE} -- Factory

	new_interpreter: detachable AUT_INTERPRETER_PROXY
			-- Create a new interpreter proxy, Void if executable did not exist.
		require
			running: is_running
		local
			l_session: like session
			l_itp_gen: AUT_INTERPRETER_GENERATOR
		do
			l_session := session
			l_itp_gen := l_session.interpreter_generator
			l_itp_gen.create_interpreter (file_system.pathname (session.output_dirname, "log"))
			Result := l_itp_gen.last_interpreter
		end

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
	running_implies_session_attached: is_running implies session /= Void

note
	copyright: "Copyright (c) 1984-2009, Eiffel Software"
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
