note
	legal: "See notice at end of class."
	status: "See notice at end of class."
	keywords: "Eiffel test"

class EW_DEFINE_DIR_INST

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
		do
			args := broken_into_words (line)
			count := args.count
			if count < 3 then
				failure_explanation := {STRING_32} "argument count must be at least 3"
				init_ok := False
			elseif args.first.item (1) = Substitute_char then
				failure_explanation := {STRING_32} "variable being defined cannot start with "
				failure_explanation.extend (Substitute_char)
				init_ok := False
			else
				variable := args.first
				value := make_dir_value (args)
				init_ok := True
			end
			if init_ok then
				init_environment.define (variable, value)
			end
		end

	execute (test: EW_EIFFEL_EWEASEL_TEST)
			-- Execute `Current' as one of the
			-- instructions of `test'.  Always successful.
		do
			test.environment.define (variable, value)
		end

	init_ok: BOOLEAN
			-- Was last call to `initialize' successful?

	execute_ok: BOOLEAN = True
			-- Calls to `execute' are always successful.

feature {NONE}

	variable: READABLE_STRING_32
			-- Name of environment value

	value: READABLE_STRING_32
			-- Value to be given to environment value

	make_dir_value (args: LIST [READABLE_STRING_32]): READABLE_STRING_32
			-- Directory name derived from arguments of `args'
		do
			across
				args as a
			from
					-- Skip first items - the variable name.
				a.forth
					-- Initialize from the first part
				create {STRING_32} Result.make_from_string  (a.item)
				a.forth
			loop
				Result := os.full_directory_name (Result, a.item)
			end
		end

note
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
