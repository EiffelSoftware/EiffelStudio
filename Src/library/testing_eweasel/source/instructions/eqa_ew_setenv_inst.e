note
	description: "[
					Set environment variable <name> with <value>
																								]"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	keywords: "Eiffel test"
	date: "$Date$"
	revision: "$Revision$"

class EQA_EW_SETENV_INST

inherit
	EQA_EW_TEST_INSTRUCTION
--	EW_STRING_UTILITIES
--		export
--			{NONE} all
--		end
--	EW_SUBSTITUTION_CONST
--		export
--			{NONE} all
--		end
--	EXECUTION_ENVIRONMENT
--		export
--			{NONE} all
--		end

create
	make

feature {NONE} -- Intialization

	make (a_line: STRING)
			-- Creation method
		do
			inst_initialize (a_line)
		end

	inst_initialize (a_line: STRING)
			-- Initialize instruction from `a_line'.  Set
			-- `init_ok' to indicate whether
			-- initialization was successful.
		local
			l_args: LIST [STRING]
			l_count, l_pos: INTEGER
			l_failure_explanation: like failure_explanation
			l_value: like value
		do
			l_args := string_util.broken_into_words (a_line)
			l_count := l_args.count
			if l_count < 2 then
				failure_explanation := "argument count must be at least 2"
				init_ok := False
			elseif l_args.first.has ('%/0/') then
				create l_failure_explanation.make (0)
				failure_explanation := l_failure_explanation
				l_failure_explanation.append ("environment variable name contains null character")
				init_ok := False
			elseif l_args.i_th (2).has ('%/0/') then
				create l_failure_explanation.make (0)
				failure_explanation := l_failure_explanation
				l_failure_explanation.append ("environment variable value contains null character")
				init_ok := False
			elseif l_count = 2 then
				variable := l_args.i_th (1)
				value := l_args.i_th (2)
				init_ok := True
			else
				l_pos :=  string_util.first_white_position (a_line)
				variable := a_line.substring (1, l_pos - 1)
				l_value := a_line.substring (l_pos, a_line.count)
				value := l_value
				l_value.left_adjust
				l_value.right_adjust
				init_ok := True
			end
			if init_ok then
				l_value := value
				check attached l_value end -- Implied by previous if clause
				if l_value.item (1) = {EQA_EW_SUBSTITUTION_CONST}.Quote_char and
				   l_value.item (l_value.count) = {EQA_EW_SUBSTITUTION_CONST}.Quote_char then
					l_value.remove (l_value.count)
					l_value.remove (1)
				elseif l_value.item (1) = {EQA_EW_SUBSTITUTION_CONST}.Quote_char or
				   l_value.item (l_value.count) = {EQA_EW_SUBSTITUTION_CONST}.Quote_char then
					failure_explanation := "value must be quoted on both ends or on neither end"
					init_ok := False
				end
			end

			if not init_ok then
				l_failure_explanation := failure_explanation
				check attached l_failure_explanation end -- Implied by previous if clause
				assert.assert (l_failure_explanation, False)
			end
		end

feature -- Command

	execute (a_test: EQA_EW_SYSTEM_TEST_SET)
			-- Execute `Current' as one of the
			-- instructions of `a_test'
		local
			l_var, l_val: like variable
		do
			l_var := variable
			check attached l_var end -- Implied by `init_ok' is True, otherwise assertion would be violated in `inst_initialize'
			l_val := value
			check attached l_val end -- Implied by `init_ok' is True, otherwise assertion would be violated in `inst_initialize'

			a_test.environment.put (l_val, l_var)
			if a_test.environment.return_code = 0 then
				execute_ok := True
			else
				execute_ok := False
				failure_explanation := "call to set environment variable failed"
			end
		end

feature -- Query

	init_ok: BOOLEAN
			-- Was last call to `initialize' successful?

	execute_ok: BOOLEAN
			-- Was last call to `execute' successful?

feature {NONE} -- Implementation

	variable: detachable STRING
			-- Name of environment variable

	value: detachable STRING
			-- Value to be given to environment variable

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
