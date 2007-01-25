indexing
	description: "Command to save current docking layout as a named layout."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date		: "$Date$"
	revision	: "$Revision$"

class
	EB_SAVE_LAYOUT_AS_COMMAND

inherit
	EB_MENUABLE_COMMAND

	EB_CONSTANTS

	EB_SHARED_DEBUGGER_MANAGER

	EC_EIFFEL_LAYOUT

create
	make

feature {NONE} -- Initlization

	make (a_develop_window: EB_DEVELOPMENT_WINDOW) is
			-- Creation method
		require
			not_void: a_develop_window /= Void
		do
			develop_window := a_develop_window
			enable_sensitive
		ensure
			set: develop_window = a_develop_window
		end

feature -- Command

	execute is
			-- Save current docking layout as a named layout.
		local
			l_dialog: EB_SAVE_LAYOUT_DIALOG
			l_win: EV_WINDOW
			l_x, l_y: INTEGER
			l_screen: EV_SCREEN
		do
			create l_dialog.make (develop_window)
			l_win := develop_window.window
			l_x := l_win.screen_x + l_win.width // 2 - l_dialog.width // 2
			l_y := l_win.screen_y + l_win.height // 2 - l_dialog.height // 2
			create l_screen
			if l_x + l_dialog.width > l_screen.width or l_y + l_dialog.height > l_screen.height then
				l_x := l_win.x_position
				l_y := l_win.y_position
			end
			l_dialog.set_position (l_x, l_y)
			l_dialog.show_relative_to_window (l_win)
		end

feature -- Query

	menu_name: STRING_GENERAL is
			-- Menu name
		do
			Result := interface_names.m_save_layout_as
		end

feature {NONE} -- Implementation

	dialog: EB_SAVE_LAYOUT_DIALOG
			-- Save layout dialog.

	develop_window: EB_DEVELOPMENT_WINDOW;
			-- Developement window.

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

end -- class EB_SAVE_LAYOUT_AS_COMMAND
