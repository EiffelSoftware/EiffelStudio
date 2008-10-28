indexing
	description: "An Eiffel test filter which selects all tests that match a particular keyword"
	legal: "See notice at end of class."
	status: "See notice at end of class.";
	date: "93/10/15"

class EW_FILTER_KEYWORD

inherit
	EW_EIFFEL_TEST_FILTER

create
	make
feature -- Creation

	make (kw: STRING) is
			-- Create filter which selects tests which have 
			-- keyword `kw' associated with them
		do
			keyword := kw;
		end

feature -- Filtering

	selects (test: EW_NAMED_EIFFEL_TEST): BOOLEAN is
			-- Does `Current' select `test' for execution?
		do
			Result := test.has_keyword (keyword);
		end

feature {NONE} -- Implementation

	keyword: STRING;
			-- Keyword which must be specified for test in order
			-- for test to be selected

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
