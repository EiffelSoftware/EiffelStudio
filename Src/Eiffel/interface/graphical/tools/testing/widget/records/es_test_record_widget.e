note
	description: "[
		Widget displaying the contents of a {TEST_SESSION_RECORD}.
	]"
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	ES_TEST_RECORD_WIDGET [G -> TEST_SESSION_I]

inherit
	ES_TEST_SESSION_WIDGET [TEST_SESSION_I]
		rename
			make as make_session_widget
		end

create
	make, make_running

feature {NONE} -- Initialization

	make (a_window: like develop_window; a_record: like record)
			-- Initialize `Current'.
			--
			-- `a_record': Record being shown in `Current'.
		do
			record := a_record
			create subrows.make (10)
			make_session_widget (a_window)
		end

	make_running (a_window: like develop_window; a_session: like session)
			-- Initialize `Current' with a running session.
			--
			-- `a_session': Currently running session.
		require
			a_session_attached: a_session /= Void
			a_session_usable: a_session.is_interface_usable
			a_session_running: a_session.has_next_step
		do
			make (a_window, record_from_session (a_session))
		end

	build_widget_interface (a_widget: like create_widget)
			-- <Precursor>
		do
			create grid
			grid.disable_tree
			grid.enable_single_row_selection
			grid.set_column_count_to (1)
			grid.enable_last_column_use_all_width
			grid.hide_header
			a_widget.extend (grid)
		end

feature -- Access

	record: like record_from_session
			-- Record being shown in `Current'

feature {NONE} -- Access

	grid: ES_TESTING_TOOL_GRID
			-- Grid in which record details are displayed

	subrows: DS_HASH_TABLE [ES_TEST_GRID_ROW, READABLE_STRING_8]
			-- Table containing test names and the corresponding grid row

	session: G
			-- Running session attached to `record'
		require
			running: is_running
		local
			l_result: detachable G
		do
			if attached {G} record.session as l_session then
				l_result := l_session
			else
				check l_result /= Void end
			end
			Result := l_result
		ensure
			valid_result: Result = record.session
		end

	test_from_name (a_name: READABLE_STRING_8): detachable TEST_I
			-- Test instance given it's name if available
			--
			-- `a_name': Name of the test for which its instance should be returned.
			-- `Result': Test from test suite.
		require
			a_name_attached: a_name /= Void
		local
			l_function: FUNCTION [ANY, TUPLE [TEST_SUITE_S], detachable TEST_I]
		do
			l_function := agent (a_test_suite: TEST_SUITE_S; a_n: READABLE_STRING_8): detachable TEST_I
				do
					if a_test_suite.has_test (a_n) then
						Result := a_test_suite.test (a_n)
					end
				end (?, a_name)
			if is_running then
				l_function.call ([session.test_suite])
			else
				perform_with_test_suite (l_function)
			end
			Result := l_function.last_result
		ensure
			result_valid: Result /= Void implies Result.name.same_string (a_name)
		end

feature {NONE} -- Status report

	is_running: BOOLEAN
			-- Is `record' currently attached to a running session?
		do
			Result := record.is_running
		ensure
			result_implies_record_running: Result implies record.is_running
		end

feature {ES_TEST_RECORDS_TAB} -- Basic operations

	on_record_update
			-- Called when `record' is updated.
		do
		end

	on_record_property_update
			-- Called when a property of `record' is updated.
		do
		end

feature {NONE} -- Factory

	create_widget: EV_VERTICAL_BOX
			-- <Precursor>
		do
			create Result
		end

	record_from_session (a_session: G): TEST_SESSION_RECORD
			-- Retrieve record from given session.
		require
			a_session_usable: a_session.is_interface_usable
			a_session_running: a_session.has_next_step
		do
			Result := a_session.record
		end

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
