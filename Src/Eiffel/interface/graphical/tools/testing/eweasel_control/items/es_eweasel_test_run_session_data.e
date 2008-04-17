indexing
	description: "[
					Information about ALL history test run recorded.
					This is topmost level test run information.
																					]"
	status: "See notice at end of class."
	legal: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	ES_EWEASEL_TEST_RUN_SESSION_DATA

inherit
	SESSION_DATA_I

create
	make

feature {NONE} -- Initialization

	make is
			-- Creation method
		do
			create internal_total_test_runs.make (10)

			-- Default value
			maximum_remembered_data_count := 10
		ensure
			default_value_set: maximum_remembered_data_count /= 0
		end

feature -- Command

	set_maximum_remembered_data_count (a_count: like maximum_remembered_data_count) is
			-- Set `maximum_remembered_data_count' with `a_count'
		do
			maximum_remembered_data_count := a_count
		ensure
			set: maximum_remembered_data_count = a_count
		end

	remove_test_run_data (a_item: !ES_EWEASEL_TEST_RUN_DATA_ITEM) is
			-- Remove `a_list' from `all_test_runs'
		do
			internal_total_test_runs.prune_all (a_item)
		ensure
			pruned: not has_test_data (a_item)
		end

	append_test_run_data (a_list: !ARRAYED_LIST [ES_EWEASEL_TEST_RESULT_ITEM]; a_related_test_cases: !ARRAYED_LIST [ES_EWEASEL_TEST_CASE_ITEM]) is
			-- Added a test run data to session data
		local
			l_item: ES_EWEASEL_TEST_RUN_DATA_ITEM
			l_time: TIME
			l_date: DATE
			l_date_time: DT_DATE_TIME
		do
			create l_time.make_now
			create l_date.make_now

			create l_item.make
			create l_date_time.make (l_date.year, l_date.month, l_date.day, l_time.hour, l_time.minute, l_time.second)
			l_item.set_date_time (l_date_time)

			l_item.set_test_run_data (a_list)
			l_item.set_related_test_cases (a_related_test_cases)

			if not internal_total_test_runs.is_empty and then internal_total_test_runs.count.as_natural_32 >= maximum_remembered_data_count then
				-- Remove first item if data count larger than `maximum_remembered_data_count'
				internal_total_test_runs.start
				internal_total_test_runs.remove
			end

			internal_total_test_runs.extend (l_item)

			current_session_data_index := 0
		ensure
			added: (old internal_total_test_runs.count.as_natural_32 < maximum_remembered_data_count) implies
					(internal_total_test_runs.count = old internal_total_test_runs.count + 1)
			reset: current_session_data_index = 0
		end

feature -- Query

	maximum_remembered_data_count: NATURAL
			-- How many test run data should be remembered?

	has_test_data (a_item: !ES_EWEASEL_TEST_RUN_DATA_ITEM): BOOLEAN
			-- Dose Current have `a_item' ?
		do
			Result := internal_total_test_runs.has (a_item)
		end

	all_test_runs: like internal_total_test_runs is
			-- All test run data's snapshot
		do
			Result := internal_total_test_runs.twin
		end

	current_session_data: ES_EWEASEL_TEST_RUN_DATA_ITEM is
			-- Current session data
			-- Result void if none
		do
			if not internal_total_test_runs.is_empty then
				if internal_total_test_runs.valid_index (current_session_data_index) then
					Result := internal_total_test_runs.i_th (current_session_data_index)
				else
					Result := internal_total_test_runs.last
				end
			end
		end

feature {ES_ALL_TEST_RUN_RESULTS_DIALOG} -- Internal setting

	current_session_data_index: INTEGER
				-- Index of `internal_total_test_runs'
				-- Because end users can select test run data from "all test run" dialog,
				-- we use this value in indicate which session data is current shown in {ES_TESTING_RESULT_TOOL_PANEL}
				-- Value 0 means this is not used

	set_current_session_data_index (a_int: like current_session_data_index) is
			-- Set `current_session_data_index' with `a_int'
		do
			current_session_data_index := a_int
		ensure
			set: current_session_data_index = a_int
		end

feature {NONE} -- Implementation

	internal_total_test_runs: !ARRAYED_LIST [ES_EWEASEL_TEST_RUN_DATA_ITEM]
			-- Total test runs data.


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
