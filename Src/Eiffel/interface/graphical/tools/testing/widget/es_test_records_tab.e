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
			create_right_tool_bar_items,
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

	records_menu: EV_MENU
			-- Menu displayed when the user clicks on the `records_button'
		local

		do
			if attached records_menu_cache as l_cache then
				Result := l_cache
			else
				create Result
				perform_with_test_suite (agent fill_records_menu (?, Result))
				Result.item_select_actions.extend (agent on_record_menu_select)
				records_menu_cache := Result
			end
		ensure
			result_attached: Result /= Void
		end

	records_menu_cache: detachable like records_menu
			-- Cache for `records_menu'

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
			records_menu_cache := Void
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
			records_menu_cache := Void
			if is_record_displayed and then record_widget.record = a_record then
				remove_displayed_record
			end
		end

	on_record_property_updated (a_repo: TEST_RECORD_REPOSITORY_I; a_record: TEST_SESSION_RECORD)
			-- <Precursor>
		do
			records_menu_cache := Void
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

	on_record_menu_select (an_item: EV_MENU_ITEM)
			-- Called when item is selected in menu of `records_button'.
			--
			-- `an_item': Item that was selected.
		require
			an_item_attached: an_item /= Void
		do
			if
				attached {TEST_SESSION_RECORD} an_item.data as l_record and then
				(not is_record_displayed or else record_widget.record /= l_record)
			then
				if is_record_displayed then
					remove_displayed_record
				end
				display_record (l_record)
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
			if attached records_menu_cache as l_menu then
				from
					l_menu.start
				until
					l_menu.after
				loop
					if attached {EV_CHECK_MENU_ITEM} l_menu.item_for_iteration as l_item then
						if l_item.data = a_record then
							if not l_item.is_selected then
								l_item.enable_select
							end
						else
							if l_item.is_selected then
								l_item.disable_select
							end
						end
					end
					l_menu.forth
				end
			end
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
			l_separator_pos: INTEGER
			l_label: STRING_32
		do
			l_records := a_test_suite.record_repository.records
			from
				l_records.start
			until
				l_records.after
			loop
				l_record := l_records.item_for_iteration
				if is_valid_record (l_record) then
					create l_label.make (50)
					l_label.append (date_time (l_record.creation_date))
					create l_item
					l_item.set_pixmap (stock_pixmaps.debug_run_icon)
					l_item.set_data (l_record)
					if is_record_displayed and then record_widget.record = l_record then
						l_item.enable_select
					end
					if l_record.is_running then
						if l_separator_pos > 0 then
							a_menu.put_front (create {EV_MENU_SEPARATOR})
							l_separator_pos := 1
						end
						a_menu.put_i_th (l_item, l_separator_pos)
						l_separator_pos := l_separator_pos + 1
					else
						if attached {TEST_EXECUTION_RECORD} l_record as l_exec_record then
							l_label.append_string (" (")
							l_label.append_integer (l_exec_record.tests.count)
							l_label.append_string (" tests)")
						end
						a_menu.force (l_item)
					end
					l_item.set_text (l_label)
				end
				l_records.forth
			end
		end

feature {NONE} -- Factory

	create_record_widget (a_record: TEST_SESSION_RECORD): like record_widget
			-- Create a new `record_widget' from a given record.
		do
			if attached {TEST_EXECUTION_RECORD} a_record as l_execution then
				create {ES_TEST_EXECUTION_TAB} Result.make (icons_provider.develop_window, l_execution)
			else
				create Result.make (icons_provider.develop_window, a_record)
			end
		end

	create_record_widget_from_session (a_session: TEST_SESSION_I): like record_widget
			-- Create a new `record_widget' from a running session.
		do
			if attached {TEST_EXECUTION_I} a_session as l_execution then
				create {ES_TEST_EXECUTION_TAB} Result.make_running (icons_provider.develop_window, l_execution)
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
		local
			l_menu_button: SD_TOOL_BAR_POPUP_BUTTON
			l_button: SD_TOOL_BAR_BUTTON
		do
			create Result.make (5)

			create l_menu_button.make
			--l_menu_button.set_text ("History")

			l_menu_button.set_pixel_buffer (stock_pixmaps.general_document_icon_buffer)
			l_menu_button.set_menu_function (agent records_menu)
			Result.force_last (l_menu_button)

			create l_button.make
			l_button.set_text ("Compare")
			Result.force_last (l_button)
		end

	create_right_tool_bar_items: DS_ARRAYED_LIST [SD_TOOL_BAR_ITEM]
			-- <Precursor>
		local
			l_menu_button: SD_TOOL_BAR_DUAL_POPUP_BUTTON
			l_button: SD_TOOL_BAR_BUTTON
			l_menu: EV_MENU
		do
			create Result.make (3)
			create l_button.make
			l_button.set_pixel_buffer (stock_pixmaps.general_save_icon_buffer)
			Result.force_last (l_button)

			create l_button.make
			l_button.set_pixel_buffer (stock_pixmaps.command_send_to_external_editor_icon_buffer)
			Result.force_last (l_button)

			create l_menu_button.make
			l_menu_button.set_pixel_buffer (stock_pixmaps.general_delete_icon_buffer)
			create l_menu
			l_menu.extend (create {EV_MENU_ITEM}.make_with_text ("Delete All"))
			l_menu_button.set_menu (l_menu)
			Result.force_last (l_menu_button)
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
