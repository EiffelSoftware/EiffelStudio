indexing
	description: "[
						Information about a set of test cases run and their results.
																						]"
	status: "See notice at end of class."
	legal: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	ES_EWEASEL_TEST_RUN_DATA_ITEM

create
	make

feature {NONE} -- Initialization

	make is
			-- Creation method
		do
			create internal_test_cases_data.make (10)
		end

feature -- Query

	test_run_data: !ARRAYED_LIST [ES_EWEASEL_TEST_RESULT_ITEM]
			-- All test cases

	date_time: DT_DATE_TIME
			-- Date and time on which this test run happened

	related_test_cases: !ARRAYED_LIST [ES_EWEASEL_TEST_CASE_ITEM] is
			-- Test cases realted with `test_run_data'
		local
			l_data: ES_EWEASEL_TEST_CASE_ITEM
		do
			from
				create Result.make (internal_test_cases_data.count)
				internal_test_cases_data.start
			until
				internal_test_cases_data.after
			loop
				l_data := internal_test_cases_data.item.twin
				l_data.to_running_state

				Result.extend (l_data)

				internal_test_cases_data.forth
			end
		ensure
			valid: internal_test_cases_data.count = Result.count
		end

feature -- Command

	set_date_time (a_date_time: like date_time) is
			-- Set `date_time' with `a_date_time'
		do
			date_time := a_date_time
		ensure
			set: date_time = a_date_time
		end

	set_test_run_data (a_data: like test_run_data) is
			-- Set `test_run_data' with `a_data'
		do
			test_run_data := a_data
		ensure
			set: test_run_data = a_data
		end

	set_related_test_cases (a_data: like related_test_cases) is
			-- Set `related_test_cases' with `a_data'
		local
			l_data: ES_EWEASEL_TEST_CASE_ITEM
		do
			from
				internal_test_cases_data.wipe_out
				a_data.start
			until
				a_data.after
			loop
				l_data := a_data.item.twin
				l_data.to_saving_state

				internal_test_cases_data.extend (l_data)

				a_data.forth
			end
		ensure
			count_valid: internal_test_cases_data.count = a_data.count
		end

feature {NONE} -- Implementation

	internal_test_cases_data: !ARRAYED_LIST [ES_EWEASEL_TEST_CASE_ITEM]
			-- Cache for `test_run_data'


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
