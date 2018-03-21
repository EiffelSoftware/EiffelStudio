note
	legal: "See notice at end of class."
	status: "See notice at end of class."
	keywords: "Eiffel test"

deferred class EW_C_COMPILE_INST

inherit
	EW_TEST_INSTRUCTION
	EW_STRING_UTILITIES
	EW_PREDEFINED_VARIABLES
	EW_OS_ACCESS

feature

	inst_initialize (line: READABLE_STRING_32)
			-- Initialize instruction from `line'.  Set
			-- `init_ok' to indicate whether
			-- initialization was successful.
		local
			args: LIST [READABLE_STRING_32]
		do
			args := broken_into_words (line)
			if args.count > 1 then
				init_ok := False
				failure_explanation := {STRING_32} "must supply 0 or 1 argument"
			elseif args.count = 1 then
				output_file_name := args [1]
				init_ok := True
			else
				init_ok := True
			end
		end;

	execute (test: EW_EIFFEL_EWEASEL_TEST)
			-- Execute `Current' as one of the
			-- instructions of `test'.
			-- Set `execute_ok' to indicate whether successful.
		local
			dir, save: READABLE_STRING_32
			freeze_cmd: READABLE_STRING_32
			exec_error: like executable_file_error
			l_max_c_processes: INTEGER
			compilation: EW_C_COMPILATION;
		do
			freeze_cmd := test.environment.value (Freeze_command_name)
			exec_error := executable_file_error (freeze_cmd)
			if exec_error = Void then
				test.increment_c_compile_count
				dir := test.environment.value (compilation_dir_name)
				l_max_c_processes := test.environment.max_c_processes
				save := output_file_name
				if not attached save then
					save := test.c_compile_output_name
				end
				save := os.full_file_name (test.environment.value (Output_dir_name), save)
				create compilation.make (dir, save, freeze_cmd, test.environment.environment_variables, l_max_c_processes)
				test.set_c_compilation (compilation)
				test.set_c_compilation_result (compilation.next_compile_result)
				execute_ok := True
			else
				failure_explanation := exec_error
				execute_ok := False
			end
		end

feature -- Status

	init_ok: BOOLEAN
			-- Was last call to `initialize' successful?

	execute_ok: BOOLEAN
			-- Was last call to `execute' successful?

feature {NONE} -- Implementation

	output_file_name: READABLE_STRING_32
			-- Name of file where output from compile is
			-- to be placed

	compilation_dir_name: READABLE_STRING_32
			-- Name of directory where compilation is to be done
		deferred
		end

note
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
