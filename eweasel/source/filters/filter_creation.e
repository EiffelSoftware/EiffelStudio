indexing
	description: "Creation of Eiffel test filter"
	legal: "See notice at end of class."
	status: "See notice at end of class.";
	date: "93/10/15"

class FILTER_CREATION

inherit
	STRING_UTILITIES

feature -- Filtering

	string_to_filter (s: STRING): EIFFEL_TEST_FILTER is
			-- Filter `s' represents (Void if none - i.e. if
			-- `s' is invalid).
		local
			words: LIST [STRING];
			first: STRING;
		do
			words := broken_into_words (s);
			if words.count = 2 then
				first := words.first;
				first.to_lower;
				if equal (first, "test") then
					create {FILTER_TEST_NAME} Result.make (words.i_th (2));
				elseif equal (first, "kw") then
					create {FILTER_KEYWORD} Result.make (words.i_th (2));
				end
			end
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
