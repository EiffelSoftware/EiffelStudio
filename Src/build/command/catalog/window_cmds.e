
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

	set_focus_string is
		do
			button.set_focus_string (Focus_labels.window_label)
		end

	make is 
		do
			old_make (command_catalog)
--samik			associated_catalog := command_catalog;
			reset_commands
		end;

	reset_commands is
		do
			extend (popup_cmd);
			extend (popdown_cmd);
		end;


end -- class WINDOW_CMDS
