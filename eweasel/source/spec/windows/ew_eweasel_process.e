indexing
	description: "An independent process used by EiffelWeasel"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	keywords: "Eiffel test"
	date: "October 14, 1997"

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

	make (cmd: STRING; args: LIST [STRING]; inf, outf, savef: STRING) is
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
			cmd_line: STRING
			k: INTEGER
			l_success: BOOLEAN
		do
			debug
				output.append_new_line
				output.append ("Start: ", False)
				output.append (cmd, False)
				output.append (" ", False)
				from
					args.start
				until
					args.after
				loop
					output.append (args.item, False)
					output.append (" ", False)
					args.forth
				end
				output.append ("End", False)
				output.append_new_line
			end

			create cmd_line.make (1024)
			cmd_line.append (cmd)
			cmd_line.append_character (' ')
			from
				args.start
				k := 1
			until
				args.after
			loop
				cmd_line.append (args.item)
				cmd_line.append_character (' ')
				args.forth
			end
			input_file_name := inf
			output_file_name := outf
			input_pipe_needed := inf = Void
			output_pipe_needed := outf = Void
			run_hidden
			spawn_with_console (cmd_line, current_working_directory)
			l_success := file_handle.close (child_input)
			l_success := file_handle.close (child_output)

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

	put_string (s: STRING) is
			-- Send characters in `s' to process
		require
			string_not_void: s /= Void
		local
			l_file_handle: EW_WEL_FILE_HANDLE
		do
			if input_pipe_needed then
				create l_file_handle
				l_file_handle.put_string (std_input, s)
			end
		end

	terminate is
			-- Terminate independent process - wait for
			-- it to exit and get its status
		local
			a_boolean: BOOLEAN
		do
			close
			a_boolean := cwin_exit_code_process (process_info.process_handle, $last_process_result)
			if a_boolean then
					-- Process is most likely active, we just wait until it has actually finished.
				from
				until
					last_process_result /= cwin_still_active or not a_boolean
				loop
					sleep (1000000)
					a_boolean := cwin_exit_code_process (process_info.process_handle, $last_process_result)
				end
				cwin_close_handle (process_info.thread_handle)
				cwin_close_handle (process_info.process_handle)
			end
			suspended := False
		end

	abort is
			-- Abort independent process, forcibly killing
			-- it if it is still running
		local
			a_boolean: BOOLEAN
			terminated: BOOLEAN
		do
			close
			a_boolean := cwin_exit_code_process (process_info.process_handle, $last_process_result)
			if a_boolean then
				if last_process_result = cwin_still_active then
					terminated := cwin_terminate_process (process_info.process_handle, 0)
				end
				cwin_close_handle (process_info.thread_handle)
				cwin_close_handle (process_info.process_handle)
			end
			suspended := False
		end

feature {NONE} -- Implementation

	input_pipe_needed: BOOLEAN
			-- Is a pipe needed to write input from current process?

	output_pipe_needed: BOOLEAN
			-- Is a pipe needed to read output from current process?

	input_file_name: STRING
			-- Name if any of input file

	output_file_name: STRING
			-- Name if any of output file

	savefile: RAW_FILE
			-- File to which output read from process is written,
			-- if not void

	savefile_name: STRING
			-- Name of file to which output read from process
			-- is written, if not Void

	savefile_contents: STRING
			-- Current contents of file named `savefile_name'
		local
			f: RAW_FILE
		do
			create f.make_open_read (savefile_name)
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

	std_input, std_output: POINTER
			-- Handle used to read input and output from child.

	child_input, child_output: POINTER
			-- Input/output given to child.

	close is
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

	read_line is
			-- Read next line from process and make
			-- available in `last_string'.  Set `end_of_file'
			-- if no more lines available.
		local
			in_progress: BOOLEAN
			l_file_handle: EW_WEL_FILE_HANDLE
		do
			if not in_progress then
				create l_file_handle
				l_file_handle.read_line (std_output)
				if not l_file_handle.last_read_successful then
					end_of_file := True
				else
					last_string := l_file_handle.last_string
				end
			end
		rescue
			if exception = Io_exception then
				in_progress := True
				end_of_file := True
				retry
			end
		end

	read_character is
			-- Read next line from process and make
			-- available in `last_string'.  Set `end_of_file'
			-- if no more lines available.
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
			-- Result of last call to `read_line'

	last_character: CHARACTER
			-- Result of last call to `read_character'

	startup_info: WEL_STARTUP_INFO is
			-- Process startup information
		local
			l_tuple: TUPLE [POINTER, POINTER]
		do
				-- Initialize input of child
			if input_pipe_needed then
				l_tuple := file_handle.create_pipe_read_inheritable
				child_input := l_tuple.pointer_item (1)
				std_input := l_tuple.pointer_item (2)
			else
				child_input := file_handle.open_file_inheritable (input_file_name)
				std_input := default_pointer
			end
				-- Initialize output of child
			if output_pipe_needed then
				l_tuple := file_handle.create_pipe_write_inheritable
				std_output := l_tuple.pointer_item (1)
				child_output := l_tuple.pointer_item (2)
			else
				child_output := file_handle.create_file_inheritable (output_file_name, False)
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

	file_handle: EW_WEL_FILE_HANDLE is
			-- Factory for managing HANDLE
		once
			create Result
		ensure
			file_handle_not_void: Result /= Void
		end

indexing
	copyright: "[
			Copyright (c) 1984-2007, University of Southern California and contributors.
			All rights reserved.
			]"
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
