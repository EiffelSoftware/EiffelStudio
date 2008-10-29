indexing

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
			report_error_message
		end

	AUT_SHARED_TYPE_FORMATTER

	AUT_SHARED_INTERPRETER_INFO

create
	make


feature{NONE} -- Initialization

	make (a_system: like system) is
			-- Initialize.
		require
			a_system_attached: a_system /= Void
		do
			system := a_system
			make_standard
			set_info_null
			set_warning_null
		ensure
			error_file_set: error_file = std.error
			warning_file_set: warning_file = null_output_stream
			info_file_set: info_file = null_output_stream
		end

feature -- Status report

	is_verbose: BOOLEAN is
			-- Is `info_file' set to something other than
			-- the null output stream?
		do
			Result := (info_file /= null_output_stream) and
						(warning_file /= null_output_stream)
		end

	has_error: BOOLEAN
			-- Has an error occured?

	is_benchmarking: BOOLEAN
			-- Should timing information be logged?

feature -- Access

	Version_message: UT_MESSAGE is
			-- 'Version' message
		do
			create Result.make ("auto_test version " + Version_number)
		end

	Version_number: STRING is
			-- Current version number of AutoTest
		once
			Result := "1.3.2"
		end

	remaining_time: DT_DATE_TIME_DURATION
			-- Remaining time for testing

	start_time: DT_DATE_TIME
			-- Time when AutoTEst was started

	duration_to_now: DT_DATE_TIME_DURATION is
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

feature -- Status setting

	enable_verbose is
			-- Set `is_verbose' to True.
		do
			warning_file := std.output
			info_file := std.output
		ensure
			verbose: is_verbose
		end

	disable_verbose is
			-- Set `is_verbose' to False.
		do
			warning_file := null_output_stream
			info_file := null_output_stream
		ensure
			not_verbose: not is_verbose
		end

	set_start_time (a_start_time: like start_time) is
			-- Set `start_time' to `a_start_time'.
		require
			a_start_time_not_void: a_start_time /= Void
			a_start_time_not_negative: a_start_time.second_count >= 0
		do
			start_time := a_start_time
		ensure
			start_time_set: start_time = a_start_time
		end

	set_remaining_time (a_remaining_time: like remaining_time) is
			-- Set `remaining_time' to `a_remaining_time'.
		require
			a_remaining_time_not_void: a_remaining_time /= Void
			a_remaining_time_not_negative: a_remaining_time.second_count >= 0
		do
			remaining_time := a_remaining_time
		ensure
			remaininig_time_set: remaining_time = a_remaining_time
		end

	enable_benchmarking is
			-- Should benchmarking be enabled?
		do
			is_benchmarking := True
		ensure
			benchmarking_enabled: is_benchmarking
		end

feature -- Reporting messages

	report_version_message is
			-- Report reversion message.
		do
			report_info (Version_message)
		end

	report_benchmark_message (an_info: STRING) is
			-- Report benchmarking message `an_info'. (Only logged if benchmarking is enabled and info messages are not surpressed.)
		require
			an_info_not_void: an_info /= Void
		do
			if is_benchmarking then
				info_file.put_line (an_info)
				info_file.flush
			end
		end

	report_ise_eiffel_output (a_message: STRING) is
			-- Report the message `a_string' from the ISE Eiffel compiler.
		require
			a_message_not_void: a_message /= Void
		do
			info_file.put_string (a_message)
		end

	report_statistics_format_error (a_format: STRING) is
			-- Report that `a_format' is not a valid statistics output format.
		require
			a_format_not_void: a_format /= Void
		do
			report_error_message ("'" + a_format + "' is not a valid statistics output format. Please specify either 'text' or 'html'.")
		end

	report_cannot_specify_both_disable_minimze_and_minimize is
			-- Report that not both can be given on the command line "--disable-minimze" and "--minimize".
		do
			report_error_message ("Both '--disable-minimize' and '--minimize' have been specified as command line arguments. These arguments contradict themselves, please specify at most one of them.")
		end

	report_invalid_minimization_algorithm (an_algorithm: STRING) is
			-- Report that `an_algorithm' is an invalid minimization algorithm.
		require
			an_algorithm_not_void: an_algorithm /= Void
		do
			report_error_message ("Invalid minimization algorithm '" + an_algorithm + "'. Valid algorithms are 'slice' and 'ddmin'.")
		end

	report_text_generation_finished (a_file: STRING) is
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

	report_html_generation_finished (a_file: STRING) is
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

	report_feature_selection (a_type: TYPE_A; a_feature: FEATURE_I) is
			-- Report that feature `a_feature' of type `a_type' has been selected for testing.
		require
			a_feature_not_void: a_feature /= Void
			a_type_not_void: a_type /= Void
		local
			text: STRING
		do
			create text.make (100)
			if remaining_time /= Void then
				remaining_time.time_duration.append_to_string (text)
				text.append_string (": ")
			end
			text.append_string (type_name (a_type, a_feature))
			text.append_string (".")
			text.append_string (a_feature.feature_name)
			report_info_message (text)
		end

	report_no_time_for_testing (a_time_out: DT_TIME_DURATION) is
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

	report_minimization_task is
			-- Report that auto_test is now minimizing a witness.
		do
			report_info_message ("Minimizing a bug reproducing example (this can take overtime, to disable use '--disable-minimize').")
		end

	report_manual_testing is
			-- Report that auto_test is now using the manual unit test strategy.
		do
			report_info_message ("Executing manual unit tests")
		end

	report_random_testing is
			-- Report that auto_test is now using the ranomd testing strategy.
		do
			report_info_message ("Executing automatically generated tests")
		end

feature -- Reporting errors

	report_missing_command_line_parameter_error (a_parameter_name: STRING) is
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

	report_missing_command_line_parameter_value_error (a_parameter_name: STRING) is
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

	report_missing_ecf_filename_error is
			-- Report that no ecf filename has been provided.
		do
			report_error_message ("No ecf-filename has been provided. Please provide one for the system that you want to make reflectable.")
		end

	report_invalid_or_unknown_type_error (a_type_name: STRING) is
			-- Report that type named `a_type_name' is either invalid or unknown.
		require
			a_type_name_not_void: a_type_name /= Void
		local
			a_text: STRING
		do
			a_text := "Type " + a_type_name + " is either invalid or unknown."
			report_error_message (a_text)
		end

	report_cannot_read_error (a_filename: STRING) is
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

	report_cannot_write_error (a_filename: STRING) is
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

	report_fatal_generation_error is
			-- Report that a fatal error during file generation happened.
		do
			report_error_message ("A fatal error happened during file generation")
		end

	report_error_message (an_error: STRING) is
			-- Report `an_error'.
		do
			precursor (an_error)
			has_error := True
		ensure then
			has_error: has_error
		end

	report_invalid_time_out_value (a_value: STRING) is
			-- Report that `a_value' is not a correct time-out value.
		require
			a_value_not_void: a_value /= Void
		local
			an_error: AUT_INVALID_TIME_OUT_VALUE_ERROR
		do
			create an_error.make (a_value)
			report_error (an_error)
		end

	report_unknown_class_error (a_class_name: STRING) is
			-- Report that class named `a_class_name' cannot be tested because it is unknown.
		require
			a_class_name_not_void: a_class_name /= Void
		local
			a_text: STRING
		do
			a_text := "Class " + a_class_name + " cannot be tested because it is unknown."
			report_error_message (a_text)
		end

	report_erroneous_class_error (a_class_name: STRING) is
			-- Report that class named `a_class_name' cannot be tested because it contains errors.
		require
			a_class_name_not_void: a_class_name /= Void
		local
			a_text: STRING
		do
			a_text := "Class " + a_class_name + " cannot be tested because it contains errors."
			report_error_message (a_text)
		end

	report_expanded_types_not_yet_supported (a_class_type: CL_TYPE_A) is
			-- Report that the expanded classes are not yet supported, but `a_class_type' is requested to be tested.
		require
			a_class_type_not_void: a_class_type /= Void
			a_class_type_is_expanded: a_class_type.is_expanded
		do
			report_error_message ("Expanded types cannot be tested yet, but " + type_name (a_class_type, Void) + " has been requested to be tested.")
		end

	report_interpreter_generation_error is
			-- Report that the interpreter could not be generated.
		do
			report_error_message ("Could not generate interpreter.")
		end

	report_html_generation_error is
			-- Report that an error occured while generation the html pages
		do
			report_error_message ("Could not generate html pages.")
		end

	report_text_generation_error is
			-- Report that an error occured while generation the text file
		do
			report_error_message ("Could not generate text file.")
		end

	report_log_parsing_error (a_filename: STRING; a_line_number: INTEGER; a_reason: STRING) is
			-- Report that the error `a_reason' occured while parsing a interpreter log file.
		require
			a_line_number_positive: a_line_number > 0
			a_filename_not_void: a_filename /= Void
			a_reason_not_void: a_reason /= Void
			a_reason_not_empty: not a_reason.is_empty
		do
			report_error_message ("error parsing log file '" + a_filename + "' (line: " + a_line_number.out + "): " + a_reason)
		end

	report_class_creations_error (a_filename: STRING) is
			-- Report that file `a_filename' cannot be created for writing.
		require
			a_filename_attached: a_filename /= Void
		do
			report_error_message ("Could not create file '" + a_filename + "' for writing.")
		end

invariant
	remaining_time_not_negative: remaining_time /= Void implies remaining_time.second_count >= 0
	system_attached: system /= Void

end
