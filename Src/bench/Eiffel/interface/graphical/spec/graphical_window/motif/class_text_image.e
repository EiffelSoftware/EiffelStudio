indexing

	description: 
		"Graphical text representing normal formatted text.";
	date: "$Date$";
	revision: "$Revision $"

class CLASS_TEXT_IMAGE

inherit

	TEXT_FIGURE
		rename
			g_Class_font as font,
			g_Class_fg_color as foreground_color			
		redefine
			stone
		end

feature -- Access

	stone: STONE
			-- Associated stone

end -- class CLASS_TEXT_IMAGE
