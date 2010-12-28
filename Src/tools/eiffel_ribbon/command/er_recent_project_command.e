note
	description: "Summary description for {ER_RECENT_PROJECT_COMMAND}."
	date: "$Date$"
	revision: "$Revision$"

class
	ER_RECENT_PROJECT_COMMAND

inherit
	ER_COMMAND

create
	make

feature {NONE} -- Initlization

	make (a_menu: EV_MENU_ITEM)
			-- Creation method
		do
			init
			create shared_singleton
			menu_items.extend (a_menu)
		end
feature -- Command

	execute
			--
		do
			-- Nothing to do
		end

	restore_recent_item_menu
			--
		local
			l_menu_item: EV_MENU_ITEM
			l_projects: ARRAYED_LIST [STRING]
		do
			if attached shared_singleton.tool_info_cell.item as l_tool_info then
				if attached main_window as l_win then
					l_projects := l_tool_info.recent_projects
					from
						l_projects.finish
					until
						l_projects.before or l_projects.index > 10
					loop
						create l_menu_item.make_with_text_and_action (l_projects.item, agent (l_win.open_project_command).execute_with_file_name (l_projects.item))
						l_win.recent_projects.extend (l_menu_item)
						l_projects.back
					end
				end
			end
		end

	set_main_window (a_main_window: MAIN_WINDOW)
			--
		do
			main_window := a_main_window
		end

feature {NONE}	-- Implementation

	main_window: detachable MAIN_WINDOW
			--

	shared_singleton: ER_SHARED_SINGLETON
			--

end
