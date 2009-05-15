note

	description:

		"Error Handler for AutoTest"

	copyright: "Copyright (c) 2005, Andreas Leitner and others"
	license: "Eiffel Forum License v2 (see forum.txt)"
	date: "$Date$"
	revision: "$Revision$"

class AUT_ERROR_HANDLER

inherit
	UT_ERROR_HANDLER
		redefine
			is_verbose,
			report_error_message,
			report_warning_message,
			report_info_message
		end

	AUT_PROXY_EVENT_OBSERVER

	AUT_SHARED_TYPE_FORMATTER

	AUT_SHARED_INTERPRETER_INFO

create
	make


feature{NONE} -- Initialization

	make (a_system: like system)
			-- Initialize.
		require
			a_system_attached: a_system /= Void
		do
			make_standard
			debug_file := null_output_stream
			system := a_system
			set_info_null
			set_warning_null
			create request_printer.make
			create response_printer.make
		ensure
			error_file_set: error_file = std.error
			warning_file_set: warning_file = null_output_stream
			info_file_set: info_file = null_output_stream
		end

feature -- Status report

	is_verbose: BOOLEAN
			-- Is `info_file' set to something other than
			-- the null output stream?
		do
			Result := (info_file /= null_output_stream) and
						(warning_file /= null_output_stream)
		end

	is_debugging: BOOLEAN
			-- Is `debug_file' set to something other than the null output stream?
		do
			Result := debug_file /= null_output_stream
		end

	has_error: BOOLEAN
			-- Has an error occured?

	is_benchmarking: BOOLEAN
			-- Should timing information be logged?

feature -- Access

	Version_message: UT_MESSAGE
			-- 'Version' message
		do
			create Result.make ("auto_test version " + Version_number)
		end

	Version_number: STRING
			-- Current version number of AutoTest
		once
			Result := "1.3.2"
		end

	remaining_time: detachable DT_DATE_TIME_DURATION
			-- Remaining time for testing

	start_time: DT_DATE_TIME
			-- Time when AutoTEst was started

	duration_to_now: DT_DATE_TIME_DURATION
			-- Time elapsed since the start of AutoTest
		require
			start_time_not_void: start_time /= Void
		local
			time_now: DT_DATE_TIME
			shared_system_clock: DT_SHARED_SYSTEM_CLOCK
		do
			create shared_system_clock
			time_now := shared_system_clock.system_clock.date_time_now
			Result := time_now.duration (start_time)
			Result.set_time_canonical
		ensure
			Result_not_void: Result /= Void
		end

	system: SYSTEM_I
			-- System

	start_count: like counter
			-- Initial value for `counter'

	counter: NATURAL
			-- Counter indicating how many subtasks have been executed so far

	debug_file: KI_TEXT_OUTPUT_STREAM
			-- File where debug information is logged
			--
			-- Note: default value is `null_output_stream'

feature {NONE} -- Access

	request_printer: AUT_SIMPLE_REQUEST_PRINTER
			-- Printer used for formatting requests in log messages

	response_printer: AUT_SIMPLE_RESPONSE_PRINTER
			-- Printer used for formatting responses in log messages

	last_testing_request: detachable AUT_REQUEST
			-- Last request processed by `report_request'

feature -- Status setting

	enable_verbose
			-- Set `is_verbose' to True.
		do
			warning_file := std.output
			info_file := std.output
		ensure
			verbose: is_verbose
		end

	disable_verbose
			-- Set `is_verbose' to False.
		do
			warning_file := null_output_stream
			info_file := null_output_stream
		ensure
			not_verbose: not is_verbose
		end

	reset_counters (a_start_count: like start_count)
			-- Set `start_count' and `counter' to `a_start_count'.
		do
			start_count := a_start_count
			counter := a_start_count
		end

	set_start_time (a_start_time: like start_time)
			-- Set `start_time' to `a_start_time'.
		require
			a_start_time_not_void: a_start_time /= Void
			a_start_time_not_negative: a_start_time.second_count >= 0
		do
			start_time := a_start_time
		ensure
			start_time_set: start_time = a_start_time
		end

	set_remaining_time (a_remaining_time: like remaining_time)
			-- Set `remaining_time' to `a_remaining_time'.
		require
			a_remaining_time_not_void: a_remaining_time /= Void
			a_remaining_time_not_negative: a_remaining_time.second_count >= 0
		do
			remaining_time := a_remaining_time
		ensure
			remaininig_time_set: remaining_time = a_remaining_time
		end

	enable_benchmarking
			-- Should benchmarking be enabled?
		do
			is_benchmarking := True
		ensure
			benchmarking_enabled: is_benchmarking
		end

	set_debug_null
			-- Set `debug_file' to null stream.
		do
			debug_file := null_output_stream
		ensure
			debug_file_set: debug_file = Void
		end

	set_debug_standard
			-- Set `debug_file' to standard output
		do
			debug_file := std.error
		ensure
			debug_file_set: debug_file = std.error
		end

	set_debug_to_file (a_file: like debug_file)
			-- Set `debug_file' to given output stream.
			--
			-- `a_file': File to be used for debugging output.
		do
			debug_file := a_file
		ensure
			debug_file_set: debug_file = a_file
		end

feature -- Basic operations

	report_error_message (an_error: STRING)
			-- Report `an_error'.
		do
			Precursor (an_error)
			error_file.flush
			has_error := True
		ensure then
			has_error: has_error
		end

	report_warning_message (a_warning: STRING_8)
			-- <Precursor>
		do
			Precursor (a_warning)
			warning_file.flush
		end

	report_info_message (an_info: STRING_8)
			-- <Precursor>
		do
			Precursor (an_info)
			info_file.flush
		end

	report_debug_message (a_debug_info: STRING_8)
			-- Report a debug information
		local
			l_any: ANY
		do
			l_any := Current
			debug_file.put_string ("debug: ")
			debug_file.put_line (a_debug_info)
			debug_file.flush
		end

feature -- Report events

	report_request (a_producer: AUT_PROXY_EVENT_PRODUCER; a_request: AUT_REQUEST)
			-- <Precursor>
		local
			l_msg: STRING
		do
			last_testing_request := Void
			if a_producer.is_executing and then not a_producer.is_replaying then
				last_testing_request := a_request
			end
			if is_debugging then
				create l_msg.make (100)
				a_request.process (request_printer)
				l_msg.append_string (request_printer.last_string)
				if a_producer.is_executing then
					if a_producer.is_replaying then
						l_msg.append_string (" [replaying]")
					else
						l_msg.append_string (" [testing]")
					end
				else
					l_msg.append_string (" [parsed]")
				end
				report_debug_message (l_msg)
			end
		end

	report_response (a_producer: AUT_PROXY_EVENT_PRODUCER; a_response: AUT_RESPONSE)
			-- <Precursor>
		local
			l_msg: STRING
		do
			-- TODO: possible info/debug output describing the received response?
			if attached {AUT_CALL_BASED_REQUEST} last_testing_request as l_caller then
				create l_msg.make (100)
				if attached remaining_time as l_time then
					l_time.time_duration.append_to_string (l_msg)
					l_msg.append_string (": ")
				end
				if start_count > 0 then
					l_msg.append_natural_32 (counter)
					l_msg.append_string (": ")
				end
				if attached {AUT_CREATE_OBJECT_REQUEST} l_caller then
					l_msg.append_string ("create ")
				end
				l_msg.append_string (type_name (l_caller.target_type, l_caller.feature_to_call))
				l_msg.append_character ('.')
				l_msg.append_string (l_caller.feature_to_call.feature_name)
				l_msg.append_character (' ')
				a_response.process (response_printer)
				l_msg.append_string (response_printer.last_string)
				report_info_message (l_msg)

					-- Decrement test counter
				if counter > 0 then
					counter := counter - 1
				end
			end
			last_testing_request := Void
		end

feature -- Reporting messages

	report_version_message
			-- Report reversion message.
		do
			report_info (Version_message)
		end

	report_benchmark_message (an_info: STRING)
			-- Report benchmarking message `an_info'. (Only logged if benchmarking is enabled and info messages are not surpressed.)
		require
			an_info_not_void: an_info /= Void
		do
			if is_benchmarking then
				info_file.put_line (an_info)
				info_file.flush
			end
		end

	report_ise_eiffel_output (a_message: STRING)
			-- Report the message `a_string' from the ISE Eiffel compiler.
		require
			a_message_not_void: a_message /= Void
		do
			info_file.put_string (a_message)
		end

	report_statistics_format_error (a_format: STRING)
			-- Report that `a_format' is not a valid statistics output format.
		require
			a_format_not_void: a_format /= Void
		do
			report_error_message ("'" + a_format + "' is not a valid statistics output format. Please specify either 'text' or 'html'.")
		end

	report_cannot_specify_both_disable_minimze_and_minimize
			-- Report that not both can be given on the command line "--disable-minimze" and "--minimize".
		do
			report_error_message ("Both '--disable-minimize' and '--minimize' have been specified as command line arguments. These arguments contradict themselves, please specify at most one of them.")
		end

	report_invalid_minimization_algorithm (an_algorithm: STRING)
			-- Report that `an_algorithm' is an invalid minimization algorithm.
		require
			an_algorithm_not_void: an_algorithm /= Void
		do
			report_error_message ("Invalid minimization algorithm '" + an_algorithm + "'. Valid algorithms are 'slice' and 'ddmin'.")
		end

	report_text_generation_finished (a_file: STRING)
			-- Report that generation of text statistics fininshed and that the results can be viewed by looking at file
			-- `a_file'.
		require
			a_file_not_void: a_file /= Void
		local
			text: STRING
		do
			create text.make (256)
			text.append_string ("Wrote text statistics file '")
			text.append_string (a_file)
			text.append_string ("'.")
			report_info_message (text)
		end

	report_html_generation_finished (a_file: STRING)
			-- Report that generation of html statistics finished and that the results can be viewed by looking at file
			-- `a_file'.
		require
			a_file_not_void: a_file /= Void
		local
			text: STRING
		do
			create text.make (256)
			text.append_string ("Wrote HTML statistic files. To view the results direct your HTML viewer to file '")
			text.append_string (a_file)
			text.append_string ("'.")
			report_info_message (text)
		end

	report_feature_selection (a_type: TYPE_A; a_feature: FEATURE_I)
			-- Report that feature `a_feature' of type `a_type' has been selected for testing.
		require
			a_feature_not_void: a_feature /= Void
			a_type_not_void: a_type /= Void
		local
			text: STRING
		do
			if is_debugging then
				create text.make (100)
				text.append_string ("selected ")
				text.append_string (type_name (a_type, a_feature))
				text.append_string (".")
				text.append_string (a_feature.feature_name)
				report_debug_message (text)
			end
		end

	report_no_time_for_testing (a_time_out: DT_TIME_DURATION)
			-- Report that compilation took so long, that no time was left for testing.
		require
			a_time_out_positive: a_time_out.second_count > 0
		local
			text: STRING
		do
			create text.make (100)
			text.append_string ("No tests could be run because compiling the system under test took longer than the specified time-out (")
			text.append_integer (a_time_out.minute)
			text.append_string (" min). Maybe you should increase the time-out ('--time-out=<min>'). Note that you can reuse a previous compilation by using the command line argument '--just-test'.")
			report_info_message (text)
		end

	report_minimization_task
			-- Report that auto_test is now minimizing a witness.
		do
			if attached remaining_time then
				report_info_message ("Minimizing a bug reproducing example (this will affect the remaining time AutoTest can execute tests, to disable use '--disable-minimize').")
			else
				report_info_message ("Minimizing a bug reproducing example (to disable use '--disable-minimize').")
			end
		end

	report_manual_testing
			-- Report that auto_test is now using the manual unit test strategy.
		do
			report_info_message ("Executing manual unit tests")
		end

	report_random_testing
			-- Report that auto_test is now using the ranomd testing strategy.
		do
			report_info_message ("Executing automatically generated tests")
		end

	report_test_synthesis (a_class: CLASS_I)
			-- Report that AutoTest has created a bug reproducing test case.
		require
			a_class_attached: a_class /= Void
		local
			l_string: STRING
		do
			create l_string.make (100)
			l_string.append_string ("Created new test class ")
			l_string.append_string (a_class.name)
			report_info_message (l_string)
		end

feature -- Reporting errors

	report_missing_command_line_parameter_error (a_parameter_name: STRING)
			-- Report that `a_parameter_name' has not been provided as a
			-- command line parameter.
		require
			a_parameter_name_not_void: a_parameter_name /= Void
			a_parameter_name_not_empty: not a_parameter_name.is_empty
		local
			an_error: AUT_MISSING_COMMAND_LINE_PARAMETER_ERROR
		do
			create an_error.make (a_parameter_name)
			report_error (an_error)
		end

	report_missing_command_line_parameter_value_error (a_parameter_name: STRING)
			-- Report that the command line parameter `a_parameter_name'
			-- has not been provided with a value.
		require
			a_parameter_name_not_void: a_parameter_name /= Void
			a_parameter_name_not_empty: not a_parameter_name.is_empty
		local
			an_error: AUT_MISSING_COMMAND_LINE_PARAMETER_VALUE_ERROR
		do
			create an_error.make (a_parameter_name)
			report_error (an_error)
		end

	report_missing_ecf_filename_error
			-- Report that no ecf filename has been provided.
		do
			report_error_message ("No ecf-filename has been provided. Please provide one for the system that you want to make reflectable.")
		end

	report_invalid_or_unknown_type_error (a_type_name: STRING)
			-- Report that type named `a_type_name' is either invalid or unknown.
		require
			a_type_name_not_void: a_type_name /= Void
		local
			a_text: STRING
		do
			a_text := "Type " + a_type_name + " is either invalid or unknown."
			report_error_message (a_text)
		end

	report_cannot_read_error (a_filename: STRING)
			-- Report that `a_filename' cannot be
			-- opened in read mode.
		require
			a_filename_not_void: a_filename /= Void
		local
			an_error: UT_CANNOT_READ_FILE_ERROR
		do
			create an_error.make (a_filename)
			report_error (an_error)
		end

	report_cannot_write_error (a_filename: STRING)
			-- Report that `a_filename' cannot be
			-- opened in write mode.
		require
			a_filename_not_void: a_filename /= Void
		local
			an_error: UT_CANNOT_WRITE_TO_FILE_ERROR
		do
			create an_error.make (a_filename)
			report_error (an_error)
		end

	report_fatal_generation_error
			-- Report that a fatal error during file generation happened.
		do
			report_error_message ("A fatal error happened during file generation")
		end

	report_invalid_time_out_value (a_value: STRING)
			-- Report that `a_value' is not a correct time-out value.
		require
			a_value_not_void: a_value /= Void
		local
			an_error: AUT_INVALID_TIME_OUT_VALUE_ERROR
		do
			create an_error.make (a_value)
			report_error (an_error)
		end

	report_unknown_class_error (a_class_name: STRING)
			-- Report that class named `a_class_name' cannot be tested because it is unknown.
		require
			a_class_name_not_void: a_class_name /= Void
		local
			a_text: STRING
		do
			a_text := "Class " + a_class_name + " cannot be tested because it is unknown."
			report_error_message (a_text)
		end

	report_erroneous_class_error (a_class_name: STRING)
			-- Report that class named `a_class_name' cannot be tested because it contains errors.
		require
			a_class_name_not_void: a_class_name /= Void
		local
			a_text: STRING
		do
			a_text := "Class " + a_class_name + " cannot be tested because it contains errors."
			report_error_message (a_text)
		end

	report_expanded_types_not_yet_supported (a_class_type: CL_TYPE_A)
			-- Report that the expanded classes are not yet supported, but `a_class_type' is requested to be tested.
		require
			a_class_type_not_void: a_class_type /= Void
			a_class_type_is_expanded: a_class_type.is_expanded
		do
			report_error_message ("Expanded types cannot be tested yet, but " + type_name (a_class_type, Void) + " has been requested to be tested.")
		end

	report_interpreter_generation_error
			-- Report that the interpreter could not be generated.
		do
			report_error_message ("Could not generate interpreter.")
		end

	report_html_generation_error
			-- Report that an error occured while generation the html pages
		do
			report_error_message ("Could not generate html pages.")
		end

	report_text_generation_error
			-- Report that an error occured while generation the text file
		do
			report_error_message ("Could not generate text file.")
		end

	report_log_parsing_error (a_filename: STRING; a_line_number: INTEGER; a_reason: STRING)
			-- Report that the error `a_reason' occured while parsing a interpreter log file.
		require
			a_line_number_positive: a_line_number > 0
			a_filename_not_void: a_filename /= Void
			a_reason_not_void: a_reason /= Void
			a_reason_not_empty: not a_reason.is_empty
		do
			report_error_message ("error parsing log file '" + a_filename + "' (line: " + a_line_number.out + "): " + a_reason)
		end

	report_class_creations_error (a_filename: STRING)
			-- Report that file `a_filename' cannot be created for writing.
		require
			a_filename_attached: a_filename /= Void
		do
			report_error_message ("Could not create file '" + a_filename + "' for writing.")
		end

invariant
	remaining_time_not_negative: remaining_time /= Void implies remaining_time.second_count >= 0
	system_attached: system /= Void

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
