class USER_DEF_CMDS

inherit

	COMMAND_PAGE

creation

	make

feature {NONE}

	make (i: INTEGER) is
		do
			old_make (command_catalog)
--samik			associated_catalog := command_catalog;
--			focus_string := clone (Focus_labels.user_label);
--			focus_string.append_integer (i);
		end;

	reset_commands is
		do
		end;

-- samik	focus_string: STRING;	

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
