indexing
	description: "Dialog for entering filter names."
	date: "$Date$"
	revision: "$Revision$"

class
	EB_FILTER_DIALOG

inherit
	EV_COMMAND
	EV_DIALOG
	WINDOW_ATTRIBUTES
	EIFFEL_ENV	

creation

	make
	
feature -- Initialization

	make (cmd: TOOL_COMMAND) is
			-- Create a filter window.
		local
			button_form: FORM
			display_button, execute_button, cancel_button: PUSH_B
			filter_label, shell_label: LABEL
		do
			form_dialog_create (Interface_names.n_X_resource_name, cmd.popup_parent)
			set_title (Interface_names.t_Filter_w)

			create filter_label.make_with_text (display_area, new_name)
			filter_label.set_text ("Select a filter")
			filter_label.set_left_alignment

			create list.make_with_text (display_area, new_name)
			list.compare_objects
			list.set_visible_item_count (9)
			list.add_click_command (Current, list)

			filter_command ?= cmd
			if filter_command /= Void then
				create shell_label.make_with_text (Current, "Command to be executed")
				shell_label.set_left_alignment
				create text_field.make (new_name, Current)
				create display_button.make (action_area, Interface_names.b_Display)
				display_button.add_activate_action (Current, display_it)
			end
			create execute_button.make (action_area, Interface_names.b_Execute)
			execute_button.add_activate_command (Current, execute_it)

			create cancel_button.make (action_area, Interface_names.b_Cancel)			
			cancel_button.add_activate_command (Current, cancel_it)
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
			str_element: SCROLLABLE_LIST_STRING_ELEMENT
		do
			associated_command := cmd
			warning_message := Void
			fill_list
			if filter_command = Void then
				!! str_element.make (0)
				str_element.append (filter_name)
				index := list.index_of (str_element, 1)
			else
				!! str_element.make (0)
				str_element.append (filter_command.filter_name)
				index := list.index_of (str_element, 1)
				text_field.set_text (General_resources.filter_command.value)
			end
			if index = 0 then index := 1 end
			list.go_i_th (index)
			list.select_item
			list.scroll_to_current
			display
			if warning_message /= Void then
				warner (associated_command.popup_parent). gotcha_call (warning_message)
			end
		end
	
	selected_filter: STRING is
			-- Selected filter item
		do
			if not list.off then
				Result := list.selected_item.value
			end
		end

feature {NONE} -- Properties

	display_it: ANY is
			-- Argument for the command.
		once
			!!Result
		end

	execute_it: ANY is
			-- Argument for the command.
		once
			!!Result
		end

	cancel_it: ANY is
			-- Argument for the command.
		once
			!!Result
		end

	filter_command: FILTER_COMMAND

	associated_command: TOOL_COMMAND

	list: SCROLLABLE_LIST

	text_field: TEXT_FIELD

	warning_message: STRING

feature {NONE} -- Implementation

	work (argument: ANY) is
		local
			tmp_name: STRING
		do
			if last_warner /= Void then
				last_warner.popdown
			end
			if argument = list then
				if list.selected_item = Void then
						-- The user tried to deselect the current filter
						-- name by clicking twice on it. No way!!
					list.select_item
				else
					list.go_i_th (list.selected_position)
				end
			elseif argument = cancel_it then
				popdown
			elseif argument = display_it or argument = execute_it then
				if filter_command = Void then
					filter_name.wipe_out
					filter_name.append (list.selected_item.value)
				else
					tmp_name := filter_command.filter_name
					tmp_name.wipe_out
					if list.selected_item /= Void then
						tmp_name.append (list.selected_item.value)
					end
					tmp_name := General_resources.filter_command.value
					tmp_name.wipe_out
					tmp_name.append (text_field.text)
				end
				if argument = display_it then
					filter_command.execute (Current)
				elseif argument = execute_it then
					associated_command.execute (associated_command)
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
			str_element: SCROLLABLE_LIST_STRING_ELEMENT
		do
			!!filter_dir.make (filter_path)
			if not filter_dir.exists then
				warning_message := Warning_messages.w_Directory_not_exist (filter_path)
				list.wipe_out
				!! str_element.make (0)
				str_element.append ("")
				list.put_right (str_element)
			elseif not filter_dir.is_readable then
				warning_message := Warning_messages.w_Cannot_read_directory (filter_path)
				list.wipe_out
				!! str_element.make (0)
				str_element.append ("")
				list.put_right (str_element)
			else
				!!filter_names.make
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
				list.wipe_out
				if filter_names.empty then
					!! str_element.make (0)
					str_element.append ("")
					list.put_right (str_element)
				else
					from
						filter_names.start
					until
						filter_names.after
					loop
						!! str_element.make (0)
						str_element.append (filter_names.item)
						list.extend (str_element)
						list.forth
						filter_names.forth
					end
				end
			end
		end

invariant
	list_exists: list /= Void
	text_field_exists: text_field /= Void

end -- class EB_FILTER_DIALOG
