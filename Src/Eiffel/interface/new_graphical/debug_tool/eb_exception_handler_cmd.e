indexing

	description:
		"Command to manage exception handling."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	EB_EXCEPTION_HANDLER_CMD

inherit
	EB_TOOLBARABLE_AND_MENUABLE_COMMAND
		redefine
			tooltext
		end

	EB_CONSTANTS

	SHARED_DEBUGGER_MANAGER

	EB_SHARED_WINDOW_MANAGER

create
	make

feature {NONE} -- Initialization

	make is
			-- Initialize `Current'.
		do
		end

feature -- Formatting

	execute is
			-- Pause the execution.
		do
			if is_sensitive and debugger_manager.system_defined then
				if handler_dialog = Void or else handler_dialog.is_destroyed then
					build_handler_dialog
				end

				handler_dialog.show_relative_to_window (window_manager.last_focused_window.window)
				handler_dialog.raise
			end
		end

feature -- Dialog

	build_handler_dialog is
		local
			dialog: ES_EXCEPTION_HANDLER_DIALOG
		do
			if Debugger_manager.exceptions_handler.handling_mode_is_by_name then
				check Debugger_manager.is_dotnet_project end
				create dialog
				dialog.set_handler (Debugger_manager.exceptions_handler)
				handler_dialog := dialog
			else
				check Debugger_manager.is_classic_project end
				build_handler_by_code_dialog
			end
		end

	handler_dialog: EV_DIALOG

feature {NONE} -- Attributes

	description: STRING_GENERAL is
			-- What appears in the customize dialog box.
		do
			Result := tooltip
		end

	tooltip: STRING_GENERAL is
			-- Tooltip displayed on `Current's buttons.
		do
			Result := Interface_names.e_Dbg_exception_handler
		end

	tooltext: STRING_GENERAL is
			-- Text displayed on `Current's buttons.
		do
			Result := Interface_names.b_Dbg_exception_handler
		end

	name: STRING is "Exception_handler"
			-- Name of the command.

	menu_name: STRING_GENERAL is
			-- Menu entry corresponding to `Current'.
		once
			Result := Interface_names.m_Dbg_exception_handler
		end

	pixmap: EV_PIXMAP is
			-- Pixmap representing `Current' on buttons.
		do
			Result := pixmaps.icon_pixmaps.debug_exception_handling_icon
		end

	pixel_buffer: EV_PIXEL_BUFFER is
			-- Pixel buffer representing the command.
		do
			Result := pixmaps.icon_pixmaps.debug_exception_handling_icon_buffer
		end

feature -- Handler dialog by code

	build_handler_by_code_dialog is
		local
			vb: EV_VERTICAL_BOX
			gclab: EV_GRID_CHECKABLE_LABEL_ITEM
			g_row: EV_GRID_ROW
			bt: EV_BUTTON
			except_meanings: EXCEPTION_CODE_MEANING
			c: INTEGER
			app_excep_handler: DBG_EXCEPTION_HANDLER
			fr: EV_FRAME
		do
			app_excep_handler := Debugger_manager.exceptions_handler
			if not app_excep_handler.handling_mode_is_by_code then
				app_excep_handler.set_handling_by_code_mode
			end

			create handler_dialog
			handler_dialog.set_title (interface_names.m_dbg_exception_handler)
			handler_dialog.set_icon_pixmap (pixmaps.icon_pixmaps.general_dialog_icon)

			create fr
			create vb
			fr.extend (vb)
			create cb_ignore_external.make_with_text (Interface_names.l_Ignore_external_exceptions)
			cb_ignore_external.select_actions.extend (agent handle_ignore_external_changed)
			vb.extend (cb_ignore_external)
			create cb_handle_exception.make_with_text (Interface_names.l_Filter_exceptions)
			cb_handle_exception.select_actions.extend (agent handle_exception_changed)
			vb.extend (cb_handle_exception)

			create vb
			vb.set_padding_width (5)
			vb.set_border_width (5)
			vb.extend (fr)
			vb.disable_item_expand (fr)

			from
				create except_meanings
				create grid
				grid.enable_border
				grid.hide_header
				grid.insert_new_rows (except_meanings.number_of_codes, 1)
				c := 1
			until
				c > except_meanings.number_of_codes
			loop
				g_row := grid.row (c)
				g_row.set_data (c)
				create gclab.make_with_text (c.out + ": " + except_meanings.exception_code_meaning (c))
				gclab.checked_changed_actions.extend (agent activate_grid_label)

				refresh_grid_label (c, gclab)
				g_row.set_item (1, gclab)
				c := c + 1
			end
			grid.enable_last_column_use_all_width
			grid.column (1).resize_to_content
			grid.set_minimum_height (grid.row_height * grid.row_count.min (10))
			grid.pointer_double_press_item_actions.extend (agent on_grid_cell_clicked)
--			grid.pointer_button_press_item_actions.extend (agent on_grid_cell_clicked)
			vb.extend (grid)

			create bt.make_with_text_and_action (Interface_names.b_Close, agent handler_dialog.hide)
			vb.extend (bt)
			vb.disable_item_expand (bt)
			handler_dialog.extend (vb)
			handler_dialog.set_default_cancel_button (bt)
			handler_dialog.set_size (300, 400)
			disable_grid

			if app_excep_handler.ignoring_external_exception then
				cb_ignore_external.enable_select
			end

			if app_excep_handler.enabled then
				cb_handle_exception.enable_select
			end
		end

	pixmap_for_role (r: INTEGER): EV_PIXMAP is
		do
			inspect r
			when {DBG_EXCEPTION_HANDLER}.role_continue then
				Result := continue_pixmap
			when {DBG_EXCEPTION_HANDLER}.role_stop then
				Result := stop_pixmap
			else
				check should_not_occur: False end
				Result := stop_pixmap
			end
		end

	grid: ES_GRID

	cb_ignore_external,
	cb_handle_exception: EV_CHECK_BUTTON

	Continue_pixmap: EV_PIXMAP is
		once
			Result := pixmaps.icon_pixmaps.debug_run_icon
		end

	Stop_pixmap: EV_PIXMAP is
		once
			Result := pixmaps.icon_pixmaps.debug_pause_icon
		end

	handle_ignore_external_changed is
		do
			Debugger_manager.exceptions_handler.ignore_external_exceptions (cb_ignore_external.is_selected)
		end

	handle_exception_changed is
		do
			if cb_handle_exception.is_selected then
				Debugger_manager.exceptions_handler.enable_exception_handling
				enable_grid
			else
				Debugger_manager.exceptions_handler.disable_exception_handling
				disable_grid
			end
		end

	disable_grid is
		require
			grid /= Void
		do
			grid.remove_selection
			grid.disable_sensitive
			grid.set_background_color ((create {EV_STOCK_COLORS}).Color_read_only)
			grid.set_foreground_color ((create {EV_STOCK_COLORS}).Color_3d_shadow)
		end

	enable_grid is
		require
			grid /= Void
		do
			grid.enable_sensitive
			grid.set_default_colors
		end

	on_grid_cell_clicked (ax, ay, abut: INTEGER; gi: EV_GRID_ITEM) is
		local
			glab: EV_GRID_CHECKABLE_LABEL_ITEM
		do
			if abut = 1 and then gi /= Void and then gi.is_parented then
				glab ?= gi
				if glab /= Void then
					activate_grid_label (glab)
				end
			end
		end

	activate_grid_label (gi: EV_GRID_CHECKABLE_LABEL_ITEM) is
		local
			g_row: EV_GRID_ROW
			ir: INTEGER_REF
			ecode: INTEGER
			app_excep_handler: DBG_EXCEPTION_HANDLER
		do
			g_row := gi.row
			ir ?= g_row.data
			if ir /= Void then
				app_excep_handler := Debugger_manager.exceptions_handler
				ecode := ir.item
				inspect
					app_excep_handler.exception_role_for_code (ecode)
				when {DBG_EXCEPTION_HANDLER}.role_continue then
					app_excep_handler.catch_exception_by_code (ecode)
				else
					app_excep_handler.ignore_exception_by_code (ecode)
				end
				refresh_grid_label (ecode, gi)
			end
		end

	refresh_grid_label (ecode: INTEGER; gi: EV_GRID_CHECKABLE_LABEL_ITEM) is
		local
			r: INTEGER
		do
			r := Debugger_manager.exceptions_handler.exception_role_for_code (ecode)
			gi.set_pixmap (pixmap_for_role (r))

			gi.checked_changed_actions.block
			gi.set_is_checked (r = {DBG_EXCEPTION_HANDLER}.role_continue)
			gi.checked_changed_actions.resume
		end

indexing
	copyright:	"Copyright (c) 1984-2006, Eiffel Software"
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
