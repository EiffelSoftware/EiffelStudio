-- Command used for the copy of
-- the background_pixmap attribute
-- using an attrib_stone from a context editor

class BG_P_STONE_CMD 

inherit

	BG_PIXMAP_CMD
		redefine 
			work
		end

feature 

	work (argument: CONTEXT) is
		do
			context := argument;
			old_bg_pixmap_name := context.bg_pixmap_name;
		end;

end
