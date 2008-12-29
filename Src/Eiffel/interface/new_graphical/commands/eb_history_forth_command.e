note
	description	: "Command to go forward in the history."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date		: "$Date$"
	revision	: "$Revision$"

class
	EB_HISTORY_FORTH_COMMAND

inherit
	EB_HISTORY_COMMAND
		redefine
			executable,
			mini_pixmap,
			mini_pixel_buffer
		end

create
	make

feature -- Access

	executable: BOOLEAN
			-- Is `operate' possible (i.e. can we go forth)?
		do
			Result := history_manager.is_forth_possible
		end

	mini_pixmap: EV_PIXMAP
			-- Mini pixmap representing the command.
		do
			Result := pixmaps.mini_pixmaps.general_next_icon
		end

	mini_pixel_buffer: EV_PIXEL_BUFFER
			-- Mini pixmap representing the command.
		do
			Result := pixmaps.mini_pixmaps.general_next_icon_buffer
		end

feature {NONE} -- Implementation

	operate
			-- Move forward in the history.
		do
			history_manager.forth
		end

	pixmap: EV_PIXMAP
			-- Pixmaps representing the command.
		do
			Result :=pixmaps.icon_pixmaps.view_next_icon
		end

	pixel_buffer: EV_PIXEL_BUFFER
			-- Pixel buffer representing the command.
		do
			Result := pixmaps.icon_pixmaps.view_next_icon_buffer
		end

	menu_name: STRING_GENERAL
			-- Name as it appears in the menu (with & symbol).
		do
			Result := Interface_names.m_History_forth
		end

	tooltip: STRING_GENERAL
			-- Tooltip for the toolbar button.
		do
			Result := Interface_names.f_History_forth
		end

	description: STRING_GENERAL
			-- Description for this command.
		do
			Result := Interface_names.e_History_forth
		end

	name: STRING = "History_forth";
			-- Name of the command. Used to store the command in the
			-- preferences.

note
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

end -- class EB_HISTORY_FORTH_COMMAND
