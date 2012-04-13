note
	description: "Instructions that removes an environment variable from the environment"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	keywords: "Eiffel test"
	date: "$Date$"
	revision: "$Revision$"

class EW_UNSETENV_INST

inherit
	EW_TEST_INSTRUCTION
	EW_STRING_UTILITIES
		export
			{NONE} all
		end
	EW_SUBSTITUTION_CONST
		export
			{NONE} all
		end
	EXECUTION_ENVIRONMENT
		export
			{NONE} all
		end

feature

	inst_initialize (line: STRING)
			-- Initialize instruction from `line'.  Set
			-- `init_ok' to indicate whether
			-- initialization was successful.
		local
			args: LIST [STRING]
		do
			args := broken_into_words (line)
			if args.count /= 1 then
				failure_explanation := "argument count must be at least 1"
				init_ok := False
			elseif args.first.has ('%/0/') then
				create failure_explanation.make (0)
				failure_explanation.append ("environment variable name contains null character")
				init_ok := False
			else
				variable := args.i_th (1)
				init_ok := True
			end
		end

	execute (test: EW_EIFFEL_EWEASEL_TEST)
			-- Execute `Current' as one of the
			-- instructions of `test'
		do
			test.environment.remove_environment_variable (variable)
			execute_ok := True
		end

	init_ok: BOOLEAN
			-- Was last call to `initialize' successful?

	execute_ok: BOOLEAN
			-- Was last call to `execute' successful?

feature {NONE}

	variable: STRING
			-- Name of environment variable

invariant

note
	copyright: "[
			Copyright (c) 1984-2007, University of Southern California and contributors.
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
