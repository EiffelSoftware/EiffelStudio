indexing
	description: "An independent process used by EiffelWeasel"
	legal: "See notice at end of class."
	status: "See notice at end of class.";
	keywords: "Eiffel test";
	date: "October 14, 1997"

class EWEASEL_PROCESS

inherit
	EXCEPTIONS
		export
			{NONE} all
		end;
	EXCEP_CONST
		export
			{NONE} all
		end;
	UNIX_OS_ACCESS

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
			command_not_void: cmd /= Void;
			arguments_not_void: args /= Void;
		local
			arg_array: ARRAY [STRING]
			k, count: INTEGER
		do
			debug
				io.putstring ("%NStart: " );
				io.putstring (cmd); io.putchar (' ');
				from
					args.start;
				until
					args.after
				loop
					io.putstring (args.item); io.putchar (' ');
					args.forth;
				end
				io.putstring ("End%N" );
			end;
			
			count := args.count
			create arg_array.make (1, count)
			from
				args.start
				k := 1
			until
				args.after
			loop
				arg_array.put (args.item, k)
				args.forth
				k := k + 1
			end
			create child_process.make (cmd);
			child_process.set_arguments (arg_array);
			child_process.set_close_nonstandard_files (True);
			if inf = Void then
				child_process.set_input_piped
			else
				child_process.set_input_file_name (inf)
			end
			if outf = Void then
				child_process.set_output_piped
				child_process.set_error_same_as_output
			else
				child_process.set_output_file_name (outf)
				child_process.set_error_same_as_output
			end
			child_process.spawn_nowait
			if child_process.output_piped then
				input := child_process.output_from_child
			else
				input := Void
			end
			if child_process.input_piped then
				output := child_process.input_to_child
			else
				output := Void
			end
			if savef /= Void then
				create savefile.make_open_write (savef);
			end
		end;

feature -- Status
	
	suspended: BOOLEAN;
			-- Is process suspended awaiting user input?

	end_of_file: BOOLEAN;
			-- Has end of file been reached on output from process?

	
feature -- Control
	
	put_string (s: STRING) is
			-- Send characters in `s' to process
		require
			string_not_void: s /= Void;
		do
			output.put_string (s);
			output.flush;
		end;

	terminate is
			-- Terminate independent process
		do
			close;
			if child_process /= Void then
				try_to_terminate;
				child_process.get_status_block;
				child_process := Void;
				suspended := False;
			end;
		end;

feature {NONE} -- Implementation

	child_process: UNIX_PROCESS;
			-- Child process
			
	input: RAW_FILE;
			-- File for reading from process, if not void
			
	output: RAW_FILE;
			-- File for writing to process, if not void
	
	savefile: RAW_FILE;
			-- File to which output read from process is written, 
			-- if not void

	close is
			-- Close input, output and save files
		do
			if input /= Void and then not input.is_closed then
				input.close;
			end;
			if output /= Void and then not output.is_closed then
				output.close;
			end;
			if savefile /= Void and then not savefile.is_closed then
				savefile.close;
			end
		end;


	try_to_terminate is
			-- Try to terminate independent process, ignoring
			-- any errors since process may not be there
		local
			tried: BOOLEAN
		do
			if not tried then
				child_process.terminate_hard;
			end
		rescue
			tried := True
			retry
		end;

	read_line is
			-- Read next line from process and make
			-- available in `last_string'.  Set `end_of_file'
			-- if no more lines available.
		require
			input_file_available: input /= Void;
		local
			in_progress: BOOLEAN;
		do
			if not in_progress then
				input.read_line_thread_aware
				if input.end_of_file then
					end_of_file := True;
				end;
				last_string := input.last_string;
			end
		rescue
			if exception = Io_exception then
				in_progress := True;
				end_of_file := True;
				retry;
			end
		end;

	last_string: STRING;
			-- Result of last call to `read_line'
	
	Invalid_file_descriptor: INTEGER is -1;
			-- File descriptor which is not valid
	
invariant
	bad_file_desc_not_valid: 
		not unix_os.valid_file_descriptor (Invalid_file_descriptor);

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
