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

	PROJECT_CONTEXT

	SHARED_EIFFEL_PROJECT

create
	make

feature {NONE} -- Initialization

	make is
			-- Create a project manager.
		do
				-- Set up the recent project list from datastore
			create recent_projects.make (10)
			recent_projects.compare_objects
			update_recent_projects_from_datastore
			load_recent_projects (preferences.recent_projects_data.last_opened_projects)
		end

feature -- Access

	recent_projects: ARRAYED_LIST [FILE_NAME]
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

	save_environment is
			-- Save the current list of recent projects
		require
			recent_projects_exists: recent_projects /= Void
			recent_projects_compare_objects: recent_projects.object_comparison
		local
			lop: ARRAYED_LIST [FILE_NAME]
			l_project_file_name: FILE_NAME
			i: INTEGER
		do
				-- We save the environment variable only once and when the system
				-- has been compiled, otherwise we do not change anything.
			if Eiffel_project.system /= Void and then Eiffel_project.system.name /= Void then
					-- Build the name of the entry in the recent projects list.
				create l_project_file_name.make_from_string (eiffel_ace.lace.file_name)

				update_recent_projects_from_datastore
				load_recent_projects (preferences.recent_projects_data.last_opened_projects)

					-- Update the list of opened projects.
				if recent_projects.has (l_project_file_name) then
					recent_projects.prune_all (l_project_file_name)
				end
				recent_projects.put_front (l_project_file_name)
				on_update

					-- Rebuild the preferences entry and save it.
				from
					create lop.make (0)
					recent_projects.start
				until
					recent_projects.after or else i >= number_of_recent_projects
				loop
					lop.extend (recent_projects.item)
					recent_projects.forth
					i := i + 1
				end
				preferences.recent_projects_data.last_opened_projects_preference.set_value (lop)
				saving_done := True
			end
		end

	update_recent_projects_from_datastore is
			-- Get from the datastore the recent projects.
		local
			l_value: STRING
		do
			l_value := preferences.preferences.get_preference_value_direct ("LIST_" + preferences.recent_projects_data.last_opened_projects_string)
			if l_value /= Void then
				preferences.recent_projects_data.last_opened_projects_preference.set_value_from_string (l_value)
			end
		end

	load_recent_projects (projects: ARRAY [STRING]) is
			--
		local
			i: INTEGER
			l_project_name: FILE_NAME
		do
			if not projects.is_empty then
				from
					i := projects.lower
				until
					i > projects.upper
				loop
					create l_project_name.make_from_string (projects @ i)
					if not recent_projects.has (l_project_name) then
						recent_projects.extend (create {FILE_NAME}.make_from_string (l_project_name))
					end
					i := i + 1
				end
			end
		end

	saving_done: BOOLEAN
			--| Has the environment variable "BENCH_RECENT_FILES" been updated?
			-- Has the ebench environment been saved?

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

	number_of_recent_projects: INTEGER is
			-- Number of recent projects the user wants to keep.
		do
			Result := preferences.recent_projects_data.keep_n_projects
			if Result <= 0 then
				Result := 10
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

end -- class EB_RECENT_PROJECTS_MANAGER
