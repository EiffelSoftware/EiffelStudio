
class TEMPL_CMDS 

inherit

	COMMAND_PAGE

creation

	make

feature {NONE}

	command_command: COMMAND_CMD;

	undoable_command: UNDOABLE_CMD;

	--exit_command: EXIT_CMD;

feature {NONE}

	make is
		do
			associated_catalog := command_catalog;
			!!command_command.make;
			!!undoable_command.make;
			reset_commands
		end;

	reset_commands is
		do
			extend (command_command);
			extend (undoable_command);
		end;

	symbol: PIXMAP is
		do
			Result := Pixmaps.command_page_pixmap
		end;

	selected_symbol: PIXMAP is
		do
			Result := Pixmaps.selected_command_page_pixmap
		end;

	focus_string: STRING is
		do
			Result := Focus_labels.templates_label
		end;

end -- class TEMPL_CMDS
