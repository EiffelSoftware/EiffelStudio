indexing
	legal: "See notice at end of class."
	status: "See notice at end of class."
	keywords: "Eiffel test";
	date: "93/08/30"

class EW_UNKNOWN_INST

inherit
	EW_TEST_INSTRUCTION

feature

	inst_initialize (args: STRING) is
			-- Initialize instruction from `args'.
		do
			failure_explanation := "unknown test instruction %"" + command + "%""
		end;

	execute (test: EW_EIFFEL_EWEASEL_TEST) is
			-- Execute `Current' as one of the
			-- instructions of `test'.
		do
			failure_explanation := "unknown test instruction %"" + command + "%""
		end;

	init_ok: BOOLEAN is False;
			-- Calls to `initialize' always fail.
	
	execute_ok: BOOLEAN is False;
			-- Calls to `execute' always fail.

indexing
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
