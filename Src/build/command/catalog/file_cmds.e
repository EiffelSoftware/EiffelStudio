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

	fill_page is
		do
 			extend (new_cmd)
 			extend (open_cmd)
 			extend (save_cmd)
		end

	symbol: EV_PIXMAP is
		do
			Result := Pixmaps.file_pixmap
		end

-- 	selected_symbol: PIXMAP is
-- 		do
-- 			Result := Pixmaps.selected_file_pixmap
-- 		end

-- 	set_focus_string is
-- 		do
-- 			button.set_focus_string (Focus_labels.file_label)
-- 		end

end -- class FILE_CMDS

