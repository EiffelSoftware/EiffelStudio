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

	fill_page is
		do
 			extend (command_cmd)
 			extend (undoable_cmd)
		end

	symbol: EV_PIXMAP is
		do
			Result := Pixmaps.command_page_pixmap
		end

-- 	selected_symbol: PIXMAP is
-- 		do
-- 			Result := Pixmaps.selected_command_page_pixmap
-- 		end

-- 	set_focus_string is
-- 		do
-- 			button.set_focus_string (Focus_labels.templates_label)
-- 		end

end -- class TEMPL_CMDS

