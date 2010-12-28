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
					else
						-- User didn't select any folder
					end
				else
					check False end
				end
			end
		end

	open_project_file (a_eiffel_ribbon_file: STRING)
			--
		require
			not_void: a_eiffel_ribbon_file /= Void
		local
			l_file_name: FILE_NAME
			l_env: OPERATING_ENVIRONMENT
			l_dir: STRING
			l_index, l_last_index: INTEGER
		do
			if attached shared_singleton.tool_info_cell.item as l_tool_info then

				create l_env
				from
					l_index := 1 -- Make sure loop run at least once
				until
					l_index = 0
				loop
					l_index := a_eiffel_ribbon_file.index_of (l_env.directory_separator, (l_last_index + 1))
					if l_index /= 0 then
						l_last_index := l_index
					end
				end
				check l_last_index /= 0 end
				l_dir := a_eiffel_ribbon_file.substring (1, (l_last_index - 1))

				create l_file_name.make_from_string (a_eiffel_ribbon_file)
				if not l_tool_info.recent_projects.has (a_eiffel_ribbon_file) then
					l_tool_info.recent_projects.extend (a_eiffel_ribbon_file)
				end

				if attached shared_singleton.project_info_cell.item as l_project_info then
					l_project_info.set_project_location (l_dir)
				end
			end
		end

	set_main_window (a_main_window: EV_WINDOW)
			--
		do
			main_window := a_main_window
		end

feature -- Query

feature {NONE} -- Implementation

	main_window: detachable EV_WINDOW
			--

	shared_singleton: ER_SHARED_SINGLETON
			--

end
