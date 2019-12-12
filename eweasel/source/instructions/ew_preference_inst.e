note
	description: "Compiler preference setting instruction."
	keywords: "Eiffel test"

class EW_PREFERENCE_INST

inherit
	EW_TEST_INSTRUCTION

feature

	inst_initialize (line: READABLE_STRING_32)
			-- Initialize instruction with preference name and value stored in `line`.
			-- Set `init_ok` to indicate whether initialization was successful.
		local
			arguments: LIST [READABLE_STRING_32]
		do
			arguments := broken_into_arguments (line)
			if arguments.count = 2 then
				init_ok := True
				name := arguments [1]
				value := arguments [2]
			else
				init_ok := False
				failure_explanation := {STRING_32} "preference should have two arguments: name and value"
			end
		end

	execute (test: EW_EIFFEL_EWEASEL_TEST)
			-- <Precursor>
		do
			test.set_preference (name, value)
		end

	init_ok: BOOLEAN
			-- <Precursor>

	execute_ok: BOOLEAN = True
			-- <Precursor>

feature {NONE}

	name: READABLE_STRING_32
			-- Preference name.

	value: READABLE_STRING_32
			-- Preference value.

;note
	date: "$Date$"
	revision: "$Revision$"
	copyright: "[
			Copyright (c) 2019, Eiffel Software and contributors.
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
