
class WINDOW_CMDS 

inherit

	COMMAND_PAGE

creation

	make

	
feature {NONE}

	popup_command: POPUP_CMD;

	popdown_command: POPDOWN_CMD;

	symbol: PIXMAP is
		do
			Result := Pixmaps.windows_pixmap
		end;

	selected_symbol: PIXMAP is
		do
			Result := Pixmaps.selected_windows_pixmap
		end;

	focus_string: STRING is
		do
			Result := Focus_labels.window_label
		end;

	make is 
		do
			associated_catalog := command_catalog;
			!!popup_command.make;
			!!popdown_command.make;
			reset_commands
		end;

	reset_commands is
		do
			extend (popup_command);
			extend (popdown_command);
		end;

end -- class WINDOW_CMDS
