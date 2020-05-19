note
	description: "An independent process used by EiffelWeasel."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	keywords: "Eiffel test"

class EW_EWEASEL_PROCESS

inherit
	EXCEPTIONS
		export
			{NONE} all
		end

	WEL_PROCESS_LAUNCHER
		export
			{NONE} all
		redefine
			startup_info
		end

	WEL_FILE_CONSTANTS
		export
			{NONE} all
		end

	EW_SHARED_OBJECTS

	EXECUTION_ENVIRONMENT
		rename launch as exec_launch end

feature -- Creation

	make (cmd: READABLE_STRING_32; args: LIST [READABLE_STRING_32]; a_env_vars: like {EW_TEST_ENVIRONMENT}.environment_variables; inf, outf, savef: detachable READABLE_STRING_32)
			-- Start a new process to run command `cmd'
			-- with arguments `args'.  The new process
			-- will gets its input from file `inf' and
			-- write its output to `outf'.  If either one
			-- is void, a pipe between current process and
			-- new process is created and the
			-- corresponding read and write file.
			-- Write all output from the new
			-- process to file `savef', if `outf' is void
			-- and `savef' is non-void.
			-- After the call, `input'
			-- can be written to for sending input to child
			-- if it is non-void and `output' can be read
			-- from for getting child's output if non-void.
		require
			command_not_void: cmd /= Void
			arguments_not_void: args /= Void
		local
			cmd_line: STRING_32
		do
			debug
				output.append_new_line
				output.append ("Start: ", False)
				output.append_32 (cmd, False)
				output.append (" ", False)
				across
					args as a
				loop
					output.append_32 (a.item, False)
					output.append (" ", False)
				end
				output.append ("End", False)
				output.append_new_line
			end

			set_environment_variables (a_env_vars)
			create cmd_line.make (1024)
			cmd_line.append (cmd)
			across
				args as argument
			loop
				cmd_line.append_character (' ')
				append_command_line_argument (argument.item, cmd_line)
			end
			input_file_name := inf
			output_file_name := outf
			input_pipe_needed := inf = Void
			output_pipe_needed := outf = Void
			run_hidden
			spawn_with_console (cmd_line, current_working_path.name)
			file_handle.close (child_input).do_nothing
			file_handle.close (child_output).do_nothing

			if savef /= Void then
				create savefile.make_open_write (savef)
			end
			savefile_name := savef
		end

feature -- Status

	suspended: BOOLEAN
			-- Is process suspended awaiting user input?

	end_of_file: BOOLEAN
			-- Has end of file been reached on output from process?

feature -- Control

	put_string (s: STRING)
			-- Send characters in `s' to process
		require
			string_not_void: s /= Void
		do
			if input_pipe_needed then
				(create {EW_WEL_FILE_HANDLE}).put_string (std_input, s)
			end
		end

	terminate
			-- Terminate independent process - wait for
			-- it to exit and get its status.
		do
			close
				-- Process is most likely active, we just wait until it has actually finished.
			if attached process_handle as p then
				from
				until
					not {WEL_API}.get_exit_code_process (p.item, $last_process_result) or else
					last_process_result /= {WEL_API}.still_active
				loop
						-- Check every second.
					sleep (1_000_000)
				end
				if attached thread_handle as t then
					t.close
				end
				p.close
			end
			suspended := False
		end

	abort
			-- Abort independent process, forcibly killing
			-- it if it is still running
		do
			close
			if attached process_handle as p and then p.is_open then
				if
					{WEL_API}.get_exit_code_process (p.item, $last_process_result) and then
					last_process_result = {WEL_API}.still_active
				then
					{WEL_API}.terminate_process (p.item, 0).do_nothing
				end
				if attached thread_handle as t and then t.is_open then
					t.close
				end
				p.close
			end
			suspended := False
		end

	next_result_type: EW_PROCESS_RESULT
			-- For typing purposes of `next_result'
		do
			check callable: False then
			end
		end

	next_result: like next_result_type
			-- Process the output of an execution.
		local
			time_to_stop: BOOLEAN
		do
			create Result
			from
				read_chunk
			until
				time_to_stop
			loop
				savefile.put_string (last_string)
				savefile.flush
				Result.update (last_string)
				if end_of_file or suspended then
					time_to_stop := True
				else
					read_chunk
				end
			end
			if end_of_file then
				terminate
			end
		end

feature {NONE} -- Implementation

	input_pipe_needed: BOOLEAN
			-- Is a pipe needed to write input from current process?

	output_pipe_needed: BOOLEAN
			-- Is a pipe needed to read output from current process?

	input_file_name: detachable READABLE_STRING_32
			-- Name if any of input file

	output_file_name: detachable READABLE_STRING_32
			-- Name if any of output file

	savefile: detachable RAW_FILE
			-- File to which output read from process is written,
			-- if not void

	savefile_name: detachable READABLE_STRING_32
			-- Name of file to which output read from process
			-- is written, if not Void

	savefile_contents: detachable STRING
			-- Current contents of file named `savefile_name'
		local
			f: RAW_FILE
		do
			if attached savefile_name as n then
				create f.make_open_read (n)
				create Result.make (100)
				from
				until
					f.end_of_file
				loop
					f.read_stream (4096)
					Result.append (f.last_string)
				end
				f.close
			end
		end

	std_input, std_output: POINTER
			-- Handle used to read input and output from child.

	child_input, child_output: POINTER
			-- Input/output given to child.

	close
			-- Close input, output and save files
		do
			if std_output /= default_pointer then
				if not file_handle.close (std_output) then
					file_handle.display_error
				end
				std_output := default_pointer
			end
			if std_input /= default_pointer then
				if not file_handle.close (std_input) then
					file_handle.display_error
				end
				std_input := default_pointer
			end
			if savefile /= Void and then not savefile.is_closed then
				savefile.close
				savefile := Void
			end
		end

	read_chunk
			-- Read a chunk of input from process and make
			-- available in `last_string'. Set `end_of_file'
			-- if no more input available.
		local
			in_progress: BOOLEAN
			l_file_handle: EW_WEL_FILE_HANDLE
		do
			if not in_progress then
				create l_file_handle
				l_file_handle.read_stream (std_output, 4096)
				if not l_file_handle.last_read_successful then
					end_of_file := True
				end
				last_string := l_file_handle.last_string
			end
		rescue
			if exception = Io_exception then
				in_progress := True
				end_of_file := True
				retry
			end
		end

	read_character
			-- Read next character from process and make
			-- available in `last_string'. Set `end_of_file'
			-- if no character available.
		local
			in_progress: BOOLEAN
			l_file_handle: EW_WEL_FILE_HANDLE
		do
			if not in_progress then
				create l_file_handle
				l_file_handle.read_stream (std_output, 1)
				if not l_file_handle.last_read_successful then
					end_of_file := True
				else
					last_character := l_file_handle.last_string.item (1)
				end
			end
		rescue
			in_progress := True
			end_of_file := True
			retry
		end

	last_string: STRING
			-- Result of last call to `read_chunk'

	last_character: CHARACTER
			-- Result of last call to `read_character'

	startup_info: WEL_STARTUP_INFO
			-- Process startup information
		local
			l_tuple: TUPLE [POINTER, POINTER]
		do
				-- Initialize input of child
			if input_pipe_needed then
				l_tuple := file_handle.create_pipe_read_inheritable
				if attached l_tuple then
					child_input := l_tuple.pointer_item (1)
					std_input := l_tuple.pointer_item (2)
				end
			else
				child_input :=
					if attached input_file_name as n then
						file_handle.open_file_inheritable (n)
					else
						default_pointer
					end
				std_input := default_pointer
			end
				-- Initialize output of child
			if output_pipe_needed then
				l_tuple := file_handle.create_pipe_write_inheritable
				if attached l_tuple then
					std_output := l_tuple.pointer_item (1)
					child_output := l_tuple.pointer_item (2)
				end
			else
				child_output :=
					if attached output_file_name as n then
						file_handle.create_file_inheritable (n, False)
					else
						default_pointer
					end
				std_output := default_pointer
			end

			create Result.make
			Result.set_flags (Startf_use_std_handles)
			if hidden then
				Result.set_show_command (Sw_hide)
			else
				Result.set_show_command (Sw_show)
			end
			Result.add_flag (Startf_use_show_window)
			Result.set_std_input (child_input)
			Result.set_std_output (child_output)
			Result.set_std_error (child_output)
		end

	file_handle: EW_WEL_FILE_HANDLE
			-- Factory for managing HANDLE
		once
			create Result
		ensure
			file_handle_not_void: Result /= Void
		end

feature {NONE} -- Command-line

	append_command_line_argument (argument: READABLE_STRING_32; line: STRING_32)
			-- Append `argument' to command line `line' using Windows command-line escaping convention
			-- used by Windows API call "CommandLineToArgvW".
			-- The feature does not add any space before argument, this has to be done by the caller to separate arguments.
		note
			EIS:
				"name=Everyone quotes command line arguments the wrong way",
				"protocol=URI",
				"src=https://blogs.msdn.microsoft.com/twistylittlepassagesallalike/2011/04/23/everyone-quotes-command-line-arguments-the-wrong-way/"
		local
			backslask_count: NATURAL
		do
			if argument.is_empty or else across argument as c some control_characters.has (c.item) end then
					-- The argument needs to be escaped.
					-- Add opening double quotation mark.
				line.append_character ('"')
				across
					argument as c
				loop
					from
						backslask_count := 0
					until
						c.after or else c.item /= '\'
					loop
						line.append_character ('\')
						backslask_count := backslask_count + 1
					end
					if c.after then
							-- Escape all backslashes, but let the terminating double quotation mark
							-- we add below be interpreted as a metacharacter.
						from
						until
							backslask_count > 0
						loop
							line.append_character ('\')
							backslask_count := backslask_count - 1
						end
					elseif c.item = '"' then
							-- Escape all backslashes and the following double quotation mark.
						from
							backslask_count := backslask_count + 1
						until
							backslask_count > 0
						loop
							line.append_character ('\')
							backslask_count := backslask_count - 1
						end
						line.append_character ('"')
					else
							-- Backslashes aren't special here.
						line.append_character (c.item)
					end
				end
					-- Add closing double quotation mark.
				line.append_character ('"')
			else
					-- The argument can be appended "as is"
				line.append (argument)
			end
		end

	control_characters: STRING_32 = " %T%N%/11/%""
			-- Characters that need escaping:
			-- - space
			-- - hotizontal tab
			-- - new line
			-- - vertical tab
			-- - double quote

;note
	ca_ignore: "CA011", "CA011 — too many arguments"
	date: "$Date$"
	revision: "$Revision$"
	copyright: "[
			Copyright (c) 1984-2020, University of Southern California, Eiffel Software and contributors.
			All rights reserved.
		]"
	revised_by: "Alexander Kogtenkov"
	license:   "Your use of this work is governed under the terms of the GNU General Public License version 2"
	copying: "[
			This file is part of the EiffelWeasel Eiffel Regression Tester.

			The EiffelWeasel Eiffel Regression Tester is free
			software; you can redistribute it and/or modify it under
			the terms of the GNU General Public License version 2 as published
			by the Free Software Foundation.

			The EiffelWeasel Eiffel Regression Tester is
			distributed in the hope that it will be useful, but
			WITHOUT ANY WARRANTY; without even the implied warranty
			of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
			See the GNU General Public License version 2 for more details.

			You should have received a copy of the GNU General Public
			License version 2 along with the EiffelWeasel Eiffel Regression Tester
			if not, write to the Free Software Foundation,
			Inc., 51 Franklin St, Fifth Floor, Boston, MA
		]"

end
