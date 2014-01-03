note
	description: "[
					Check that the result from the last execute_work or
					execute_final instruction matches <result>.  If it does not,
					then the test has failed and the rest of the test instructions
					are skipped.  If the result matches <result>, continue
					processing with the next test instruction.  <result> can be:

					ok

					Matches if no exception trace or run-time
					panic occurred and there were no error
					messages of any kind.

					failed

					Matches if system did not complete normally
					(did not exit with 0 status) and output includes
					a "system execution failed" string

					failed_silently

					Matches if system did not complete normally
					(did not exit with 0 status) but output does not
					include a "system execution failed" string

					completed_but_failed

					Matches if system completed normally
					(exited with 0 status) but output includes
					a "system execution failed" string
																								]"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	keywords: "Eiffel test"
	date: "$Date$"
	revision: "$Revision$"

class EQA_EW_EXECUTE_RESULT_INST

inherit
	EQA_EW_TEST_INSTRUCTION

create
	make

feature {NONE} -- Intialization

	make (a_result: STRING)
			-- Creation method
		require
			not_void: attached a_result
		do
			inst_initialize (a_result)
		end

	inst_initialize (a_line: STRING)
			-- Initialize instruction from `a_line'.  Set
			-- `init_ok' to indicate whether
			-- initialization was successful.
		local
			l_words: LIST [STRING]
			l_count: INTEGER
			l_er: EQA_EW_EXECUTION_RESULT
			l_type: STRING
			l_failure_explanation: like failure_explanation
		do
			l_words := string_util.broken_into_words (a_line)
			l_count := l_words.count
			if l_count /= 1 then
				init_ok := False
				failure_explanation := "exactly one argument required"
			else
				create l_er
				l_type := l_words.first
				l_type.to_lower
				if equal (l_type, "ok") then
					l_er.set_execution_finished (True)
					l_er.set_execution_failure (False)
					init_ok := True
				elseif equal (l_type, "failed") then
					l_er.set_execution_finished (False)
					l_er.set_execution_failure (True)
					init_ok := True
				elseif equal (l_type, "failed_silently") then
					l_er.set_execution_finished (False)
					l_er.set_execution_failure (False)
					init_ok := True
				elseif equal (l_type, "completed_but_failed") then
					l_er.set_execution_finished (True)
					l_er.set_execution_failure (True)
					init_ok := True
				else
					init_ok := False
					create l_failure_explanation.make (0)
					failure_explanation := l_failure_explanation
					l_failure_explanation.append ("unknown keyword: ")
					l_failure_explanation.append (l_type)
				end
				expected_execution_result := l_er
			end
		end

feature -- Command

	execute (a_test: EQA_EW_SYSTEM_TEST_SET)
			-- Execute `Current' as one of the
			-- instructions of `a_test'.
			-- Set `execute_ok' to indicate whether successful.
		local
			l_er: detachable EQA_EW_EXECUTION_RESULT
			l_failure_explanation: like failure_explanation
		do
			l_er := a_test.execution_result
			if l_er = Void then
				execute_ok := False
				create l_failure_explanation.make (0)
				failure_explanation := l_failure_explanation
				l_failure_explanation.append ("no pending execution result to check")

			elseif attached expected_execution_result as l_expected_execution_result then
				execute_ok := l_er.matches (l_expected_execution_result)
				if not execute_ok then
					create l_failure_explanation.make (0)
					failure_explanation := l_failure_explanation
					l_failure_explanation.append ("actual execution result does not match expected result%N")
					l_failure_explanation.append ("Actual result:%N")
					l_failure_explanation.append (l_er.summary)
					l_failure_explanation.append ("%NExpected result:%N")
					l_failure_explanation.append (l_expected_execution_result.summary)
				end
				a_test.set_execution_result (Void)
			else
				execute_ok := False
				failure_explanation := "No execution result available"
			end

			if not execute_ok then
				print (failure_explanation)
				a_test.assert ("Unexpected execution result", False)
			end

		end

feature {NONE} -- Implementation

	init_ok: BOOLEAN
			-- Was last call to `initialize' successful?

	execute_ok: BOOLEAN
			-- Was last call to `execute' successful?

feature {NONE} -- Implementation

	expected_execution_result: detachable EQA_EW_EXECUTION_RESULT
			-- Result expected from system compilation

;note
	copyright: "Copyright (c) 1984-2014, Eiffel Software and others"
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
