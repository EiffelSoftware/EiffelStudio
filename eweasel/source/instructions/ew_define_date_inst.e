note
	description: "[
			An instruction
				define_date VARIABLE_NAME INTEGER_VALUE
			defines a variable VARIABLE_NAME that contains a date string in ISO8601 format (yyyy-mm-dd) shifted from today (UTC time) by INTEGER_VALUE.
			Examples:
				define_date NEXT_WEEK 7
				define_date TOMORROW 1
				define_date TODAY 0
				define_date YESTERDAY -1
				define_date LAST_WEEK -7
		]"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	keywords: "Eiffel test"

class EW_DEFINE_DATE_INST

inherit
	EW_TEST_INSTRUCTION
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
			date: DATE
		do
			init_ok := False
			args := broken_into_words (line)
			count := args.count
			if count /= 2 then
				failure_explanation := {STRING_32} "argument count must be 2"
			elseif args.first [1] = Substitute_char then
				failure_explanation := {STRING_32} "variable being defined cannot start with "
				failure_explanation.extend (Substitute_char)
			elseif not args.last.is_integer_16 then
				failure_explanation := {STRING_32} "allowed value should be a number of days from today in range "
				failure_explanation.append_integer_16 ({INTEGER_16}.min_value)
				failure_explanation.append ({STRING_32} "..")
				failure_explanation.append_integer_16 ({INTEGER_16}.max_value)
			else
				variable := args.first
				create date.make_now_utc
				date.add (create {DATE_DURATION}.make_by_days (args.last.to_integer))
				value := from_utf_8 (date.formatted_out ("yyyy-mm-dd"))
				init_ok := True
			end
			if init_ok then
				init_environment.define (variable, value)
			end
		end

	execute (test: EW_EIFFEL_EWEASEL_TEST)
			-- Execute `Current' as one of the instructions of `test'.
		do
			test.environment.define (variable, value)
		end

	init_ok: BOOLEAN
			-- Was last call to `initialize' successful?

	execute_ok: BOOLEAN = True
			-- Calls to `execute' are always successful.

feature {NONE}

	variable: READABLE_STRING_32
			-- Name of environment value.

	value: READABLE_STRING_32
			-- Value to be given to environment value.

;note
	date: "$Date$"
	revision: "$Revision$"
	copyright: "[
			Copyright (c) 2017, Eiffel Software and contributors.
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
