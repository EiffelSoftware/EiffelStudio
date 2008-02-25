indexing
	description: "Command to create a new tab editor."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	EB_NEW_TAB_EDITOR_COMMAND

inherit
	EB_TOOLBARABLE_AND_MENUABLE_COMMAND
		redefine
			tooltext,
			new_sd_toolbar_item,
			new_mini_sd_toolbar_item
		end

	EB_DEVELOPMENT_WINDOW_COMMAND
		rename
			target as development_window,
			make as make_old
		end

	EB_SHARED_PREFERENCES
		export
			{NONE} all
		end

	EB_SHARED_WINDOW_MANAGER

	EB_CONSTANTS

create
	make

feature -- Initialization

	make (dev_window: EB_DEVELOPMENT_WINDOW) is
			-- Creation method.
		require
			dev_window_attached: dev_window /= Void
		local
			l_shortcut: SHORTCUT_PREFERENCE
		do
			development_window := dev_window
			l_shortcut := preferences.misc_shortcut_data.shortcuts.item ("new_tab")
			create accelerator.make_with_key_combination (l_shortcut.key, l_shortcut.is_ctrl, l_shortcut.is_alt, l_shortcut.is_shift)
			set_referred_shortcut (l_shortcut)
			accelerator.actions.extend (agent execute)
			enable_sensitive
		ensure
			development_window_attached: development_window = dev_window
		end

feature -- Execution

	execute is
			-- Create new tab.
		do
			creating_empty_tab := True
			execute_with_stone_content (Void, Void)
			creating_empty_tab := False
		end

	execute_with_stone (a_stone: STONE) is
			-- Execute with `a_stone'.
		do
			execute_with_stone_content (a_stone, Void)
		end

	execute_with_stone_content (a_stone: STONE; a_content: SD_CONTENT) is
			-- Create a new tab which stone is `a_stone' and create at side of `a_content' if exists.
		local
			l_editor : EB_SMART_EDITOR
		do
			if is_sensitive then
				if editors_manager.stone_acceptable (a_stone) or creating_empty_tab then
					l_editor := editors_manager.editor_with_stone (a_stone)
					if l_editor = Void and a_content = Void then
						editors_manager.create_editor
						editors_manager.select_editor (editors_manager.last_created_editor, True)
					elseif l_editor = Void and a_content /= Void then
						editors_manager.create_editor_beside_content (a_stone, a_content)
						editors_manager.select_editor (editors_manager.last_created_editor, True)
					else
						editors_manager.select_editor (l_editor, True)
					end

					development_window.set_stone (a_stone)
					development_window.address_manager.on_new_tab_command
				end
			end
		end

feature -- Items

	new_sd_toolbar_item (display_text: BOOLEAN): EB_SD_COMMAND_TOOL_BAR_BUTTON is
			-- New toolbar item for dockable toolbar.
		do
			Result := Precursor {EB_TOOLBARABLE_AND_MENUABLE_COMMAND}(display_text)
			Result.drop_actions.extend (agent execute_with_stone)
			Result.drop_actions.set_veto_pebble_function (agent editors_manager.stone_acceptable)
		end

	new_mini_sd_toolbar_item: EB_SD_COMMAND_TOOL_BAR_BUTTON is
			-- New mini toolbar item.
		do
			Result := Precursor {EB_TOOLBARABLE_AND_MENUABLE_COMMAND}
			Result.drop_actions.extend (agent execute_with_stone)
			Result.drop_actions.set_veto_pebble_function (agent editors_manager.stone_acceptable)
		end

feature {NONE} -- Implementation

	menu_name: STRING_GENERAL is
			-- Name as it appears in the menu (with & symbol).
		do
			Result := interface_names.m_new_tab
		end

	pixmap: EV_PIXMAP is
			-- Pixmap representing the command.
		do
			Result := pixmaps.icon_pixmaps.new_document_icon
		end

	pixel_buffer: EV_PIXEL_BUFFER is
			-- Pixel buffer representing the command.
		do
			Result := pixmaps.icon_pixmaps.new_document_icon_buffer
		end

	tooltip: STRING_GENERAL is
			-- Tooltip for the toolbar button.
		do
			Result := interface_names.f_new_tab
		end

	tooltext: STRING_GENERAL is
			-- Text for the toolbar button.
		do
			Result := interface_names.b_new_tab
		end

	description: STRING_GENERAL is
			-- Description for this command.
		do
			Result := interface_names.f_new_tab
		end

	name: STRING_GENERAL is
			-- Name of the command. Used to store the command in the
			-- preferences.
		do
			Result := "New_tab"
		end

feature {NONE} -- Implementation

	creating_empty_tab: BOOLEAN
			-- Creating empty tab?

	editors_manager: EB_EDITORS_MANAGER is
			-- Editors manager.
		do
			Result := development_window.editors_manager
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
