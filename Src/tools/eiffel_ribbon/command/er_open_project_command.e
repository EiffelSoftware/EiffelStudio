note
	description: "Summary description for {ER_OPEN_PROJECT_COMMAND}."
	date: "$Date$"
	revision: "$Revision$"

class
	ER_OPEN_PROJECT_COMMAND

inherit
	ER_NEW_PROJECT_COMMAND
			redefine
				execute
			end

create
	make

feature -- Command

	execute
			-- <Precursor>
		local
			l_file: EV_FILE_OPEN_DIALOG
		do
			if attached main_window as l_win then
				create l_file
				l_file.show_modal_to_window (l_win)

				execute_with_file_name (l_file.file_name)
			end
		end

	execute_with_file_name (a_project_file: STRING)
			--
		do
			if attached a_project_file as l_file and then not l_file.is_empty then
				open_project_file (l_file)
				if attached shared_singleton.layout_constructor_list.first as l_layout_constructor then
					l_layout_constructor.load_tree
				end

				if attached main_window as l_win then
					l_win.save_project_command.enable
					l_win.gen_code_command.enable

					disable
					l_win.new_project_command.disable
					l_win.recent_project_command.disable
				end
			end
		end

	new_menu_item: SD_TOOL_BAR_BUTTON
			--
		do
			create Result.make
			if attached shared_singleton.layout_constructor_list.first as l_layout_constructor then
				Result.set_text ("Open")
				Result.select_actions.extend (agent execute)

				tool_bar_items.extend (Result)
			end
		end

feature {NONE}	-- Implementation

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

end
