indexing
	description: "Command page representing file commands."
	Id: "$Id$"
	Date: "$Date$"
	Revision: "$Revision$"

class FILE_CMDS  

inherit

	COMMAND_PAGE

creation

	make

feature {NONE}

	make (cmd_catalog: COMMAND_CATALOG) is
		do
			old_make (cmd_catalog)
			reset_commands
		end

	reset_commands is
		do
			extend (new_cmd)
			extend (open_cmd)
			extend (save_cmd)
		end

	symbol: PIXMAP is
		do
			Result := Pixmaps.file_pixmap
		end

	selected_symbol: PIXMAP is
		do
			Result := Pixmaps.selected_file_pixmap
		end

	set_focus_string is
		do
			button.set_focus_string (Focus_labels.file_label)
		end

end 
