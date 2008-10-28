indexing
	description: "An Eiffel test filter which selects all tests with a particular test directory"
	legal: "See notice at end of class."
	status: "See notice at end of class.";

class EW_FILTER_TEST_DIRECTORY

inherit
	EW_EIFFEL_TEST_FILTER

create
	make

feature -- Creation

	make (dir: STRING) is
			-- Create filter which selects tests whose
			-- test directory is `dir'
		do
			test_directory := dir
		end

feature -- Filtering

	selects (test: EW_NAMED_EIFFEL_TEST): BOOLEAN is
			-- Does `Current' select `test' for execution?
		do
			Result := equal (test.last_source_directory_component, test_directory)
		end

feature {NONE} -- Implementation

	test_directory: STRING;
			-- Directory test must have in order for test to be selected

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
