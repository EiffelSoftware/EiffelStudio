indexing

	description:

		"Abstract IO Processor"

	copyright: "Copyright (c) 1999, Andreas Leitner and others"
	license: "Eiffel Forum License v2 (see forum.txt)"
	date: "$Date$"
	revision: "$Revision$"


deferred class DRC_IO_PROCESSOR

feature {NONE} -- Initialization

	make (a_input: like input;
			a_output: like output) is
			-- Create new processor with `a_input' as input source
			-- and `a_output' as output sink.
		require
			a_input_not_void: a_input /= Void
			a_input_is_open_read: a_input.is_open_read
			a_output_not_void: a_output /= Void
			a_output_is_open_write: a_output.is_open_write
		do
			input := a_input
			output := a_output
		end

	make_from_string (a_input, a_output: STRING) is
			-- Create new processor with `a_input' as input source
			-- and `a_output' as output sink.
		require
			a_input_not_void: a_input /= Void
			a_output_not_void: a_output /= Void
		do
			create {KL_STRING_INPUT_STREAM} input.make (a_input)
			create {KL_STRING_OUTPUT_STREAM} output.make (a_output)
		end

feature

	input: KI_TEXT_INPUT_STREAM
			-- Input source for `process'

	output: KI_TEXT_OUTPUT_STREAM
			-- Output sink for `process'

feature

	run_process is
			-- Run `process'.
		local
			out_file: ABSTRACT_FILE_DESCRIPTOR
		do
			create_process
			process.execute

			from
			until
				input.end_of_input
			loop
				input.read_line
				process.fd_stdin.put_string (input.last_string)
			end
			process.fd_stdin.flush
			process.fd_stdin.close

			if process.fd_stderr /= Void then
				out_file := process.fd_stderr
			else
				out_file := process.fd_stdout
			end

			from
				out_file.read_string (512)
			until
				out_file.eof
			loop
				output.put_string (out_file.last_string)
				out_file.read_string (512)
			end
			process.wait_for (True)
		end

feature {NONE}

	process: EPX_EXEC_PROCESS
			-- Process that will be executed, read from `input' and write
			-- to `output'.

	create_process is
			-- Redefine in descendant to create desired process.
		deferred
		ensure
			process_not_void: process /= Void
			stdout_or_stderr_not_void: (process.fd_stdout /= Void) = (process.fd_stderr /= Void)
		end

invariant

	input_not_void: input /= Void
	input_is_open_read: input.is_open_read
	output_not_void: output /= Void
	output_is_open_write: output.is_open_write

end
