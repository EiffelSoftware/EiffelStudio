indexing
	description: "Command page representing reset commands."
	Id: "$Id$" 
	Date: "$Date$"
	Revision: "$Revision$"

class
	RESET_CMDS

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
			extend (reset_to_empty_cmd)
			extend (reset_to_zero_cmd)
			extend (clear_cmd)
		end

	symbol: PIXMAP is
		do
			Result := Pixmaps.reset_pixmap
		end

	selected_symbol: PIXMAP is
		do
			Result := Pixmaps.selected_reset_pixmap
		end

	set_focus_string is
		do
			button.set_focus_string (Focus_labels.reset_label)
		end


end -- class RESET_CMDS
