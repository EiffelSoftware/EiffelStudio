note
	description: "An Eiffel compilation"
	legal: "See notice at end of class."
	status: "See notice at end of class.";
	keywords: "Eiffel test";
	date: "93/08/30"

class EW_EIFFEL_COMPILATION

inherit
	EW_EWEASEL_PROCESS
		rename
			make as process_make,
			next_result as next_compile_result,
			next_result_type as next_compile_result_type
		redefine
			terminate, read_chunk, abort,
			next_compile_result,
			next_compile_result_type
		end;

	EW_EIFFEL_COMPILER_CONSTANTS;

create
	make

feature

	make (cmd: STRING; args: LIST [STRING]; env_vars: HASH_TABLE [STRING, STRING]; save: STRING)
			-- Start a new Eiffel compilation process to
			-- run command `cmd' with arguments `args'.
			-- Write all output from the new process to
			-- file `save'.
		require
			command_not_void: cmd /= Void;
			arguments_not_void: args /= Void;
			save_name_not_void: save /= Void;
		do
			process_make (cmd, args, env_vars, Void, Void, save);
		end;

	next_compile_result_type: EW_EIFFEL_COMPILATION_RESULT
			-- <Precursor>
		do
			check callable: False then
			end
		end

	next_compile_result: like next_compile_result_type
			-- <Precursor>
		do
			Result := Precursor
			if not Result.is_status_known then
					-- Save raw compiler output so it can
					-- be displayed
				Result.set_raw_compiler_output (savefile_contents)
			end
		end

	resume
			-- Resume compilation
		do
			put_string ("%N");
			suspended := False;
		end;

	quit
			-- Quit compilation
		do
			put_string (quit_reply);
			suspended := False;
		end;

	abort
			-- <Precursor>
		local
			e: EW_EIFFEL_COMPILATION_RESULT
		do
				-- Because windows does not seem to remove the lock on files owned by a killed
				-- process immediately after the process is killed, we have to redefine abort
				-- to cancel the Eiffel compilation before trying to kill it.
				-- This allows the removal of the test directory for eweasel test#valid012 for
				-- example.			
			if suspended then
				quit
					-- Discard any pending compile result
				e := next_compile_result
			end
			Precursor {EW_EWEASEL_PROCESS}
		end

	terminate
			-- <Precursor>
		local
			e: EW_EIFFEL_COMPILATION_RESULT
		do
			if suspended then
				quit;
					-- Discard any pending compile result
				e := next_compile_result;
			end;
			Precursor {EW_EWEASEL_PROCESS}
		end;

feature {NONE} -- Implementation

	read_chunk
			-- <Precursor>
		local
			in_progress, is_suspend_prompt: BOOLEAN;
			is_resume_prompt, is_missing_precomp: BOOLEAN
			line: STRING;
			count: INTEGER;
			last_char: CHARACTER;
		do
			if not in_progress then
				from
					create line.make (128);
					last_char := '%U';
				until
					(last_char = '%N') or else end_of_file or else is_suspend_prompt
				loop
					read_character;
					if not end_of_file then
						last_char := last_character;
						debug
							io.put_character (last_char);
							io.output.flush;
						end;
							-- We ignore the Windows %R character when reading the output
							-- of the compiler (remember windows new lines are %R%N).
						if last_char /= '%R' then
							line.extend (last_char);
							count := count + 1;
							is_resume_prompt := count = Resume_prompt.count and then equal (line, Resume_prompt)
							is_missing_precomp := count = Missing_precompile_prompt.count and then equal (line, Missing_precompile_prompt)
							is_suspend_prompt := is_resume_prompt or is_missing_precomp
						end
					end
				end;
			end;
			if is_suspend_prompt then
				suspended := True;
				if is_resume_prompt then
					quit_reply := "q%N"
				else
					quit_reply := "n%N"
				end
			end;
			last_string := line;
		rescue
			if exception = Io_exception then
				in_progress := True;
				end_of_file := True;
				retry;
			end
		end;

	quit_reply: STRING;
			-- Reply to send to compiler to quit compilation

note
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
