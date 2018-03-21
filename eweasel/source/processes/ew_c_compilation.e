note
	description: "A C compilation"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	keywords: "Eiffel test"

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

feature {NONE} -- Creation

	make (dir, save, freeze_cmd: READABLE_STRING_32 env_vars: like {EW_TEST_ENVIRONMENT}.environment_variables; max_procs: INTEGER)
			-- Start a new process to do any necessary
			-- C compilations (freezing) in directory `dir',
			-- using at most `max_procs' simultaneous processes to do C compilations.
			-- Write all output from the new process to file `save'.
		require
			directory_not_void: dir /= Void
			save_name_not_void: save /= Void
		local
			args: LINKED_LIST [READABLE_STRING_32]
			l_cmd: READABLE_STRING_32
		do
			create args.make
			if {PLATFORM}.is_windows then
				args.extend ({STRING_32} "-location")
				l_cmd := freeze_cmd
			else
				args.extend (freeze_cmd)
				l_cmd := shell_command
			end
			args.extend (dir)
			if max_procs > 0 then
				args.extend ({STRING_32} "-nproc")
				args.extend (create {STRING_32}.make_from_string_general (max_procs.out))
			end
			process_make (l_cmd, args, env_vars, Void, Void, save)
		end

feature

	next_compile_result_type: EW_C_COMPILATION_RESULT
			-- <Precursor>
		do
			check callable: False then
			end
		end

feature {NONE} -- Constant strings

	Shell_command: STRING_32 = "/bin/sh"
			-- Unix way to start finish_freezing as it is a shell script.

;note
	ca_ignore: "CA011", "CA011 — too many arguments"
	date: "$Date$"
	revision: "$Revision$"
	copyright: "[
			Copyright (c) 1984-2018, University of Southern California, Eiffel Software and contributors.
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
