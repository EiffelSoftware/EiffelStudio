indexing
	legal: "See notice at end of class."
	status: "See notice at end of class."
	keywords: "Eiffel test";
	date: "93/08/30"

class EW_CPU_LIMIT_INST

inherit
	EW_TEST_INSTRUCTION;
	EW_STRING_UTILITIES;

feature

	inst_initialize (limit: STRING) is
			-- Initialize instruction from `limit'.  Set
			-- `init_ok' to indicate whether
			-- initialization was successful.
		do
			if limit.count = 0 or first_white_position (limit) > 0 
			   or else not is_integer (limit) then
				init_ok := False;
				failure_explanation := "need exactly one integer argument";
			else
				cpu_limit := limit.to_integer;
				init_ok := True;
			end
		end;

	execute (test: EW_EIFFEL_EWEASEL_TEST) is
			-- Execute `Current' as one of the
			-- instructions of `test'.  Always successful.
		do
			test.set_cpu_limit (cpu_limit);
		end;

	init_ok: BOOLEAN;
			-- Was last call to `initialize' successful?
	
	execute_ok: BOOLEAN is True;
			-- Calls to `execute' are always successful.

feature {NONE}
	
	cpu_limit: INTEGER;
			-- CPU limit in seconds for spawned processes
	
	
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
