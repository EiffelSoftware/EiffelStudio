class USER_DEF_CMDS

inherit

	COMMAND_PAGE

creation

	make

feature {NONE}

	make (i: INTEGER; cmd_catalog: COMMAND_CATALOG) is
		do
			old_make (cmd_catalog)
		end;

	reset_commands is
		do
		end;

	symbol: PIXMAP is
		do
			Result := Pixmaps.user_defined_pixmap
		end;

	selected_symbol: PIXMAP is
		do
			Result := Pixmaps.selected_user_defined_pixmap
		end

	set_focus_string is
		do
			button.set_focus_string (Focus_labels.user_label)
		end

end
