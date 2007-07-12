indexing
	legal: "See notice at end of class."
	status: "See notice at end of class."
	keywords: "Eiffel test";
	date: "93/08/30"

class TEST_DESCRIPTION_INST

inherit
	TEST_INSTRUCTION

feature

	inst_initialize (desc: STRING) is
			-- Initialize instruction from `args'.
		do
			if desc.count = 0 then
				init_ok := False;
				failure_explanation := "no test description supplied";
			else
				test_description := desc;
				init_ok := True;
			end
		end;

	execute (test: EIFFEL_TEST) is
			-- Execute `Current' as one of the
			-- instructions of `test'.
		do
			test.set_test_description (test_description);
		end;

	init_ok: BOOLEAN;
			-- Was last call to `initialize' successful?
	
	execute_ok: BOOLEAN is True;
			-- Calls to `execute' always succeed.

feature {NONE}
	
	test_description: STRING;
			-- Description of test
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
