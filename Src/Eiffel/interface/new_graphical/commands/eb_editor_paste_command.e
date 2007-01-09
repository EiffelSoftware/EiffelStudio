indexing
	description	: "Command to perform a clipboard-paste operation"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date		: "$Date$"
	revision	: "$Revision $"

class
	EB_EDITOR_PASTE_COMMAND

inherit
	EB_CLIPBOARD_COMMAND
		redefine
			executable,
			tooltext,
			pixel_buffer
		end

	EB_DEVELOPMENT_WINDOW_COMMAND
		redefine
			executable
		end

create
	make

feature -- Status report

	executable: BOOLEAN is
			-- Is the operation possible?
		do
				--| FIXME ARNAUD: waiting for Vision2 clipboard.
			Result := is_sensitive
		end

feature -- Execution

	execute is
			-- Execute the copy/copy/paste operation
		do
				--| FIXME ARNAUD: waiting for Vision2 clipboard.
			editor.paste
		end

feature {NONE} -- Implementation

	menu_name: STRING_GENERAL is
			-- Name as it appears in the menu (with & symbol).
		do
			Result := Interface_names.m_Paste
		end

	pixmap: EV_PIXMAP is
			-- Pixmap representing the command.
		do
			Result := pixmaps.icon_pixmaps.general_paste_icon
		end

	pixel_buffer: EV_PIXEL_BUFFER is
			-- Pixel buffer representing the command.
		do
			Result := pixmaps.icon_pixmaps.general_paste_icon_buffer
		end

	tooltip: STRING_GENERAL is
			-- Tooltip for the toolbar button.
		do
			Result := Interface_names.f_Paste
		end

	tooltext: STRING_GENERAL is
			-- Text for the toolbar button.
		do
			Result := Interface_names.b_Paste
		end

	editor: EB_EDITOR is
			-- Editor corresponding to Current
		do
			Result := target.ui.current_editor
		end

	description: STRING_GENERAL is
			-- Description for current command
		do
			Result := Interface_names.e_Paste
		end

	name: STRING is "Editor_paste";
			-- Name of the command. Used to store the command in the
			-- preferences.


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

end -- class EB_EDITOR_PASTE_COMMAND
