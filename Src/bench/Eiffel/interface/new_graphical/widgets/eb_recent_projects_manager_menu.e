indexing
	description	: "Menu representing all the recent opened projects."
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

end -- class EB_RECENT_PROJECT_MANAGER_MENU
