
class CMD_ED_GENERATE 
 
inherit
	WINDOWS
		select
			init_toolkit
		end
	EB_BUTTON
	COMMAND

creation
	make

feature {NONE}

	command_editor: CMD_EDITOR;

	make (ed: CMD_EDITOR; a_parent: COMPOSITE) is
		do
			command_editor := ed;
			make_visible (a_parent);
			-- added by samik
			set_focus_string (Focus_labels.generate_code_label)
			-- end of samik
			add_activate_action (Current, Void)
		end;

-- samik	focus_label: FOCUS_LABEL is
-- samik		do
-- samik			Result := command_editor.focus_label
-- samik		end;

-- samik	focus_string: STRING is
-- samik		do
-- samik			Result := Focus_labels.generate_code_label
-- samik		end;

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
