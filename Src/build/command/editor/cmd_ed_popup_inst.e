
class CMD_ED_POPUP_INST 
 
inherit
	WINDOWS
	EB_BUTTON;
	COMMAND

creation
	make

feature {NONE}

	command_editor: CMD_EDITOR;

	make (ed: CMD_EDITOR; a_parent: COMPOSITE) is
		do
			command_editor := ed;
			make_visible (a_parent);
			add_activate_action (Current, Void)
		end;

	focus_label: FOCUS_LABEL is
		do
			Result := command_editor.focus_label
		end;

	focus_string: STRING is
		do
			Result := Focus_labels.popup_instance_label
		end;

	symbol: PIXMAP is
		do
			Result := Pixmaps.popup_instances_pixmap;
		end;

feature {NONE}

	edit_list: CMD_ED_CHOICE_WND

	execute (arg: ANY) is
		local
			list: LINKED_LIST [CMD_INSTANCE];
		do
			if command_editor.current_command /= Void then
				list := command_editor.current_command.instances;
				!! edit_list.make (command_editor);
				edit_list.popup_with_list (list)
			end
		end;

feature

    update_popup_position is
        do
            if edit_list /= Void and then not edit_list.destroyed then
                edit_list.update_position (real_x, real_y);
				edit_list.raise;
            end
        end;
			
end
