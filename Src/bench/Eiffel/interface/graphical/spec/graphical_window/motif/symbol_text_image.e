indexing

	description: 
		"Graphical text representing text of symbols.";
	date: "$Date$";
	revision: "$Revision $"

class SYMBOL_TEXT_IMAGE

inherit

	TEXT_FIGURE
		rename
			g_Symbol_fg_color as foreground_color,
			g_Symbol_font as font
		redefine
			stone
		end

feature -- Access

	stone: FEATURE_STONE
			-- If symbol is an operator text then it has a stone

end -- class SYMBOL_TEXT_IMAGE
