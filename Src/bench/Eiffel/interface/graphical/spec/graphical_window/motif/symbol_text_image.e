indexing

	description: 
		"Graphical text representing text of symbols.";
	date: "$Date$";
	revision: "$Revision $"

class SYMBOL_TEXT_IMAGE

inherit

	TEXT_FIGURE
		redefine
			stone
		end

feature -- Access

	stone: FEATURE_STONE
			-- If symbol is an operator text then it has a stone

	font (values: GRAPHICAL_VALUES): FONT is
			-- Font to be used for text
		do
			Result := values.symbol_font
		end;
			
	foreground_color (values: GRAPHICAL_VALUES): COLOR is
			-- Foreground color
		do
			Result := values.symbol_color
		end;

end -- class SYMBOL_TEXT_IMAGE
