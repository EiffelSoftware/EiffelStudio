
class FILE_CMDS  

inherit

	COMMAND_PAGE

creation

	make

feature {NONE}

	make is
		do
			old_make (command_catalog)
			-- added by samik
			set_focus_string (Focus_labels.file_label)
			-- end of samik
--samik associated_catalog := command_catalog;
			associated_catalog := command_catalog;
			reset_commands
		end;

	reset_commands is
		do
			extend (save_cmd);
			extend (open_cmd);
		end;

	symbol: PIXMAP is
		do
			Result := Pixmaps.file_pixmap
		end;

	selected_symbol: PIXMAP is
		do
			Result := Pixmaps.selected_file_pixmap
		end;

-- samik	focus_string: STRING is
-- samik		do
-- samik			Result := Focus_labels.file_label
-- samik		end;

end 
