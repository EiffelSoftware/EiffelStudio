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
			new_toolbar_item,
			new_sd_toolbar_item,
			new_mini_toolbar_item
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
		do
			development_window := dev_window
			create accelerator.make_with_key_combination (
				create {EV_KEY}.make_with_code ({EV_KEY_CONSTANTS}.Key_t),
				True, False, False)
			accelerator.actions.extend (agent execute)
			accelerator.actions.extend (agent (development_window.address_manager).on_new_tab_command)
		ensure
			development_window_attached: development_window = dev_window
		end

feature -- Execution

	execute is
			-- Create new tab.
		do
			editors_manager.create_editor
		end

feature -- Items

	new_toolbar_item (display_text: BOOLEAN): EB_COMMAND_TOOL_BAR_BUTTON is
			-- Create a new toolbar button for this command.
		do
			Result := Precursor (display_text)
			Result.drop_actions.extend (agent execute_with_stone)
		end

	new_sd_toolbar_item (display_text: BOOLEAN): EB_SD_COMMAND_TOOL_BAR_BUTTON is
			-- New toolbar item for dockable toolbar.
		do
			Result := Precursor {EB_TOOLBARABLE_AND_MENUABLE_COMMAND}(display_text)
			Result.drop_actions.extend (agent execute_with_stone)
		end

	new_mini_toolbar_item: EB_COMMAND_TOOL_BAR_BUTTON is
			-- New mini toolbar item.
		do
			Result := Precursor {EB_TOOLBARABLE_AND_MENUABLE_COMMAND}
			Result.drop_actions.extend (agent execute_with_stone)
		end

feature {NONE} -- Implementation

	execute_with_stone (a_stone: STONE) is
			-- Execute with `a_stone'.
		local
			l_editor : EB_SMART_EDITOR
		do
			l_editor := editors_manager.editor_with_stone (a_stone)
			if l_editor = Void then
				execute
				editors_manager.select_editor (editors_manager.last_created_editor)
			else
				editors_manager.select_editor (l_editor)
			end
			development_window.set_stone (a_stone)
		end

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

	editors_manager: EB_EDITORS_MANAGER is
			-- Editors manager.
		do
			Result := development_window.editors_manager
		end

	development_window: EB_DEVELOPMENT_WINDOW;
			-- Development window.

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
