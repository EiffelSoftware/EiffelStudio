
class PIXMAP_FILE_BOX 

inherit

	FILE_SEL_D
		rename
			init_toolkit as unused,
			make as file_sel_d_create
		end;
	COMMAND
		export
			{NONE} all
		end;
	COMMAND_ARGS
		export
			{NONE} all
		end


creation

	make

	
feature {NONE}

	text_field: EB_TEXT_FIELD;

	command: COMMAND;

	editor: CONTEXT_EDITOR;

	
feature 

	make (tf: EB_TEXT_FIELD; a_parent: COMPOSITE; cmd: COMMAND; ed: CONTEXT_EDITOR) is
		do
			text_field := tf;
			command := cmd;
			editor := ed;
			file_sel_d_create ("Pixmap File Selection", a_parent.top);
			hide_help_button;
			add_ok_action (Current, First);
			add_cancel_action (Current, Second);
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
