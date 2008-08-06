indexing
	description: "Commands that maximized whole editor area."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date		: "$Date$"
	revision	: "$Revision$"

class
	EB_MINIMIZE_EDITOR_AREA_COMMAND

inherit
	EB_MENUABLE_COMMAND

	EB_DEVELOPMENT_WINDOW_COMMAND
		rename
			target as develop_window
		redefine
			make
		end

	EB_CONSTANTS

create
	make

feature {NONE} -- Initlization

	make (a_develop_window: EB_DEVELOPMENT_WINDOW) is
			-- Creation method
		do
			Precursor {EB_DEVELOPMENT_WINDOW_COMMAND}(a_develop_window)
			enable_sensitive
			a_develop_window.docking_manager.restore_editor_area_for_minimized_actions.extend (agent update_menu_items_state)
		end

feature -- Query

	menu_name: STRING_GENERAL is
			-- Menu name
		do
			Result := interface_names.m_Minimize_editor_Area
		end

feature -- Command

	execute is
			-- Execute
		local
			l_manager: SD_DOCKING_MANAGER
		do
			l_manager := develop_window.docking_manager
			if not l_manager.is_editor_area_minimized then
				l_manager.minimize_editor_area
			end
			update_menu_items_state
		end

	update_menu_items_state is
			-- Update menu items state
		do
			if develop_window.docking_manager.is_editor_area_minimized then
				disable_sensitive
				develop_window.commands.restore_editor_area_command.enable_sensitive
			end
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

end -- class EB_MINIMIZE_EDITOR_AREA_COMMAND
