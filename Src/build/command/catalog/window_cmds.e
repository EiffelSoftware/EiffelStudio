indexing
	description: "Command page representing window commands."
	Id: "$Id$"
	Date: "$Date$"
	Revision: "$Revision$"

class WINDOW_CMDS 

inherit

	COMMAND_PAGE

creation

	make

	
feature {NONE}

	symbol: PIXMAP is
		do
			Result := Pixmaps.windows_pixmap
		end

	selected_symbol: PIXMAP is
		do
			Result := Pixmaps.selected_windows_pixmap
		end

	set_focus_string is
		do
			button.set_focus_string (Focus_labels.window_label)
		end

	make (cmd_catalog: COMMAND_CATALOG) is 
		do
			old_make (cmd_catalog)
			reset_commands
		end

	reset_commands is
		do
			extend (popup_cmd)
			extend (popdown_cmd)
			extend (open_window_cmd)
			extend (close_window_cmd)
			extend (minimize_window_cmd)
			extend (maximize_window_cmd)
			extend (restore_window_cmd)
		end

end -- class WINDOW_CMDS
