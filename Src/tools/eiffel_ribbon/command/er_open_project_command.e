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
				l_file.filters.extend (["*.er", "EiffelRibbon Project Files"])
				l_file.filters.extend (["*.*", "All Files"])
				l_file.show_modal_to_window (l_win)

				execute_with_file_name (l_file.file_name)
			end
		end

	execute_with_file_name (a_project_file: STRING)
			--
		local
			l_warn: EV_WARNING_DIALOG
		do
			if attached a_project_file as l_file and then not l_file.is_empty then
				open_project_file (l_file)
				if is_open_file_successed then
					if attached shared_singleton.layout_constructor_list.first as l_layout_constructor then
						l_layout_constructor.load_tree
					end

					load_project_info
					if attached shared_singleton.project_info_cell.item as l_info then
						l_info.update_ribbon_names_to_ui
					end

					if attached main_window as l_win then
						l_win.save_project_command.enable
						l_win.gen_code_command.enable

						disable
						l_win.new_project_command.disable
						l_win.recent_project_command.disable
					end
				else
					if attached main_window as l_win then
						create l_warn.make_with_text ("Cannot open file: " + a_project_file + ". Please select a valid project configuration file.")
						l_warn.show_modal_to_window (l_win)
					end
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
					load_project_info
						-- Again, to update project location now
					l_project_info.set_project_location (l_dir)
				end
			end
		end

	load_project_info
			--
		local
			l_sed: SED_MEDIUM_READER_WRITER
			l_sed_utility: SED_STORABLE_FACILITIES
			l_file: RAW_FILE
			l_constants: ER_MISC_CONSTANTS
			l_singleton: ER_SHARED_SINGLETON
			l_retried: BOOLEAN
		do
			if not l_retried then
				create l_constants
				create l_singleton
				if attached l_singleton.project_info_cell.item as l_info then

					if attached l_constants.project_full_file_name as l_project_config then
						create l_file.make (l_project_config)
						l_file.open_read
						create l_sed.make (l_file)
						l_sed.set_for_reading

						create l_sed_utility
						if attached {ER_PROJECT_INFO} l_sed_utility.retrieved (l_sed, False) as l_data then
							l_singleton.project_info_cell.put (l_data)
						end

						l_file.close
					end
				end
				is_open_file_successed := True
			else
				is_open_file_successed := False
			end
		rescue
			l_retried := True
			retry
		end

	is_open_file_successed: BOOLEAN
			--

end
