indexing
	description: "Command that lets the user add new external commands to the tools menus"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	author: "Xavier Rousselot"
	date: "$Date$"
	revision: "$Revision$"

class
	EB_EXTERNAL_COMMANDS_EDITOR

inherit
	EB_TOOLBARABLE_AND_MENUABLE_COMMAND
		redefine
			name,
			executable,
			new_sd_toolbar_item,
			pixel_buffer
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

	make is
			-- Initialize `Current'.
		local
			i: INTEGER
			s: STRING
			c: EB_EXTERNAL_COMMAND
		do
			if not loaded.item then
				loaded.put (True)
				from
				until
					i > 9
				loop
					s := preferences.external_command_data.i_th_external_preference_value (i)
					if not s.is_empty and not s.is_equal (" ") then
						create c.make_from_string (s)
						c.setup_managed_shortcut (accelerators)
					end
					i := i + 1
				end
			end
			enable_displayed
		end

	loaded: CELL [BOOLEAN] is
			-- Has `Current' already loaded the preferences?
		once
			create Result.put (False)
		ensure
			loaded_not_void: Result /= Void
		end

feature -- Status report

	menus: LIST [EB_COMMAND_MENU_ITEM] is
			-- Create a list of menu items that represent the list of external commands.
		local
			i: INTEGER
		do
			from
				create {ARRAYED_LIST [EB_COMMAND_MENU_ITEM]} Result.make (10)
			until
				i > 9
			loop
				if commands @ i /= Void then
					Result.extend ((commands @ i).new_menu_item)
				end
				i := i + 1
			end
		end

	commands: ARRAY [EB_EXTERNAL_COMMAND] is
			-- Array of external commands.
		once
			create Result.make (0, 9)
		end

	accelerators: ARRAY [EV_ACCELERATOR] is
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

	pixmap: EV_PIXMAP is
			-- Pixmap representing the command.
		do
			Result := pixmaps.icon_pixmaps.tool_external_commands_icon
		end

	pixel_buffer: EV_PIXEL_BUFFER is
			-- Pixel buffer representing the command.
		do
			Result := pixmaps.icon_pixmaps.tool_external_commands_icon_buffer
		end

	tooltip: STRING_GENERAL is
			-- Tooltip for the toolbar button.
		do
			Result := description
		end

	name: STRING is "External commands"
			-- Name of the command. Use to store the command in the
			-- preferences.

	description: STRING_GENERAL is
			-- Pop up help on the toolbar button.
		do
			Result := Interface_names.l_manage_external_commands
		end

	executable: BOOLEAN is
			-- Is Current command executable?
			-- (True by default)
		do
			Result := is_sensitive
		end

	new_sd_toolbar_item (display_text: BOOLEAN): EB_SD_COMMAND_TOOL_BAR_BUTTON is
			-- Create a new toolbar button for this command.
		do
			Result := Precursor (display_text)
			Result.set_pixmap (pixmap)
			Result.set_pixel_buffer (pixel_buffer)
			Result.set_tooltip (tooltip)
		end

	list_exists: BOOLEAN is
			-- Does `list' exist?
		do
			Result := list /= Void
		end

feature -- Actions

	on_shortcut_change (i: INTEGER) is
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

	execute is
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

	execute_command_at_position (a_pos: INTEGER) is
			-- Execute command at position `a_pos'.
		require
			a_pos_valid: a_pos >=0 and a_pos <= 9
		do
			if commands.item (a_pos) /= Void then
				commands.item (a_pos).execute
			end
		end

	refresh_list is
			-- Rebuild the list of available commands.
		require
			list_exists: list_exists
		local
			i: INTEGER
			litem: EV_LIST_ITEM
		do
			from
				list.wipe_out
			until
				i > 9
			loop
				if commands @ i /= Void then
					create litem
					litem.set_text ((commands @ i).name)
					litem.set_data (commands @ i)
					list.extend (litem)
				end
				i := i + 1
			end
		end

feature{ES_CONSOLE_TOOL_PANEL} -- Synchronizing features used by EB_EXTERNAL_OUTPUT_TOOL

	refresh_list_from_outside is
			-- Refresh command list from EB_EXTERNAL_OUTPUT_TOOL
		do
			if list /= Void then
				refresh_list
			end
		end
	update_menus_from_outside is
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

	create_dialog is
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
			if not commands.has (Void) then
					-- All command indices are already taken.
				add_button.disable_sensitive
			end
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

			if commands.has (Void) then
					-- It is not full
				dialog.show_actions.extend (agent add_button.set_focus)
			end
		end

	destroy_dialog is
			-- Free all widgets.
		local
			i: INTEGER
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
			from
			until
				i > 9
			loop
				if commands @ i /= Void then
					preferences.external_command_data.i_th_external_preference (i).set_value ((commands @ i).resource)
				else
						-- We use an empty string as value, because this is how the
						-- preferences are initialized. That way, the entry is actually
						-- removed from the preferences.
					preferences.external_command_data.i_th_external_preference (i).set_value ("")
				end
				i := i + 1
			end
		end

	update_edit_buttons is
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

	add_command is
			-- Create a new command.
		require
			dialog_exists: dialog /= Void and then not dialog.is_destroyed
			room_left: commands.has (Void)
		local
			new_command: EB_EXTERNAL_COMMAND
		do
			create new_command.make (dialog)
			new_command.setup_managed_shortcut (accelerators)
			refresh_list
			if not commands.has (Void) then
				add_button.disable_sensitive
				close_button.set_focus
			end
			update_edit_buttons
			shortcut_manager.update_external_commands
		end

	edit_command is
			-- Edit an existing command.
		require
			dialog_exists: list /= Void and dialog /= Void and not dialog.is_destroyed
			has_selection: list.selected_item /= Void
		local
			comm: EB_EXTERNAL_COMMAND
		do
			comm ?= list.selected_item.data
			comm.edit_properties (dialog)
			comm.setup_managed_shortcut (accelerators)
			shortcut_manager.update_external_commands
			refresh_list
			update_edit_buttons
			dialog.set_focus
		end

	delete_command is
			-- Delete an existing command.
		require
			dialog_exists: list /= Void and dialog /= Void and not dialog.is_destroyed
			has_selection: list.selected_item /= Void
		local
			comm: EB_EXTERNAL_COMMAND
		do
			comm ?= list.selected_item.data
			commands.put (Void, comm.index)
			refresh_list
			update_edit_buttons
			add_button.enable_sensitive
			add_button.set_focus
			external_output_manager.synchronize_command_list (Void)
		end

	on_key (k: EV_KEY) is
			-- A key was pressed in the list. Process it.
		do
			if k.code = {EV_KEY_CONSTANTS}.Key_delete then
				if list /= Void and list.selected_item /= Void then
					delete_command
				end
			end
		end

	update_menus is
			-- Refresh the 'tools' menus of all development windows.
		local
			l_builder: EB_DEVELOPMENT_WINDOW_MENU_BUILDER
			l_managed_windows: ARRAYED_SET [EB_WINDOW]
			l_develop_window: EB_DEVELOPMENT_WINDOW
		do
			from
				l_managed_windows := window_manager.managed_windows
				l_managed_windows.start
			until
				l_managed_windows.after
			loop
				l_develop_window ?= l_managed_windows.item
				if l_develop_window /= Void then
					create l_builder.make (l_develop_window)
					l_builder.rebuild_tools_menu
				end
				l_managed_windows.forth
			end
		end

feature {NONE} -- Properties

	menu_name: STRING_GENERAL is
			-- Name of `Current' as it appears in menus.
		do
			Result := interface_names.m_Edit_external_commands
		end

invariant
	invariant_clause: True -- Your invariant here

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

end -- class EB_EXTERNAL_COMMANDS_EDITOR
