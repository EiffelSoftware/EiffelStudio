indexing
	description: "An Eiffel system execution"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	keywords: "Eiffel test"
	date: "93/08/30"

class EW_SYSTEM_EXECUTION

inherit
	EW_EWEASEL_PROCESS
		rename
			make as process_make
		end

create
	make

feature

	make (prog: STRING; args: LINKED_LIST [STRING]; execute_cmd, dir, inf, outf, savef: STRING) is
			-- Start a new process to execute `prog' with
			-- arguments `args' using execution command
			-- `execute_cmd' in directory `dir'.
			-- `inf' is the input file to be fed into the
			-- new process (void to set up pipe).
			-- `outf' is the file where new process is
			-- write its output (void to set up pipe).
			-- Write all output from the new process to
			-- file `savef'.
		require
			program_not_void: prog /= Void
			arguments_not_void: args /= Void
			directory_not_void: dir /= Void
			save_name_not_void: savef /= Void
		local
			real_args: LINKED_LIST [STRING]
		do
			create real_args.make
			real_args.extend ("/c ")
			real_args.extend (execute_cmd)
			real_args.extend (dir)
			real_args.extend (prog)
			real_args.finish
			real_args.merge_right (args)
			process_make (Shell_command, real_args, inf, outf, savef)
		end

	next_execution_result: EW_EXECUTION_RESULT is
		local
			time_to_stop: BOOLEAN
		do
			create Result
			from
				read_line
			until
				end_of_file or time_to_stop
			loop
				savefile.put_string (last_string)
				savefile.flush
				Result.update (last_string)
				if suspended then
					time_to_stop := True
				else
					read_line
				end
			end
			if end_of_file then
				terminate
			end
		end

feature {NONE} -- Constant strings

	Shell_command: STRING is
			-- Path to shell command on Windows.
		once
			Result := (create {EXECUTION_ENVIRONMENT}).get ("COMSPEC")
			if Result = Void then
					-- If not defined use the Windows NT/2k/XP command line tool
					-- which should be in the path of the user.
				Result := "cmd.exe"
			end
		ensure
			shell_command_not_void: Result /= Void
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
