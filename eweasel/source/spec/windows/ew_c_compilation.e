indexing
	description: "A C compilation"
	legal: "See notice at end of class."
	status: "See notice at end of class.";
	keywords: "Eiffel test";
	date: "93/08/30"

class EW_C_COMPILATION

inherit
	EW_EWEASEL_PROCESS
		rename
			make as process_make
		end;

create
	make

feature

	make (dir, save, freeze_cmd: STRING max_procs: INTEGER) is
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
		do
			create args.make
			args.extend ("-location")
			args.extend (dir)
			args.extend ("-silent")
			if max_procs > 0 then
				args.extend ("-nproc");
				args.extend (max_procs.out);
			end
			process_make (freeze_cmd, args, Void, Void, save);
		end;

	next_compile_result: EW_C_COMPILATION_RESULT is
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
