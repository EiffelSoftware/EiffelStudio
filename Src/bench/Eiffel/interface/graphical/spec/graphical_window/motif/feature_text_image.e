indexing

	description: 
		"Graphical text representing feature text.";
	date: "$Date$";
	revision: "$Revision $"

class FEATURE_TEXT_IMAGE

inherit

	TEXT_FIGURE
		rename
			g_Feature_fg_color as foreground_color,
			g_Feature_font as font
		redefine
			stone
		end

feature -- Access

	stone: FEATURE_STONE
			-- Associated stone

end -- class FEATURE_TEXT_IMAGE
