note
	description: "[
					Similar to `Compile_melted'
					Compile_final requests finalizing of the system with assertions discarded
																								]"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	keywords: "Eiffel test"
	date: "$Date$"
	revision: "$Revision$"

class EQA_EW_C_COMPILE_RESULT_INST

inherit
	EQA_EW_TEST_INSTRUCTION

create
	make

feature {NONE} -- Initialization

	make (a_args: STRING)
			-- Initialize instruction from `a_args'.  Set
			-- `init_ok' to indicate whether
			-- initialization was successful.
		local
			l_words: LIST [STRING]
			l_count: INTEGER
			l_type: STRING
			l_cr: EQA_EW_C_COMPILATION_RESULT
			l_failure_explanation: like failure_explanation
		do
			l_words := string_util.broken_into_words (a_args)
			l_count := l_words.count
			if l_count /= 1 then
				init_ok := False
				failure_explanation := "exactly one argument required"
			else
				l_type := l_words.i_th (1)
				l_type.to_lower
				if equal (l_type, "ok") then
					create l_cr
					l_cr.set_compilations_completed (True)
					expected_compile_result := l_cr
					init_ok := True
				else
					init_ok := False
					create l_failure_explanation.make (0)
					l_failure_explanation.append ("unknown keyword: ")
					l_failure_explanation.append (l_type)
				end
			end
		end

feature -- Command

	execute (a_test: EQA_EW_SYSTEM_TEST_SET)
			-- Execute `Current' as one of the
			-- instructions of `a_test'.
			-- Set `execute_ok' to indicate whether successful.
		local
			l_cr: detachable EQA_EW_C_COMPILATION_RESULT
			l_failure_explanation: like failure_explanation
			l_expected_compile_result: like expected_compile_result
		do
			l_cr := a_test.c_compilation_result
			if l_cr = Void then
				execute_ok := False
				create l_failure_explanation.make (0)
				failure_explanation := l_failure_explanation
				l_failure_explanation.append ("no pending C compilation result to check")

			else
				l_expected_compile_result := expected_compile_result
				check attached l_expected_compile_result end -- Implied by `init_ok' is True, otherwise assertion would be violated in `inst_initialize'
				execute_ok := l_cr.matches (l_expected_compile_result)
				if not execute_ok then
					create l_failure_explanation.make (0)
					failure_explanation := l_failure_explanation
					l_failure_explanation.append ("actual C compilation result does not match expected result%N")
					l_failure_explanation.append ("Actual result: ")
					l_failure_explanation.append (l_cr.summary)
					l_failure_explanation.append ("%NExpected result: ")
					l_failure_explanation.append (l_expected_compile_result.summary)
				end
				a_test.set_c_compilation_result (Void)
			end

			if not execute_ok then
				l_failure_explanation := failure_explanation
				check attached l_failure_explanation end -- Implied by previous if clause
				assert.assert (l_failure_explanation, execute_ok)
			end
		end

feature -- Query

	init_ok: BOOLEAN
			-- Was last call to `initialize' successful?

	execute_ok: BOOLEAN
			-- Was last call to `execute' successful?

feature {NONE} -- Implementation

	expected_compile_result: detachable EQA_EW_C_COMPILATION_RESULT
			-- Result expected from C compilations

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
