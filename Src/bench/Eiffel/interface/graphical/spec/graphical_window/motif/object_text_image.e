indexing

	description: 
		"Graphical text representing object text.";
	date: "$Date$";
	revision: "$Revision $"

class OBJECT_TEXT_IMAGE

inherit

	TEXT_FIGURE
		rename
			g_Object_fg_color as foreground_color,
			g_Object_font as font		
		redefine
			stone
		end

feature -- Access

	stone: OBJECT_STONE
			-- Associated stone

end -- class OBJECT_TEXT_IMAGE
