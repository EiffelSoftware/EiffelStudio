note
	description: "Commands that restore whole editor area."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date		: "$Date$"
	revision	: "$Revision$"

class
	EB_RESTORE_EDITOR_AREA_COMMAND

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

	make (a_develop_window: EB_DEVELOPMENT_WINDOW)
			-- Creation method
		do
			Precursor {EB_DEVELOPMENT_WINDOW_COMMAND}(a_develop_window)
			a_develop_window.docking_manager.restore_editor_area_actions.extend (agent update_menu_items_state)
			a_develop_window.docking_manager.restore_editor_area_for_minimized_actions.extend (agent update_menu_items_state)
		end

feature -- Query

	menu_name: STRING_GENERAL
			-- Menu name
		do
			Result := interface_names.m_restore_editor_area
		end

feature -- Command

	execute
			-- Execute
		local
			l_manager: SD_DOCKING_MANAGER
		do
			l_manager := develop_window.docking_manager

			l_manager.restore_editor_area
			l_manager.restore_editor_area_for_minimized

			update_menu_items_state
		end

	update_menu_items_state
			-- Update menu items state
		do
			disable_sensitive
			develop_window.commands.maximize_editor_area_command.enable_sensitive
			develop_window.commands.minimize_editor_area_command.enable_sensitive
		end

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

end -- class EB_MAXIMIZE_EDITOR_AREA_COMMAND
