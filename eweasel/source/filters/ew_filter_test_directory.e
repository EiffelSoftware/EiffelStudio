note
	description: "An Eiffel test filter which selects all tests with a particular test directory"
	legal: "See notice at end of class."
	status: "See notice at end of class."

class EW_FILTER_TEST_DIRECTORY

inherit
	EW_EIFFEL_TEST_FILTER

create
	make

feature {NONE} -- Creation

	make (dir: READABLE_STRING_32)
			-- Create filter which selects tests whose test directory is `dir`.
		do
			test_directory := dir
		end

feature -- Filtering

	selects (test: EW_NAMED_EIFFEL_TEST): BOOLEAN
			-- Does `Current' select `test' for execution?
		do
			Result := test.last_source_directory_component.same_string_general (test_directory)
		end

feature {NONE} -- Implementation

	test_directory: READABLE_STRING_32
			-- Directory test must have in order for test to be selected.

;note
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
