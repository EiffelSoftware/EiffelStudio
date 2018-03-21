note
	legal: "See notice at end of class."
	status: "See notice at end of class."
	keywords: "Eiffel test"

class EW_TEST_END_INST

inherit
	EW_TEST_INSTRUCTION
		redefine
			test_execution_terminated
		end

feature
	inst_initialize (args: READABLE_STRING_32)
			-- Initialize instruction from `args'.  Set
			-- `init_ok' to indicate whether
			-- initialization was successful.
		do
			if args.is_empty then
				init_ok := True
			else
				init_ok := False
				failure_explanation := {STRING_32} "no arguments allowed"
			end
		end

	execute (test: EW_EIFFEL_EWEASEL_TEST)
			-- Execute `Current' as one of the
			-- instructions of `test'.
			-- Always successful.
		local
			e_comp: EW_EIFFEL_COMPILATION
			c_comp: EW_C_COMPILATION
		do
			e_comp := test.e_compilation
			c_comp := test.c_compilation
			if e_comp /= Void then
				e_comp.abort
			end;
			if c_comp /= Void then
				c_comp.abort
			end
		end

	init_ok: BOOLEAN
			-- Was last call to `initialize' successful?

	execute_ok: BOOLEAN = True
			-- Calls to `execute' always succeed.

	test_execution_terminated: BOOLEAN = True
			-- Did last call to `execute' indicate that
			-- execution of test should be terminated?

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
