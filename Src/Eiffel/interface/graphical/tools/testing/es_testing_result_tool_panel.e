indexing
	description: "[
						This tool showing result from eweasel tests.
						This tool can also manage all test run data, compare test results etc.
						
						The eweasel tests is controled by {ES_TESTING_TOOL_PANEL}
																					]"
	status: "See notice at end of class."
	legal: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	ES_TESTING_RESULT_TOOL_PANEL

inherit
	ES_CLICKABLE_EVENT_LIST_TOOL_PANEL_BASE
		export
			{ES_TEST_RUN_RESULT_GRID_MANAGER} create_clickable_grid_item
		redefine
			build_tool_interface,
			on_after_initialized,
			is_appliable_event,
			row_item_text
		end

create
	make

feature {NONE} -- Redefine

	build_tool_interface (a_grid: ES_GRID) is
			-- <Precursor>
		local
			l_cell: EV_CELL
			l_box: EV_BOX
			l_contants: EV_LAYOUT_CONSTANTS
			l_level_2_3_vertical_box: EV_VERTICAL_BOX
			l_top_container: EV_VERTICAL_BOX
		do
			Precursor {ES_CLICKABLE_EVENT_LIST_TOOL_PANEL_BASE} (a_grid)
			failure_trace_grid := a_grid

			create l_contants
			-- Level 2 2nd box
			 l_top_container := widget
			-- Level 2 3rd box
			create l_level_2_3_vertical_box
			l_level_2_3_vertical_box.set_padding_width (l_contants.default_padding_size)
			l_top_container.extend (l_level_2_3_vertical_box)
			l_top_container.disable_item_expand (l_level_2_3_vertical_box)

			create {EV_HORIZONTAL_BOX} l_box
			l_box.set_padding_width (l_contants.default_padding_size)
			l_box.set_border_width (l_contants.default_border_size)
			l_level_2_3_vertical_box.extend (l_box)
			l_level_2_3_vertical_box.disable_item_expand (l_box)

			create l_cell
			l_box.extend (l_cell)

			check not_void: failure_trace_grid /= Void end
		ensure then
			set: failure_trace_grid = a_grid
		end

	on_after_initialized is
			-- <Precursor>
			-- Build own interface after base interface created
		local
			l_shared: SHARED_EIFFEL_PROJECT
		do
			test_run_result_grid_manager.build_columns
			-- Enable sorting
			enable_sorting_on_columns (test_run_result_grid_manager.all_columns)

			enable_copy_to_clipboard

			create l_shared
			if l_shared.eiffel_project.manager.is_project_loaded then
				test_run_result_grid_manager.restore_test_run_data
			else
				l_shared.eiffel_project.manager.load_agents.extend (agent test_run_result_grid_manager.restore_test_run_data)
			end
		end

	populate_event_grid_row_items (a_event_item: EVENT_LIST_ITEM_I; a_row: EV_GRID_ROW) is
			-- <Precursor>
		do
			if {l_testing_event: EVENT_LIST_TESTING_RESULT_ITEM} a_event_item then
				if {l_result: ES_EWEASEL_TEST_RESULT_ITEM} l_testing_event.data then
					test_run_result_grid_manager.append_result_item (l_result, a_row)
				end
			end
		end

	do_default_action (a_row: EV_GRID_ROW) is
			-- <Precursor>
		local
			l_factory: ES_EWEASEL_SINGLETON_FACTORY
			l_testing_tool: ES_TESTING_TOOL_PANEL
			l_row: EV_GRID_ROW
			l_conf_class: CONF_CLASS
			l_util: ES_TEST_CASE_FINDER
		do
			create l_factory
			-- If testing tool initialized, we select that row related with `a_row'
			l_testing_tool := l_factory.manager.testing_tool
			if l_testing_tool /= Void then
				if {l_event_list: EVENT_LIST_ITEM} a_row.data then
					if {l_test_run_result: ES_EWEASEL_TEST_RESULT_ITEM} l_event_list.data then
						if l_test_run_result.root_class_name /= Void then
							create l_util
							if {lt_class_name: STRING} l_test_run_result.root_class_name.as_string_8 then
								l_conf_class := l_util.conf_class_of (lt_class_name)
								if {lt_conf_class: CONF_CLASS} l_conf_class then
									l_row := l_testing_tool.test_case_grid_manager.test_case_row_related_with (lt_conf_class)
									if l_row /= Void then
										l_testing_tool.content.set_focus
										l_testing_tool.test_case_grid_manager.unselect_all_rows
										l_row.enable_select
										-- Start test for that row
										if l_factory.manager.start_test_run_command.executable then
											l_factory.manager.start_test_run_command.execute
										end
									end
								end
							end
						end
					end
				end
			end
		end

	create_tool_bar_items: DS_ARRAYED_LIST [SD_TOOL_BAR_ITEM] is
			-- <Precursor>
		local
			l_shared: ES_EWEASEL_SINGLETON_FACTORY
			l_manager: ES_EWEASEL_EXECUTION_MANAGER
			l_show_failure_trace_button: SD_TOOL_BAR_BUTTON
			l_shim: ES_TESTING_TOOL
			l_show_tool_command: ES_SHOW_TOOL_COMMAND
		do
			create l_shared
			l_manager := l_shared.manager

			create Result.make (3)
			Result.force_last (l_manager.all_test_run_results_command.new_sd_toolbar_item (False))

			l_show_failure_trace_button := l_manager.see_testing_failure_trace_command.new_sd_toolbar_item (False)
			l_show_failure_trace_button.select_actions.extend (agent set_is_failure_trace_button_enabled)
			if is_failure_trace_button_enabled then
				l_manager.see_testing_failure_trace_command.enable_select
			end
			Result.force_last (l_show_failure_trace_button)

			-- FIXIT: This button is not implemented now
--			Result.force_last (l_manager.compare_with_expected_result_command.new_sd_toolbar_item (False))

			Result.force_last (create {SD_TOOL_BAR_SEPARATOR}.make)

			l_shim ?= develop_window.shell_tools.tool ({ES_TESTING_TOOL})
			if l_shim /= Void then
				l_show_tool_command := develop_window.commands.show_shell_tool_commands.item (l_shim)
				Result.force_last (l_show_tool_command.new_sd_toolbar_item (False))
			end
		end

	is_appliable_event (a_item: EVENT_LIST_ITEM_I): BOOLEAN is
			-- <Precursor>
		do
			Result := a_item /= Void and then a_item.category = {ENVIRONMENT_CATEGORIES}.testing and then
						{l_test: EVENT_LIST_TESTING_RESULT_ITEM} a_item
		end

	row_item_text (a_item: EV_GRID_ITEM): STRING_32
			-- <Precursor>
		local
			l_label_item: EV_GRID_LABEL_ITEM
		do
			l_label_item ?= a_item
			if l_label_item /= Void then
				Result := l_label_item.text
				if Result /= Void and then not Result.is_empty then
					-- We added "%N" back to the texts
					Result.replace_substring_all ("%R", "%R%N")
				end
			end
			if Result = Void then
				Result := Precursor (a_item)
			end
		end

feature -- Query

	test_run_result_grid_manager: !ES_TEST_RUN_RESULT_GRID_MANAGER is
			-- Manager of `failure_trace_grid'
		do
			if not {l_test: ES_TEST_RUN_RESULT_GRID_MANAGER} internal_test_run_result_grid_manager then
				create internal_test_run_result_grid_manager.make (failure_trace_grid)
			end
			Result := internal_test_run_result_grid_manager
		end

feature {NONE} -- Implementation

	set_is_failure_trace_button_enabled is
			-- Set `session_data_id_show_failure_trace_enabled' session data
		local
			l_shared: ES_EWEASEL_SINGLETON_FACTORY
		do
			create l_shared
			session_data.set_value (l_shared.manager.see_testing_failure_trace_command.is_selected, session_data_id_show_failure_trace_enabled)
		end

	is_failure_trace_button_enabled: BOOLEAN is
			-- If failure trace button enabled in last time running Eiffel Studio?
		do
			if {l_result: BOOLEAN} session_data.value (session_data_id_show_failure_trace_enabled) then
				Result := l_result
			end
		end

	session_data_id_show_failure_trace_enabled: STRING is "com.eiffel.testing.show_failure_trace_enabled"
			-- Session data used for session service	
			-- This id means whether show failure trace button is selected	

	failure_trace_grid: ES_GRID
			-- Grid to show all failed test run results.

	internal_test_run_result_grid_manager: like test_run_result_grid_manager;
			-- Instance holder.
			-- Used by `test_run_result_grid_manager' ONLY!

indexing
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
