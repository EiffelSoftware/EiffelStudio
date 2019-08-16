note
	description: "[
					Ancestor for all execution instructions
																								]"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	keywords: "Eiffel test"
	date: "$Date$"
	revision: "$Revision$"

deferred class
	EQA_EW_EXECUTE_INST

inherit
	EQA_EW_TEST_INSTRUCTION

feature {NONE} -- Initialization

	make (a_test_set: EQA_EW_SYSTEM_TEST_SET; a_line: STRING)
			-- Creation method
		do
			inst_initialize (a_test_set, a_line)
		end

	inst_initialize (a_test_set: EQA_EW_SYSTEM_TEST_SET; a_line: STRING)
			-- Initialize instruction from `a_line'.  Set
			-- `init_ok' to indicate whether
			-- initialization was successful.
		local
			l_args: LIST [STRING]
			l_arguments: like arguments
		do
			l_args := string_util.broken_into_words (a_line)
			if l_args.count < 2 then
				init_ok := False
				failure_explanation := "must have at least 2 arguments"
			else
				input_file_name := l_args.i_th (1)
				output_file_name := l_args.i_th (2)
				if equal (input_file_name, No_file_name) then
					input_file_name := Void
				end
				if equal (output_file_name, No_file_name) then
					output_file_name := Void
				end
				create l_arguments.make (l_args.count - 2)
				arguments := l_arguments
				from
					l_args.start
					l_args.forth
					l_args.forth
				until
					l_args.after
				loop
					l_arguments.extend (l_args.item)
					l_args.forth
				end
				init_ok := True
			end
			if not init_ok then
				print (failure_explanation)
				a_test_set.assert ("Invalid execute instruction", False)
			end
		end

feature -- Query

	init_ok: BOOLEAN
			-- Was last call to `initialize' successful?

	execute_ok: BOOLEAN
			-- Was last call to `execute' successful?

feature -- Command

	execute (a_test: EQA_EW_SYSTEM_TEST_SET)
			-- Execute `Current' as one of the
			-- instructions of `a_test'.
			-- Set `execute_ok' to indicate whether successful.
		local
			l_prog, l_exec_dir: STRING_32
			l_outfile, l_execute_cmd: READABLE_STRING_32
			l_exec_error: detachable READABLE_STRING_32
			l_file_system: EQA_FILE_SYSTEM
		do
			l_execute_cmd := a_test.environment.item_attached ({EQA_EW_PREDEFINED_VARIABLES}.Execute_command_name, a_test.asserter)
			l_execute_cmd := a_test.environment.substitute (l_execute_cmd)
			l_file_system := a_test.file_system
			l_exec_error := l_file_system.executable_file_exists (l_execute_cmd)
			if l_exec_error = Void then
				a_test.increment_execution_count
				l_exec_dir := l_file_system.build_path_from_key (execution_dir_name, Void)
				l_prog := a_test.file_system.build_path (l_exec_dir, << "test" >>)
				if attached output_file_name as l_output_file_name and then not l_output_file_name.is_empty then
					l_outfile := l_output_file_name
				else
					l_outfile := a_test.execution_output_name
				end

				l_exec_error := l_file_system.executable_file_exists (l_prog)
				if l_exec_error = Void then
					if attached arguments as l_arguments then
						execute_ok := True
						;(create {EQA_EW_SYSTEM_EXECUTION}.make (l_prog, l_arguments, l_execute_cmd, l_exec_dir, input_file_name, l_outfile, a_test)).do_nothing
					else
						failure_explanation := "No arguments provided"
						execute_ok := False
					end
				else
					failure_explanation := l_exec_error
					execute_ok := False
				end

			else
				failure_explanation := l_exec_error
				execute_ok := False
			end

			if not execute_ok then
				print (failure_explanation)
				a_test.assert ("Execution failure", execute_ok)
			end
		end

feature {NONE} -- Constants

	No_file_name: STRING = "NONE"
			-- Constant for no file name

feature {NONE} -- Implementation

	input_file_name: detachable STRING
			-- Name of input file

	output_file_name: detachable STRING
			-- Name of output file

	arguments: detachable ARRAYED_LIST [READABLE_STRING_32]
			-- Arguments

	execution_dir_name: STRING
			-- Name of directory where executable resides
		deferred
		end

;note
	copyright: "Copyright (c) 1984-2019, Eiffel Software and others"
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
