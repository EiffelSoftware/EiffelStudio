indexing
	description	: "Menu representing all the recent opened projects."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	author		: "Arnaud PICHERY [ aranud@mail.dotcom.fr ]"
	date		: "$Date$"
	revision	: "$Revision$"

class
	EB_RECENT_PROJECTS_MANAGER_MENU

inherit
	EV_MENU

	EB_RECENT_PROJECTS_MANAGER_OBSERVER
		undefine
			default_create, is_equal, copy
		redefine
			on_update
		end

	EB_CONSTANTS
		undefine
			default_create, is_equal, copy
		end

	EB_RECYCLABLE
		undefine
			default_create, is_equal, copy
		end

create
	make

feature {NONE} -- Initialization

	make (a_recent_projects_manager: EB_RECENT_PROJECTS_MANAGER) is
			-- Initialization: build the widget and the menu.
		do
				-- Setup the manager.
			recent_projects_manager := a_recent_projects_manager
			recent_projects_manager.add_observer (Current)

				-- Build the menu.
			make_with_text (Interface_names.m_Recent_project)
			update
		end

feature {EB_RECENT_PROJECTS_MANAGER} -- Observer pattern

	on_update is
			-- the list of recent projects has changed.
		do
			update
		end

	update is
			-- (Re)build the menu.
		local
			recent_projects: ARRAYED_LIST [STRING]
			open_cmd: EB_OPEN_PROJECT_COMMAND
			menu_item: EV_MENU_ITEM
			project_file_name: STRING
		do
			wipe_out
			recent_projects := recent_projects_manager.recent_projects
			from
				recent_projects.start
			until
				recent_projects.after
			loop
				project_file_name := recent_projects.item
				create open_cmd.make
				create menu_item.make_with_text (project_file_name)
				menu_item.select_actions.extend (agent open_cmd.execute_with_file (project_file_name))
				extend (menu_item)
				recent_projects.forth
			end
		end	

feature -- Recycle

	recycle is
			-- To be called when the object is no more used.
		do
			recent_projects_manager.remove_observer (Current)
		end

feature {NONE} -- Implementation
		
	recent_projects_manager: EB_RECENT_PROJECTS_MANAGER
			-- Associated recent project manager

feature -- Obsolete

	clean_up is
		obsolete "use `recycle' instead"
		do
			recycle
		end

indexing
	copyright:	"Copyright (c) 1984-2006, Eiffel Software"
	license:	"GPL version 2 see http://www.eiffel.com/licensing/gpl.txt)"
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

end -- class EB_RECENT_PROJECT_MANAGER_MENU
