indexing

	description: 
		"Graphical text representing keyword text.";
	date: "$Date$";
	revision: "$Revision $"

class KEYWORD_TEXT_IMAGE

inherit

	TEXT_FIGURE
		rename
			g_Keyword_fg_color as foreground_color,
			g_Keyword_font as font
		redefine
			stone
		end

feature -- Access

	stone: FEATURE_STONE
			-- If symbol is an operator text then it has a stone

end -- class KEYWORD_TEXT_IMAGE
