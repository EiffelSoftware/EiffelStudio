
class WINDOW_CMDS 

inherit

	COMMAND_PAGE

creation

	make

	
feature {NONE}

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
			reset_commands
		end;

	reset_commands is
		do
			extend (popup_cmd);
			extend (popdown_cmd);
		end;

end -- class WINDOW_CMDS
