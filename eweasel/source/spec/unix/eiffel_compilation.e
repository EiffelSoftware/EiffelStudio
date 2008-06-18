indexing
	description: "An Eiffel compilation"
	legal: "See notice at end of class."
	status: "See notice at end of class.";
	keywords: "Eiffel test";
	date: "93/08/30"

class EIFFEL_COMPILATION

inherit
	EWEASEL_PROCESS
		rename
			make as process_make
		redefine
			terminate, read_line
		end;
	
	EIFFEL_COMPILER_CONSTANTS;
	
create
	make

feature

	make (cmd: STRING; args: LIST [STRING]; save: STRING) is
			-- Start a new Eiffel compilation process to
			-- run command `cmd' with arguments `args'.
			-- Write all output from the new process to
			-- file `save'.
		require
			command_not_void: cmd /= Void;
			arguments_not_void: args /= Void;
			save_name_not_void: save /= Void;
		do
			process_make (cmd, args, Void, Void, save);
		ensure
			input_file_available: input /= Void;
			output_file_available: output /= Void;
		end;

	next_compile_result: EIFFEL_COMPILATION_RESULT is
		local
			time_to_stop: BOOLEAN;
		do
			create Result;
			from
				read_line;
			until
				end_of_file or time_to_stop
			loop
				savefile.put_string (last_string);
				savefile.new_line;
				savefile.flush;
				Result.update (last_string);
				if suspended then
					time_to_stop := True;
				else
					read_line;
				end
			end;
			if end_of_file then
				terminate;
			end;
		end;

	resume is
			-- Resume compilation
		do
			put_string ("%N");
			output.flush;
			suspended := False;
		end;

	quit is
			-- Quit compilation
		do
			put_string (quit_reply);
			output.flush;
			suspended := False;
		end;

	terminate is
			-- Terminate Eiffel compilation
		local
			e: EIFFEL_COMPILATION_RESULT
		do
			if suspended then
				quit;
				e := next_compile_result;
					-- Discard any pending compile result
			end;
			Precursor {EWEASEL_PROCESS}
		end;

	
feature {NONE} -- Implementation

	read_line is
			-- Read next line from `input' and make
			-- available in `last_string'.  Set `end_of_file'
			-- if no more lines available.
		local
			in_progress, is_suspend_prompt: BOOLEAN;
			is_resume_prompt, is_missing_precomp: BOOLEAN
			line: STRING;
			count: INTEGER;
			last_char: CHARACTER;
		do
			if not in_progress then
				from
					create line.make (80);
					last_char := '%U';
				until
					(last_char = '%N') or else input.end_of_file or else is_suspend_prompt
				loop
					input.read_character;
					if not input.end_of_file then
						last_char := input.last_character;
						debug
							io.put_character (last_char);
							io.output.flush;
						end;
						line.extend (last_char);
						count := count + 1;
						is_resume_prompt := count = Resume_prompt.count and then equal (line, Resume_prompt)
						is_missing_precomp := count = Missing_precompile_prompt.count and then equal (line, Missing_precompile_prompt)
						is_suspend_prompt := is_resume_prompt or is_missing_precomp
					end
				end;
			end;	
			if line /= Void and then line.count > 0 and then line.item (line.count) = '%N' then
				line.keep_head (line.count - 1);
			end;
			if input.end_of_file then
				end_of_file := True;
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
