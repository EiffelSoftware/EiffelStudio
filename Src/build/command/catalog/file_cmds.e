
class FILE_CMDS  

inherit

	COMMAND_PAGE

creation

	make

feature {NONE}

	open_command: OPEN_CMD;

	save_command: SAVE_CMD;

	make is
		do
			associated_catalog := command_catalog;
			!!save_command.make;
			!!open_command.make;
			reset_commands
		end;

	reset_commands is
		do
			extend (save_command);
			extend (open_command);
		end;

	symbol: PIXMAP is
		do
			Result := Pixmaps.file_pixmap
		end;

	selected_symbol: PIXMAP is
		do
			Result := Pixmaps.selected_file_pixmap
		end;

	focus_string: STRING is
		do
			Result := Focus_labels.file_label
		end;

end 
