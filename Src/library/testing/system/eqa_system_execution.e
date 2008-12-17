indexing
	description: "[
		Objets that launch the system under test in a separate process and provide in- and output
		support routines.
	]"
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	EQA_SYSTEM_EXECUTION

create
	make

feature {NONE} -- Initialization

	make (an_environment: like environment)
			-- Initialize `Current'.
			--
			-- `an_environment': Environment in for current system test.
		local
			l_empty_path: EQA_SYSTEM_PATH
		do
			environment := an_environment
			create l_empty_path.make_empty
			set_working_directory (file_system.build_source_path (l_empty_path))
			create arguments.make (default_argument_count)
		end

feature -- Access

	environment: !EQA_SYSTEM_ENVIRONMENT
			-- Current environment

	working_directory: !READABLE_STRING_8
			-- Working directory in which process will be launched

	output_path: ?EQA_SYSTEM_PATH
			-- Path of file to which output will be printed, Void if output should not be stored

	error_path: ?EQA_SYSTEM_PATH
			-- Path of file to which errors will be printed, Void if errors should not be stored

	input_path: ?EQA_SYSTEM_PATH
			-- Path of file from which input will be read, Void if input is not read from a file

	output_processor: ?EQA_SYSTEM_OUTPUT_PROCESSOR
			-- Processor analysing output, Void if output should not be analysed

	error_processor: ?EQA_SYSTEM_OUTPUT_PROCESSOR
			-- Processor analysing errors, Void if errors should not be analysed

	exit_code: INTEGER
			-- Exit code process has returned.
		require
			exited: has_exited
		do
			Result := last_exit_code
		end

feature {NONE} -- Access

	file_system: !EQA_FILE_SYSTEM
			-- Shared instance of {EQA_FILE_SYSTEM}
		do
			Result := environment.test_set.file_system
		end

	arguments: !ARRAYED_LIST [!STRING]
			-- Arguments passed to process when `launch' is called.

	process: ?EQA_SYSTEM_EXECUTION_PROCESS
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

	set_working_directory (a_working_directory: like working_directory)
			-- Set `working_directory' to `a_working_directory'.
		require
			not_launched: not is_launched
		local
			l_dir: ?like working_directory
		do
			l_dir := a_working_directory.string
			check l_dir /= Void end
			working_directory := l_dir
		ensure
			working_directory_set: working_directory ~ a_working_directory.string
		end

	set_output_path (a_output_path: like output_path)
			-- Set `output_path' to `a_output_path'.
		require
			not_launched: not is_launched
			a_output_path_not_empty: not a_output_path.is_empty
		do
			output_path := a_output_path.twin
		ensure
			output_path_set: output_path ~ a_output_path
		end

	set_error_path (a_error_path: like error_path)
			-- Set `error_path' to `a_error_path'.
		require
			not_launched: not is_launched
			a_error_path_not_empty: not a_error_path.is_empty
		do
			error_path := a_error_path.twin
		ensure
			error_path_set: error_path ~ a_error_path
		end

	set_input_path (a_input_path: like input_path)
			-- Set `input_path' to `a_input_path'.
		require
			not_launched: not is_launched
			a_input_path_not_empty: not a_input_path.is_empty
		do
			input_path := a_input_path.twin
		ensure
			input_path_set: input_path ~ a_input_path
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

feature {NONE} -- Query

	executable_name: !STRING
			-- Name of executable to run system
		local
			l_exec_env: EXECUTION_ENVIRONMENT
			l_env, l_cmd: STRING
		do
			l_cmd := environment.get (executable_env)
			if l_cmd = Void then
				create l_exec_env
				l_cmd := l_exec_env.command_line.argument (0)
				check l_cmd /= Void end
			end
			Result := l_cmd
		end

feature -- Basic operations

	launch
			-- Launch system.
		require
			not_launched: not is_launched
		local
			l_status: like process
			l_output_path, l_error_path, l_input_path: like output_path
			l_output_file, l_error_file, l_input_file: ?PLAIN_TEXT_FILE
		do
			l_output_path := output_path
			if l_output_path /= Void then
				file_system.create_file_from_path (l_output_path)
				l_output_file := file_system.last_created_file
			end
			l_error_path := error_path
			if l_error_path /= Void then
				file_system.create_file_from_path (l_error_path)
				l_error_file := file_system.last_created_file
			end
			l_input_path := input_path
			if l_input_path /= Void then
				create l_input_file.make (file_system.build_target_path (l_input_path))
				assert ("input_file_exists", l_input_file.exists)
				assert ("input_file_readable", l_input_file.readable)
				l_input_file.open_read
			end

			create l_status.make (output_processor, error_processor, l_output_file, l_error_file, l_input_file)
			l_status.launch (executable_name, arguments, working_directory)
			process := l_status
			is_launched := True
		ensure
			launched: is_launched
		end

	process_output
			-- Check if any output has been received from system and process it if so.
		require
			launched: is_launched
			not_exited: not has_exited
		local
			l_status: like process
		do
			l_status := process
			check l_status /= Void end
			l_status.redirect_output
			if l_status.has_exited then
				cleanup_process
			end
		end

	process_output_until_exit
			-- Process all output received from system until system terminates.
		require
			launched: is_launched
			not_exited: not has_exited
		local
			l_status: like process
		do
			l_status := process
			check l_status /= Void end
			from until
				l_status.has_exited
			loop
				l_status.redirect_output
			end
			cleanup_process
		ensure
			exited: has_exited
		end

	put_string (a_input: !READABLE_STRING_8)
			-- Send input to process.
			--
			-- `a_input': Input to be sent to process.
		require
			launched: is_launched
			not_exited: not has_exited
			input_path_detached: input_path = Void
		do
			process.redirect_input (a_input)
		end

feature -- Element change

	add_argument (a_argument: !READABLE_STRING_8)
			-- Add `a_arguments' to end of `arguments'.
		require
			not_launched: not is_launched
			a_argument_not_empty: not a_argument.is_empty
		do
			arguments.force (create {STRING}.make_from_string (a_argument))
		ensure
			arguments_count_increased: arguments.count = old arguments.count + 1
			a_argument_last: arguments.last ~ a_argument
		end

feature {NONE} -- Implementation

	cleanup_process
			-- Cleanup current `process' instance.
		require
			launched: is_launched
			not_has_exited: not has_exited
			process_exited: {l_proc: like process} process and then process.has_exited
		local
			l_process: like process
		do
			l_process := process
			last_exit_code := l_process.last_exit_code
			process := Void
		ensure
			exited: has_exited
		end

	frozen assert (a_tag: !STRING; a_condition: BOOLEAN)
			-- Assert `a_condition'.
		do
			environment.test_set.assert (a_tag, a_condition)
		end

feature {NONE} -- Constants

	executable_env: !STRING = "EQA_EXECUTABLE"

	default_argument_count: INTEGER = 5

invariant
	environment_valid: environment.test_set.has_valid_name
	running_implies_status_attached: (is_launched and not has_exited) implies process /= Void

end
