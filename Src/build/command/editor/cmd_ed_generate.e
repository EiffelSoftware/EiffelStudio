
class CMD_ED_GENERATE 
 
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
			Result := Focus_labels.generate_code_label
		end;

	symbol: PIXMAP is
		do
			Result := Pixmaps.generate_pixmap;
		end;
			
feature {NONE}

	execute (arg: ANY) is
		do
			if command_editor.edited_command /= Void then
				command_editor.edited_command.update_text
			end
		end;

end
