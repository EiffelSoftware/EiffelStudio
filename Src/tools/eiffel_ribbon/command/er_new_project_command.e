note
	description: "Summary description for {ER_NEW_PROJECT_COMMAND}."
	date: "$Date$"
	revision: "$Revision$"

class
	ER_NEW_PROJECT_COMMAND

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
			-- <Precursor>
		local
			l_folder: EV_DIRECTORY_DIALOG
			l_misc: ER_MISC_CONSTANTS
		do
			if attached main_window as l_win then
				create l_folder
				l_folder.show_modal_to_window (l_win)

				if attached shared_singleton.project_info_cell.item as l_item then
					if not l_folder.directory.is_empty then
						l_item.set_project_location (l_folder.directory)

						if attached shared_singleton.tool_info_cell.item as l_tool_info then
							create l_misc
							if attached l_misc.project_full_file_name as l_config_file then
								l_tool_info.recent_projects.extend (l_config_file)
							end

						else
							check should_not_happen: False end
						end

						l_win.save_project_command.enable
						l_win.gen_code_command.enable

						disable
						l_win.new_project_command.disable
						l_win.recent_project_command.disable
					else
						-- User didn't select any folder
					end
				else
					check False end
				end
			end
		end

	set_main_window (a_main_window: MAIN_WINDOW)
			--
		do
			main_window := a_main_window
		end

feature -- Query

feature {NONE} -- Implementation

	main_window: detachable MAIN_WINDOW
			--

	shared_singleton: ER_SHARED_SINGLETON
			--

end
