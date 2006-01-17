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
	EB_MENUABLE_COMMAND

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
				loaded.set_item (True)
				from
				until
					i > 9
				loop
					s := preferences.misc_data.i_th_external_preference_value (i)
					if not s.is_empty and not s.is_equal (" ") then
						create c.make_from_string (s)
					end
					i := i + 1
				end
			end
		end

	loaded: BOOLEAN_REF is
			-- Has `Current' already loaded the preferences?
		once
			create Result
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

feature{EB_EXTERNAL_OUTPUT_TOOL} -- Synchronizing features used by EB_EXTERNAL_OUTPUT_TOOL

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
			dialog.set_icon_pixmap (pixmaps.icon_dialog_window)
			dialog.set_default_push_button (close_button)
			dialog.set_default_cancel_button (close_button)
			list.disable_multiple_selection
			list.set_minimum_width (100)
			Layout_constants.set_default_size_for_button (close_button)
			Layout_constants.set_default_size_for_button (add_button)
			Layout_constants.set_default_size_for_button (edit_button)
			Layout_constants.set_default_size_for_button (delete_button)
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
					preferences.misc_data.i_th_external_preference (i).set_value ((commands @ i).resource)
				else
						-- We use an empty string as value, because this is how the
						-- preferences are initialized. That way, the entry is actually
						-- removed from the preferences.
					preferences.misc_data.i_th_external_preference (i).set_value ("")
				end
				i := i + 1
			end
		end

	refresh_list is
			-- Rebuild the list of available commands.
		require
			list_exists: list /= Void
		local
			i: INTEGER
			tmp_lst: ARRAYED_LIST [EV_LIST_ITEM]
			litem: EV_LIST_ITEM
		do
			from
				create tmp_lst.make (10)
			until
				i > 9
			loop
				if commands @ i /= Void then
					create litem
					litem.set_text ((commands @ i).name)
					litem.set_data (commands @ i)
					tmp_lst.extend (litem)
				end
				i := i + 1
			end
			list.wipe_out
			list.append (tmp_lst)
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
			refresh_list
			if not commands.has (Void) then
				add_button.disable_sensitive
				close_button.set_focus
			end
			update_edit_buttons
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
			refresh_list
			update_edit_buttons
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
		do
			Window_manager.for_all_development_windows (agent {EB_DEVELOPMENT_WINDOW}.rebuild_tools_menu)
		end

feature {NONE} -- Properties

	menu_name: STRING is
			-- Name of `Current' as it appears in menus.
		do
			Result := interface_names.m_Edit_external_commands
		end

invariant
	invariant_clause: True -- Your invariant here

indexing
	copyright:	"Copyright (c) 1984-2006, Eiffel Software"
	license:	"GPL version 2 see http://www.eiffel.com/licensing/gpl.txt)"
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
