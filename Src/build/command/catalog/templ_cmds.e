
class TEMPL_CMDS 

inherit

	COMMAND_PAGE

creation

	make

feature {NONE}

	--exit_command: EXIT_CMD;

feature {NONE}

	make is
		do
			old_make (command_catalog)
			-- added by samik
			set_focus_string (Focus_labels.templates_label)
			-- end of samik
--samik			associated_catalog := command_catalog;
			associated_catalog := command_catalog;
			reset_commands
		end;

	reset_commands is
		do
			extend (command_cmd);
			extend (undoable_cmd);
		end;

	symbol: PIXMAP is
		do
			Result := Pixmaps.command_page_pixmap
		end;

	selected_symbol: PIXMAP is
		do
			Result := Pixmaps.selected_command_page_pixmap
		end;

-- samik	focus_string: STRING is
-- samik		do
-- samik			Result := Focus_labels.templates_label
-- samik		end;

end -- class TEMPL_CMDS
