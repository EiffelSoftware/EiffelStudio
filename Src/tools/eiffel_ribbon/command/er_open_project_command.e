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
				if attached shared_singleton.layout_constructor_cell.item as l_layout_constructor then
					l_layout_constructor.load_tree
				end
			end
		end

	new_menu_item: SD_TOOL_BAR_BUTTON
			--
		do
			create Result.make
			if attached shared_singleton.layout_constructor_cell.item as l_layout_constructor then
				Result.set_text ("Open")
				Result.select_actions.extend (agent execute)

				tool_bar_items.extend (Result)
			end
		end
end
