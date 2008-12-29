note
	description: "[
		Objects that launch an instance of {PROCESS} and redirect in- and output in a thread safe manner.
	]"
	author: ""
	date: "$Date$"
	revision: "$Revision$"

frozen class
	EQA_SYSTEM_EXECUTION_PROCESS

create {EQA_SYSTEM_EXECUTION}
	make

feature {NONE} -- Initialization

	make (a_outproc, a_errproc: like output_processor; a_outfile, a_errfile, a_infile: like output_file)
			-- Initialize `Current'.
			--
			-- `a_outproc': Processor analysing output, can be Void if output should not be analysed.
			-- `a_errproc': Processor analysing errors, can be Void if errors should not be analysed.
			-- `a_outfile': File to which output will be printed, can be Void if output should not be stored
			-- `a_errfile': File to which errors will be printed, can be Void if errors should not be stored
			-- `a_infile': File from which input will be read, Void if input is not read from a file
		require
			output_file_valid: a_outfile /= Void implies a_outfile.is_open_write
			error_file_valid: a_errfile /= Void implies a_errfile.is_open_write
			input_file_valid: a_infile /= Void implies a_infile.is_open_read
		do
			create mutex.make
			create client_condition.make
			create provider_condition.make
			output_processor := a_outproc
			error_processor := a_errproc
			output_file := a_outfile
			error_file := a_errfile
			input_file := a_infile
		ensure
			output_processor_set: output_processor = a_outproc
			error_processor_set: error_processor = a_errproc
			output_file_set: output_file = a_outfile
			error_file_set: error_file = a_errfile
			input_file_set: input_file = a_infile
		end

feature {EQA_SYSTEM_EXECUTION}

	last_exit_code: INTEGER
			-- Exit code last returned by `process'

feature {NONE} -- Access

	process: ?PROCESS
			-- Actual process instance

feature {NONE} -- Access: threading

	mutex: !MUTEX
			-- Mutex for controlling access to `Current'

	client_condition: !CONDITION_VARIABLE
			-- Condition variable for signalling that new output is available

	provider_condition: !CONDITION_VARIABLE
			-- Condition valiablefor signalling that `Current' is waiting for new output

	next_output: ?READABLE_STRING_8
			-- Output to be processed next

feature {NONE} -- Access: io redirection

	output_processor: ?EQA_SYSTEM_OUTPUT_PROCESSOR
			-- Processor analysing output, Void if output should not be analysed

	error_processor: ?EQA_SYSTEM_OUTPUT_PROCESSOR
			-- Processor analysing errors, Void if errors should not be analysed

	output_file: ?FILE
			-- File to which output will be printed, Void if output should not be stored

	error_file: ?FILE
			-- File to which errors will be printed, Void if errors should not be stored

	input_file: ?FILE
			-- File from which input will be read, Void if input is not read from a file

feature {EQA_SYSTEM_EXECUTION} -- Status report

	is_launched: BOOLEAN
			-- Has `Current' been launched yet?

	has_exited: BOOLEAN
			-- Has `process' exited yet?
		require
			launched: is_launched
		do
			Result := process = Void
		end

feature {NONE} -- Status report

	is_next_error: BOOLEAN
			-- Does `next_output' represent a error message?

	is_finished: BOOLEAN
			-- Has process terminated?

feature {EQA_SYSTEM_EXECUTION} -- Status setting

	launch (a_exec: !READABLE_STRING_8; a_arg_list: !LIST [!STRING]; a_dir: !READABLE_STRING_8)
		require
			not_launched: not is_launched
		local
			l_factory: PROCESS_FACTORY
			l_process: like process
		do
			is_launched := True
			create l_factory
			l_process := l_factory.process_launcher (a_exec, a_arg_list, a_dir)
			l_process.enable_launch_in_new_process_group
			l_process.set_separate_console (False)
			l_process.set_hidden (True)
			check l_process /= Void end
			prepare_redirection (l_process)
			l_process.set_on_terminate_handler (agent set_finished)
			l_process.set_on_exit_handler (agent set_finished)
			l_process.launch
			process := l_process
		end

feature {NONE} -- Status setting

	set_finished
			-- Set `is_finished' to True and notify any threads waiting.
		do
			mutex.lock
			is_finished := True
			client_condition.broadcast
			mutex.unlock
		end

feature {EQA_SYSTEM_EXECUTION} -- Basic operations

	redirect_input (a_input: !READABLE_STRING_8)
			-- Send input to `process'.
			--
			-- `a_input': Input to be sent to process
			--
			-- Note: this routine has preconditions since it is only meant to be called from the main thread
		require
			launched: is_launched
			not_exited: not has_exited
		local
			l_input: STRING
		do
			mutex.lock
			if not is_finished then
				create l_input.make_from_string (a_input)
				process.put_string (l_input)
			end
			mutex.unlock
		end

	redirect_output
			-- Redirect any output received from `process' to the corresponding file and output processor.
			--
			-- Note: this routine has preconditions since it is only meant to be called from the main thread
		require
			launched: is_launched
			not_exited: not has_exited
		local
			l_output: like next_output
			l_processor: like output_processor
			l_file: like output_file
		do
			mutex.lock
			if next_output = Void and not is_finished then
				client_condition.wait (mutex)
			end
			l_output := next_output
			if l_output /= Void then
				if is_next_error then
					l_processor := error_processor
					l_file := error_file
				else
					l_processor := output_processor
					l_file := output_file
				end
					-- We can assume that `l_processor' is attached, since otherwise the output would have been
					-- redirected to the file directly.
				check
					l_processor /= Void
				end
				l_processor.append_output (l_output)

					-- The file can be Void, if the output was only redirected to a processor
				if l_file /= Void and then l_file.extendible then
					l_file.put_string (l_output)
				end
			end
			next_output := Void
			if is_finished then
				cleanup_redirection
				last_exit_code := process.exit_code
				process := Void
			end
			provider_condition.signal
			mutex.unlock
		end

feature {NONE} -- Basic operations

	append_output (a_output: !STRING; a_is_error: BOOLEAN)
			-- Set next output to be processed.
			--
			-- `a_output': Output retrieved from `process'.
			-- `a_is_error': Indicated whether `a_output' represents an error message from `process'.
			--
			-- Note: although `append_output' is thread safe, it is not meant to be called simultaneously
			--       for the same type of output. Otherwise it can not be guaranteed that the output wil be
			--       redirected in the same order it was retrieved from the system.
		do
			mutex.lock
			if next_output /= Void then
				provider_condition.wait (mutex)
			end
			if not is_finished then
				next_output := a_output.twin
				is_next_error := a_is_error
				client_condition.signal
			end
			mutex.unlock
		end

	prepare_redirection (a_process: !like process)
			-- Prepare redirection for `a_process'.
		local
			l_output_proc, l_error_proc: like output_processor
			l_output_file, l_error_file, l_input_file: like output_file
		do
			l_output_proc := output_processor
			l_output_file := output_file
			if l_output_proc /= Void then
				a_process.redirect_output_to_agent (agent append_output (?, False))
			elseif l_output_file /= Void then
				if not l_output_file.is_closed then
					l_output_file.close
				end
				a_process.redirect_output_to_file (l_output_file.name)
			end
			l_error_proc := error_processor
			l_error_file := error_file
			if l_error_proc /= Void then
				a_process.redirect_error_to_agent (agent append_output (?, True))
			elseif l_error_file /= Void then
				if not l_error_file.is_closed then
					l_error_file.close
				end
				a_process.redirect_error_to_file (l_error_file.name)
			end
			l_input_file := input_file
			if l_input_file /= Void then
				if not l_input_file.is_closed then
					l_input_file.close
				end
				a_process.redirect_input_to_file (l_input_file.name)
			end
		end

	cleanup_redirection
			-- Flush buffers which potentially contain redirected output and close any remaining open files.
		require
			launched: is_launched
			not_exited: not has_exited
			finished: is_finished
		local
			l_output_proc, l_error_proc: like output_processor
			l_output_file, l_error_file: like output_file
		do
			l_output_proc := output_processor
			if l_output_proc /= Void then
				l_output_proc.flush_buffer
			end
			l_error_proc := error_processor
			if l_error_proc /= Void then
				l_error_proc.flush_buffer
			end
			l_output_file := output_file
			if l_output_file /= Void and then not l_output_file.is_closed then
				l_output_file.flush
				l_output_file.close
			end
			l_error_file := error_file
			if l_error_file /= Void and then not l_error_file.is_closed then
				l_error_file.flush
				l_error_file.close
			end
		end

end
