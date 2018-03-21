note
	legal: "See notice at end of class."
	status: "See notice at end of class."
	keywords: "Eiffel test"

class EW_EXECUTE_RESULT_INST

inherit
	EW_TEST_INSTRUCTION
	EW_STRING_UTILITIES

feature

	inst_initialize (line: READABLE_STRING_32)
			-- Initialize instruction from `line'.  Set
			-- `init_ok' to indicate whether
			-- initialization was successful.
		local
			words: LIST [READABLE_STRING_32]
			count: INTEGER
			er: EW_EXECUTION_RESULT
			type: READABLE_STRING_32
		do
			words := broken_into_words (line)
			count := words.count
			if count = 1 then
				create er
				type := words.first
				if type.is_case_insensitive_equal ({STRING_32} "ok") then
					er.set_execution_finished (True)
					er.set_execution_failure (False)
					init_ok := True
				elseif type.is_case_insensitive_equal ({STRING_32} "failed") then
					er.set_execution_finished (False)
					er.set_execution_failure (True)
					init_ok := True
				elseif type.is_case_insensitive_equal ({STRING_32} "failed_silently") then
					er.set_execution_finished (False)
					er.set_execution_failure (False)
					init_ok := True
				elseif type.is_case_insensitive_equal ({STRING_32} "completed_but_failed") then
					er.set_execution_finished (True)
					er.set_execution_failure (True)
					init_ok := True
				else
					init_ok := False
					failure_explanation := {STRING_32} "unknown keyword: " + type
				end
				expected_execution_result := er
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
			er: EW_EXECUTION_RESULT
		do
			er := test.execution_result
			if er = Void then
				execute_ok := False
				failure_explanation := {STRING_32} "no pending execution result to check"
			else
				execute_ok := er.matches (expected_execution_result)
				if not execute_ok then
					failure_explanation :=
						{STRING_32} "actual execution result does not match expected result%N" +
						"Actual result:%N" +
						test.execution_result.summary +
						"%NExpected result:%N" +
						expected_execution_result.summary
				end
				test.set_execution_result (Void)
			end
		end

	init_ok: BOOLEAN
			-- Was last call to `initialize' successful?

	execute_ok: BOOLEAN
			-- Was last call to `execute' successful?

feature {NONE} -- Implementation

	expected_execution_result: EW_EXECUTION_RESULT
			-- Result expected from system compilation

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
