note
	description: "[
		Notebook widget showing execution states and results.
	]"
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	ES_TEST_EXECUTION_WIDGET

inherit
	ES_TEST_RECORDS_TAB [TEST_EXECUTION_I, TEST_EXECUTION_RECORD, ES_TEST_EXECUTION_GRID_ROW]
		redefine
			record,
			on_after_initialized
		end

create
	make

feature {NONE} -- Initialization

	on_after_initialized
			-- <Precursor>
		do
			Precursor
			grid.row_select_actions.extend (agent on_row_select)
			grid.row_deselect_actions.extend (agent on_row_deselect)
		end

feature {NONE} -- Access

	last_selected_row: detachable EV_GRID_ROW
			-- Row for which result details were last displayed

feature {NONE} -- Events

	on_row_select (a_row: EV_GRID_ROW)
			-- Called when a row in `grid' is selected.
			--
			-- `a_row': Row that was selected.
		require
			a_row_attached: a_row /= Void
		local
			l_tools: ES_SHELL_TOOLS
		do
			l_tools := icons_provider.tool.window.shell_tools
			if
				attached {ES_TEST_RESULT_GRID_ROW} a_row.data as l_result_row and
				attached {ES_TESTING_RESULTS_TOOL} l_tools.tool ({ES_TESTING_RESULTS_TOOL}) as l_tool
			then
				l_tool.show_result (l_result_row.test_result)
				l_tools.show_tool ({ES_TESTING_RESULTS_TOOL}, True)
				last_selected_row := a_row
			end
		end

	on_row_deselect (a_row: EV_GRID_ROW)
			-- Called when a row in `grid' is deselected.
			--
			-- `a_row': Row that was deselected.
		require
			a_row_attached: a_row /= Void
		do
			if
				last_selected_row = a_row and
				attached {ES_TESTING_RESULTS_TOOL} icons_provider.tool.window.shell_tools.tool ({ES_TESTING_RESULTS_TOOL}) as l_tool
			then
				l_tool.clear
				last_selected_row := Void
			end
		end

feature {NONE} -- Access

	record (a_session: TEST_EXECUTION_I): TEST_EXECUTION_RECORD
			-- <Precursor>
		do
			Result := a_session.record
		end

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
