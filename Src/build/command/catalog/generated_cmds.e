indexing
	description: "Page containing automatically generated %
				% commands."
	date: "$Date$"
	id: "$Id$"
	revision: "$Revision$"

class
	GENERATED_CMDS

inherit
	COMMAND_PAGE

creation
	make

feature {NONE}

	fill_page is
		do
		end

	symbol: EV_PIXMAP is
		do
			Result := Pixmaps.generated_pixmap
		end

-- 	selected_symbol: PIXMAP is
-- 		do
-- 			Result := Pixmaps.selected_generated_pixmap
-- 		end
-- 
-- 	set_focus_string is
-- 		do
-- 			button.set_focus_string (Focus_labels.generated_commands_label)
-- 		end
 
end -- class GENERATED_CMDS

