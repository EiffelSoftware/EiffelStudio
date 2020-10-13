note
	description: "Command that lets the user add new external commands to the tools menus"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	author: "Xavier Rousselot"
	revised_by: "Alexander Kogtenkov"
	date: "$Date$"
	revision: "$Revision$"

class
	EB_EXTERNAL_COMMANDS_EDITOR

inherit
	EB_TOOLBARABLE_AND_MENUABLE_COMMAND
		redefine
			executable,
			new_sd_toolbar_item
		end

	EB_CONSTANTS
		export
			{NONE} all
		end

	EB_SHARED_PREFERENCES
		export
			{NONE} all
		end

	EB_SHARED_MANAGERS

create
	make

feature {NONE} -- Initialization

	make
			-- Initialize `Current'.
		do
			if not loaded.item then
				loaded.put (True)
				update_commands_from_ini_file
			end
			enable_displayed
		end

	loaded: CELL [BOOLEAN]
			-- Has `Current' already loaded the preferences?
		once
			create Result.put (False)
		ensure
			loaded_not_void: Result /= Void
		end

feature -- Status report

	menus: LIST [EB_COMMAND_MENU_ITEM]
			-- Create a list of menu items that represent the list of external commands.
		do
			from
				create {ARRAYED_LIST [EB_COMMAND_MENU_ITEM]} Result.make (10)
				commands.start
			until
				commands.after
			loop
				if commands.item_for_iteration /= Void then
					Result.extend ((commands.item_for_iteration).new_menu_item)
				end
				commands.forth
			end
		end

	commands: HASH_TABLE [EB_EXTERNAL_COMMAND, INTEGER]
			-- Array of external commands.
		do
			Result := ini_manager.commands
		end

	accelerators: ARRAY [EV_ACCELERATOR]
			-- Accelerators for `commands'.
		local
			l_shortcut: SHORTCUT_PREFERENCE
			i: INTEGER
		once
			create Result.make (0, 9)
			from
				i := 0
			until
				i > 9
			loop
				l_shortcut := preferences.external_command_data.shortcuts.item ("shortcut_" + i.out)
				l_shortcut.change_actions.extend (agent on_shortcut_change (i))
				Result.put (create{EV_ACCELERATOR}.make_with_key_combination (l_shortcut.key, l_shortcut.is_ctrl, l_shortcut.is_alt, l_shortcut.is_shift), i)
				Result.item (i).actions.extend (agent execute_command_at_position (i))
				i := i + 1
			end
		ensure
			Result_attached: Result /= Void
		end

	pixmap: EV_PIXMAP
			-- Pixmap representing the command.
		do
			Result := pixmaps.icon_pixmaps.tool_external_commands_icon
		end

	pixel_buffer: EV_PIXEL_BUFFER
			-- Pixel buffer representing the command.
		do
			Result := pixmaps.icon_pixmaps.tool_external_commands_icon_buffer
		end

	tooltip: STRING_GENERAL
			-- Tooltip for the toolbar button.
		do
			Result := description
		end

	name: STRING = "External commands"
			-- Name of the command. Use to store the command in the
			-- preferences.

	description: STRING_GENERAL
			-- Pop up help on the toolbar button.
		do
			Result := Interface_names.l_manage_external_commands
		end

	executable: BOOLEAN
			-- Is Current command executable?
			-- (True by default)
		do
			Result := is_sensitive
		end

	new_sd_toolbar_item (display_text: BOOLEAN): EB_SD_COMMAND_TOOL_BAR_BUTTON
			-- Create a new toolbar button for this command.
		do
			Result := Precursor (display_text)
			Result.set_pixmap (pixmap)
			Result.set_pixel_buffer (pixel_buffer)
			Result.set_tooltip (tooltip)
		end

	list_exists: BOOLEAN
			-- Does `list' exist?
		do
			Result := list /= Void
		end

	ini_manager: EB_EXTERNAL_COMMANDS_INI_MANAGER
			-- External command ini file manager
		once
			create Result.make (Current)
		end

feature -- Actions

	on_shortcut_change (i: INTEGER)
			-- Action to be performed when shortcut for an external command changes
		require
			i_valid: i >= 0 and i <= 9
		local
			l_shortcut: SHORTCUT_PREFERENCE
		do
			l_shortcut := preferences.external_command_data.shortcuts.item ("shortcut_" + i.out)
			accelerators.put (create{EV_ACCELERATOR}.make_with_key_combination (l_shortcut.key, l_shortcut.is_ctrl, l_shortcut.is_alt, l_shortcut.is_shift), i)
			accelerators.item (i).actions.extend (agent execute_command_at_position (i))
		end

feature -- Basic operations

	execute
			-- Pop up a dialog that lets the user customize external commands.
		do
			if dialog = Void then
				create_dialog
				dialog.show_modal_to_window (Window_manager.last_focused_development_window.window)
			else
				dialog.hide
				dialog.show_modal_to_window (Window_manager.last_focused_development_window.window)
			end
		end

	execute_command_at_position (a_pos: INTEGER)
			-- Execute command at position `a_pos'.
		require
			a_pos_valid: a_pos >=0 and a_pos <= 9
		do
			if commands.item (a_pos) /= Void then
				commands.item (a_pos).execute
			end
		end

	refresh_list
			-- Rebuild the list of available commands.
		require
			list_exists: list_exists
		local
			litem: EV_LIST_ITEM
		do
			from
				list.wipe_out
				commands.start
			until
				commands.after
			loop
				if commands.item_for_iteration /= Void then
					create litem
					litem.set_text ((commands.item_for_iteration).name)
					litem.set_data (commands.item_for_iteration)
					list.extend (litem)
				end
				commands.forth
			end
		end

	update_commands_from_ini_file
			-- Update `commands' from ini file
		do
			ini_manager.update_from_ini_file
		end

feature {ES_CONSOLE_TOOL_PANEL, EB_DEVELOPMENT_WINDOW, ES_SETTINGS_IMPORT_DIALOG} -- Synchronizing features used by EB_EXTERNAL_OUTPUT_TOOL

	refresh_list_from_outside
			-- Refresh command list from EB_EXTERNAL_OUTPUT_TOOL
		do
			if list /= Void then
				refresh_list
			end
		end

	update_menus_from_outside
			-- Update external menu items from EB_EXTERNAL_OUTPUT_TOOL
		do
			update_menus
		end

feature {NONE} -- Widgets

	dialog: EV_DIALOG
			-- Dialog that contains all widgets and lets the user edit the list of external commands.

	add_button: EV_BUTTON
			-- Button that lets the user add an external command.

	edit_button: EV_BUTTON
			-- Button that lets the user edit an external command.

	delete_button: EV_BUTTON
			-- Button that lets the user delete an external command.

	close_button: EV_BUTTON
			-- Button to close dialog.

	list: EV_LIST
			-- List that represents the available external commands.

feature {NONE} -- Implementation

	create_dialog
			-- Initialize all widgets and build `dialog'.
		local
			hb: EV_HORIZONTAL_BOX
			vb: EV_VERTICAL_BOX
			f: EV_FRAME
		do
				-- Create widgets.
			create dialog
			create list
			create add_button.make_with_text (Interface_names.b_New_command)
			create edit_button.make_with_text (Interface_names.b_Edit_command)
			create delete_button.make_with_text (Interface_names.b_Delete_command)
			create close_button.make_with_text (Interface_names.b_Close)

				-- Organize widgets.
			create vb
			vb.set_padding (Layout_constants.Default_padding_size)
			vb.extend (add_button)
			vb.disable_item_expand (add_button)
			vb.extend (edit_button)
			vb.disable_item_expand (edit_button)
			vb.extend (delete_button)
			vb.disable_item_expand (delete_button)
			vb.extend (create {EV_CELL})
			vb.extend (close_button)
			vb.disable_item_expand (close_button)

			create hb
			hb.set_padding (Layout_constants.Default_padding_size)
			hb.set_border_width (Layout_constants.Default_border_size)

			create f
			f.set_style ({EV_FRAME_CONSTANTS}.Ev_frame_lowered)
			f.extend (list)

			hb.extend (f)
			hb.extend (vb)
			hb.disable_item_expand (vb)

			dialog.extend (hb)

				-- Set widget properties.
			refresh_list
			update_edit_buttons

			dialog.set_title (Interface_names.t_external_commands)
			dialog.set_icon_pixmap (pixmaps.icon_pixmaps.general_dialog_icon)
			dialog.set_default_push_button (close_button)
			dialog.set_default_cancel_button (close_button)
			list.disable_multiple_selection
			list.set_minimum_width (100)
			Layout_constants.set_default_width_for_button (close_button)
			Layout_constants.set_default_width_for_button (add_button)
			Layout_constants.set_default_width_for_button (edit_button)
			Layout_constants.set_default_width_for_button (delete_button)
			dialog.set_size (300, 200)

				-- Set up events.
			list.select_actions.extend (agent update_edit_buttons)
			list.deselect_actions.extend (agent update_edit_buttons)
			list.key_press_actions.extend (agent on_key)
			close_button.select_actions.extend (agent destroy_dialog)
			add_button.select_actions.extend (agent add_command)
			edit_button.select_actions.extend (agent edit_command)
			delete_button.select_actions.extend (agent delete_command)

			dialog.show_actions.extend (agent add_button.set_focus)

		end

	destroy_dialog
			-- Free all widgets.
		do
			check
				dialog /= Void
				--| FIXME XR: We shouldn't be able to call destroy_dialog more than once, but it occurred...
			end
			if dialog /= Void then
				dialog.destroy
			end
			dialog := Void
			add_button := Void
			edit_button := Void
			delete_button := Void
			list := Void
			update_menus
		end

	update_edit_buttons
			-- Update the sensitivity of the buttons that alter the list.
		require
			initialized: list /= Void
		do
			if list.selected_item /= Void then
				edit_button.enable_sensitive
				delete_button.enable_sensitive
			else
				edit_button.disable_sensitive
				delete_button.disable_sensitive
			end
		end

	add_command
			-- Create a new command.
		require
			dialog_exists: dialog /= Void and then not dialog.is_destroyed
		local
			new_command: EB_EXTERNAL_COMMAND
		do
			create new_command.make (dialog, Current)
			if new_command.is_valid then
				update_commands_and_ini (new_command.index, commands, new_command)
				new_command.setup_managed_shortcut (accelerators)
				refresh_list
				update_edit_buttons
				shortcut_manager.update_external_commands
			end
		end

	edit_command
			-- Edit an existing command.
		require
			dialog_exists: list /= Void and dialog /= Void and not dialog.is_destroyed
			has_selection: list.selected_item /= Void
		local
			l_old_index: INTEGER
		do
			if attached {EB_EXTERNAL_COMMAND} list.selected_item.data as comm then
				l_old_index := comm.index

				comm.edit_properties (dialog)

				commands.replace (void, l_old_index)
				update_commands_and_ini (comm.index, commands, comm)

				comm.setup_managed_shortcut (accelerators)
				shortcut_manager.update_external_commands
				refresh_list
				update_edit_buttons
				dialog.set_focus
			else
				check is_ext_command: False end
			end
		end

	update_commands_and_ini (a_index: INTEGER; a_commands: like commands; a_new_command: detachable EB_EXTERNAL_COMMAND)
				-- Update two `commands' lists and ini file
			require
				postive: a_index >= 0
				not_void: attached a_commands
			do
				if commands.has (a_index) then
					commands.replace (a_new_command, a_index)
				else
					commands.put (a_new_command, a_index)
				end

				ini_manager.generate_ini
			end

	delete_command
			-- Delete an existing command.
		require
			dialog_exists: list /= Void and dialog /= Void and not dialog.is_destroyed
			has_selection: list.selected_item /= Void
		do
			if attached {EB_EXTERNAL_COMMAND} list.selected_item.data as comm then
				update_commands_and_ini (comm.index, commands, Void)
				refresh_list
				update_edit_buttons
				add_button.enable_sensitive
				add_button.set_focus
				external_output_manager.synchronize_command_list (Void)
			else
				check is_ext_command: False end
			end
		end

	on_key (k: EV_KEY)
			-- A key was pressed in the list. Process it.
		do
			if k.code = {EV_KEY_CONSTANTS}.Key_delete then
				if attached list as lst and then lst.selected_item /= Void then
					delete_command
				end
			end
		end

	update_menus
			-- Refresh the 'tools' menus of all development windows.
		local
			l_builder: EB_DEVELOPMENT_WINDOW_MENU_BUILDER
		do
			across
				window_manager.managed_windows as ic
			loop
				if attached {EB_DEVELOPMENT_WINDOW} ic.item as l_develop_window then
					create l_builder.make (l_develop_window)
					l_builder.rebuild_tools_menu
				end
			end
		end

feature {NONE} -- Properties

	menu_name: STRING_GENERAL
			-- Name of `Current' as it appears in menus.
		do
			Result := interface_names.m_Edit_external_commands
		end

;note
	copyright:	"Copyright (c) 1984-2020, Eiffel Software"
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
