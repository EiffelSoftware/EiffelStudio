indexing
	description	: "Facilities to manage a recent project"
	date		: "$Date$"
	revision	: "$Revision$"
	author		: "Arnaud PICHERY [ aranud@mail.dotcom.fr ]"

class
	EB_RECENT_PROJECTS_MANAGER

inherit
	EB_RECENT_PROJECTS

	PROJECT_CONTEXT

	SHARED_EIFFEL_PROJECT

	SHARED_RESOURCES

creation
	make

feature {NONE} -- Initialization

	make is
			-- Create a project manager.
		local
			projects: ARRAY [STRING]
			i: INTEGER
		do
				-- Set up the recent project list from registry
			create recent_projects.make (10)
			recent_projects.compare_objects
			projects := last_opened_projects
			if not projects.is_empty then
				from
					i := projects.lower
				until
					i > projects.upper
				loop
--! FIXME EA: 
--	"$not_a_project_path$" is the project path in the default recent project xml file.
--	It is used on unix to create ".es5_recent_project" if it does not exist.
--	We should not have to use a default xml file with a fake project path but at the time
--	these lines are written, it is the easier way without modifying the preference library
					if not projects.item (i).is_equal ("$not_a_project_path$") then
						recent_projects.extend (create {FILE_NAME}.make_from_string (projects @ i))
					end
					i := i + 1
				end
			end
		end
	
feature -- Access

	recent_projects: ARRAYED_LIST [FILE_NAME]
			-- Save the list of recent opened projects during the execution
			-- Purpose: make it easier to save the data at the end.

feature -- Menus handling

	new_menu: EB_RECENT_PROJECTS_MANAGER_MENU is
			-- Menu corresponding to current: This is a menu with
			-- on entry per old project.
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
			project_file_name: FILE_NAME
			i: INTEGER
		do
				-- We save the environment variable only once and when the system
				-- has been compiled, otherwise we do not change anything.
			if not saving_done
				and then Eiffel_project.system /= Void
				and then Eiffel_project.system.name /= Void
			then
					-- Build the name of the entry in the recent projects list.
				create project_file_name.make_from_string (project_directory_name)
				project_file_name.set_file_name (eiffel_project.system.name)
				project_file_name.add_extension (project_extension)

					-- Update the list of opened projects.	
				if recent_projects.has (project_file_name) then
					recent_projects.prune_all (project_file_name)
				end
				recent_projects.put_front (project_file_name)
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
				save_last_opened_projects (lop)
				saving_done := True
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
			Result := integer_resource_value ("recent_projects_number", 10)
			if Result <= 0 then
				Result := 10
			end
		end
	
end -- class EB_RECENT_PROJECTS_MANAGER
