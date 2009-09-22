note
	description: "[
		Grid row visualizing execution record/state.
	]"
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	ES_TEST_EXECUTION_GRID_ROW

inherit
	ES_TEST_RECORD_GRID_ROW [TEST_EXECUTION_I, TEST_EXECUTION_RECORD]
		redefine
			make_running,
			detach_session,
			show_content
		end

	TEST_EXECUTION_OBSERVER
		redefine
			on_test_running,
			on_test_executed,
			on_test_removed
		end

	SHARED_TEST_SERVICE

create
	make, make_running

feature {NONE} -- Initialization

	make_running (a_session: like session; a_row: like row; a_icons_provider: like icons_provider)
			-- <Precursor>
		do
			Precursor (a_session, a_row, a_icons_provider)
			session.execution_connection.connect_events (Current)
			if row.is_expandable and not row.is_expanded then
				row.expand
			end
		end

feature {NONE} -- Access

	pixmap: EV_PIXMAP
			-- <Precursor>
		do
			Result := icon_pixmaps.debug_run_icon
		end

	label: STRING
			-- <Precursor>
		local
			l_count: INTEGER
		do
			if is_running then
				l_count := session.initial_test_count.to_integer_32
			else
				l_count := record.tests.count
			end
			Result := "Execute " + l_count.out + " Tests"
		end

	running_index: INTEGER
	queued_index: INTEGER
			-- Indices of the first row displaying a running/queued test, a non positive value indicates
			-- that there is not running/queued test displayed.

feature {NONE} -- Status report

	is_expandable: BOOLEAN = True
			-- <Precursor>

feature {NONE} -- Basic operations

	show_content
			-- <Precursor>
		do
			Precursor
			record.tests.do_all (
				agent (a_test_name: READABLE_STRING_8)
					do
						add_result (Void, a_test_name, record.result_for_name (a_test_name))
					end)
			if is_running then
				session.running_tests.do_all (agent add_running_test)
				session.queued_tests.do_all (agent add_queued_test)
			end
		end

feature {ES_TEST_RECORDS_TAB} -- Status setting

	detach_session
			-- <Precursor>
		do
			session.execution_connection.disconnect_events (Current)
			Precursor
		end

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

	on_test_removed (a_session: TEST_EXECUTION_I; a_test: TEST_I)
			-- <Precursor>
		do
			remove_subrow (a_test.name)
		end

feature {NONE} -- Implementation

	append_result (a_test: READABLE_STRING_8; a_result: detachable EQA_RESULT)
		local
			l_row: like row
			l_pos: INTEGER
			l_do_expansion: BOOLEAN
		do
			if is_expanded then
				l_row := row
				l_do_expansion := l_row.subrow_count = 0 and not l_row.is_expanded
				l_pos := 1 + l_row.subrow_count
				l_row.insert_subrow (l_pos)

				if a_result /= Void then
					perform_with_test_suite (agent add_subrow (a_test, a_result, l_row.subrow (l_pos), ?))
				end

				if l_do_expansion then
					l_row.expand
				end
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
			is_expanded: is_expanded
		local
			l_pos: INTEGER
			l_test: detachable TEST_I
			l_name: like a_test_name
			l_row: like row
			l_subrow: ES_TEST_RESULT_GRID_ROW
		do
			l_pos := row.subrow_count + 1
			if queued_index > 0 then
				l_pos := queued_index
				queued_index := l_pos + 1
			end
			if running_index > 0 then
				l_pos := running_index
				running_index := l_pos + 1
			end
			l_row := row
			l_row.insert_subrow (l_pos)
			if a_test_name /= Void then
				l_test := test_from_name (a_test_name)
				l_name := a_test_name
			else
				l_test := a_test
				l_name := l_test.name
			end
			if l_test /= Void then
				create l_subrow.make_attached (l_test, a_result, l_row.subrow (l_pos))
			else
				create l_subrow.make (l_name, a_result, l_row.subrow (l_pos))
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
			is_expanded: is_expanded
		local
			l_pos: INTEGER
			l_subrow: ES_RUNNING_TEST_GRID_ROW
			l_row: like row
		do
			l_pos := row.subrow_count + 1
			if queued_index > 0 then
				l_pos := queued_index
				queued_index := l_pos + 1
			end
			if running_index = 0 then
				running_index := l_pos
			end
			l_row := row
			l_row.insert_subrow (l_pos)
			create l_subrow.make_attached (a_test, l_row.subrow (l_pos))
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
			is_expanded: is_expanded
		local
			l_pos: INTEGER
			l_subrow: ES_QUEUED_TEST_GRID_ROW
			l_row: like row
		do
			l_pos := row.subrow_count + 1
			if queued_index = 0 then
				queued_index := l_pos
			end
			l_row := row
			l_row.insert_subrow (l_pos)
			create l_subrow.make_attached (a_test, l_row.subrow (l_pos))
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
			l_row: like row
			l_grid: detachable EV_GRID
		do
			l_subrows := subrows
			l_subrows.search (a_test_name)
			if l_subrows.found then
				l_row := row
				l_subrow := l_subrows.found_item
				l_index := l_subrow.row.index
				if queued_index > 0 and then l_index <= l_row.subrow (queued_index).index then
					if l_index = l_row.subrow (queued_index).index then
						if queued_index = l_row.subrow_count then
							queued_index := 0
						end
					else
						queued_index := queued_index - 1
					end
				end
				if running_index > 0 and then l_index <= l_row.subrow (running_index).index then
					if l_index = l_row.subrow (running_index).index then
							-- Note: `queued_index' may have been decreased above, so we can check for equality with `running_index'
						if running_index = queued_index or running_index = l_row.subrow_count then
							running_index := 0
						end
					else
						running_index := running_index - 1
					end
				end
				l_grid := l_row.parent
				check l_grid /= Void end
				l_grid.remove_row (l_subrow.row.index)
				l_subrows.remove_found_item
			end
		ensure
			removed: not subrows.has (a_test_name)
		end

invariant
	running_index_valid: running_index > 0 implies is_running
	queued_index_valid: queued_index > 0 implies is_running
	indices_valid: (running_index > 0 and queued_index > 0) implies running_index < queued_index

note
	copyright: "Copyright (c) 1984-2009, Eiffel Software"
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
