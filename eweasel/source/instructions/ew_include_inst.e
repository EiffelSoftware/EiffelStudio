note
	legal: "See notice at end of class."
	status: "See notice at end of class."
	keywords: "Eiffel test"

class EW_INCLUDE_INST

inherit
	EW_TEST_INSTRUCTION
	EW_OS_ACCESS
	EW_STRING_UTILITIES
	EW_SUBSTITUTION_CONST

feature

	inst_initialize (line: READABLE_STRING_32)
			-- Initialize instruction from `line'.  Set
			-- `init_ok' to indicate whether
			-- initialization was successful.
		local
			args: LIST [READABLE_STRING_32]
			count: INTEGER
			tcf: EW_TEST_CONTROL_FILE
		do
			args := broken_into_words (line)
			count := args.count
			if count = 2 then
				include_directory_name := args [1]
				include_file_name := args [2]
				include_tcf_name := os.full_directory_name (include_directory_name, include_file_name)
				if makes_include_cycle (include_tcf_name) then
					failure_explanation := {STRING_32} "include cycle on include file " + include_tcf_name
					init_ok := False
				else
					create tcf.make (include_tcf_name, test_control_file, command_table, False)
					tcf.parse (init_environment);
					if tcf.last_ok then
						include_instructions := tcf.instructions
						init_ok := True
					else
						test_control_file.add_errors (tcf.errors)
						failure_explanation := {STRING_32} "error parsing include file " + include_tcf_name
						init_ok := False
					end
				end
			else
				failure_explanation := {STRING_32} "argument count must be 2"
				init_ok := False
			end
		end

	execute (test: EW_EIFFEL_EWEASEL_TEST)
			-- Execute `Current' as one of the
			-- instructions of `test'.
			-- Set `execute_ok' to indicate whether successful.
		local
			saved_insts: LIST [EW_TEST_INSTRUCTION]
		do
			saved_insts := test.instructions
			test.set_instructions (include_instructions)
			test.execute (test.environment)
			test.set_instructions (saved_insts)
			if test.last_ok then
				execute_ok := True
			else
				failure_explanation :=  {STRING_32} "error executing include file " + include_tcf_name
				execute_ok := False
			end
		end

	init_ok: BOOLEAN
			-- Was last call to `initialize' successful?

	execute_ok: BOOLEAN
			-- Was last call to `execute' successful?

feature {NONE} -- Implementation

	makes_include_cycle (fn: READABLE_STRING_32): BOOLEAN
			-- Would processing include file named `fn' cause
			-- an include cycle?
		local
			tcf: EW_TEST_CONTROL_FILE
		do
			from
				tcf := test_control_file
			until
				tcf = Void or Result
			loop
				if tcf.file_name.same_string_general (fn) then
					Result := True
				end
				tcf := tcf.include_parent
			end
		end

feature {NONE}

	include_directory_name: READABLE_STRING_32
			-- Name of directory where include file resides

	include_file_name: READABLE_STRING_32
			-- Name of include file

	include_tcf_name: READABLE_STRING_32
			-- Full name of included test control file

	include_instructions: LIST [EW_TEST_INSTRUCTION]
			-- Test instructions from include file

;note
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
