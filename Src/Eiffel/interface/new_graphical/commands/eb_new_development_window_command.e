note
	description: "Command to create a new development window."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"
	author: "Arnaud PICHERY [ aranud@mail.dotcom.fr ]"
	revised_by: "Alexander Kogtenkov"

class
	EB_NEW_DEVELOPMENT_WINDOW_COMMAND

inherit
	EB_TOOLBARABLE_AND_MENUABLE_COMMAND
		redefine
			new_sd_toolbar_item,
			tooltext,
			mini_pixmap,
			mini_pixel_buffer
		end

	EB_SHARED_WINDOW_MANAGER

	EB_CONSTANTS

	EB_SHARED_PREFERENCES
		export
			{NONE} all
		end

create
	make

feature {NONE} -- Initialization

	make
			-- Initialize default values.
		local
			l_shortcut: MANAGED_SHORTCUT
		do
			is_sensitive := True
			l_shortcut := preferences.misc_shortcut_data.shortcuts.item ("new_window")
			create accelerator.make_with_key_combination (l_shortcut.key, l_shortcut.is_ctrl, l_shortcut.is_alt, l_shortcut.is_shift)
			accelerator.actions.extend (agent execute)
			set_referred_shortcut (l_shortcut)
		end

feature -- Basic operations

	execute
			-- Create a development window.
		local
			l_window: EB_DEVELOPMENT_WINDOW
		do
			window_manager.create_window
			l_window := window_manager.last_created_window
			window_manager.load_window_session_data (l_window)
		end

	execute_with_stone (a_stone: STONE)
			-- Create a development window and process `a_stone'.
		local
			new_window: EB_DEVELOPMENT_WINDOW
		do
			execute
			new_window := window_manager.last_created_window
			check creation_effective: new_window /= Void end
			new_window.set_stone (a_stone)
		end

	new_sd_toolbar_item (display_text: BOOLEAN): EB_SD_COMMAND_TOOL_BAR_BUTTON
			-- Create a new toolbar button for this command.
		do
			Result := Precursor (display_text)
			Result.drop_actions.extend (agent execute_with_stone)
			Result.drop_actions.set_veto_pebble_function (agent is_storable)
		end

feature -- Access

	menu_name: STRING_GENERAL
			-- Name as it appears in the menu (with & symbol).
		do
			Result := Interface_names.m_New_window
		end

	pixmap: EV_PIXMAP
			-- Pixmaps representing the command.
		do
			Result := pixmaps.icon_pixmaps.new_window_icon
		end

	pixel_buffer: EV_PIXEL_BUFFER
			-- Pixel buffer representing the command.
		do
			Result := pixmaps.icon_pixmaps.new_window_icon_buffer
		end

	mini_pixmap: EV_PIXMAP
			-- Pixmap representing the command for mini toolbars.
		do
			Result := pixmaps.mini_pixmaps.new_window_icon
		end

	mini_pixel_buffer: EV_PIXEL_BUFFER
			-- Pixel buffer representing the command for mini toolbars.
		do
			Result := pixmaps.mini_pixmaps.new_window_icon_buffer
		end

	tooltip: STRING_GENERAL
			-- Tooltip for the toolbar button.
		do
			Result := description
		end

	tooltext: STRING_GENERAL
			-- Text for the toolbar button.
		do
			Result := Interface_names.b_New_window
		end

	is_storable (st: ANY): BOOLEAN
			-- Can `st' be dropped?
		local
			conv_st: STONE
			tar_st: TARGET_STONE
		do
			tar_st ?= st
			if tar_st = Void then
				conv_st ?= st
				Result := conv_st /= Void and then conv_st.is_storable and then conv_st.is_valid
			end
		end

	description: STRING_GENERAL
			-- Description for this commane
		do
			Result := Interface_names.f_New_window
		end

	name: STRING_GENERAL
			-- Name of the command. Used to store the command in the
			-- preferences.
		do
			Result := "New_window"
		end

note
	copyright: "Copyright (c) 1984-2023, Eiffel Software"
	license:   "GPL version 2 (see http://www.eiffel.com/licensing/gpl.txt)"
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
