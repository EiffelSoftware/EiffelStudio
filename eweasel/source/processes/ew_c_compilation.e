note
	description: "A C compilation"
	legal: "See notice at end of class."
	status: "See notice at end of class.";
	keywords: "Eiffel test";
	date: "93/08/30"

class EW_C_COMPILATION

inherit
	EW_EWEASEL_PROCESS
		rename
			make as process_make,
			next_result as next_compile_result,
			next_result_type as next_compile_result_type
		redefine
			next_compile_result_type
		end

create
	make

feature

	make (dir, save, freeze_cmd: STRING env_vars: HASH_TABLE [STRING, STRING]; max_procs: INTEGER)
			-- Start a new process to do any necessary
			-- C compilations (freezing) in directory `dir',
			-- using at most `max_procs' simultaneous processes
			-- to do C compilations.
			-- Write all output from the new process to
			-- file `save'.
		require
			directory_not_void: dir /= Void;
			save_name_not_void: save /= Void;
		local
			args: LINKED_LIST [STRING];
			l_cmd: STRING
		do
			create args.make
			if {PLATFORM}.is_windows then
				args.extend ("-location")
				l_cmd := freeze_cmd
			else
				args.extend (freeze_cmd);
				l_cmd := shell_command
			end
			args.extend (dir);
			if max_procs > 0 then
				args.extend ("-nproc");
				args.extend (max_procs.out);
			end
			process_make (l_cmd, args, env_vars, Void, Void, save);
		end;

	next_compile_result_type: EW_C_COMPILATION_RESULT
			-- <Precursor>
		do
			check callable: False then
			end
		end

feature {NONE} -- Constant strings

	Shell_command: STRING = "/bin/sh";
			-- Unix way to start finish_freezing as it is a shell script.

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
