note
	description: "Test creator representing AutoTest"
	date: "$Date$"
	revision: "$Revision$"

class
	TEST_GENERATOR

inherit
	ETEST_CREATION
		redefine
			make
		end

	ROTA_SERIAL_TASK_I
		redefine
			step,
			remove_task
		end

	EIFFEL_LAYOUT
		export
			{NONE} all
		end

	DISPOSABLE_SAFE

	ERL_G_TYPE_ROUTINES
		export
			{NONE} all
		end

	KL_SHARED_FILE_SYSTEM
		export
			{NONE} all
		end

	AUT_SHARED_RANDOM
		export
			{NONE} all
		end

create
	make

feature {NONE} -- Initialization

	make (a_test_suite: like test_suite; a_etest_suite: like etest_suite; a_is_gui: BOOLEAN)
			-- <Precursor>
		local
			u: FILE_UTILITIES
		do
			Precursor (a_test_suite, a_etest_suite, a_is_gui)
			create output_stream.make_empty


			create source_writer

				-- Initialize options
			create class_names.make_default
			class_names.set_equality_tester (create {KL_STRING_EQUALITY_TESTER_A [STRING]})
			proxy_time_out := 2
			set_time_out (3)
			output_dirname := u.make_file_name_in
				({STRING_32} "auto_test",
				etest_suite.project_access.project.project_directory.testing_results_path.name).as_string_32
			set_seed ((create {TIME}.make_now).milli_second.as_natural_32)
			create error_handler.make (system)
		end

feature -- Access

	progress: REAL_32
			-- <Precursor>
		do
			if attached {ETEST_MELT_TASK} sub_task then
				Result := {REAL_32} 0.1
			elseif attached {ETEST_GENERATION_TESTING} sub_task as l_task then
				Result := {REAL_32} 0.1 + l_task.progress * {REAL_32} 0.85
			else
				Result := {REAL_32} 0.95
			end
		end

feature -- Access: options

	output_dirname: STRING_32
			-- Name of output directory

	class_names: DS_HASH_SET [STRING]
			-- List of class names to be tested

	time_out: DT_DATE_TIME_DURATION
			-- Maximal time to test;
			-- A timeout value of `0' means no time out.

	test_count: NATURAL
			-- Maximum number of tests to be executed
			--
			-- Note: a value of `0' means no upper limit

	is_minimization_enabled: BOOLEAN
			-- Should bug reproducing examples be minimized?
		do
			Result := is_slicing_enabled or is_ddmin_enabled
		end

	is_text_statistics_format_enabled: BOOLEAN
			-- Should statistics be output as plain text?

	is_html_statistics_format_enabled: BOOLEAN
			-- Should statistics be output static HTML?

	is_slicing_enabled: BOOLEAN
			-- Should test cases be minimized via slicing?

	is_ddmin_enabled: BOOLEAN
			-- Should test cases be minimized via ddmin?

	proxy_time_out: NATURAL
			-- Proxy time out in second

	is_debugging: BOOLEAN
			-- True if debugging output should be written to log.

feature -- Access: session

	system: SYSTEM_I
			-- Eiffel system containing compiled project information
		do
			Result := etest_suite.project_access.project.system.system
		end

	error_handler: AUT_ERROR_HANDLER
			-- AutoTest error handler

feature {NONE} -- Access

	current_results: detachable DS_ARRAYED_LIST [AUT_TEST_CASE_RESULT]
			-- Results printed to new test class

	source_writer: TEST_GENERATED_SOURCE_WRITER
			-- Source writer used for creating test classes

	output_stream: KL_STRING_OUTPUT_STREAM
			-- String stream for storing output

	output_file: detachable KL_TEXT_OUTPUT_FILE
			-- Output file to which output should be written to

feature {NONE} -- Access: tasks

	sub_task: detachable ROTA_TASK_I
			-- <Precursor>

feature -- Status report

	sleep_time: NATURAL
			-- <Precursor>
		do
			if attached {ETEST_MELT_TASK} sub_task as l_task then
				Result := l_task.sleep_time
			else
				Result := 0
			end
		end

feature {NONE} -- Status report

	is_creating_new_class: BOOLEAN
			-- <Precursor>
		do
			Result := current_results /= Void and then not current_results.is_empty
		ensure then
			definition: Result = (current_results /= Void and then not current_Results.is_empty)
		end

	creates_multiple_classes: BOOLEAN = True
			-- <Precursor>

feature -- Status setting

	set_output_dirname (a_dirname: like output_dirname)
			-- Set `output_dirname' to given name.
			--
			-- `a_dirname': New directory name for `output_dirname'.
		require
			a_dirname_attached: a_dirname /= Void
			not_running: not has_next_step
		do
			create output_dirname.make_from_string (a_dirname)
		ensure
			output_dirname_set: output_dirname.same_string (a_dirname)
		end

	add_class_name (a_class_name: READABLE_STRING_32)
			-- Add given name to `class_names'.
			--
			-- `a_class_name': New class name to test.
		require
			a_class_name_attached: a_class_name /= Void
			not_running: not has_next_step
		do
			class_names.force_last (a_class_name.as_string_8)
		ensure
			added: across class_names as ic some a_class_name.same_string_general (ic.item) end
		end

	set_time_out (a_time_out: NATURAL)
			-- Set minutes for `time_out'.
			--
			-- `a_time_out': Timout in minutes for `time_out'.
		require
			not_running: not has_next_step
			a_valid_time_out: a_time_out <= {INTEGER_32}.max_value.as_natural_32
		do
			create time_out.make (0, 0, 0, 0, a_time_out.as_integer_32, 0)
		ensure
			time_out_set: time_out.minute.as_natural_32 = a_time_out
		end

	set_test_count (a_test_count: like test_count)
			-- Set `test_count' to given value.
			--
			-- `a_test_count': Number of test routines to be called.
		require
			not_running: not has_next_step
		do
			test_count := a_test_count
		ensure
			test_count_set: test_count = a_test_count
		end

	enable_slicing
			-- Enable slicing.
		require
			not_running: not has_next_step
		do
			is_slicing_enabled := True
		end

	enable_ddmin
			-- Enable ddmin.
		require
			no_minimization: not is_minimization_enabled
			not_running: not has_next_step
		do
			is_ddmin_enabled := True
		end

	set_text_statistics (a_text_statistics: like is_text_statistics_format_enabled)
			-- Enable/disable text statistics.
		require
			not_running: not has_next_step
		do
			is_text_statistics_format_enabled := a_text_statistics
		ensure
			set: is_text_statistics_format_enabled = a_text_statistics
		end

	set_html_statistics (a_html_statistics: like is_html_statistics_format_enabled)
			-- Enable/disable html statistics.
		require
			not_running: not has_next_step
		do
			is_html_statistics_format_enabled := a_html_statistics
		ensure
			set: is_html_statistics_format_enabled = a_html_statistics
		end

	set_proxy_timeout (a_timeout: like proxy_time_out)
			-- Set `proxy_time_out' to given value.
		require
			not_running: not has_next_step
			a_timeout_positive: a_timeout > 0
		do
			proxy_time_out := a_timeout
		ensure
			set: proxy_time_out = a_timeout
		end

	set_debugging (a_is_debugging: like is_debugging)
			-- Set `is_debugging' to given value.
		require
			not_running: not has_next_step
		do
			is_debugging := a_is_debugging
		ensure
			set: is_debugging = a_is_debugging
		end

	set_seed (a_seed: NATURAL)
			-- Set random testing seed to `a_seed'.
		require
			not_running: not has_next_step
		do
			if a_seed > 0 then
				random.set_seed (a_seed.as_integer_32)
			else
				random.set_seed ((create {TIME}.make_now).seconds)
			end
		end

feature -- Basic operations

	step
			-- <Precursor>
		do
			Precursor
			flush_output
			proceeded_event.publish ([Current])
		end


feature {NONE} -- Basic operations

	start_creation
			-- <Precursor>
		do
			random.start
			prepare
			initiate_testing_task
		end

	remove_task (a_task: attached like sub_task; a_cancel: BOOLEAN)
			-- <Precursor>
		local
			l_stat_task: ETEST_GENERATION_STATISTICS
		do
			if not a_cancel and attached {ETEST_GENERATION_TESTING} sub_task as l_task then
				create l_stat_task.make (Current)
				l_stat_task.start (l_task.result_repository, l_task.classes_under_test)
				sub_task := l_stat_task
			end
			if not has_next_step then
				clean
			end
		end

	clean
			-- Clean up any resources used during testing.
		do
			sub_task := Void
			flush_output
			if attached output_file as l_file then
				if l_file.is_closable then
					l_file.close
				end
				output_file := Void
			end
			clean_record
		end

feature {NONE} -- Implementation: preparation

	prepare
			-- Prepare test generation
		local
			l_file_name: PATH
			l_file: KL_TEXT_OUTPUT_FILE_32
			l_error_handler: AUT_ERROR_HANDLER
		do
			eiffel_layout.check_environment_variable
			eiffel_layout.set_precompile (False, Void)

			l_error_handler := error_handler

			create l_file_name.make_from_string (output_dirname)
			l_file_name := l_file_name.extended ("log").extended ("error").appended_with_extension("log")
			create l_file.make_with_path (l_file_name)
			l_file.recursive_open_write
			if l_file.is_open_write then
				output_file := l_file
			end

			l_error_handler.set_error_file (output_stream)
			l_error_handler.set_warning_file (output_stream)
			l_error_handler.set_info_file (output_stream)
			if is_debugging then
				l_error_handler.set_debug_to_file (output_stream)
			end
		end

	initiate_testing_task
			-- Launch a {ETEST_GENERATION_TESTING} task in `sub_task'
		local
			l_test_task: ETEST_GENERATION_TESTING
		do
			compute_interpreter_root_class
			if attached interpreter_root_class then
				create l_test_task.make_random (Current, class_names)
				l_test_task.start
				sub_task := l_test_task
			end
		end

feature{NONE} -- Test result analyizing

	print_new_class (a_file: KL_TEXT_OUTPUT_FILE_32; a_class_name: READABLE_STRING_32)
			-- <Precursor>
		local
			l_system: like system
			l_count: NATURAL
			l_test_name: IMMUTABLE_STRING_32
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
				create l_test_name.make_from_string (a_class_name + {STRING_32} "." + source_writer.last_test_routine_name)
				publish_test_creation (l_test_name)
			end
			source_writer.finish
		ensure then
			results_decreased: current_results.count < old current_results.count
		end

feature -- Basic operations

	print_test_set (a_list: DS_ARRAYED_LIST [AUT_TEST_CASE_RESULT])
			-- Print test case results as test.
			--
			-- `a_list': List of test case results to be printed to a test set.
		require
			a_list_attached: a_list /= Void
		local
			l_project_helper: TEST_PROJECT_HELPER_I
			l_last_class: EIFFEL_CLASS_I
		do
			current_results := a_list
			l_project_helper := etest_suite.project_helper
			if l_project_helper.is_class_added then
				l_last_class := l_project_helper.last_added_class
			end
			create_new_class
			if
				l_project_helper.is_class_added and then
				attached l_project_helper.last_added_class as l_new_class and then
				l_last_class /= l_new_class
			then
				error_handler.report_test_generation (l_new_class)
			end
			current_results := Void
		end

	flush_output
			-- Redirect output currently stored in `output_stream' to `output_file' and `output_formatter'
			-- (if attached) and wipe out string in `output_stream'.
		local
			l_string: STRING
		do
			l_string := output_stream.string
			if not l_string.is_empty then
				if attached output_file as l_file then
					l_file.put_string (l_string)
					l_file.flush
				end
				append_output (agent {TEXT_FORMATTER}.add_string (l_string), False)
				l_string.wipe_out
			end
		end

feature {NONE} -- Implementation

	safe_dispose (a_explicit: BOOLEAN)
			-- <Precursor>
		do
			if a_explicit and has_next_step then
				cancel
			end
		end

feature {NONE} -- Constants

	max_tests_per_class: NATURAL = 9
			-- Maximal number of test routines in a single class

note
	copyright: "Copyright (c) 1984-2023, Eiffel Software"
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
