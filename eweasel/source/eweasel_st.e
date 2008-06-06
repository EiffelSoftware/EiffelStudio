indexing
	description: "The EiffelWeasel automatic tester - single-threaded version"
	legal: "See notice at end of class."
	status: "See notice at end of class.";
	date: "2008/06/03"

class EWEASEL_ST

inherit
	EWEASEL

create	
	make,
	make_and_execute

feature  {NONE} -- Implementation

	new_test_suite (tests: LIST [NAMED_EIFFEL_TEST] opts: TEST_SUITE_OPTIONS): EIFFEL_TEST_SUITE
			-- New test suite with `tests' using options `opts'
		do
			create {EIFFEL_TEST_SUITE_ST} Result.make (tests, test_suite_directory, environment)
		end

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
