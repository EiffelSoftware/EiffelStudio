-- Window to enter filter names

class FILTER_W 

inherit

	COMMAND_W;
	NAMER;
	FORM_D
		rename
			make as form_dialog_create
		end;
	SET_WINDOW_ATTRIBUTES

creation

	make
	
feature 

	make (a_composite: COMPOSITE; cmd: FILTER_COMMAND) is
			-- Create a filter window.
		local
			button_form: FORM;
			display_button, execute_button, cancel_button: PUSH_B;
			filter_label, shell_label: LABEL
		do
			form_dialog_create (l_Filter_w, a_composite);
			set_title (l_Filter_w);

			!!filter_label.make (new_name, Current);
			filter_label.set_text ("Select a filter");
			filter_label.set_left_alignment;
			attach_top (filter_label, 10);
			attach_left (filter_label, 10);
			attach_right (filter_label, 10);

			!!list.make (new_name, Current);
			list.set_single_selection;
			list.set_visible_item_count (5);
			list.add_single_action (Current, list);
			attach_left (list, 10);
			attach_top_widget (filter_label, list, 0);
			attach_right (list, 10);
			
			!!shell_label.make (new_name, Current);
			shell_label.set_text ("Command to be executed");
			shell_label.set_left_alignment;
			attach_right (shell_label, 10);
			attach_left (shell_label, 10);
			attach_bottom_widget (shell_label, list, 10);
			
			!!text_field.make (new_name, Current);
			attach_right (text_field, 10);
			attach_left (text_field, 10);
			attach_bottom_widget (text_field, shell_label, 0);

			!!button_form.make (new_name, Current);
			button_form.set_fraction_base (3);
			attach_left (button_form, 10);
			attach_bottom (button_form, 10);
			attach_right (button_form, 10);
			attach_bottom_widget (button_form, text_field, 10);

			!!display_button.make (" Display ", button_form);
			!!execute_button.make (" Execute ", button_form);
			!!cancel_button.make (" Cancel ", button_form);
			button_form.attach_left (display_button, 0);
			button_form.attach_top (display_button, 0);
			button_form.attach_bottom (display_button, 0);
			button_form.attach_right_position (display_button, 1);
			button_form.attach_left_position (execute_button, 1);
			button_form.attach_top (execute_button, 0);
			button_form.attach_bottom (execute_button, 0);
			button_form.attach_right_position (execute_button, 2);
			button_form.attach_left_position (cancel_button, 2);
			button_form.attach_right (cancel_button, 0);
			button_form.attach_top (cancel_button, 0);
			button_form.attach_bottom (cancel_button, 0);

			display_button.add_activate_action (Current, display_it);
			execute_button.add_activate_action (Current, execute_it);
			cancel_button.add_activate_action (Current, cancel_it);
			associated_command := cmd;
			set_composite_attributes (Current)
		end;

	
feature {NONE}

	display_it: ANY is once !!Result end;
	execute_it: ANY is once !!Result end;
	cancel_it: ANY is once !!Result end;
			-- Arguments for the command

feature 
	
	call is
		local
			index: INTEGER
		do
			warning_message := Void;
			fill_list;
			index := list.index_of (associated_command.filter_name, 1);
			if index = 0 then index := 1 end;
			list.go_i_th (index);
			list.select_item;
			list.scroll_to_current;
			text_field.set_text (associated_command.shell_command_name);
			popup;
			raise;
			if warning_message /= Void then
				warner (associated_command.text_window). gotcha_call (warning_message)
			end
		end;

feature {NONE}

	associated_command: FILTER_COMMAND;

	work (argument: ANY) is
		local
			tmp_name: STRING
        do
			if last_warner /= Void then
				last_warner.popdown
			end;
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
				tmp_name := associated_command.filter_name;
				tmp_name.wipe_out;
				if list.selected_item /= Void then
					tmp_name.append (list.selected_item)
				end;
				tmp_name := associated_command.shell_command_name;
				tmp_name.wipe_out;
				tmp_name.append (text_field.text);
				if argument = display_it then
					associated_command.execute (Current)
				elseif argument = execute_it then
					associated_command.execute (associated_command);
					popdown
				end
			end
		end;

	fill_list is
			-- Read available filter names from the filter directory
			-- and fill the scroll_list.
		local
			filter_dir: DIRECTORY;
			file_name, file_suffix: STRING;
			name_count: INTEGER;
			filter_names: SORTED_TWO_WAY_LIST [STRING]
		do
			!!filter_dir.make (filter_path);
			if not filter_dir.exists then
				warning_message := w_Directory_not_exist (filter_path);
				list.wipe_out;
				list.put_right ("")
			elseif not filter_dir.is_readable then
				warning_message := w_Cannot_read_directory (filter_path);
				list.wipe_out;
				list.put_right ("")
			else
				!!filter_names.make;
				filter_dir.open_read;
				from
					filter_dir.start;
					filter_dir.readentry;
					file_name := filter_dir.lastentry
				until
					file_name = Void
				loop
					name_count := file_name.count;
					if name_count > 4 then 
						file_suffix := 
							file_name.substring (name_count - 3, name_count);
						file_suffix.to_lower;
						if file_suffix.is_equal (".fil") then
							file_name.head (name_count - 4);
							filter_names.extend (file_name)
						end
					end;
					filter_dir.readentry;
					file_name := filter_dir.lastentry
				end;
				filter_dir.close;
				list.wipe_out;
				if filter_names.empty then
					list.put_right ("")
				else
					from
						filter_names.start
					until
						filter_names.after
					loop
						list.put_right (filter_names.item);
						list.forth;
						filter_names.forth
					end
				end
			end
		end;

	list: SCROLL_LIST;
	text_field: TEXT_FIELD;
	warning_message: STRING;

invariant

	list_exists: list /= Void;
	text_field_exists: text_field /= Void

end -- class FILTER_W
