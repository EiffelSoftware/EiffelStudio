note
	description: "Creation of Eiffel test filter"
	legal: "See notice at end of class."
	status: "See notice at end of class."

class EW_FILTER_CREATION

inherit
	EW_STRING_UTILITIES

feature -- Filtering

	string_to_filter (s: READABLE_STRING_32): detachable EW_EIFFEL_TEST_FILTER
			-- Filter `s' represents (Void if none - i.e. if
			-- `s' is invalid).
		local
			words: LIST [READABLE_STRING_32]
			value: READABLE_STRING_32
		do
			words := broken_into_words (s)
			if words.count >= 1 then
				filter_type := words.first.as_lower
				filter_count := words.count - 1
				is_filter_type_known := True
				if filter_count = 1 then
					value := words [2]
				end
				if filter_type.same_string ({STRING_32} "test") then
					if attached value then
						create {EW_FILTER_TEST_NAME} Result.make (value)
					end
				elseif filter_type.same_string ({STRING_32} "dir") or filter_type.same_string ({STRING_32} "directory") then
					if attached value then
						create {EW_FILTER_TEST_DIRECTORY} Result.make (value)
					end
				elseif filter_type.same_string ({STRING_32} "kw") or filter_type.same_string ({STRING_32} "keyword") then
					if attached value then
						create {EW_FILTER_KEYWORD} Result.make (value)
					end
				else
					is_filter_type_known := False
				end
			else
				filter_type := {STRING_32} ""
				filter_count := 0
			end
		end

	filter_type: READABLE_STRING_32
			-- Type of filter or Void if none

	is_filter_type_known: BOOLEAN
			-- Is type of filter a known type?

	filter_count: INTEGER
			-- Number of values (test names or test directories or
			-- test keywords) supplied with filter

;note
	date: "$Date$"
	revision: "$Revision$"
	copyright: "[
			Copyright (c) 1984-2020, University of Southern California, Eiffel Software and contributors.
			All rights reserved.
		]"
	revised_by: "Alexander Kogtenkov"
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
