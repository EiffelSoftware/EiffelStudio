note
	description: "[
		Objects that launch an arbitrary command in a separate process and provide in- and output
		support routines.
	]"
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	EQA_EXECUTION

create
	make

feature {NONE} -- Initialization

	make (a_test_set: like test_set; a_command: READABLE_STRING_GENERAL)
			-- Initialize `Current'.
			--
			-- `a_test_set': Test set for which `Current' will be used.
			-- `a_command': Executable name
		require
			an_environment_attached: a_test_set /= Void
		local
			l_empty_path: EQA_SYSTEM_PATH
		do
			test_set := a_test_set
			create command.make_from_string_general (a_command)
			create l_empty_path.make_empty
			set_working_directory (file_system.build_source_path (l_empty_path))
			create arguments.make (default_argument_count)
		end

feature -- Access

	test_set: EQA_SYSTEM_TEST_SET
			-- Test set for which `Current' is used

	command: IMMUTABLE_STRING_32
			-- Executable name

	working_directory: IMMUTABLE_STRING_32
			-- Working directory in which process is launched

	output_file_name: detachable IMMUTABLE_STRING_32
			-- File to which output will be printed, Void if output should be stored

	error_file_name: detachable IMMUTABLE_STRING_32
			-- File to which error output will be printed
			--
			-- Note: if `error_file' and `error_processor' are void at the time the `Current' is launched,
			--       the error output will be redirected to the regular output

	input_file_name: detachable IMMUTABLE_STRING_32
			-- File from which input will be read, Void if input is not read from a file

	output_processor: detachable EQA_SYSTEM_OUTPUT_PROCESSOR
			-- Processor analysing output, Void if output should not be analysed

	error_processor: detachable EQA_SYSTEM_OUTPUT_PROCESSOR
			-- Processor analysing errors, Void if errors should not be analysed
			--
			-- Note: if `error_file_name' and `error_processor' are void at the time the `Current' is launched,
			--       the error output will be redirected to the regular output

	exit_code: INTEGER
			-- Exit code process has returned.
		require
			exited: has_exited
		do
			Result := last_exit_code
		end


feature {NONE} -- Access

	file_system: EQA_FILE_SYSTEM
			-- Shared instance of {EQA_FILE_SYSTEM}
		do
			Result := test_set.file_system
		end

	arguments: ARRAYED_LIST [READABLE_STRING_GENERAL]
			-- Arguments passed to process when `launch' is called.

	process: detachable EQA_SYSTEM_EXECUTION_PROCESS
			-- Process for launching system and redirecting in-/output

	last_exit_code: like exit_code
			-- Exit code last retrieved from `process'

feature -- Status report

	is_launched: BOOLEAN
			-- Has system been launched yet?

	has_exited: BOOLEAN
			-- Has system exited yet?
		require
			launched: is_launched
		do
			Result := process = Void
		ensure
			result_implies_status_attached: Result implies process = Void
		end

feature -- Status setting

	set_working_directory (a_working_directory: READABLE_STRING_GENERAL)
			-- Set `working_directory' to `a_working_directory'.
		require
			a_working_directory_attached: a_working_directory /= Void
			not_launched: not is_launched
		do
			create working_directory.make_from_string_general (a_working_directory)
		ensure
			working_directory_set: working_directory.same_string_general (a_working_directory)
		end

	set_output_path (a_path: EQA_SYSTEM_PATH)
			-- Set `output_file_name' to file in `output_directory' with `a_path' appended.
		require
			not_launched: not is_launched
			a_path_attached: a_path /= Void
			a_path_not_empty: not a_path.is_empty
		do
			set_output_file_name (test_set.file_system.build_path (output_directory, a_path))
		ensure
			output_file_name_set: attached output_file_name as l_file_name and then
				l_file_name.same_string (test_set.file_system.build_path (output_directory, a_path))
		end

	set_output_file_name (a_output_file_name: detachable READABLE_STRING_GENERAL)
			-- Set `output_file_name' to `a_output_file_name'.
		require
			not_launched: not is_launched
			a_output_file_name_not_empty: a_output_file_name /= Void implies not a_output_file_name.is_empty
		do
			if a_output_file_name /= Void then
				create output_file_name.make_from_string_general (a_output_file_name)
			else
				output_file_name := Void
			end
		ensure
			output_file_name_set: a_output_file_name /= Void implies
				(attached output_file_name as l_path and then l_path.same_string_general (a_output_file_name))
			output_file_name_unset: a_output_file_name = Void implies output_file_name = Void
		end

	set_output_file_path (a_output_file_name: detachable PATH)
			-- Set `output_file_name' to `a_output_file_name'.
		require
			not_launched: not is_launched
			a_output_file_name_not_empty: a_output_file_name /= Void implies not a_output_file_name.is_empty
		do
			if a_output_file_name /= Void then
				output_file_name := a_output_file_name.name
			else
				output_file_name := Void
			end
		ensure
			output_file_name_set: a_output_file_name /= Void implies
				(attached output_file_name as l_path and then l_path.same_string (a_output_file_name.name))
			output_file_name_unset: a_output_file_name = Void implies output_file_name = Void
		end

	set_error_path (a_path: EQA_SYSTEM_PATH)
			-- Set `error_file_name' to file in `output_directory' with `a_path' appended.
		require
			not_launched: not is_launched
			a_path_attached: a_path /= Void
			a_path_not_empty: not a_path.is_empty
		do
			set_error_file_name (test_set.file_system.build_path (output_directory, a_path))
		ensure
			error_file_name_set: attached error_file_name as l_file_name and then
				l_file_name.same_string (test_set.file_system.build_path (output_directory, a_path))
		end

	set_error_file_name (a_error_file_name: detachable READABLE_STRING_GENERAL)
			-- Set `error_file_name' to `a_error_file_name'.
		require
			not_launched: not is_launched
			a_error_file_name_not_empty: a_error_file_name /= Void implies not a_error_file_name.is_empty
		do
			if a_error_file_name /= Void then
				create error_file_name.make_from_string_general (a_error_file_name)
			else
				error_file_name := Void
			end
		ensure
			error_file_name_set: a_error_file_name /= Void implies
				(attached error_file_name as l_path and then l_path.same_string_general (a_error_file_name))
			error_file_name_unset: a_error_file_name = Void implies error_file_name = Void
		end

	set_error_file_path (a_error_file_name: detachable PATH)
			-- Set `error_file_name' to `a_error_file_name'.
		require
			not_launched: not is_launched
			a_error_file_name_not_empty: a_error_file_name /= Void implies not a_error_file_name.is_empty
		do
			if a_error_file_name /= Void then
				error_file_name := a_error_file_name.name
			else
				error_file_name := Void
			end
		ensure
			error_file_name_set: a_error_file_name /= Void implies
				(attached error_file_name as l_path and then l_path.same_string (a_error_file_name.name))
			error_file_name_unset: a_error_file_name = Void implies error_file_name = Void
		end

	set_input_path (a_path: EQA_SYSTEM_PATH)
			-- Set `input_file_name' to file in the source directory with `a_path' appended.
		require
			not_launched: not is_launched
			a_path_attached: a_path /= Void
			a_path_not_empty: not a_path.is_empty
		do
			set_input_file_name (test_set.file_system.build_source_path (a_path))
		ensure
			input_file_name_set: attached input_file_name as l_file_name and then
				l_file_name.same_string (test_set.file_system.build_source_path (a_path))
		end

	set_input_file_name (a_input_file_name: detachable READABLE_STRING_GENERAL)
			-- Set `input_file_name' to `a_input_file_name'.
		require
			not_launched: not is_launched
			a_input_file_name_not_empty: a_input_file_name /= Void implies not a_input_file_name.is_empty
		do
			if a_input_file_name /= Void then
				create input_file_name.make_from_string_general (a_input_file_name)
			else
				input_file_name := Void
			end
		ensure
			input_file_name_set: a_input_file_name /= Void implies
				(attached input_file_name as l_path and then l_path.same_string_general (a_input_file_name))
			input_file_name_unset: a_input_file_name = Void implies input_file_name = Void
		end

	set_input_file_path (a_input_file_name: detachable PATH)
			-- Set `input_file_name' to `a_input_file_name'.
		require
			not_launched: not is_launched
			a_input_file_name_not_empty: a_input_file_name /= Void implies not a_input_file_name.is_empty
		do
			if a_input_file_name /= Void then
				input_file_name := a_input_file_name.name
			else
				input_file_name := Void
			end
		ensure
			input_file_name_set: a_input_file_name /= Void implies
				(attached input_file_name as l_path and then l_path.same_string (a_input_file_name.name))
			input_file_name_unset: a_input_file_name = Void implies input_file_name = Void
		end

	set_output_processor (a_output_processor: like output_processor)
			-- Set `output_processor' to `a_output_processor'.
		require
			not_launched: not is_launched
		do
			output_processor := a_output_processor
		ensure
			output_processor_set: output_processor = a_output_processor
		end

	set_error_processor (a_error_processor: like error_processor)
			-- Set `error_processor' to `a_error_processor'.
		require
			not_launched: not is_launched
		do
			error_processor := a_error_processor
		ensure
			error_processor_set: error_processor = a_error_processor
		end

feature -- Basic operations

	launch
			-- Launch system.
		require
			not_launched: not is_launched
		local
			l_process: like process
			l_output_file, l_error_file, l_input_file: detachable PLAIN_TEXT_FILE
		do
			if attached output_file_name as l_name then
				create l_output_file.make_with_name (l_name)
				l_output_file.open_write
			end
			if attached error_file_name as l_name then
				create l_error_file.make_with_name (l_name)
				l_error_file.open_write
			end
			if attached input_file_name as l_name then
				create l_input_file.make_with_name (l_name)
				assert ("input_file_exists", l_input_file.exists)
				assert ("input_file_readable", l_input_file.readable)
				l_input_file.open_read
			end
			create l_process.make (output_processor, error_processor, l_output_file, l_error_file, l_input_file)
			l_process.launch (command, arguments, working_directory)
			process := l_process
			is_launched := True
		ensure
			launched: is_launched
		end

	process_output
			-- Check if any output has been received from system and process it if so.
		require
			launched: is_launched
			not_exited: not has_exited
		do
			check not_exited: attached process as l_process then
				l_process.redirect_output
				if not l_process.is_running then
					cleanup_process
				end
			end
		end

	process_output_until_exit
			-- Process all output received from system until system terminates.
		require
			launched: is_launched
			not_exited: not has_exited
		do
			check not_exited: attached process as l_process then
				from
				until
					not l_process.is_running
				loop
					l_process.redirect_output
				end
				cleanup_process
			end
		ensure
			exited: has_exited
		end

	put_string (a_input: READABLE_STRING_8)
			-- Send input to process.
			--
			-- `a_input': Input to be sent to process.
		require
			launched: is_launched
			not_exited: not has_exited
			input_file_name_detached: input_file_name = Void
		do
			check not_exited: attached process as l_process then
				l_process.redirect_input (a_input)
			end
		end

feature -- Element change

	clear_argument
			-- Wipe out `arguments'
		do
			arguments.wipe_out
		end

	add_argument (a_argument: READABLE_STRING_GENERAL)
			-- Add `a_arguments' to end of `arguments'.
		require
			a_argument_attached: a_argument /= Void
			not_launched: not is_launched
			a_argument_not_empty: not a_argument.is_empty
		do
			arguments.extend (create {IMMUTABLE_STRING_32}.make_from_string_general (a_argument))
		ensure
			arguments_count_increased: arguments.count = old arguments.count + 1
			a_argument_last: arguments.last.same_string (a_argument)
		end

feature {NONE} -- Implementation

	output_directory: READABLE_STRING_32
			-- Path to which output files are written.
		do
			if attached test_set.environment.item ({EQA_EXECUTION}.output_path_key) as l_path then
				Result := l_path
			else
				Result := test_set.file_system.build_target_path (<< default_output_directory >>)
				test_set.environment.put (Result, {EQA_EXECUTION}.output_path_key)
			end
		ensure
			result_attached: Result /= Void
			same_as_environment: attached test_set.environment.item ({EQA_EXECUTION}.output_path_key) as l_path
				and then l_path.same_string (Result)
		end

	cleanup_process
			-- Cleanup current `process' instance.
		require
			launched: is_launched
			not_has_exited: not has_exited
			process_exited: attached process as l_proc and then not l_proc.is_running
		do
			check not_exited: attached process as l_process then
				last_exit_code := l_process.last_exit_code
				process := Void
			end
		ensure
			exited: has_exited
		end

	frozen assert (a_tag: READABLE_STRING_GENERAL; a_condition: BOOLEAN)
			-- Assert `a_condition'.
		require
			a_tag_attached: a_tag /= Void
		do
			test_set.assert_32 (a_tag, a_condition)
		end

feature -- Constants

	output_path_key: STRING_32 = "OUTPUT_PATH"

	default_output_directory: STRING_32 = "output"

feature {NONE} -- Constants

	default_argument_count: INTEGER = 5

invariant
	running_implies_status_attached: (is_launched and not has_exited) implies process /= Void


note
	copyright: "Copyright (c) 1984-2013, Eiffel Software and others"
	license: "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"
end
