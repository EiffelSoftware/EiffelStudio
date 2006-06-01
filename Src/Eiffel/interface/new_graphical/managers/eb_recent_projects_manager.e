indexing
	description	: "Facilities to manage a recent project"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date		: "$Date$"
	revision	: "$Revision$"
	author		: "Arnaud PICHERY [ aranud@mail.dotcom.fr ]"

class
	EB_RECENT_PROJECTS_MANAGER

inherit
	EB_SHARED_PREFERENCES

create
	make

feature {NONE} -- Initialization

	make is
			-- Create a project manager.
		local
			l_value: STRING
			l_projects: ARRAY [STRING]
			i: INTEGER
			l_project_name: STRING
		do
				-- Get values from preferences.
			l_value := preferences.preferences.get_preference_value_direct ("LIST_" + preferences.recent_projects_data.last_opened_projects_string)
			if l_value /= Void then
				preferences.recent_projects_data.last_opened_projects_preference.set_value_from_string (l_value)
			end
			l_projects := preferences.recent_projects_data.last_opened_projects

			if l_projects /= Void and then not l_projects.is_empty then
				create recent_projects.make (l_projects.count)
				recent_projects.compare_objects
				from
					i := l_projects.lower
				until
					i > l_projects.upper
				loop
					create l_project_name.make_from_string (l_projects.item (i))
					if not recent_projects.has (l_project_name) then
						recent_projects.extend (l_project_name)
					end
					i := i + 1
				end
			else
				create recent_projects.make (1)
				recent_projects.compare_objects
			end
		end

feature -- Access

	recent_projects: ARRAYED_LIST [STRING]
			-- Save the list of recent opened projects during the execution
			-- Purpose: make it easier to save the data at the end.

feature -- Menus handling

	new_menu: EB_RECENT_PROJECTS_MANAGER_MENU is
			-- Menu corresponding to current: This is a menu with
			-- one entry per old project.
			--
			-- When this menu is not anymore needed, call `clean_up' on it.
		do
			create Result.make (Current)
		end

feature -- Basic operations

	add_recent_project (a_project: STRING) is
			-- Add `a_project' to list of recent projects.
		require
			a_project_not_void: a_project /= Void
			a_project_not_empty: not a_project.is_empty
		do
			recent_projects.prune_all (a_project)
			recent_projects.put_front (a_project)
		end

	save_recent_projects is
			-- Save the current list of recent projects
		do
			save_projects (recent_projects)
		end

	save_projects (a_projects_list: like recent_projects) is
			-- Save `a_projects_list' recent projects.
		require
			a_projects_list_not_void: a_projects_list /= Void
		do
			recent_projects := a_projects_list
				-- Let observers know about the changes.
			on_update
				-- Save it.
			preferences.recent_projects_data.last_opened_projects_preference.set_value (recent_projects)
		end

feature {EB_RECENT_PROJECTS_MANAGER_OBSERVER} -- Observer pattern / Registration

	add_observer (an_observer: EB_RECENT_PROJECTS_MANAGER_OBSERVER) is
			-- Add `an_observer' to the list of observers for Current.
		require
			valid_observer: an_observer /= Void
		do
			if observers = Void then
				create observers.make (2)
			end
			observers.extend (an_observer)
		end

	remove_observer (an_observer: EB_RECENT_PROJECTS_MANAGER_OBSERVER) is
			-- Remove `an_observer' to the list of observers for Current.
		require
			valid_observer: an_observer /= Void
		do
			if observers /= Void then
				observers.prune_all (an_observer)
			end
		end

feature {NONE} -- Observer pattern / Implementation

	on_update is
			-- The list of recent projects has changed
		do
			if observers /= Void then
				from
					observers.start
				until
					observers.after
				loop
					observers.item.on_update
					observers.forth
				end
			end
		end

	observers: ARRAYED_LIST [EB_RECENT_PROJECTS_MANAGER_OBSERVER]
			-- All observers for Current.

invariant
	recent_projects_not_void: recent_projects /= Void
	recent_projects_compare_objects: recent_projects.object_comparison

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

end -- class EB_RECENT_PROJECTS_MANAGER
