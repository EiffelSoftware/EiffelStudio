indexing
	description: "[
		A help link selection dialog for displaying a choice of help document links to navigate to.
	]"
	legal: "See notice at end of class."
	status: "See notice at end of class.";
	date: "$Date$";
	revision: "$Revision$"

class
	ES_HELP_SELECTOR_DIALOG

inherit
	ES_DIALOG
		redefine
			on_before_initialize,
			on_after_initialized
		end

create
	make

feature {NONE} -- User interface initialization

	build_dialog_interface (a_container: EV_VERTICAL_BOX)
			-- Builds the dialog's user interface.
			--
			-- `a_container': The dialog's container where the user interface elements should be extended
		local
			l_box: EV_HORIZONTAL_BOX
			l_cell: EV_CELL
			l_col: EV_GRID_COLUMN
		do
			create l_box

				-- Left border
			create l_cell
			l_cell.set_background_color (colors.stock_colors.black)
			l_cell.set_minimum_width (1)
			l_box.extend (l_cell)
			l_box.disable_item_expand (l_cell)

				-- Help documents grid
			create help_documents_grid
			help_documents_grid.set_minimum_size (400, 120)
			help_documents_grid.set_column_count_to (doc_type_column_index)
			help_documents_grid.enable_auto_size_best_fit_column (document_column_index)
			help_documents_grid.enable_single_row_selection
			help_documents_grid.enable_always_selected
			help_documents_grid.set_focused_selection_color (colors.grid_focus_selection_color)
			help_documents_grid.set_focused_selection_text_color (colors.grid_focus_selection_text_color)
			help_documents_grid.set_non_focused_selection_color (colors.grid_unfocus_selection_color)
			help_documents_grid.set_non_focused_selection_text_color (colors.grid_unfocus_selection_text_color)
			register_action (help_documents_grid.row_select_actions, agent on_row_selected)
			l_box.extend (help_documents_grid)

			l_col := help_documents_grid.column (document_column_index)
			l_col.set_title ("Document")
			l_col.set_width (400)

			l_col := help_documents_grid.column (doc_type_column_index)
			l_col.set_title ("Type")
			l_col.set_width (100)

			set_button_text (dialog_buttons.ok_button, "Show Help")

				-- Right border
			create l_cell
			l_cell.set_background_color (colors.stock_colors.black)
			l_cell.set_minimum_width (1)
			l_box.extend (l_cell)
			l_box.disable_item_expand (l_cell)

			a_container.extend (l_box)

				-- Bottom border
			create l_cell
			l_cell.set_background_color (colors.stock_colors.black)
			l_cell.set_minimum_height (1)
			a_container.extend (l_cell)
			a_container.disable_item_expand (l_cell)

				-- Close on check button
			create close_on_launch_check
			close_on_launch_check.set_text ("Close dialog after showing help?")
			close_on_launch_check.set_tooltip ("Check to close the dialog after showing a select help document.")
			register_action (close_on_launch_check.select_actions, agent on_close_on_launch_toggled)

			a_container.extend (close_on_launch_check)
			a_container.disable_item_expand (close_on_launch_check)

				-- Disable launch help button (requires selection)
			dialog_window_buttons.item (dialog_buttons.ok_button).disable_sensitive
			set_button_action_before_close (dialog_buttons.ok_button, agent on_launch_help)
		end

	on_before_initialize
			-- Use to perform additional creation initializations, before the UI has been created.
			-- Note: No user interface initialization should be done here! Use build_dialog_interface instead
		do
			Precursor {ES_DIALOG}
			create {!DS_ARRAYED_LIST [!HELP_CONTEXT_I]} links.make_default
		ensure then
			links_attached: links /= Void
		end

	on_after_initialized
			-- Use to perform additional creation initializations, after the UI has been created.
		do
			Precursor {ES_DIALOG}

			if session_manager.is_service_available then
					-- Set UI based on session data
				if {l_close: !BOOLEAN_REF} session_data.value_or_default (close_on_launch_session_id, True) then
					if l_close.item then
						close_on_launch_check.enable_select
					else
						close_on_launch_check.disable_select
					end
					on_close_on_launch_toggled
				end
			end

			populate_help_documents
		end

feature -- Access

	links: DS_BILINEAR [!HELP_CONTEXT_I]
			-- Help context links

feature {NONE} -- Access

	icon: EV_PIXEL_BUFFER
			-- The dialog's icon
		do
			Result := stock_pixmaps.command_system_info_icon_buffer
		end

	title: STRING_32
			-- The dialog's title
		do
			Result := "Select Help Document"
		end

	buttons: DS_SET [INTEGER]
			-- Set of button id's for dialog
			-- Note: Use {ES_DIALOG_BUTTONS} or `dialog_buttons' to determine the id's correspondance.
		do
			Result := dialog_buttons.ok_cancel_buttons
		end

	default_button: INTEGER
			-- The dialog's default action button
		do
			Result := dialog_buttons.ok_button
		end

	default_confirm_button: INTEGER
			-- The dialog's default confirm button
		do
			Result := dialog_buttons.ok_button
		end

	default_cancel_button: INTEGER
			-- The dialog's default cancel button
			-- Note: The default cancel button is set on show, so if you want to change the
			--       default cancel button after the dialog has been shown, please see the implmentation
			--       of `show' to see how it is done.
		do
			Result := dialog_buttons.cancel_button
		end

feature -- Element change

	set_links (a_links: like links)
			-- Sets help context links
		require
			is_interface_usable: is_interface_usable
			a_links_attached: a_links /= Void
			not_a_links_is_empty: not a_links.is_empty
			a_links_contains_valid_items: a_links.for_all (agent is_context_valid)
		do
			links := a_links
			if is_initialized then
				populate_help_documents
			end
		ensure
			links_set: links = a_links
		end

feature {NONE} -- User interface elements

	help_documents_grid: ES_GRID
			-- Help documents grid

	close_on_launch_check: EV_CHECK_BUTTON
			-- Check button to close dialog on launch of help

feature -- Query

	is_context_valid (a_context: !HELP_CONTEXT_I): BOOLEAN
			-- Determines if a help context is valid to be linked to.
			--
			-- `a_context': A help context to validate.
			-- `Result': True if the context is valid, False otherwise.
		require
			is_interface_usable: is_interface_usable
		do
			Result := a_context.is_interface_usable and then a_context.is_help_available
		ensure
			a_context_is_usable: Result implies a_context.is_interface_usable
			a_context_is_help_available: Result implies a_context.is_help_available
		end

feature {NONE} -- Query

	help_context_document_title (a_context: !HELP_CONTEXT_I): !STRING_GENERAL is
			-- Retrieves a title for a given help context.
			--
			-- `a_context': A help context to build a help document title for.
			-- `Result': A help document title for the given help context.
		require
			is_context_valid: is_context_valid (a_context)
		do
			create {!STRING_32} Result.make (100)
			Result.append (a_context.help_context_id)
			if {l_section: !STRING_GENERAL} a_context.help_context_section then
				Result.append (", ")
				Result.append (l_section)
			end
		ensure
			not_result_is_empty: not Result.is_empty
		end

feature {NONE} -- Basic operations

	populate_help_documents
			-- Populates the help documents list with the links set in `links'
		require
			is_interface_usable: is_interface_usable
			is_initialized: is_initialized
			help_documents_grid_attached: help_documents_grid /= Void
			links_attached: links /= Void
		local
			l_grid: like help_documents_grid
			l_cursor: DS_BILINEAR_CURSOR [!HELP_CONTEXT_I]
			i: INTEGER
		do
			l_grid := help_documents_grid
			l_grid.remove_and_clear_all_rows
			l_grid.set_row_count_to (links.count)
			l_cursor := links.new_cursor
			from l_cursor.start until l_cursor.after loop
				i := i + 1
				if {l_row: !EV_GRID_ROW} l_grid.row (i) then
					populate_help_document_row (l_cursor.item, l_row)
				end
				l_cursor.forth
			end
		end

feature {NONE} -- Action handlers

	on_row_selected (a_row: EV_GRID_ROW)
			-- Called when a row is selected in the help links grid.
			--
			-- `a_row': Selected row.
		require
			is_interface_usable: is_interface_usable
			is_initialized: is_initialized
			not_a_row_is_destroyed: a_row /= Void implies not a_row.is_destroyed
			a_row_parented: a_row /= Void implies a_row.parent /= Void
		local
			l_enable: BOOLEAN
		do
			if a_row /= Void then
				if help_providers.is_service_available and then {l_context: !HELP_CONTEXT_I} a_row.data then
					l_enable := help_providers.service.is_provider_available (l_context.help_provider)
				end
			end
			if l_enable then
				dialog_window_buttons.item (dialog_buttons.ok_button).enable_sensitive
			else
				dialog_window_buttons.item (dialog_buttons.ok_button).disable_sensitive
			end
		end

	on_close_on_launch_toggled
			-- Called when the close on launch check button is toggled
		require
			is_interface_usable: is_interface_usable
			is_initialized: is_initialized
		do
			if session_manager.is_service_available then
				session_data.set_value (close_on_launch_check.is_selected, close_on_launch_session_id)
			end
		end

	on_launch_help
			-- Called when a request is made to launch a selected help document
		require
			is_interface_usable: is_interface_usable
			is_initialized: is_initialized
		local
			l_rows: ARRAYED_LIST [EV_GRID_ROW]
			l_cursor: CURSOR
			l_service: HELP_PROVIDERS_S
			l_error: ES_ERROR_PROMPT
		do
			if help_providers.is_service_available then
				l_service := help_providers.service

				l_rows := help_documents_grid.selected_rows
				l_cursor := l_rows.cursor
				from l_rows.start until l_rows.after loop
					if {l_context: !HELP_CONTEXT_I} l_rows.item.data then
							-- Launch help
						l_service.show_help (l_context)
					else
						check False end -- This is set in `populate_help_document_row'
					end
					l_rows.forth
				end
				l_rows.go_to (l_cursor)
			else
				create l_error.make_standard ("The Help Providers service is no available so no help can be displayed!")
				l_error.show (dialog)
			end

			if not close_on_launch_check.is_selected then
				veto_close
			end
		end

feature {NONE} -- Factory

	populate_help_document_row (a_context: !HELP_CONTEXT_I; a_row: !EV_GRID_ROW) is
			-- Populates a single grid row using a help context.
			--
			-- `a_context': The help context to populate information on a row with.
			-- `a_row': A grid row to populate.
		require
			a_context_is_interface_usable: a_context.is_interface_usable
			a_context_is_context_valid: is_context_valid (a_context)
			not_a_row_is_destroy: not a_row.is_destroyed
			a_row_is_parented: a_row.parent /= Void
		local
			l_item: !EV_GRID_LABEL_ITEM
			l_provider: !HELP_PROVIDER_I
			l_available: BOOLEAN
		do
			l_available := help_providers.is_service_available and then help_providers.service.is_provider_available (a_context.help_provider)

				-- Document title
			create l_item.make_with_text (help_context_document_title (a_context))
			l_item.set_pixmap (stock_pixmaps.general_document_icon)
			if l_available then
				l_item.set_foreground_color (colors.grid_item_text_color)
			else
				l_item.set_foreground_color (colors.disabled_foreground_color)
			end
			a_row.set_item (document_column_index, l_item)

				-- Document type
			if l_available then
				l_provider := help_providers.service.help_provider (a_context.help_provider)
				create l_item.make_with_text (l_provider.document_description)
				l_item.set_foreground_color (colors.grid_item_text_color)
			else
				create l_item.make_with_text ("Help Unavailable!")
				l_item.set_foreground_color (colors.disabled_foreground_color)
			end
			a_row.set_item (doc_type_column_index, l_item)

			a_row.set_data (a_context)
		ensure
			a_row_data_set: a_row.data = a_context
		end

feature {NONE} -- Constants

	document_column_index: INTEGER = 1
	doc_type_column_index: INTEGER = 2
			-- Column indexed for the `help_documents_grid' grid

	close_on_launch_session_id: STRING_8 = "com.eiffel.help_selection_dialog.close_on_launch"
			-- Session ids

invariant
	help_documents_grid_attached: is_initializing and is_interface_usable implies help_documents_grid /= Void
	close_on_launch_check_attached: is_initializing and is_interface_usable implies close_on_launch_check /= Void
	links_attached: is_initializing and is_interface_usable implies links /= Void
	links_contains_valid_items: is_initializing and is_interface_usable implies not links.for_all (agent is_context_valid)

;indexing
	copyright:	"Copyright (c) 1984-2007, Eiffel Software"
	license:	"GPL version 2 (see http://www.eiffel.com/licensing/gpl.txt)"
	licensing_options:	"http://www.eiffel.com/licensing"
	copying: "[
			This file is part of Eiffel Software's Eiffel Development Environment.
			
			Eiffel Software's Eiffel Development Environment is free
			software; you can redistribute it and/or modify it under
			the terms of the GNU General Public License as published
			by the Free Software Foundation, version 2 of the License
			(available at the URL listed under "license" above).
			
			Eiffel Software's Eiffel Development Environment is
			distributed in the hope that it will be useful,	but
			WITHOUT ANY WARRANTY; without even the implied warranty
			of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
			See the	GNU General Public License for more details.
			
			You should have received a copy of the GNU General Public
			License along with Eiffel Software's Eiffel Development
			Environment; if not, write to the Free Software Foundation,
			Inc., 51 Franklin St, Fifth Floor, Boston, MA 02110-1301  USA
		]"
	source: "[
			 Eiffel Software
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"

end
