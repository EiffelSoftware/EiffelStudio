note
	description: "[
		Grid row visualizing execution record/state.
	]"
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	ES_TEST_EXECUTION_WIDGET

inherit
	ES_TEST_RECORD_WIDGET [TEST_EXECUTION_I]
		redefine
			on_after_initialized,
			record_from_session,
			internal_recycle
		end

	TEST_EXECUTION_OBSERVER
		redefine
			on_test_running,
			on_test_executed,
			on_test_aborted
		end

create
	make, make_running

feature {NONE} -- Initialization

	on_after_initialized
			-- <Precursor>
		do
			Precursor
			record.tests.do_all (
				agent (a_test_name: READABLE_STRING_8)
					do
						add_result (Void, a_test_name, record.result_for_name (a_test_name))
					end)
			if is_running then
				session.execution_connection.connect_events (Current)
				session.running_tests.do_all (agent add_running_test)
				session.queued_tests.do_all (agent add_queued_test)
			end
			grid.row_select_actions.extend (agent on_select_row)
		end

feature {NONE} -- Access

	running_index: INTEGER
	queued_index: INTEGER
			-- Indices of the first row displaying a running/queued test, a non positive value indicates
			-- that there is not running/queued test displayed.

feature {TEST_EXECUTION_I} -- Events

	on_test_running (a_session: TEST_EXECUTION_I; a_test: TEST_I)
			-- <Precursor>
		do
			remove_subrow (a_test.name)
			add_running_test (a_test)
		end

	on_test_executed (a_session: TEST_EXECUTION_I; a_test: TEST_I; a_result: EQA_RESULT)
			-- <Precursor>
		do
			remove_subrow (a_test.name)
			add_result (a_test, Void, a_result)
		end

	on_test_aborted (a_session: TEST_EXECUTION_I; a_test: TEST_I)
			-- <Precursor>
		do
			remove_subrow (a_test.name)
		end

feature {NONE} -- Events: grid

	on_select_row (a_row: EV_GRID_ROW)
			-- Called when a row in `grid' is selected.
		local
			l_tools: ES_SHELL_TOOLS
		do
			l_tools := develop_window.shell_tools
			if
				attached {ES_TEST_RESULT_GRID_ROW} a_row.data as l_result_row and
				attached {ES_TESTING_RESULTS_TOOL} l_tools.tool ({ES_TESTING_RESULTS_TOOL}) as l_tool
			then
				l_tools.show_tool ({ES_TESTING_RESULTS_TOOL}, True)
				l_tool.show_result (l_result_row.test_result)
			end
		end

feature {NONE} -- Implementation

	append_result (a_test: READABLE_STRING_8; a_result: detachable EQA_RESULT)
		local
			l_grid: like grid
			l_pos: INTEGER
		do
			l_grid := grid
			l_pos := 1 + l_grid.row_count
			l_grid.insert_new_row (l_pos)

			if a_result /= Void then
				perform_with_test_suite (agent add_subrow (a_test, a_result, l_grid.row (l_pos), ?))
			end
		end

	add_subrow (a_test: READABLE_STRING_8; a_result: EQA_RESULT; a_row: EV_GRID_ROW; a_test_suite: TEST_SUITE_S)
		local
			l_row: ES_TEST_RESULT_GRID_ROW
			l_test: TEST_I
		do
			if a_test_suite.has_test (a_test) then
				l_test := a_test_suite.test (a_test)
				create l_row.make_attached (l_test, a_result, a_row)
			else
				create l_row.make (a_test, a_result, a_row)
			end
			subrows.force_last (l_row, a_test)
		end

feature {NONE} -- Implementation

	add_result (a_test: detachable TEST_I; a_test_name: detachable READABLE_STRING_8; a_result: EQA_RESULT)
			-- Add result subrow to `row'.
			--
			-- `a_test': Test.
			-- `a_test_name': Name of test.
			-- `a_result': Test result.
		require
			a_result_attached: a_result /= Void
			a_test_xor_a_test_name_attached: a_test /= Void xor a_test_name /= Void
		local
			l_pos: INTEGER
			l_test: detachable TEST_I
			l_name: like a_test_name
			l_grid: like grid
			l_subrow: ES_TEST_RESULT_GRID_ROW
		do
			l_grid := grid
			l_pos := l_grid.row_count + 1
			if queued_index > 0 then
				l_pos := queued_index
				queued_index := l_pos + 1
			end
			if running_index > 0 then
				l_pos := running_index
				running_index := l_pos + 1
			end
			l_grid.insert_new_row (l_pos)
			if a_test_name /= Void then
				l_test := test_from_name (a_test_name)
				l_name := a_test_name
			else
				l_test := a_test
				l_name := l_test.name
			end
			if l_test /= Void then
				create l_subrow.make_attached (l_test, a_result, l_grid.row (l_pos))
			else
				create l_subrow.make (l_name, a_result, l_grid.row (l_pos))
			end
			subrows.force_last (l_subrow, l_name)
		end

	add_running_test (a_test: TEST_I)
			-- Add running test subrow to `row'.
			--
			-- `a_test': Test currently running.
		require
			a_test_attached: a_test /= Void
			a_test_usable: a_test.is_interface_usable
			running: is_running
		local
			l_pos: INTEGER
			l_subrow: ES_RUNNING_TEST_GRID_ROW
			l_grid: like grid
		do
			l_grid := grid
			l_pos := l_grid.row_count + 1
			if queued_index > 0 then
				l_pos := queued_index
				queued_index := l_pos + 1
			end
			if running_index = 0 then
				running_index := l_pos
			end
			l_grid.insert_new_row (l_pos)
			create l_subrow.make_attached (a_test, l_grid.row (l_pos))
			subrows.force_last (l_subrow, a_test.name)
		end

	add_queued_test (a_test: TEST_I)
			-- Add queued test subrow to `row'.
			--
			-- `a_test': Test currently queued.
		require
			a_test_attached: a_test /= Void
			a_test_usable: a_test.is_interface_usable
			running: is_running
		local
			l_pos: INTEGER
			l_subrow: ES_QUEUED_TEST_GRID_ROW
			l_grid: like grid
		do
			l_grid := grid
			l_pos := l_grid.row_count + 1
			if queued_index = 0 then
				queued_index := l_pos
			end
			l_grid.insert_new_row (l_pos)
			create l_subrow.make_attached (a_test, l_grid.row (l_pos))
			subrows.force_last (l_subrow, a_test.name)
		end

	remove_subrow (a_test_name: READABLE_STRING_8)
			-- Remove subrow for test with name `a_test_name'.
		require
			a_test_name_attached: a_test_name /= Void
		local
			l_subrows: like subrows
			l_subrow: ES_TEST_GRID_ROW
			l_index: INTEGER
			l_grid: like grid
		do
			l_subrows := subrows
			l_subrows.search (a_test_name)
			if l_subrows.found then
				l_grid := grid
				l_subrow := l_subrows.found_item
				l_index := l_subrow.row.index
				if queued_index > 0 and then l_index <= l_grid.row (queued_index).index then
					if l_index = l_grid.row (queued_index).index then
						if queued_index = l_grid.row_count then
							queued_index := 0
						end
					else
						queued_index := queued_index - 1
					end
				end
				if running_index > 0 and then l_index <= l_grid.row (running_index).index then
					if l_index = l_grid.row (running_index).index then
							-- Note: `queued_index' may have been decreased above, so we can check for equality with `running_index'
						if running_index = queued_index or running_index = l_grid.row_count then
							running_index := 0
						end
					else
						running_index := running_index - 1
					end
				end
				l_grid.remove_row (l_subrow.row.index)
				l_subrows.remove_found_item
			end
		ensure
			removed: not subrows.has (a_test_name)
		end

feature {NONE} -- Factory

	record_from_session (a_session: TEST_EXECUTION_I): TEST_EXECUTION_RECORD
			-- <Precursor>
		do
			Result := a_session.record
		end

feature {NONE} -- Clean

	internal_recycle
			-- <Precursor>
		do
			Precursor
			if is_running then
				session.execution_connection.disconnect_events (Current)
			end
		end

invariant
	running_index_valid: running_index > 0 implies is_running
	queued_index_valid: queued_index > 0 implies is_running
	indices_valid: (running_index > 0 and queued_index > 0) implies running_index < queued_index

note
	copyright: "Copyright (c) 1984-2010, Eiffel Software"
	license: "GPL version 2 (see http://www.eiffel.com/licensing/gpl.txt)"
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
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"
end
