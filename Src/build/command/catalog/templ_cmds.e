indexing
	description: "Command page representing template commands."
	Id: "$Id$"
	Date: "$Date$"
	Revision: "$Revision$"

class TEMPL_CMDS 

inherit

	COMMAND_PAGE

creation

	make

feature {NONE}

	--exit_command: EXIT_CMD

feature {NONE}

	make (cmd_catalog: COMMAND_CATALOG) is
		do
			old_make (cmd_catalog)
			reset_commands
		end

	reset_commands is
		do
			extend (command_cmd)
			extend (undoable_cmd)
		end

	symbol: PIXMAP is
		do
			Result := Pixmaps.command_page_pixmap
		end

	selected_symbol: PIXMAP is
		do
			Result := Pixmaps.selected_command_page_pixmap
		end

	set_focus_string is
		do
			button.set_focus_string (Focus_labels.templates_label)
		end

end -- class TEMPL_CMDS
