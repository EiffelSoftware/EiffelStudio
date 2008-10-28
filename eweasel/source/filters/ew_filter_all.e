indexing
	description: "An Eiffel test filter which selects all tests"
	legal: "See notice at end of class."
	status: "See notice at end of class.";
	date: "93/10/15"

class EW_FILTER_ALL

inherit
	EW_EIFFEL_TEST_FILTER

feature -- Filtering

	selects (test: EW_NAMED_EIFFEL_TEST): BOOLEAN is
			-- Does `Current' select `test' for execution?
			-- (Answer: yes.)
		do
			Result := True;
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
