
class PIXMAP_FILE_BOX 

inherit

	FILE_SEL_D
		rename
			make as file_sel_d_create
		end;
	COMMAND;
	COMMAND_ARGS

creation

	make

	
feature {NONE}

	text_field: EB_TEXT_FIELD;

	command: COMMAND;

	editor: CONTEXT_EDITOR;

	
feature 

	make (tf: EB_TEXT_FIELD; a_parent: COMPOSITE; cmd: COMMAND; ed: CONTEXT_EDITOR) is
		local
			set_win_att: SET_WINDOW_ATTRIBUTES_COM
		do
			text_field := tf;
			command := cmd;
			editor := ed;
			file_sel_d_create ("Pixmap File Selection", a_parent.top);
			hide_help_button;
			add_ok_action (Current, First);
			add_cancel_action (Current, Second);
			!! set_win_att;
			set_win_att.execute (Current);
			set_exclusive_grab
		end;

	
feature {NONE}

	execute (argument: ANY) is
			-- Argument = Second then popdown
		local
			cmd: like command
		do
			if argument = First then
				popdown;
				text_field.set_text (selected_file);
				cmd := clone (command);
				cmd.execute (editor)
			elseif argument = Second then
				popdown
			end
		end;

end
