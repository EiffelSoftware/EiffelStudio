indexing
	description: "Dialog for entering filter names."
	date: "$Date$"
	revision: "$Revision$"

class
	EB_FILTER_DIALOG

inherit
	EV_COMMAND
	EV_DIALOG
	EB_GENERAL_DATA
	NEW_EB_CONSTANTS
--	WINDOW_ATTRIBUTES
	EIFFEL_ENV	

creation

	make_with_command
	
feature -- Initialization

	make_with_command (cmd: EB_TOOL_COMMAND) is
			-- Create a filter window.
		local
			display_button, execute_button, cancel_button: EV_BUTTON
			filter_label, shell_label: EV_LABEL
		do
			make (cmd.tool.parent_window)
			set_title (Interface_names.t_Filter_w)

			associated_command := cmd

			create filter_label.make_with_text (display_area, "Select a filter")
			filter_label.set_left_alignment

			create list.make (display_area)
--			list.compare_objects
--			list.set_visible_item_count (9)
			list.add_selection_command (Current, list_it)

			filter_command ?= cmd
			if filter_command /= Void then
				create shell_label.make_with_text (display_area, "Command to be executed")
				shell_label.set_left_alignment
				create text_field.make (display_area)
				create display_button.make_with_text (action_area, Interface_names.b_Display)
				display_button.add_click_command (Current, display_it)
			end
			create execute_button.make_with_text (action_area, Interface_names.b_Execute)
			execute_button.add_click_command (Current, execute_it)

			create cancel_button.make_with_text (action_area, Interface_names.b_Cancel)			
			cancel_button.add_click_command (Current, cancel_it)
--			set_composite_attributes (Current)
		end

feature -- Execution Implementation

	filter_name: STRING is
			-- Filter name 
		once
			Result := clone (General_resources.filter_name.value)
		end
	
	call (cmd: like associated_command) is
		local
			index: INTEGER
			str_element: EV_LIST_ITEM
			wd: EV_WARNING_DIALOG
		do
			associated_command := cmd
			warning_message := Void
			fill_list
			if filter_command = Void then
				create str_element.make_with_text (list, filter_name)
				index := str_element.index
			else
				create str_element.make_with_text (list, filter_command.filter_name)
				index := str_element.index
				text_field.set_text (General_resources.filter_command.value)
			end
			if index = 0 then index := 1 end
			list.select_item (index)
			last_selected_item := list.get_item (index)
			show
			if warning_message /= Void then
				create wd.make_default (associated_command.tool.parent,
					Interface_names.t_Warning, warning_message)
			end
		end
	
	selected_filter: STRING is
			-- Selected filter item
		do
			Result := last_selected_item.text
		end

feature {NONE} -- Properties

	display_it: EV_ARGUMENT1 [ANY] is
			-- Argument for the command.
		once
			create Result.make (Void)
		end

	execute_it: EV_ARGUMENT1 [ANY] is
			-- Argument for the command.
		once
			create Result.make (Void)
		end

	cancel_it: EV_ARGUMENT1 [ANY] is
			-- Argument for the command.
		once
			create Result.make (Void)
		end

	list_it: EV_ARGUMENT1 [ANY] is
			-- Argument for the command.
		once
			create Result.make (Void)
		end

	filter_command: EB_FILTER_CMD

	associated_command: EB_TOOL_COMMAND

	list: EV_LIST

	last_selected_item: EV_LIST_ITEM

	text_field: EV_TEXT_FIELD

	warning_message: STRING

feature {NONE} -- Implementation

	execute (argument: EV_ARGUMENT1 [ANY]; data: EV_EVENT_DATA) is
		local
			tmp_name: STRING
		do
			if argument = list_it then
				if list.selected_item = Void then
						-- The user tried to deselect the current filter
						-- name by clicking twice on it. No way!!
					last_selected_item.set_selected (True)
				else
					last_selected_item := list.selected_item
				end
			elseif argument = cancel_it then
				popdown
			elseif argument = display_it or argument = execute_it then
				if filter_command = Void then
					filter_name.wipe_out
					filter_name.append (list.selected_item.text)
				else
					tmp_name := filter_command.filter_name
					tmp_name.wipe_out
					if list.selected_item /= Void then
						tmp_name.append (list.selected_item.text)
					end
					tmp_name := General_resources.filter_command.value
					tmp_name.wipe_out
					tmp_name.append (text_field.text)
				end
				if argument = display_it then
					filter_command.execute (filter_command.filter_it, data)
				elseif argument = execute_it then
					associated_command.execute (execute_it, data)
					popdown
				end
			end
		end

	fill_list is
			-- Read available filter names from the filter directory
			-- and fill the scroll_list.
		local
			filter_dir: DIRECTORY
			file_name, file_suffix: STRING
			name_count: INTEGER
			filter_names: SORTED_TWO_WAY_LIST [STRING]
			str_element: EV_LIST_ITEM
		do
			!!filter_dir.make (filter_path)
			if not filter_dir.exists then
				warning_message := Warning_messages.w_Directory_not_exist (filter_path)
				list.clear_items
				create str_element.make (list)
			elseif not filter_dir.is_readable then
				warning_message := Warning_messages.w_Cannot_read_directory (filter_path)
				list.clear_items
				create str_element.make (list)
			else
				!! filter_names.make
				filter_dir.open_read
				from
					filter_dir.start
					filter_dir.readentry
					file_name := filter_dir.lastentry
				until
					file_name = Void
				loop
					name_count := file_name.count
					if name_count > 4 then 
						file_suffix := file_name.substring (name_count - 3, name_count)
						file_suffix.to_lower
						if file_suffix.is_equal (".fil") then
							file_name.head (name_count - 4)
							filter_names.extend (file_name)
						end
					end
					filter_dir.readentry
					file_name := filter_dir.lastentry
				end
				filter_dir.close
				list.clear_items
				if filter_names.empty then
					create str_element.make (list)
				else
					from
						filter_names.start
					until
						filter_names.after
					loop
						create str_element.make_with_text (list, filter_names.item)
						filter_names.forth
					end
				end
			end
		end

	popdown is
		-- destroy the dialog without calling a "selection changed" event
		do
			list.remove_selection_commands
			destroy
		end

invariant
--	list_exists: list /= Void
--	text_field_exists: text_field /= Void

end -- class EB_FILTER_DIALOG
