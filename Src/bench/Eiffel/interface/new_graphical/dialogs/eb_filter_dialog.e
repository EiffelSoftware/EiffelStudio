indexing
	description: "Dialog for entering filter names."
	date: "$Date$"
	revision: "$Revision$"

class
	EB_FILTER_DIALOG

inherit
	EV_COMMAND
		undefine
			default_create
		end
	EV_DIALOG
	EB_GENERAL_DATA
		undefine
			default_create
		end
	NEW_EB_CONSTANTS
		undefine
			default_create
		end
	EIFFEL_ENV	
		undefine
			default_create
		end

creation

	make
	
feature -- Initialization

	make (cmd: like filter_command) is
			-- Create a filter window.
		local
			display_button, execute_button, cancel_button: EV_BUTTON
			filter_label, shell_label: EV_LABEL
		do
			default_create
			set_title (Interface_names.t_Filter_w)

			filter_command := cmd

			create filter_label.make_with_text ("Select a filter")
			extend (filter_label)
			filter_label.align_text_left

			create list
			extend (list)

			if filter_command /= Void then
				create shell_label.make_with_text ("Command to be executed")
				extend (shell_label)
				shell_label.align_text_left
				create text_field
				extend (text_field)
				create display_button.make_with_text (Interface_names.b_Display)
				extend (display_button)
				display_button.select_actions.extend (~display)
			end
			create execute_button.make_with_text (Interface_names.b_Execute)
			extend (execute_button)
			execute_button.select_actions.extend (~execute)

			create cancel_button.make_with_text (Interface_names.b_Cancel)			
			extend (cancel_button)
--			set_composite_attributes (Current)
		end

feature -- Execution Implementation

	filter_name: STRING is
			-- Filter name 
		once
			if filter_command /= Void then
				Result := clone (filter_command.filter_name)
			else
				Result := ""
			end
		end
	
	call (cmd: like filter_command) is
		local
			str_element: EV_LIST_ITEM
		do
			filter_command := cmd
			fill_list
			if filter_command = Void then
				create str_element.make_with_text (filter_name)
				list.extend (str_element)
				str_element.enable_select
			else
				create str_element.make_with_text (filter_command.filter_name)
				list.extend (str_element)
				text_field.set_text (general_filter_command)
				str_element.enable_select
			end
			show_modal
		end
	
feature {NONE} -- Properties

	filter_command: EB_FILTER_CMD

	list: EV_LIST

	text_field: EV_TEXT_FIELD

	warning_message: STRING

feature {NONE} -- Implementation

	execute is
		local
			tmp_name: STRING
		do
			if filter_command = Void then
				filter_name.wipe_out
				filter_name.append (list.selected_item.text)
			else
				tmp_name := filter_command.filter_name
				tmp_name.wipe_out
				if list.selected_item /= Void then
					tmp_name.append (list.selected_item.text)
				end
				tmp_name := general_filter_command
				tmp_name.wipe_out
				tmp_name.append (text_field.text)
			end
			filter_command.execute_filter_callback
		end

	display is
		local
			tmp_name: STRING
		do
			tmp_name := filter_command.filter_name
			tmp_name.wipe_out
			if list.selected_item /= Void then
				tmp_name.append (list.selected_item.text)
			end
			tmp_name := general_filter_command
			tmp_name.wipe_out
			tmp_name.append (text_field.text)
			filter_command.display_filter
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
			create filter_dir.make (filter_path)
			if not filter_dir.exists then
				warning_message := Warning_messages.w_Directory_not_exist (filter_path)
				list.wipe_out
				create str_element
				list.extend (str_element)
			elseif not filter_dir.is_readable then
				warning_message := Warning_messages.w_Cannot_read_directory (filter_path)
				list.wipe_out
				create str_element
				list.extend (str_element)
			else
				create filter_names.make
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
					create str_element
					list.extend (str_element)
				else
					from
						filter_names.start
					until
						filter_names.after
					loop
						create str_element.make_with_text (filter_names.item)
						list.extend (str_element)
						filter_names.forth
					end
				end
			end
		end

invariant
--	list_exists: list /= Void
--	text_field_exists: text_field /= Void

end -- class EB_FILTER_DIALOG
