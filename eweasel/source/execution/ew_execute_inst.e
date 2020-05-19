note
	legal: "See notice at end of class."
	status: "See notice at end of class."
	keywords: "Eiffel test"

deferred class EW_EXECUTE_INST

inherit
	EW_TEST_INSTRUCTION
	EW_STRING_UTILITIES
	EW_PREDEFINED_VARIABLES
	EW_EIFFEL_TEST_CONSTANTS
	EW_OS_ACCESS

feature

	inst_initialize (line: READABLE_STRING_32)
			-- Initialize instruction from `line'.  Set
			-- `init_ok' to indicate whether
			-- initialization was successful.
		local
			args: LIST [READABLE_STRING_32]
			n: READABLE_STRING_32
		do
			args := broken_into_words (line)
			if args.count < 2 then
				init_ok := False
				failure_explanation := {STRING_32} "must have at least 2 arguments"
			else
				create arguments.make
				across
					args as a
				from
					n := a.item
					input_file_name := if n.same_string (No_file_name) then Void else n end
					a.forth
					n := a.item
					output_file_name := if n.same_string (No_file_name) then Void else n end
					a.forth
				loop
					arguments.extend (a.item)
				end
				init_ok := True
			end
		end

	execute (test: EW_EIFFEL_EWEASEL_TEST)
			-- Execute `Current' as one of the
			-- instructions of `test'.
			-- Set `execute_ok' to indicate whether successful.
		local
			exec_dir, infile, outfile, savefile: READABLE_STRING_32
			execute_cmd: READABLE_STRING_32
			prog: READABLE_STRING_32
			exec_error: like executable_file_error
			input_file: RAW_FILE
			execution: EW_SYSTEM_EXECUTION
		do
			execute_cmd := test.environment.value (Execute_command_name)
			execute_cmd := test.environment.substitute (execute_cmd)
			exec_error := executable_file_error (execute_cmd)
			if exec_error = Void then
				test.increment_execution_count
				exec_dir := test.environment.value (execution_dir_name)
				prog := os.executable_full_file_name (exec_dir, test.system_name)
				if attached input_file_name as n then
					infile := os.full_file_name (test.environment.value (Source_dir_name), n)
				else
					infile := os.null_file_name
				end
				outfile := Void	-- Pipe output back to parent
				if attached output_file_name as n then
					savefile := n
				else
					savefile := test.execution_output_name
				end
				savefile := os.full_file_name (test.environment.value (Output_dir_name), savefile)

				exec_error := executable_file_error (prog)
				if exec_error = Void then
					execute_ok := True
					if infile /= Void and then not infile.is_equal (os.null_file_name) then
						create input_file.make_with_name (infile)
						if not input_file.exists then
							failure_explanation := {STRING_32} "input file not found"
							execute_ok := False
						elseif not input_file.is_plain then
							failure_explanation := {STRING_32} "input file not a plain file"
							execute_ok := False
						end
					end
					if execute_ok then
						create execution.make (prog, arguments, test.environment.environment_variables, execute_cmd, exec_dir, infile, outfile, savefile)
						test.set_execution_result (execution.next_execution_result)
					end
				else
					failure_explanation := exec_error
					execute_ok := False
				end
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

feature {NONE} -- Constants

	No_file_name: STRING_32 = "NONE"

feature {NONE} -- Implementation

	input_file_name: detachable READABLE_STRING_32
			-- Name of input file

	output_file_name: detachable READABLE_STRING_32
			-- Name of output file

	arguments: LINKED_LIST [READABLE_STRING_32]

	execution_dir_name: READABLE_STRING_32
			-- Name of directory where executable resides
		deferred
		end

note
	date: "$Date$"
	revision: "$Revision$"
	copyright: "[
			Copyright (c) 1984-2020, University of Southern California, Eiffel Software and contributors.
			All rights reserved.
		]"
	revised_by: "Alexander Kogtenkov"
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
