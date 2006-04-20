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

	EB_SHARED_DEBUG_TOOLS

	EB_SHARED_WINDOW_MANAGER

create
	make

feature {NONE} -- Initialization

	make is
			-- Initialize `Current'.
		do
--			create accelerator.make_with_key_combination (
--				create {EV_KEY}.make_with_code ({EV_KEY_CONSTANTS}.Key_f5),
--				True, False, True)
--			accelerator.actions.extend (agent execute)
		end

feature -- Formatting

	execute is
			-- Pause the execution.
		do
			if handler_dialog = Void or else handler_dialog.is_destroyed then
				build_handler_dialog
			end

			handler_dialog.show_relative_to_window (window_manager.last_focused_window.window)
			handler_dialog.raise
		end

feature -- Dialog

	build_handler_dialog is
		local
			dialog: ES_EXCEPTION_HANDLER_DIALOG
			app_exec: APPLICATION_EXECUTION
		do
			app_exec := Eb_debugger_manager.application
			if app_exec.exceptions_handler.handling_mode_is_by_name then
				check app_exec.is_dotnet end
				create dialog
				dialog.set_handler (app_exec.exceptions_handler)
				handler_dialog := dialog
			else
				check app_exec.is_classic end
				build_handler_by_code_dialog
			end

		end

	handler_dialog: EV_DIALOG

feature {NONE} -- Attributes

	description: STRING is
			-- What appears in the customize dialog box.
		do
			Result := tooltip
		end

	tooltip: STRING is
			-- Tooltip displayed on `Current's buttons.
		do
			Result := Interface_names.e_Dbg_exception_handler
		end

	tooltext: STRING is
			-- Text displayed on `Current's buttons.
		do
			Result := Interface_names.b_Dbg_exception_handler
		end

	name: STRING is "Exception_handler"
			-- Name of the command.

	menu_name: STRING is
			-- Menu entry corresponding to `Current'.
		once
			Result := Interface_names.m_Dbg_exception_handler
		end

	pixmap: EV_PIXMAP is
			-- Pixmap representing `Current' on buttons.
		do
			Result := Pixmaps.icon_debugger_exception
		end

feature -- Handler dialog by code

	build_handler_by_code_dialog is
		local
			vb: EV_VERTICAL_BOX
			glab: EV_GRID_LABEL_ITEM
			g_row: EV_GRID_ROW
			bt: EV_BUTTON
			except_meanings: EXCEPTION_CODE_MEANING
			c: INTEGER
			app_excep_handler: DBG_EXCEPTION_HANDLER
			fr: EV_FRAME
		do
			app_excep_handler := Eb_debugger_manager.application.exceptions_handler
			if not app_excep_handler.handling_mode_is_by_code then
				app_excep_handler.set_handling_by_code_mode
			end

			create handler_dialog
			handler_dialog.set_title (interface_names.m_dbg_exception_handler)
			handler_dialog.set_icon_pixmap (pixmaps.icon_dialog_window)

			create fr
			create vb
			fr.extend (vb)
			create cb_ignore_external.make_with_text ("Ignore external exception")
			cb_ignore_external.select_actions.extend (agent handle_ignore_external_changed)
			vb.extend (cb_ignore_external)
			create cb_handle_exception.make_with_text ("Exceptions handling enabled ?")
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
				create glab.make_with_text (c.out + ": " + except_meanings.exception_code_meaning (c))
				glab.set_pixmap (pixmap_for_role (app_excep_handler.exception_role_for_code (c)))
				g_row.set_item (1, glab)
				c := c + 1
			end
			grid.enable_last_column_use_all_width
			grid.column (1).resize_to_content
			grid.set_minimum_height (grid.row_height * grid.row_count.min (10))
			grid.pointer_double_press_item_actions.extend (agent double_clicked_on_grid_cell)
			vb.extend (grid)

			create bt.make_with_text_and_action ("Close", agent handler_dialog.hide)
			vb.extend (bt)
			vb.disable_item_expand (bt)
			handler_dialog.extend (vb)
			handler_dialog.set_default_cancel_button (bt)
			handler_dialog.set_size (300, 400)
			disable_grid
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
			Result := pixmaps.icon_run
		end

	Stop_pixmap: EV_PIXMAP is
		once
			Result := pixmaps.icon_exec_stop
		end

	handle_ignore_external_changed is
		do
			debugger_manager.application.exceptions_handler.ignore_external_exceptions (cb_ignore_external.is_selected)
		end

	handle_exception_changed is
		do
			if cb_handle_exception.is_selected then
				debugger_manager.application.exceptions_handler.enable_exception_handling
				enable_grid
			else
				debugger_manager.application.exceptions_handler.disable_exception_handling
				disable_grid
			end
		end

	disable_grid is
		require
			grid /= Void
		do
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

	double_clicked_on_grid_cell (ax, ay, abut: INTEGER; gi: EV_GRID_ITEM) is
		local
			glab: EV_GRID_LABEL_ITEM
			g_row: EV_GRID_ROW
			ir: INTEGER_REF
			ecode: INTEGER
			app_excep_handler: DBG_EXCEPTION_HANDLER
		do
			app_excep_handler := eb_debugger_manager.application.exceptions_handler
			if abut = 1 and then gi /= Void and then gi.is_parented then
				glab ?= gi
				if glab /= Void then
					g_row := gi.row
					ir ?= g_row.data
					if ir /= Void then
						ecode := ir.item
						inspect
							app_excep_handler.exception_role_for_code (ecode)
						when {DBG_EXCEPTION_HANDLER}.role_continue then
							app_excep_handler.catch_exception_by_code (ecode)
						else
							app_excep_handler.ignore_exception_by_code (ecode)
						end
						glab.set_pixmap (pixmap_for_role (app_excep_handler.exception_role_for_code (ecode)))
					end
				end
			end
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
