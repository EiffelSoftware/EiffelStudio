indexing
	description: "External command tester, used to test if output/error a process matchs given expected output/error"
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	EB_METRIC_EXTERNAL_COMMAND_TESTER

inherit
	EB_METRIC_VISITABLE

	EB_METRIC_SHARED
		undefine
			copy,
			is_equal
		end

--inherit {NONE}
	EIFFEL_LAYOUT
		export
			{NONE} all
		undefine
			copy,
			is_equal
		end

create
	make

feature{NONE} -- Initialization

	make (a_command: like command) is
			-- Initialize.
		require
			a_command_attached: a_command /= Void
		do
			set_command (a_command)
			set_input ("")
			set_output ("")
			set_error ("")
			set_working_directory ("")
		end

feature -- Access

	visitable_name: STRING_GENERAL is
			-- Name of current visitable item
		do
			Result := metric_names.l_external_command_tester
		end

	command: STRING
			-- Command to execute
			-- May contain placeholders such as $file_name, $directory_name

	working_directory: STRING
			-- Directory to launch `command'
			-- May contain placeholders such as $file_name, $directory_name

	input: STRING
			-- Input for `command'
			-- May contain placeholders such as $file_name, $directory_name

	output: STRING
			-- Output from `command'
			-- May contain placeholders such as $file_name, $directory_name

	error: STRING
			-- Error from `command'
			-- May contain placeholders such as $file_name, $directory_name

	exit_code: INTEGER
			-- Exit code from `command'

	criterion: QL_CRITERION
			-- Criterion

feature -- Status report

	is_output_enabled: BOOLEAN
			-- Should output from `command' be used to compare with expected output specified by `output'?

	is_error_enabled: BOOLEAN
			-- Should error from `command' be used to compare with expected error specified by `error'?

	is_exit_code_enabled: BOOLEAN
			-- Should exit code from `command' be used to compare with expected exit code specified by `exit_code'?

	is_error_redirected_to_output: BOOLEAN
			-- Should error from `command' be redirected to output?

	is_input_as_file: BOOLEAN
			-- Does input specified in `input' represent a file name?

	is_output_as_file: BOOLEAN
			-- Does output specified in `output' represent a file name?

	is_error_as_file: BOOLEAN
			-- Does error specified in `error' represent a file_name?

	is_command_specified: BOOLEAN is
			-- Is `command' specified?
		local
			l_cmd: like command
		do
			l_cmd := command.twin
			l_cmd.left_adjust
			l_cmd.right_adjust
			Result := not l_cmd.is_empty
		end

feature -- Setting

	set_command (a_command: like command) is
			-- Set `command' with `a_command'.
		require
			a_command_attached: a_command /= Void
		do
			command := a_command.twin
		ensure
			command_set: command /= Void and then command.is_equal (a_command)
		end

	set_working_directory (a_working_directory: like working_directory) is
			-- Set `working_directory' with `a_working_directory'.
		require
			a_working_directory_attached: a_working_directory /= Void
		do
			working_directory := a_working_directory.twin
		ensure
			working_directory_set: working_directory /= Void and then working_directory.is_equal (a_working_directory)
		end

	set_input (a_input: like input) is
			-- Set `input' with `a_input'.
		require
			a_input_attached: a_input /= Void
		do
			input := a_input.twin
		ensure
			input_set: input /= Void and then input.is_equal (a_input)
		end

	set_output (a_output: like output) is
			-- Set `output' with `a_output'.
		require
			a_output_attached: a_output /= Void
		do
			output := a_output.twin
		ensure
			output_set: output /= Void and then output.is_equal (a_output)
		end

	set_error (a_error: like error) is
			-- Set `error' with `a_error'.
		require
			a_error_attached: a_error /= Void
		do
			error := a_error.twin
		ensure
			error_set: error /= Void and then error.is_equal (a_error)
		end

	set_exit_code (a_code: INTEGER) is
			-- Set `exit_code' with `a_code'.
		do
			exit_code := a_code
		ensure
			exit_code_set: exit_code = a_code
		end

	set_is_output_enabled (b: BOOLEAN) is
			-- Set `is_output_enabled' with `b'.
		do
			is_output_enabled := b
		ensure
			is_output_enabled_set: is_output_enabled = b
		end

	set_is_error_enabled (b: BOOLEAN) is
			-- Set `is_error_enabled' with `b'.
		do
			is_error_enabled := b
		ensure
			is_error_enabled_set: is_error_enabled = b
		end

	set_is_error_redirected_to_output (b: BOOLEAN) is
			-- Set `is_error_redirected_to_output' with `b'.
		do
			is_error_redirected_to_output := b
		ensure
			is_error_redirectory_to_output_set: is_error_redirected_to_output = b
		end

	set_is_exit_code_enabled (b: BOOLEAN) is
			-- Set `is_exit_code_enabled' with `b'.
		do
			is_exit_code_enabled := b
		ensure
			is_exit_code_enabled_set: is_exit_code_enabled = b
		end

	set_input_as_file (b: BOOLEAN) is
			-- Set `is_input_as_file' with `b'.
		do
			is_input_as_file := b
		ensure
			is_input_as_file_set: is_input_as_file = b
		end

	set_output_as_file (b: BOOLEAN) is
			-- Set `is_output_as_file' with `b'.
		do
			is_output_as_file := b
		ensure
			is_output_as_file_set: is_output_as_file = b
		end

	set_error_as_file (b: BOOLEAN) is
			-- Set `is_error_as_file' with `b'.
		do
			is_error_as_file := b
		ensure
			is_error_as_file_set: is_error_as_file = b
		end

	set_criterion (a_criterion: like criterion) is
			-- Set `criterion' with `a_criterion'.
		do
			criterion := a_criterion
		ensure
			criterion_set: criterion = a_criterion
		end

feature{EB_METRIC_EXTERNAL_COMMAND_CRITERION} -- External command evaluation

	evaluate (a_item: QL_ITEM): BOOLEAN is
			-- Launch `command' to tester if its output, error match `output' and `error'.
		require
			a_item_attached: a_item /= Void
		local
			l_launcher: PROCESS
			l_process_factory: PROCESS_FACTORY
			l_replacer: EB_TEXT_REPLACER
			l_fragments: LINKED_LIST [EB_TEXT_FRAGMENT]
			l_cmd: STRING
			l_dir: STRING
			l_input: STRING
			l_output: STRING
			l_error: STRING
			l_generator: QL_DOMAIN_GENERATOR
			l_content: STRING
			l_command_output: like command_output
			l_command_error: like command_error
			l_output_cache_needed: BOOLEAN
			l_error_cache_needed: BOOLEAN
		do
			create l_fragments.make
			create l_replacer
			fragment_factory.set_item (a_item)

				-- Scan and replace `command'.
			l_cmd := replaced_text (command, l_replacer, l_fragments)

				-- Scan and replace `working_directory'.
			if not working_directory.is_empty then
				l_dir := replaced_text (working_directory, l_replacer, l_fragments)
			else
				l_dir := ""
			end

				-- Scan and replace `input'.
			if not input.is_empty then
				l_input := replaced_text (input, l_replacer, l_fragments)
			else
				l_input := ""
			end

				-- Scan and replace `output'.
			if is_output_enabled and then not output.is_empty then
				l_output := replaced_text (output, l_replacer, l_fragments)
			else
				l_output := ""
			end

				-- Scan and replace `error'.
			if is_error_enabled and then not is_error_redirected_to_output and then not error.is_empty then
				l_error := replaced_text (error, l_replacer, l_fragments)
			else
				l_error := ""
			end

				-- Prepare process.
			create l_process_factory
			l_launcher := l_process_factory.process_launcher_with_command_line (l_cmd, l_dir)
			l_launcher.set_timer (create {PROCESS_VISION2_TIMER}.make (1))

				-- Redirect process standard input.
			if is_input_as_file then
				remove_new_line_characters (l_input)
				l_launcher.redirect_input_to_file (l_input)
			else
				l_launcher.redirect_input_to_stream
			end
				-- Redirect process standard output.
			l_launcher.redirect_output_to_agent (agent on_output_from_process (?, is_output_enabled))

				-- Redirect process standard error.
			if is_error_enabled then
				if is_error_redirected_to_output then
					l_launcher.redirect_error_to_same_as_output
				else
					l_launcher.redirect_error_to_agent (agent on_error_from_process (?, True))
				end
			else
				l_launcher.redirect_error_to_agent (agent on_error_from_process (?, False))
			end

			l_output_cache_needed := is_output_enabled or else (is_error_enabled and then is_error_redirected_to_output)
			l_error_cache_needed := is_error_enabled and then not is_error_redirected_to_output

				-- Provide string cache for process output and error
			if l_output_cache_needed then
				l_command_output := command_output
				if l_command_output = Void then
					create command_output.make (2048)
					l_command_output := command_output
				else
					l_command_output.wipe_out
				end
			end
			if l_error_cache_needed then
				l_command_error := command_output
				if l_command_error = Void then
					create command_error.make (2048)
					l_command_error := command_error
				else
					l_command_error.wipe_out
				end
			end

				-- Test platform, for Windows, we disable the console window.
			if {PLATFORM}.is_windows then
				l_launcher.set_separate_console (False)
				l_launcher.set_hidden (True)
			end

				-- Launch process.
			l_launcher.launch
			if l_launcher.launched then
				if not is_input_as_file then
					l_launcher.put_string (l_input)
				end
				from
					if criterion /= Void then
						l_generator := criterion.used_in_domain_generator
					end
				until
					l_launcher.has_exited
				loop
					if l_generator /= Void then
						l_generator.tick_actions.call ([a_item])
					end
				end
				l_fragments.do_all (agent (l_fragment: EB_TEXT_FRAGMENT) do l_fragment.safe_dispose_after_replacement end)

				Result := True
					-- Compare process output result.
				if l_output_cache_needed then
					if is_output_as_file then
						l_content := file_content (l_output)
					else
						l_content := l_output
					end
					Result := l_content.is_equal (command_output)
				end
					-- Compare process error result.				
				if Result and then l_error_cache_needed then
					if is_error_as_file then
						l_content := file_content (l_error)
					else
						l_content := l_error
					end
					Result := l_content.is_equal (command_error)
				end
				if Result and then is_exit_code_enabled then
					Result := exit_code = l_launcher.exit_code
				end
			end
		rescue
			if l_launcher.launched and then not l_launcher.has_exited then
				l_launcher.terminate_tree
				l_launcher.wait_for_exit
			end
			l_fragments.do_all (agent (l_fragment: EB_TEXT_FRAGMENT) do l_fragment.safe_dispose_after_replacement end)
		end

feature{NONE} -- Implementation

	file_content (a_file: STRING): STRING is
			-- Content of file `a_file'
		require
			a_file_attached: a_file /= Void
		local
			l_file: RAW_FILE
			l_file_name: STRING
		do
			l_file_name := a_file.twin
			remove_new_line_characters (l_file_name)
			create l_file.make_open_read (l_file_name)
			l_file.read_stream (l_file.count)
			Result := l_file.last_string.twin
		rescue
			if l_file /= Void and then l_file.is_open_read then
				l_file.close
			end
		end

	on_output_from_process (a_output: STRING; a_record: BOOLEAN) is
			-- Action to be performed when `a_output' comes from launched process
			-- If `a_record' is True, store `a_output' otherwise throw it away.
		require
			a_output_attached: a_output /= Void
		do
			if a_record then
				command_output.append (a_output)
			end
		end

	on_error_from_process (a_error: STRING; a_record: BOOLEAN) is
			-- Action to be performed when `a_error' comes from launched process
			-- If `a_record' is True, store `a_error' otherwise throw it away.
		require
			a_error_attached: a_error /= Void
		do
			if a_record then
				command_error.append (a_error)
			end
		end

	replaced_text (a_text: STRING; a_replacer: EB_TEXT_REPLACER; a_fragment_list: LIST [EB_TEXT_FRAGMENT]): STRING is
			-- Return replaced text (using `a_replacer') from `a_text', and store found text fragments into `a_fragment_list'.
		require
			a_text_attached: a_text /= Void
			a_replacer_attached: a_replacer /= Void
			a_fragment_list_attached: a_fragment_list /= Void
		local
			l_frags: LIST [EB_TEXT_FRAGMENT]
		do
			l_frags := text_fragments_from_text (a_text)
			a_fragment_list.append (l_frags)

			a_replacer.text_fragments.wipe_out
			a_replacer.text_fragments.append (l_frags)
			a_replacer.prepare_replacement
			Result := a_replacer.new_text (a_text)
		ensure
			result_attached: Result /= Void
		end

	text_fragments_from_text (a_text: STRING): LIST [EB_TEXT_FRAGMENT] is
			-- Text fragments from `a_text'
		require
			a_text_attached: a_text /= Void
		local
			l_scanner: like command_scanner
		do
			l_scanner := command_scanner
			l_scanner.reset
			l_scanner.wipe_text_fragments
			l_scanner.set_input_buffer (create {YY_BUFFER}.make (a_text))
			l_scanner.scan
			Result := l_scanner.text_fragments.twin
		ensure
			result_attached: Result /= Void
		end

	fragment_factory: EB_METRIC_COMMAND_FRAGMENT_FACTORY is
			-- Fractory go generate fragments
		do
			if fragment_factory_internal = Void then
				create fragment_factory_internal
			end
			Result := fragment_factory_internal
		ensure
			result_attached: Result /= Void
		end

	fragment_factory_internal: like fragment_factory
			-- Implementation of `fragment_factory'

	command_scanner: EB_COMMAND_SCANNER is
			-- Scanner to scanner `command'
		do
			if command_scanner_internal = Void then
				create command_scanner_internal.make (fragment_factory, create {YY_BUFFER}.make (""))
			end
			Result := command_scanner_internal
		ensure
			result_attached: Result /= Void
		end

	command_scanner_internal: like command_scanner
			-- Implementation of `command_scanner'

	command_output: STRING
			-- Output from launched `command'

	command_error: STRING
			-- Error from launched `command'

feature -- Process

	process (a_visitor: EB_METRIC_VISITOR) is
			-- Process current using `a_visitor'.
		do
			a_visitor.process_external_command_tester (Current)
		end

feature{NONE} -- Implementation

	remove_new_line_characters (a_string: STRING) is
			-- Remove new line characters in `a_string'.
		require
			a_string_attached: a_string /= Void
		do
			a_string.replace_substring_all ("%N", "")
			a_string.replace_substring_all ("%R", "")
		end

invariant
	command_attached: command /= Void
	input_attached: input /= Void
	output_attached: output /= Void
	error_attached: error /= Void

end


