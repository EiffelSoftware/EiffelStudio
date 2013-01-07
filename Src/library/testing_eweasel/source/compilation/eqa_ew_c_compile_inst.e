note
	description: "[
					Ancestor for all C compilation instructions
																								]"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	keywords: "Eiffel test"
	date: "$Date$"
	revision: "$Revision$"

deferred class EQA_EW_C_COMPILE_INST

inherit
	EQA_EW_TEST_INSTRUCTION

feature {NONE} -- Initialization

	make (a_line: detachable STRING)
			-- Initialize instruction from `a_line'.  Set
			-- `init_ok' to indicate whether
			-- initialization was successful.
		local
			l_args: LIST [STRING]
			l_line: STRING
		do
			if attached a_line then
				l_line := a_line
			else
				create l_line.make_empty
			end
			l_args := string_util.broken_into_words (l_line)
			if l_args.count > 1 then
				init_ok := False
				failure_explanation := "must supply 0 or 1 argument"
			elseif l_args.count = 1 then
				output_file_name := l_args.i_th (1)
				init_ok := True
			else
				init_ok := True
			end
		end

feature -- Command

	execute (a_test: EQA_EW_SYSTEM_TEST_SET)
			-- Execute `Current' as one of the
			-- instructions of `a_test'.
			-- Set `execute_ok' to indicate whether successful.
		local
			l_save: STRING
			l_freeze_cmd, l_dir: detachable IMMUTABLE_STRING_32
			l_exec_error: detachable READABLE_STRING_32
			l_max_c_processes: INTEGER
			l_compilation: EQA_EW_C_COMPILATION
			l_file_system: EQA_FILE_SYSTEM
		do
			l_freeze_cmd := a_test.environment.item ({EQA_EW_PREDEFINED_VARIABLES}.Freeze_command_name)
			check attached l_freeze_cmd end -- Implied by environment values have been set before executing test cases
			l_freeze_cmd := a_test.environment.substitute_recursive (l_freeze_cmd)
			l_file_system := a_test.file_system
			if attached l_freeze_cmd as l_attached_freeze then
				l_exec_error := l_file_system.executable_file_exists (l_attached_freeze)
			else
				check False end -- l_freeze_cmd should not void
			end

			if l_exec_error = Void then
				a_test.increment_c_compile_count
				l_dir := a_test.environment.item (compilation_dir_name)
				check attached l_dir end -- Implied by environment values have been set before executing test cases
--				l_max_c_processes := a_test.environment.max_c_processes
				if attached output_file_name as l_output_file_name and then not l_output_file_name.is_empty then
					l_save := l_output_file_name
				else
					l_save := a_test.c_compile_output_name
				end
				if attached l_freeze_cmd as l_attached_freeze_2 then
					create l_compilation.make (l_dir, l_save, l_attached_freeze_2, l_max_c_processes, a_test)
					if attached l_compilation as l_attached_compilation then
						a_test.set_c_compilation (l_compilation)
					else
						check False end -- l_compilation should not void
					end
				else
					check False end -- l_freeze_cmd should not void
				end

				execute_ok := True
			else
				failure_explanation := l_exec_error
				execute_ok := False
			end

			if not execute_ok then
				print (failure_explanation)
				a_test.assert ("C compilation failure", False)
			end
		end

feature -- Status

	init_ok: BOOLEAN
			-- Was last call to `initialize' successful?

	execute_ok: BOOLEAN
			-- Was last call to `execute' successful?

feature {NONE} -- Implementation

	output_file_name: detachable STRING
			-- Name of file where output from compile is
			-- to be placed

	compilation_dir_name: STRING
			-- Name of directory where compilation is to be done
		deferred
		end

;note
	copyright: "Copyright (c) 1984-2009, Eiffel Software and others"
	license:   "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
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
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"


end
