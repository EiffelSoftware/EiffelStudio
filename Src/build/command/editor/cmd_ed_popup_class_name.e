indexing
	description: "";
	date: "$Date$";
	revision: "$Revision$"

class
	CMD_ED_POPUP_CLASS_NAME

inherit
	WINDOWS
		select
			init_toolkit
		end
	EB_BUTTON
	COMMAND;
	ERROR_POPUPER

creation
	make

feature {NONE}

	command_editor: COMMAND_TOOL;

	make (ed: COMMAND_TOOL; a_parent: COMPOSITE) is
		do
			command_editor := ed;
			make_visible (a_parent);
			add_activate_action (Current, Void)
		end;

	create_focus_label is
		do
			set_focus_string (Focus_labels.popup_filename_label)
		end;

	symbol: PIXMAP is
		do
			Result := Pixmaps.popup_filename_pixmap;
		end;
			
feature {NONE}

	Cancel, Ok: ANY is
		once
			!! Result
		end;

	execute (arg: ANY) is
		local
			cmd: USER_CMD;
			x1, y1: INTEGER;
			mp: MOUSE_PTR
		do
			if arg = Void then
				create_popup;
				x1 := command_editor.real_x + command_editor.width //2
						- fname_popup.width //2;
				y1 := command_editor.real_y;
				fname_popup.set_x_y (x1, y1);
				fname_popup.popup
			elseif arg = Cancel then
				fname_popup.popdown
			elseif arg = Ok then
				fname_popup.popdown
				if not fname_popup.selection_text.empty then
					cmd := command_catalog.command_with_class_name (fname_popup.selection_text);	
					if cmd = Void then
						Error_box.popup (Current, Messages.cannot_find_command_file_er, 
									fname_popup.selection_text)
					else
						!! mp;
						mp.set_watch_shape;
						if cmd.edited then
							cmd.command_editor.clear
						end;
--						command_editor.set_command (cmd)
						mp.restore;
					end
				end;
			end;
		end;

	fname_popup: PROMPT_D;

	create_popup is
		local
			delete_window: DELETE_WINDOW;
			set_wind_att: SET_DIALOG_ATTRIBUTES_COM
		do
			if fname_popup = Void then
            	!!fname_popup.make (Widget_names.file_popup_for_command, command_editor);
            	fname_popup.set_title(Widget_names.file_popup_for_command);
            	fname_popup.set_selection_label (Widget_names.enter_command_class_name_label);
--				if command_editor.edited_command /= Void then
--					fname_popup.set_selection_text (command_editor.edited_command.eiffel_type_to_upper)
--				end;
            	fname_popup.hide_apply_button;
            	fname_popup.hide_help_button;
            	fname_popup.add_ok_action (Current, Ok);
            	fname_popup.add_cancel_action (Current, Cancel);
            	fname_popup.set_default_position (False);
            	fname_popup.set_ok_label (Widget_names.ok_button_name);
            	fname_popup.set_cancel_label (Widget_names.cancel_button_name);
				!! set_wind_att;
				set_wind_att.execute (fname_popup);
            	fname_popup.realize;
			end
		end;

	popuper_parent: COMPOSITE is
		do
			Result := command_editor
		end;

end -- class CMD_ED_POPUP_CLASS_NAME
