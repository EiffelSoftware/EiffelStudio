indexing
	description: "[
						Test case session data which can be used for store.
						The information include current set of test case classes.
						
						Note: Test case history will not be recorded here. 
						They are recorded by {EWEASEL_TEST_RUN_SESSION_DATA}
																							]"
	status: "See notice at end of class."
	legal: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	ES_EWEASEL_TEST_CASE_SESSION_DATA

inherit
	SESSION_DATA_I

create
	make

feature {NONE} -- Initialization

	make (a_prefered_count: INTEGER) is
			-- Creation method
			-- `a_prefered_count' is the size of `all_test_cases' will be first initialized
		require
			valid: a_prefered_count >= 0
		do
			create all_test_cases.make (a_prefered_count)
		end

feature -- Command

	append_test_cases (a_list: !ARRAYED_LIST [ES_EWEASEL_TEST_CASE_ITEM]) is
			-- Append `a_list' to current
			-- This feature will append items in `a_list' as saving state.
		local
			l_temp: like all_test_cases
			l_item: ES_EWEASEL_TEST_CASE_ITEM
		do
			from
				l_temp := a_list
				l_temp.start
			until
				l_temp.after
			loop
				l_item := l_temp.item.twin
				l_item.to_saving_state -- Must convert to saving state

				all_test_cases.extend (l_item)

				l_temp.forth
			end
		end

feature -- Query

	all_running_test_cases: like all_test_cases is
			-- All test cases data for running
			-- This feature will copy items in `all_test_case'
			-- and convert them to running state.
			-- Note: if class id not found, the item will be ignored.
		local
			l_list: like all_test_cases
			l_item: ES_EWEASEL_TEST_CASE_ITEM
		do
			from
				l_list := all_test_cases
				create Result.make (l_list.count)
				l_list.start
			until
				l_list.after
			loop
				l_item := l_list.item.twin
				l_item.to_running_state
				if l_item.is_valid_for_running then
					Result.extend (l_item)
				end

				l_list.forth
			end
		end

feature {NONE} -- Implementation

	all_test_cases: !ARRAYED_LIST [ES_EWEASEL_TEST_CASE_ITEM]
			-- All test cases


;indexing
	copyright: "Copyright (c) 1984-2008, Eiffel Software"
	license:   "GPL version 2 (see http://www.eiffel.com/licensing/gpl.txt)"
	licensing_options: "http://www.eiffel.com/licensing"
	copying: "[
			This file is part of Eiffel Software's Eiffel Development Environment.
			
			Eiffel Software's Eiffel Development Environment is free
			software; you can redistribute it and/or modify it under
			the terms of the GNU General Public License as published
			by the Free Software Foundation, version 2 of the License
			(available at the URL listed under "license" above).
			
			Eiffel Software's Eiffel Development Environment is
			distributed in the hope that it will be useful, but
			WITHOUT ANY WARRANTY; without even the implied warranty
			of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
			See the GNU General Public License for more details.
			
			You should have received a copy of the GNU General Public
			License along with Eiffel Software's Eiffel Development
			Environment; if not, write to the Free Software Foundation,
			Inc., 51 Franklin St, Fifth Floor, Boston, MA 02110-1301 USA
		]"
	source: "[
			 Eiffel Software
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"

end
