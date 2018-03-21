note
	description: "An Eiffel test catalog"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class EW_EIFFEL_TEST_CATALOG

create

	make

feature {NONE}  -- Creation

	make (tests: LIST [EW_NAMED_EIFFEL_TEST])
			-- Create `Current' with `tests'.
		require
			test_list_not_void: tests /= Void
		do
			all_tests := tests
		end

feature -- Properties	

	all_tests: LIST [EW_NAMED_EIFFEL_TEST]
			-- List of all tests

	tests_matching_one_keyword (keys: LIST [READABLE_STRING_32]): LIST [EW_NAMED_EIFFEL_TEST]
			-- List of all tests whose keyword list contains
			-- at least one of the keywords in `keys'.
		require
			keywords_not_void: keys /= Void
		local
			test: EW_NAMED_EIFFEL_TEST
		do
			from
				create {LINKED_LIST [EW_NAMED_EIFFEL_TEST]} Result.make
				all_tests.start
			until
				all_tests.after
			loop
				test := all_tests.item
				if test.has_one_keyword (keys) then
					Result.extend (test)
				end
			end
		end

	tests_matching_all_keywords (keys: LIST [READABLE_STRING_32]): LIST [EW_NAMED_EIFFEL_TEST]
			-- List of all tests whose keyword list contains
			-- all of the keywords in `keys'.
		require
			keywords_not_void: keys /= Void
		local
			test: EW_NAMED_EIFFEL_TEST
		do
			from
				create {LINKED_LIST [EW_NAMED_EIFFEL_TEST]} Result.make
				all_tests.start
			until
				all_tests.after
			loop
				test := all_tests.item
				if test.has_all_keywords (keys) then
					Result.extend (test)
				end
			end
		end

;note
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
