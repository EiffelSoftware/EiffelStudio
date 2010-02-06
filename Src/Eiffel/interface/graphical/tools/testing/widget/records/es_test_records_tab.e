note
	description: "[
		Notebook widgets which are capable of displaying test session records of a certain type.
	]"
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	ES_TEST_RECORDS_TAB

inherit
	ES_NOTEBOOK_WIDGET [EV_VERTICAL_BOX]
		rename
			make as make_session_widget
		undefine
			internal_recycle
		redefine
			on_after_initialized
		end

	TEST_RECORD_REPOSITORY_OBSERVER
		redefine
			on_record_added,
			on_record_removed,
			on_record_updated,
			on_record_property_updated
		end

	ES_SHARED_TEST_SERVICE

	ES_SHARED_TEST_GRID_UTILITIES

create
	make

feature {NONE} -- Initialization

	make (a_icons_provider: like icons_provider)
			-- Initialize `Current'.
			--
			-- `a_icons_provider': Icons provider for testing tool icons.
		require
			a_icons_provider_attached: a_icons_provider /= Void
		do
			icons_provider := a_icons_provider
			make_session_widget
		ensure
			icons_provider_set: icons_provider = a_icons_provider
		end

	build_notebook_widget_interface (a_widget: EV_VERTICAL_BOX)
			-- <Precursor>
		do
			create record_widget_cell
			a_widget.set_border_width (1)
			a_widget.set_background_color (colors.stock_colors.gray)
			a_widget.extend (record_widget_cell)
		end

	on_after_initialized
			-- <Precursor>
		do
			Precursor
			perform_with_test_suite (
				agent (a_test_suite: TEST_SUITE_S)
					do
						a_test_suite.record_repository.connection.connect_events (Current)
					end)
			display_empty_widget
		end

feature {NONE} -- Access

	icons_provider: ES_TESTING_TOOL_PANEL
			-- Icons provider for testing tool icons.

	record_widget_cell: EV_VERTICAL_BOX
			-- Box in which `record_widget' is shown

	record_widget: ES_TEST_RECORD_WIDGET [TEST_SESSION_I]
			-- Widget currently displaying a record
		require
			record_displayed: is_record_displayed
		local
			l_result: like internal_record_widget
		do
			l_result := internal_record_widget
			check l_result /= Void end
			Result := l_result
		end

	internal_record_widget: detachable like record_widget
			-- Internal storage for `record_widget'

feature {NONE} -- Access: buttons

	records_button: SD_TOOL_BAR_POPUP_BUTTON
			-- Button for selecting a record

	export_button: SD_TOOL_BAR_BUTTON
			-- Button for exporting current test suite state

	compare_button: SD_TOOL_BAR_BUTTON
			-- Button to compare different test suite states

	records_menu: EV_MENU
			-- Menu displayed when the user clicks on the `records_button'
		local

		do
			create Result
			perform_with_test_suite (agent fill_records_menu (?, Result))
		ensure
			result_attached: Result /= Void
		end

feature {NONE} -- Status report

	is_record_displayed: BOOLEAN
			-- Is a record currently being displayed in `widget'?
		do
			Result := internal_record_widget /= Void
		end

feature {NONE} -- Query

	is_valid_record (a_record: TEST_SESSION_RECORD): BOOLEAN
			-- Is given record valid to be displayed in `Current'?
		do
			Result := attached {TEST_CREATION_RECORD} a_record or
				attached {TEST_EXECUTION_RECORD} a_record
		end

feature {TEST_RECORD_REPOSITORY_I} -- Events: record repository

	on_record_added (a_repo: TEST_RECORD_REPOSITORY_I; a_record: TEST_SESSION_RECORD)
			-- <Precursor>
		do
			if is_valid_record (a_record) and a_record.is_running then
				if is_record_displayed then
					remove_displayed_record
				end
				display_record (a_record)
			end
		end

	on_record_removed (a_repo: TEST_RECORD_REPOSITORY_I; a_record: TEST_SESSION_RECORD)
			-- <Precursor>
		do
			if is_record_displayed and then record_widget.record = a_record then
				remove_displayed_record
			end
		end

	on_record_property_updated (a_repo: TEST_RECORD_REPOSITORY_I; a_record: TEST_SESSION_RECORD)
			-- <Precursor>
		do
			if is_record_displayed and then record_widget.record = a_record then
				record_widget.on_record_property_update
			end
		end

	on_record_updated (a_repo: TEST_RECORD_REPOSITORY_I; a_record: TEST_SESSION_RECORD)
			-- <Precursor>
		do
			if is_record_displayed and then record_widget.record = a_record then
				record_widget.on_record_update
			end
		end

feature {NONE} -- Events: button

	on_record_menu_select (a_record: TEST_SESSION_RECORD)
			-- Called when record in `records_menu' is selected.
			--
			-- `a_record': Record that was selected.
		require
			an_item_attached: a_record /= Void
		do
			if not is_record_displayed or else record_widget.record /= a_record then
				if is_record_displayed then
					remove_displayed_record
				end
				display_record (a_record)
			end
		end

	on_remove_terminated_records
			-- Called when menu item to remove terminated records is selected.
		do
			perform_with_test_suite (agent remove_record)
		end

	on_compare_button_selected
			-- Called when `compare_button' is pressed.
		local
			l_tools: ES_SHELL_TOOLS
		do
			l_tools := icons_provider.develop_window.shell_tools
			if attached {ES_TESTING_RESULTS_TOOL} l_tools.tool ({ES_TESTING_RESULTS_TOOL}) as l_tool then
				l_tool.compare_states
			end
		end

	on_export_button_selected
			-- Called when `export_button' is pressed.
		local
			l_dialog: EV_FILE_SAVE_DIALOG
			l_prompt: ES_QUESTION_PROMPT
			l_file: RAW_FILE
		do
			create l_dialog
			l_dialog.show_modal_to_window (window)
			if not l_dialog.file_name.is_empty then
				create l_file.make (l_dialog.file_name)
				if l_file.exists then
					create l_prompt.make_standard (locale.translation (d_file_exists))
					l_prompt.set_button_action (l_prompt.default_confirm_button, agent export_state (l_dialog.file_name))
					l_prompt.show (window)
				else
					export_state (l_dialog.file_name)
				end
			end
		end

feature {NONE} -- Basic operations

	display_record (a_record: TEST_SESSION_RECORD)
			-- Display record through `record_widget'.
		require
			not_record_displayed: not is_record_displayed
			a_record_valid: is_valid_record (a_record)
		local
			l_widget: like record_widget
		do
			record_widget_cell.wipe_out
			if a_record.is_running then
				l_widget := create_record_widget_from_session (a_record.session)
			else
				l_widget := create_record_widget (a_record)
			end
			internal_record_widget := l_widget
			record_widget_cell.extend (l_widget.widget)
		ensure
			record_displayed: is_record_displayed
			a_record_displayed: record_widget.record = a_record
		end

	remove_displayed_record
			-- Remove current record being displayed in `record_widget'.	
		require
			record_displayed: is_record_displayed
		do
			display_empty_widget
			record_widget.recycle
			internal_record_widget := Void
		ensure
			not_record_displayed: not is_record_displayed
		end

feature {NONE} -- Implementation

	display_empty_widget
			-- Display an empty white cell in `record_widget_cell'.
		local
			l_cell: EV_CELL
		do
			record_widget_cell.wipe_out
			create l_cell
			l_cell.set_background_color ((create {EV_STOCK_COLORS}).white)
			record_widget_cell.extend (l_cell)
		end

	fill_records_menu (a_test_suite: TEST_SUITE_S; a_menu: EV_MENU)
			-- Fill given menu with records form the current test suite.
			--
			-- `a_test_suite': Test suite containing records.
			-- `a_menu': Menu to initialized for selecting a specific record.
		require
			a_test_suite_attached: a_test_suite /= Void
			a_menu_attached: a_menu /= Void
		local
			l_records: ARRAYED_LIST [TEST_SESSION_RECORD]
			l_record: TEST_SESSION_RECORD
			l_item: EV_CHECK_MENU_ITEM
			l_ditem: EV_MENU_ITEM
			l_separator_pos: INTEGER
			l_label: STRING_32
			l_has_records, l_has_terminated: BOOLEAN
		do
			l_records := a_test_suite.record_repository.records
			from
				l_records.start
			until
				l_records.after
			loop
				l_record := l_records.item_for_iteration
				if is_valid_record (l_record) then
					l_has_records := True
					create l_label.make (50)
					l_label.append (date_time (l_record.creation_date))
					create l_item
					register_action (l_item.select_actions, agent on_record_menu_select (l_record))
					if is_record_displayed and then record_widget.record = l_record then
						l_item.enable_select
					end
					l_item.set_pixmap (stock_pixmaps.debug_run_icon)
					l_item.set_data (l_record)
					if l_record.is_running then
						a_menu.put_front (l_item)
						l_separator_pos := l_separator_pos + 1
						l_label.append_character ('%T')
						l_label.append_string (locale.translation (l_running))
					else
						l_has_terminated := True
						if attached {TEST_EXECUTION_RECORD} l_record as l_exec_record then
							l_label.append_character ('%T')
							l_label.append_integer (l_exec_record.tests.count)
							l_label.append_string (" tests")
						end
						a_menu.go_i_th (l_separator_pos)
						a_menu.put_right (l_item)
					end
					l_item.set_text (l_label)
				end
				l_records.forth
			end
			if l_has_records then
				if l_has_terminated and l_separator_pos > 0 then
					a_menu.go_i_th (l_separator_pos)
					a_menu.put_right (create {EV_MENU_SEPARATOR})
				end
				a_menu.force (create {EV_MENU_SEPARATOR})
				create l_ditem.make_with_text (locale.translation (l_remove_terminated))
				if not l_has_terminated then
					l_ditem.disable_sensitive
				end
				register_action (l_ditem.select_actions, agent on_remove_terminated_records)
			else
				create l_ditem.make_with_text (locale.translation (l_no_results))
				l_ditem.disable_sensitive
			end
			a_menu.force (l_ditem)
		end

	export_state (a_file_name: READABLE_STRING_8)
			-- Export test suite state to file.
			--
			-- `a_file_name': Name of file in which state is written.
		require
			a_file_name_attached: a_file_name /= Void
		local
			l_exporter: TEST_STATE_SERIALIZER
			l_prompt: ES_PROMPT
			l_message: STRING_32
			l_success: BOOLEAN
		do
			create l_exporter
			l_exporter.serialize_to_file (a_file_name)
			inspect
				l_exporter.last_error_code
			when {TEST_STATE_SERIALIZER}.test_suite_unavailable then
				l_message := locale.translation (e_service_not_available)
			when {TEST_STATE_SERIALIZER}.file_not_writable then
				l_message := locale.formatted_string (d_file_not_writable, [a_file_name])
			else
				l_success := True
				l_message := locale.formatted_string (d_state_exported, [a_file_name])
			end
			if l_success then
				create {ES_INFORMATION_PROMPT} l_prompt.make_standard (l_message)
			else
				create {ES_ERROR_PROMPT} l_prompt.make_standard (l_message)
			end
			l_prompt.show (window)
		end

	remove_record (a_test_suite: TEST_SUITE_S)
			-- Remove all terminated records from repository.
		require
			a_test_suite_attached: a_test_suite /= Void
		local
			l_records: ARRAYED_LIST [TEST_SESSION_RECORD]
		do
			l_records := a_test_suite.record_repository.records
			from
				l_records.start
			until
				l_records.after
			loop
				if not l_records.item_for_iteration.is_running then
					a_test_suite.record_repository.remove_record (l_records.item_for_iteration)
				end
				l_records.forth
			end
		end

feature {NONE} -- Factory

	create_record_widget (a_record: TEST_SESSION_RECORD): like record_widget
			-- Create a new `record_widget' from a given record.
		do
			if attached {TEST_EXECUTION_RECORD} a_record as l_execution then
				create {ES_TEST_EXECUTION_WIDGET} Result.make (icons_provider.develop_window, l_execution)
			else
				create Result.make (icons_provider.develop_window, a_record)
			end
		end

	create_record_widget_from_session (a_session: TEST_SESSION_I): like record_widget
			-- Create a new `record_widget' from a running session.
		do
			if attached {TEST_EXECUTION_I} a_session as l_execution then
				create {ES_TEST_EXECUTION_WIDGET} Result.make_running (icons_provider.develop_window, l_execution)
			else
				create Result.make_running (icons_provider.develop_window, a_session)
			end
		end

	create_notebook_widget: like widget
			-- <Precursor>
		do
			create Result
		end

	create_tool_bar_items: detachable DS_ARRAYED_LIST [SD_TOOL_BAR_ITEM]
			-- <Precursor>
		do
			create Result.make (4)

			create records_button.make
			records_button.set_pixel_buffer (stock_pixmaps.general_document_icon_buffer)
			records_button.set_tooltip (locale.translation (l_test_executions))
			records_button.set_menu_function (agent records_menu)
			Result.force_last (records_button)

			Result.force_last (create {SD_TOOL_BAR_SEPARATOR}.make)

			create compare_button.make
			compare_button.set_pixel_buffer (stock_pixmaps.metric_common_criteria_icon_buffer)
			compare_button.set_tooltip (locale.translation ({ES_TESTING_RESULTS_TOOL}.l_compare_states))
			register_action (compare_button.select_actions, agent on_compare_button_selected)
			Result.force_last (compare_button)

			create export_button.make
			export_button.set_pixel_buffer (stock_pixmaps.command_send_to_external_editor_icon_buffer)
			export_button.set_tooltip (locale.translation (l_export_state))
			register_action (export_button.select_actions, agent on_export_button_selected)
			Result.force_last (export_button)
		end

feature {NONE} -- Clean up

	internal_recycle
			-- <Precursor>
		do
			Precursor
			perform_with_test_suite (agent (a_test_suite: TEST_SUITE_S)
				do
					a_test_suite.record_repository.connection.disconnect_events (Current)
				end)
		end

feature {NONE} -- Internationalization

	l_test_executions: STRING = "Test execution results"
	l_export_state: STRING = "Export test suite state to file"
	l_running: STRING = "running"
	l_remove_terminated: STRING = "Remove terminated"
	l_no_results: STRING = "No results"

	m_remove_current: STRING = "Remove shown"
	m_remove_older: STRING = "Remove older"
	m_remove_all: STRING = "Remove all"

	d_file_exists: STRING = "Are you sure you want to overwrite the existing file?"
	d_state_exported: STRING = "[
			Test results were successfully exported to
			
			$1
		]"
	d_file_not_writable: STRING = "[
			Unable to write test result to file:
			
			$1
		]"

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
