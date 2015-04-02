note
	description	: "Command to open a shell with an editor."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	EB_OPEN_SHELL_COMMAND

inherit
	EB_DEVELOPMENT_WINDOW_COMMAND
		redefine
			initialize
		end

	EB_TOOLBARABLE_AND_MENUABLE_COMMAND
		redefine
			new_sd_toolbar_item,
			tooltext
		end

	SHARED_EIFFEL_PROJECT

	SHARED_SERVER

	SYSTEM_CONSTANTS

	EB_SHARED_PREFERENCES
		export
			{NONE} all
		end

	EB_CONSTANTS

create
	make

feature {NONE} -- Initialization

	initialize
			-- Enable `Current'.
		do
			is_sensitive := True
		end

feature -- Basic operations

	new_sd_toolbar_item (display_text: BOOLEAN): EB_SD_COMMAND_TOOL_BAR_BUTTON
			-- Create a new toolbar button for this command.
		do
			Result := Precursor (display_text)
			Result.drop_actions.extend (agent execute_with_stone)
			Result.drop_actions.set_veto_pebble_function (agent is_droppable)
		end

feature -- Access

	execute_with_stone (a_stone: STONE)
		local
			req: COMMAND_EXECUTOR
			l_line_number: INTEGER
		do
			if attached {FILED_STONE} a_stone as fs then
				if attached {FEATURE_STONE} fs as l_stone then
					l_line_number := l_stone.line_number
				elseif attached {LINE_STONE} fs as l_stone then
					l_line_number := l_stone.line_number
				elseif attached {AST_STONE} fs as l_stone then
					l_line_number := l_stone.line_position.max (1)
				elseif attached {CL_SYNTAX_STONE} fs as l_stone then
					l_line_number := l_stone.syntax_message.line
				else
					l_line_number := 1
				end
				check valid_line_number: l_line_number > 0 end
				create req
				req.execute (preferences.misc_data.external_editor_cli (fs.file_name, l_line_number))
			end
		end

feature {NONE} -- Implementation

	execute
			-- Redefine
		local
			req: COMMAND_EXECUTOR
			line_nb, first_line, cursor_line: INTEGER
			development_window: EB_DEVELOPMENT_WINDOW
			editor: EB_SMART_EDITOR
		do
			development_window := target
			editor := development_window.editors_manager.current_editor
			if editor /= Void and then not editor.is_empty then
					-- We ensure that we target the editor line to the cursor position, however if the cursor
					-- is not visible we take the `first_line_displayed'.
				cursor_line := editor.cursor_y_position
				first_line := editor.first_line_displayed
				if first_line > cursor_line then
					line_nb := first_line
				elseif
					first_line < cursor_line and
					cursor_line < first_line + editor.number_of_lines_displayed
				then
					line_nb := cursor_line
				else
					line_nb := first_line
				end
			end
			create req
			req.execute (preferences.misc_data.external_editor_cli (window_file_name, line_nb.max (1)))
		end

	window_file_name: detachable like {FILED_STONE}.file_name
			-- Provides the filename of the current edited element, if possible.
		do
			if attached {FILED_STONE} target.stone as fs then
				Result := fs.file_name
			end
		end

feature {NONE} -- Implementation properties

	menu_name: STRING_GENERAL
			-- Name as it appears in the menu (with & symbol).
		do
			Result := Interface_names.m_external_editor
		end

	pixmap: EV_PIXMAP
			-- Pixmaps representing the command.
		do
			Result := pixmaps.icon_pixmaps.command_send_to_external_editor_icon
		end

	pixel_buffer: EV_PIXEL_BUFFER
			-- Pixel buffer representing the command.
		do
			Result := pixmaps.icon_pixmaps.command_send_to_external_editor_icon_buffer
		end

	tooltip: STRING_GENERAL
			-- Tooltip for the toolbar button.
		do
			Result := Interface_names.e_shell
		end

	tooltext: STRING_GENERAL
			-- Textp for the toolbar button.
		do
			Result := Interface_names.b_shell
		end

	description: STRING_GENERAL
			-- Description for this command.
		do
			Result := Interface_names.e_shell
		end

	name: STRING = "Open_shell"
			-- Name of the command. Used to store the command in the
			-- preferences.

	is_droppable (st: ANY): BOOLEAN
			-- Can `st' be dropped?
		do
			Result := attached {FILED_STONE} st as l_stone and then l_stone.is_storable and then l_stone.is_valid
			if Result and attached {CLASSI_STONE} st as l_ext_stone then
					-- If it is a .NET class, then we cannot drop.
				Result := not l_ext_stone.is_dotnet_class
			end
		end

note
	copyright:	"Copyright (c) 1984-2015, Eiffel Software"
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

end -- class EB_OPEN_SHELL_CMD
