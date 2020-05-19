note
	legal: "See notice at end of class."
	status: "See notice at end of class."
	keywords: "Eiffel test"

class EW_C_COMPILE_RESULT_INST

inherit
	EW_TEST_INSTRUCTION
	EW_STRING_UTILITIES

feature

	inst_initialize (args: READABLE_STRING_32)
			-- Initialize instruction from `args'.  Set
			-- `init_ok' to indicate whether
			-- initialization was successful.
		local
			words: LIST [READABLE_STRING_32]
			type: STRING_32
			cr: EW_C_COMPILATION_RESULT
		do
			words := broken_into_words (args)
			if words.count = 1 then
				type := words [1]
				if type.is_case_insensitive_equal ({STRING_32} "ok") then
					create cr
					cr.set_compilations_completed (True)
					expected_compile_result := cr
					init_ok := True
				else
					init_ok := False
					failure_explanation := {STRING_32} "unknown keyword: " + type
				end
			else
				init_ok := False
				failure_explanation := {STRING_32} "exactly one argument required"
			end
		end

	execute (test: EW_EIFFEL_EWEASEL_TEST)
			-- Execute `Current' as one of the
			-- instructions of `test'.
			-- Set `execute_ok' to indicate whether successful.
		local
			cr: EW_C_COMPILATION_RESULT
		do
			cr := test.c_compilation_result
			if cr = Void then
				execute_ok := False
				failure_explanation := {STRING_32} "no pending C compilation result to check"
			else
				execute_ok := cr.matches (expected_compile_result)
				if not execute_ok then
					failure_explanation := {STRING_32}
						"actual C compilation result does not match expected result%N" +
						"Actual result: " +
						cr.summary +
						"%NExpected result: " +
						expected_compile_result.summary
				end
				test.set_c_compilation_result (Void)
			end
		end

	init_ok: BOOLEAN
			-- Was last call to `initialize' successful?

	execute_ok: BOOLEAN
			-- Was last call to `execute' successful?

feature {NONE} -- Implementation

	expected_compile_result: EW_C_COMPILATION_RESULT
			-- Result expected from C compilations

;note
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
