
class CMD_ED_POPUP_CONTEXT 
 
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
			Result := Focus_labels.popup_context_label
		end;

	symbol: PIXMAP is
		do
			Result := Pixmaps.popup_context_pixmap;
		end;
			
feature {NONE}

	execute (arg: ANY) is
		local
			list: LINKED_LIST [CONTEXT];
			edit_list: CMD_ED_CHOICE_WND
		do
			if command_editor.current_command /= Void then
				list := command_editor.current_command.contexts_with_instances;
				!! edit_list.make (command_editor);	
				edit_list.popup_with_list (list)
			end
		end;

end
