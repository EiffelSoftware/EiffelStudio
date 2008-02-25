indexing
	description	: "Command to create a new development window."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date		: "$Date$"
	revision	: "$Revision$"
	author		: "Arnaud PICHERY [ aranud@mail.dotcom.fr ]"

class
	EB_NEW_DEVELOPMENT_WINDOW_COMMAND

inherit
	EB_TOOLBARABLE_AND_MENUABLE_COMMAND
		redefine
			new_sd_toolbar_item,
			tooltext,
			pixel_buffer,
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
	make_with_style

feature {NONE} -- Initialization

	make_with_style (s: INTEGER) is
			-- Initialize default values.
		require
			valid_style: s = editor_style or s = default_style or s = context_style
		local
			l_shortcut: MANAGED_SHORTCUT
		do
			is_sensitive := True
			style := s
			if s = default_style then
				l_shortcut := preferences.misc_shortcut_data.shortcuts.item ("new_window")
				create accelerator.make_with_key_combination (l_shortcut.key, l_shortcut.is_ctrl, l_shortcut.is_alt, l_shortcut.is_shift)
				accelerator.actions.extend (agent execute)
				set_referred_shortcut (l_shortcut)
			end
		end

feature -- Basic operations

	execute is
			-- Create a development window.
		do
			inspect style
			when default_style then
				window_manager.create_window
			when editor_style then
				window_manager.create_editor_window
			when context_style then
				window_manager.create_context_window
			end
		end

	execute_with_stone (a_stone: STONE) is
			-- Create a development window and process `a_stone'.
		local
			new_window: EB_DEVELOPMENT_WINDOW
		do
			execute
			new_window := window_manager.last_created_window
			check
				creation_effective: new_window /= Void
				-- Was the style invalid?
			end
			if a_stone /= Void then
				new_window.force_stone (a_stone)
			end
		end

	new_sd_toolbar_item (display_text: BOOLEAN): EB_SD_COMMAND_TOOL_BAR_BUTTON is
			-- Create a new toolbar button for this command.
		do
			Result := Precursor (display_text)
			Result.drop_actions.extend (agent execute_with_stone (?))
			Result.drop_actions.set_veto_pebble_function (agent is_storable)
		end

feature -- Access

	style: INTEGER
			-- What kind of development window should `Current' create: development windows,
			-- editor windows or context windows?
			-- This modifies the menus, the pixmaps and the execution of `Current'.

	default_style: INTEGER is 0
	editor_style: INTEGER is 1
	context_style: INTEGER is 2
			-- The different styles that can be used to initialize `Current'.

feature {NONE} -- Implementation

	menu_name: STRING_GENERAL is
			-- Name as it appears in the menu (with & symbol).
		do
			inspect style
			when default_style then
				Result := Interface_names.m_New_window
			when editor_style then
				Result := Interface_names.m_New_editor
			when context_style then
				Result := Interface_names.m_New_context_tool
			end
		end

	pixmap: EV_PIXMAP is
			-- Pixmaps representing the command.
		do
			inspect style
			when default_style then
				Result := pixmaps.icon_pixmaps.new_window_icon
			when editor_style then
				Result := pixmaps.icon_pixmaps.new_editor_icon
			when context_style then
				Result := Pixmaps.icon_new_context_tool
			end
		end

	pixel_buffer: EV_PIXEL_BUFFER is
			-- Pixel buffer representing the command.
		do
			inspect style
			when default_style then
				Result := pixmaps.icon_pixmaps.new_window_icon_buffer
			when editor_style then
				Result := pixmaps.icon_pixmaps.new_editor_icon_buffer
			when context_style then
				-- No pixel buffer for this case.
			end
		end

	mini_pixmap: EV_PIXMAP is
			-- Pixmap representing the command for mini toolbars.
		do
			Result := pixmaps.mini_pixmaps.new_window_icon
		end

	mini_pixel_buffer: EV_PIXEL_BUFFER is
			-- Pixel buffer representing the command for mini toolbars.
		do
			Result := pixmaps.mini_pixmaps.new_window_icon_buffer
		end

	tooltip: STRING_GENERAL is
			-- Tooltip for the toolbar button.
		do
			Result := description
		end

	tooltext: STRING_GENERAL is
			-- Text for the toolbar button.
		do
			inspect style
			when default_style then
				Result := Interface_names.b_New_window
			when editor_style then
				Result := Interface_names.b_New_editor
			when context_style then
				Result := Interface_names.b_New_context
			end
		end

	is_storable (st: ANY): BOOLEAN is
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

	description: STRING_GENERAL is
			-- Description for this commane
		do
			inspect style
			when default_style then
				Result := Interface_names.f_New_window
			when editor_style then
				Result := Interface_names.e_New_editor
			when context_style then
				Result := Interface_names.e_New_context_tool
			end
		end

	name: STRING is
			-- Name of the command. Used to store the command in the
			-- preferences.
		do
			inspect style
			when default_style then
				Result := "New_window"
			when editor_style then
				Result := "New_editor"
			when context_style then
				Result := "New_context_window"
			end
		end

feature -- Obsolete

	create_class_tool (a_stone: STONE) is
			-- Create a development window and process `a_stone'.
		obsolete "use `execute_with_stone' instead"
		do
			execute_with_stone (a_stone)
		end

	create_new_development_window (a_stone: STONE) is
			-- Create a development window and process `a_stone'.
		obsolete
			"use `execute_with_stone' instead"
		do
			execute_with_stone (a_stone)
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

end -- class EB_NEW_DEVELOPMENT_WINDOW_COMMAND
