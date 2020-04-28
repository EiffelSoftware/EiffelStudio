note

	description:

		"Error Handler for EWG"

	copyright: "Copyright (c) 2004, Andreas Leitner and others"
	license: "Eiffel Forum License v2 (see forum.txt)"
	date: "$Date$"
	revision: "$Revision$"

class EWG_ERROR_HANDLER

inherit

	ANY

	UT_ERROR_HANDLER
		redefine
			report_error_message,
			is_verbose,
			report_info_message
		end

	KL_IMPORTED_STRING_ROUTINES

	KL_IMPORTED_DOUBLE_ROUTINES
		export {NONE} all end

	DT_SHARED_SYSTEM_CLOCK
		export {NONE} all end

create

	make

feature {NONE} -- Initialization

	make
			-- Create a new error handler using the standard
			-- error file for error and warning reporting
			-- and ignoring info messages.
		do
			make_standard
			set_info_null
			set_warning_null
			create current_line.make (0)
		ensure
			error_file_set: error_file = std.error
			warning_file_set: warning_file = null_output_stream
			info_file_set: info_file = null_output_stream
		end

feature -- Status report

	has_error: BOOLEAN
			-- Has an error been reported?
		do
			Result := (error_count > 0)
		end

	is_verbose: BOOLEAN
			-- Is `info_file' set to something other than
			-- the null output stream?
		do
			Result := (info_file /= null_output_stream) and
				(warning_file /= null_output_stream)
		ensure then
			-- TODO: not sure why, but se chokes on this (at runtime)
			-- condition seems fine though
--			definition: Result = (info_file /= null_output_stream) and
--						(warning_file /= null_output_stream)
		end

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

feature -- Measurement

	error_count: INTEGER
			-- Number of errors reported so far

feature -- Reporting messages

	report_version_message
			-- Report reversion message
		do
			report_info (Version_message)
		end

	report_usage_message
			-- Report usage message.
		do
			report_info (Usage_message)
		end

feature -- Reporting errors

	report_missing_command_line_parameter_error (a_parameter_name: STRING)
			-- Report that `a_parameter_name' has not been provided as a
			-- command line parameter.
		require
			a_parameter_name_not_void: a_parameter_name /= Void
			a_parameter_name_not_empty: not a_parameter_name.is_empty
		local
			an_error: EWG_MISSING_COMMAND_LINE_PARAMETER_ERROR
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
			an_error: EWG_MISSING_COMMAND_LINE_PARAMETER_VALUE_ERROR
		do
			create an_error.make (a_parameter_name)
			report_error (an_error)
		end

	report_usage_error
			-- Report usage error.
		do
			report_error (Usage_message)
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

	report_parsed_successfuly_message
			-- Report 'parsed successfully' message
		do
			report_info (Parsed_successfuly_message)
		end

	report_obsolete_syntax_is_used_message
			-- Report message that the obsolete syntax is being used
		do
			report_info (Obsolete_syntax_is_used_message)
			report_usage_message
		end

	report_quitting_because_of_config_file_errors_error (a_config_file_name: STRING)
		require
			a_config_file_name_not_void: a_config_file_name /= Void
		local
			an_error: EWG_QUITING_BECAUSE_CONFIG_FILE_HAD_ERRORS_ERROR
		do
			create an_error.make (a_config_file_name)
			report_error (an_error)
		end

	report_parser_error (a_message: STRING)
			-- Report an XML parser error.
		require
			a_message_not_void: a_message /= Void
		local
			an_error: UT_MESSAGE
		do
			create an_error.make (a_message)
			report_error (an_error)
		end

	report_error_message (an_error: STRING)
			-- Report `an_error'.
		do
			error_count := error_count + 1
			precursor (an_error)
		end

	report_info_message (a_message: STRING)
			-- Report an information message, with
			-- `a_message' being the information
		local
			str: STRING
		do
			if a_message.has ('%N') then
				a_message.remove_tail (1)
			end
			str := current_line
			update_current_line (a_message)
			make_current_line_permanent
			update_current_line (str)
		end

	report_wrong_config_root_element_error (an_element_name: STRING; a_position: XM_POSITION)
			-- Report that ewg config file does not contain the
			-- expected root element `an_element_name'.
		require
			an_element_name_not_void: an_element_name /= Void
			an_element_name_not_empty: an_element_name.count > 0
			a_position_not_void: a_position /= Void
		local
			an_error: ET_XACE_WRONG_ROOT_ELEMENT_ERROR
		do
			create an_error.make (an_element_name, a_position)
			report_error (an_error)
		end

	report_missing_config_attribute_error (a_containing_element: XM_ELEMENT; an_attribute_name: STRING; a_position: XM_POSITION)
			-- Report that attribute `an_attribute_name' is
			-- missing in element `a_containing_element'.
		require
			a_containing_element_not_void: a_containing_element /= Void
			an_attribute_name_not_void: an_attribute_name /= Void
			an_attribute_name_not_empty: an_attribute_name.count > 0
			a_position_not_void: a_position /= Void
		local
			an_error: ET_XACE_MISSING_ATTRIBUTE_ERROR
		do
			create an_error.make (a_containing_element, an_attribute_name, a_position)
			report_error (an_error)
		end

	report_missing_config_element_error (a_containing_element: XM_ELEMENT; an_element_name: STRING; a_position: XM_POSITION)
			-- Report that element `an_element_name' is
			-- missing in element `a_containing_element'.
		require
			a_containing_element_not_void: a_containing_element /= Void
			an_element_name_not_void: an_element_name /= Void
			an_element_name_not_empty: an_element_name.count > 0
			a_position_not_void: a_position /= Void
		local
			an_error: ET_XACE_MISSING_ELEMENT_ERROR
		do
			create an_error.make (a_containing_element, an_element_name, a_position)
			report_error (an_error)
		end

	report_unexpected_element_error (an_expected_element_name: STRING; an_element: XM_ELEMENT; a_position: XM_POSITION)
			-- Report that instead of `an_element' an element with the name `an_expected_element_name' was expected.
		require
			an_expected_element_name_not_void: an_expected_element_name /= Void
			an_expected_element_name_not_empty: an_expected_element_name.count > 0
			an_element_not_void: an_element /= Void
			a_position_not_void: a_position /= Void
			an_element_is_not_expected: STRING_.same_string (an_expected_element_name, an_element.name)
		local
			an_error: EWG_UNEXPECTED_ELEMENT_ERROR
		do
			create an_error.make (an_expected_element_name, an_element, a_position)
			report_error (an_error)
		end

	report_unknown_config_element_error (a_containing_element: XM_ELEMENT; an_element: XM_ELEMENT; a_position: XM_POSITION)
			-- Report that element `an_element' is not
			-- expected in element `a_containing_element'.
		require
			a_containing_element_not_void: a_containing_element /= Void
			an_element_not_void: an_element /= Void
			a_position_not_void: a_position /= Void
		local
			an_error: ET_XACE_UNKNOWN_ELEMENT_ERROR
		do
			create an_error.make (a_containing_element, an_element, a_position)
			report_error (an_error)
		end

	report_unknown_config_wrapper_type_error (an_element: XM_ELEMENT; a_position: XM_POSITION)
			-- Report that the value of the attribute "type"
			-- in the "wrapper" elment `an_element' is unknown.
		local
			an_error: EWG_UNKNOWN_WRAPPER_TYPE_ERROR
		do
			create an_error.make (an_element, a_position)
			report_error (an_error)
		end

	report_unknown_config_construct_type_error (an_element: XM_ELEMENT; a_position: XM_POSITION)
			-- Report that the value of the attribute "type"
			-- in the "match" elment `an_element' is unknown.
		local
			an_error: EWG_UNKNOWN_CONSTRUCT_TYPE_ERROR
		do
			create an_error.make (an_element, a_position)
			report_error (an_error)
		end

	report_invalid_class_name_error (an_element: XM_ELEMENT; a_position: XM_POSITION)
			-- Report that the value of the attribute "name"
			-- in the "class_name" elment `an_element' is invalid.
		local
			an_error: EWG_INVALID_CLASS_NAME_ERROR
		do
			create an_error.make (an_element, a_position)
			report_error (an_error)
		end

	report_illegal_regular_expression_in_attribute (a_containing_element: XM_ELEMENT;
																	an_attribute_name: STRING;
																	a_position: XM_POSITION;
																	a_error_message: STRING;
																	a_error_position: INTEGER)
		require
			a_containing_element_not_void: a_containing_element /= Void
			an_attribute_name_not_void: an_attribute_name /= Void
			an_attribute_name_not_empty: an_attribute_name.count > 0
			a_position_not_void: a_position /= Void
			a_error_message_not_void: a_error_message /= Void
		local
			an_error: EWG_ILLEGAL_REGULAR_EXPRESSION_IN_ATTRIBUTE_ERROR
		do
			create an_error.make (a_containing_element,
										 an_attribute_name,
										 a_position,
										 a_error_message,
										 a_error_position)
			report_error (an_error)
		end

feature -- Progress indication

	start_task (a_name: STRING)
			-- Start a new task with the name `a_name'.
		require
			a_name_not_void: a_name /= Void
			task_not_running: not task_running
		do
			current_task_name := a_name
			current_task_ticks := 0
			task_running := True
			update_current_line (progress_message)
		ensure
			task_running: task_running
			current_task_ticks_is_zero: current_task_ticks = 0
		end

	tick
			-- Advance progress indicator for running task
		require
			task_running: task_running
			current_task_name_not_void: current_task_name /= Void
			not_too_many_ticks: current_task_ticks < current_task_total_ticks
		do
			set_ticks (current_task_ticks + 1)
		ensure
			current_task_ticks_increased: current_task_ticks = old current_task_ticks + 1
		end

	set_ticks (a_ticks: INTEGER)
			-- Set progress for running task
		require
			task_running: task_running
			current_task_name_not_void: current_task_name /= Void
			a_ticks_not_greater_as_total_ticks: a_ticks <= current_task_total_ticks
		do
			current_task_ticks := a_ticks
			update_current_line (progress_message)
		ensure
			current_task_ticks_set: current_task_ticks = a_ticks
		end

	stop_task
			-- Stop running task
		require
			task_running: task_running
		do
			set_ticks (current_task_total_ticks)
			update_current_line (current_line)
			make_current_line_permanent
			task_running := False
		end

	set_current_task_total_ticks (a_ticks: INTEGER)
			-- `a_ticks' is the number of ticks the task will take.
		require
			a_ticks_greater_equal_zero: a_ticks >= 0
		do
			current_task_total_ticks := a_ticks
			has_current_task_total_ticks := True
		ensure
			current_task_total_ticks_set: current_task_total_ticks = a_ticks
			has_current_task_total_ticks_set: has_current_task_total_ticks
		end

	set_current_task_has_no_total_ticks
			-- Makes the currently running task have
			-- no information how many ticks it is going to take
			-- to complete that task
		do
			has_current_task_total_ticks := False
		ensure
			has_current_task_total_ticks_reset: not has_current_task_total_ticks
		end


	task_running: BOOLEAN
			-- Is a task currently running ?

	current_task_total_ticks: INTEGER
			-- Totoal number of ticks current task will take till it is done

	has_current_task_total_ticks: BOOLEAN
			-- Returns whether the currently running tasks
			-- knows in advance how many ticks it is going to take

	current_task_ticks: INTEGER
			-- Current task has already done `current_task_ticks'.

	current_task_name: detachable STRING
			-- Name of the current_task


feature {NONE} -- Progress bar implementation

	remove_characters (n: INTEGER)
			-- Remove the last `n' characters printed to the console
		require
			n_greater_equal_zero: n >= 0
		local
			str: STRING
		do
			create str.make_filled ('%B', n)
			info_file.put_string (str)
		end

	progress_message: STRING
			-- Return a STRING containing the progress message
		local
			percent: INTEGER
		do
			check attached current_task_name as l_current_task_name then
				if current_task_total_ticks > 0 then
					percent := DOUBLE_.floor_to_integer ((current_task_ticks * 100) / current_task_total_ticks)
				end
				create Result.make (12 + l_current_task_name.count)
				Result.append_character ('[')
				if percent < 10 then
					Result.append_string (" ")
				elseif percent < 100 then
					Result.append_character (' ')
				end
				Result.append_string (percent.out)
				Result.append_string ("%%]")
				Result.append_character (' ')
				if current_task_ticks = current_task_total_ticks then
					Result.append_character (' ')
				else
					Result.append_character (spinn_characters.item (current_task_ticks \\ (spinn_characters.count)))
				end
				Result.append_character (' ')
				Result.append_string (l_current_task_name)
			end
		ensure
			result_not_void: Result /= Void
		end

	update_current_line (a_string: STRING)
			-- Update the current line by first
			-- removing the old line and then
			-- printing `a_string'.
		require
			a_string_not_void: a_string /= Void
			a_string_has_not_endl: not a_string.has ('%N')
			a_string_has_no_backspace: not a_string.has ('%B')
		local
			blanks: STRING
		do
			remove_characters (current_line.count)
			info_file.put_string (a_string)
			if a_string.count < current_line.count then
				create blanks.make_filled (' ', current_line.count - a_string.count)
				info_file.put_string (blanks)
				remove_characters (current_line.count - a_string.count)
			end
			current_line := a_string
			info_file.flush
		end

	make_current_line_permanent
			-- Makes the current line permanent.
			-- This is done by making the terminal
			-- scroll one line down, so any updates
			-- will be done on the new line.
		do
			info_file.put_new_line
			current_line.wipe_out
		end

	current_line: STRING
			-- String that is currently displayed on the current terminal line

	spinn_characters: ARRAY [CHARACTER]
		once
			create Result.make_filled (' ',0, 3)
			Result.put ('/', 0)
			Result.put ('|', 1)
			Result.put ('\', 2)
			Result.put ('-', 3)
		end

feature

	Usage_message: UT_USAGE_MESSAGE
			-- Ewg usage message.
		once
			create Result.make
			("%T[--version] [--verbose]%N" +
			 "%T%T[--c_compile_options=<...>] [--script_pre_process=<...>] [--script_post_process=<...>]%N" +
			 "%T%T[--output-dir=<...>] --full-header=<...>%N" +
			 "%T%T[--config=<...>]%N")
		ensure
			usage_message_not_void: Result /= Void
		end

	Obsolete_syntax_is_used_message: UT_MESSAGE
			-- Obsolete syntax is being used message
		once
			create Result.make
			("You are using an obsolete command line syntax, please use the new one.")
		ensure
			obsolete_syntax_is_used_message_not_void: Result /= Void
		end

	Parsed_successfuly_message: UT_MESSAGE
			-- 'Parsed successfuly' message
		once
			create Result.make ("  parsed successfuly")
		ensure
			parsed_sucessfuly_message_not_void: Result /= Void
		end


	Version_message: UT_MESSAGE
			-- 'Version' message
		do
			create Result.make ("wrap_c version " + Version_number)
		ensure
			version_message_not_void: Version_message /= Void
		end

	Version_number: STRING = "1.0.0"
			-- Current version number of EWG

invariant

	current_task_ticks_greater_equal_zero: current_task_ticks >= 0
	current_line_not_void: current_line /= Void
	current_line_has_not_endl: not current_line.has ('%N')
	current_line_has_no_backspace: not current_line.has ('%B')

end
