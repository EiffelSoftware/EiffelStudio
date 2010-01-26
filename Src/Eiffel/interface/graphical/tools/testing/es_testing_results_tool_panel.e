note
	description: "[
		Graphical panel for EiffelStudio's testing results tool.
	]"
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	ES_TESTING_RESULTS_TOOL_PANEL

inherit
	ES_DOCKABLE_TOOL_PANEL [EV_VERTICAL_BOX]

create {ES_TESTING_RESULTS_TOOL}
	make

feature {NONE} -- Initialization

	build_tool_interface (a_widget: EV_VERTICAL_BOX)
			-- <Precursor>
		do
			create notebook
			build_editor_widget
			build_comparison_widget
			a_widget.extend (notebook)
		end

	build_editor_widget
			-- Initialize `editor_widget'.
		local
			l_editor: EB_CLICKABLE_EDITOR
			l_tab: EV_NOTEBOOK_TAB
		do
			create editor_widget.make (develop_window)
			l_editor := editor_widget.editor
			l_editor.disable_line_numbers
			l_editor.disable_editable
			l_editor.disable_has_breakable_slots
			l_editor.set_read_only (True)
			l_editor.set_focus
			notebook.extend (editor_widget)
			l_tab := notebook.item_tab (editor_widget)
			l_tab.set_text (locale.translation (t_details_title))
		end

	build_comparison_widget
			-- Initialize `comparison_widget'.
		do
			create comparison_widget.make (develop_window)
			notebook.extend (comparison_widget.widget)
			notebook.item_tab (comparison_widget.widget).set_text (locale.translation (t_comparison_title))
		end

feature {NONE} -- Access

	notebook: EV_NOTEBOOK
			-- Notebook for switching between result details/comparison

	editor_widget: ES_EDITOR_WIDGET
			-- Editor showing results details

	comparison_widget: ES_TEST_COMPARISON_WIDGET
			-- Widget used to compare different test suite states	

feature {ES_TESTING_RESULTS_TOOL} -- Basic operations

	show_result (a_result: TEST_RESULT_I)
			-- Display details for given result.
			--
			-- `a_result': Testing result.
		require
			a_result_attached: a_result /= Void
		do
			clear
			notebook.select_item (editor_widget)
			editor_widget.editor.handle_before_processing (True)
			a_result.print_details (editor_widget.editor.text_displayed, True)
			editor_widget.editor.handle_after_processing
		end

	compare_states (a_file_name: READABLE_STRING_8)
			-- Compare current test suite state with results from file.
			--
			-- `a_file_name': File name in which exported results are stored.
		do
			notebook.select_item (comparison_widget.widget)
			comparison_widget.compare_states (a_file_name)
		end

	clear
			-- Remove any result details.
		do
			editor_widget.clear
		end

feature {NONE} -- Factory

	create_tool_bar_items: detachable DS_ARRAYED_LIST [SD_TOOL_BAR_ITEM]
			-- <Precursor>
		do
		end

	create_widget: EV_VERTICAL_BOX
			-- <Precursor>
		do
			create Result
		end

feature {NONE} -- Internationalization

	t_details_title: STRING = "Details"
	t_comparison_title: STRING = "Comparison"

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
