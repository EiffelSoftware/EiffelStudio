indexing

	description: 
		"Graphical text representing error text.";
	date: "$Date$";
	revision: "$Revision $"

class ERROR_TEXT_IMAGE

inherit

	TEXT_FIGURE
		rename
			g_Error_fg_color as foreground_color,
			g_Error_font as font			
		redefine
			stone
		end

feature -- Access

	stone: ERROR_STONE
			-- Associated stone

end -- class ERROR_TEXT_IMAGE
