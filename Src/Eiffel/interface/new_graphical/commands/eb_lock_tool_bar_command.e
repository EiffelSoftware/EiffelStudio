indexing
	description: "Command that lock tool bar docking mechanism."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date		: "$Date$"
	revision	: "$Revision$"

class
	EB_LOCK_TOOL_BAR_COMMAND

inherit
	EB_TOOLBARABLE_AND_MENUABLE_TOGGLE_COMMAND

	EB_DEVELOPMENT_WINDOW_COMMAND
		rename
			target as develop_window
		redefine
			make
		end

create
	make

feature {NONE} -- Initlization

	make (a_develop_window: EB_DEVELOPMENT_WINDOW) is
			-- Creation method
		do
			Precursor {EB_DEVELOPMENT_WINDOW_COMMAND}(a_develop_window)
			enable_sensitive
		end

feature -- Command

	execute is
			-- Redefine
		local
			l_manager: SD_TOOL_BAR_MANAGER
		do
			l_manager := develop_window.docking_manager.tool_bar_manager
			if is_selected then
				l_manager.unlock
			else
				l_manager.lock
			end
			set_select (is_selected)
		end

feature -- Query

	menu_name: STRING_GENERAL is
			-- Menu name
		do
			Result := interface_names.m_lock_tool_bar
		end

	is_selected: BOOLEAN is
			-- Redefine
		do
			Result := develop_window.docking_manager.tool_bar_manager.is_locked
		end

	name: STRING_GENERAL is
			-- Redefine
		do
			Result := "lock_tool_bar"
		end

	pixmap: EV_PIXMAP
			-- Redefine

	description: STRING_GENERAL
			-- Redefine

	pixel_buffer: EV_PIXEL_BUFFER
			-- Redefine

	tooltip: STRING_GENERAL;
			-- Redefine

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

end -- class EB_LOCK_TOOL_BAR_COMMAND
