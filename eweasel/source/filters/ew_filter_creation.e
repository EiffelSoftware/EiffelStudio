indexing
	description: "Creation of Eiffel test filter"
	legal: "See notice at end of class."
	status: "See notice at end of class.";
	date: "93/10/15"

class EW_FILTER_CREATION

inherit
	EW_STRING_UTILITIES

feature -- Filtering

	string_to_filter (s: STRING): EW_EIFFEL_TEST_FILTER is
			-- Filter `s' represents (Void if none - i.e. if
			-- `s' is invalid).
		local
			words: LIST [STRING];
		do
			words := broken_into_words (s);
			if words.count >= 1 then
				filter_type := words.first
				filter_type.to_lower;
				filter_count := words.count - 1
				is_filter_type_known := True
				if equal (filter_type, "test") then
					if filter_count = 1 then
						create {EW_FILTER_TEST_NAME} Result.make (words.i_th (2));
					end
				elseif equal (filter_type, "dir") or equal (filter_type, "directory") then
					if filter_count = 1 then
						create {EW_FILTER_TEST_DIRECTORY} Result.make (words.i_th (2));
					end
				elseif equal (filter_type, "kw") or equal (filter_type, "keyword") then
					if filter_count = 1 then
						create {EW_FILTER_KEYWORD} Result.make (words.i_th (2));
					end
				else
					is_filter_type_known := False
				end
			else
				filter_type := ""
				filter_count := 0
			end
		end

	filter_type: STRING
			-- Type of filter or Void if none

	is_filter_type_known: BOOLEAN
			-- Is type of filter a known type?

	filter_count: INTEGER;
			-- Number of values (test names or test directories or
			-- test keywords) supplied with filter

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
