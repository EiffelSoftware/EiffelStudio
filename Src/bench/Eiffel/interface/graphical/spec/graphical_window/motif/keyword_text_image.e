indexing

	description: 
		"Graphical text representing keyword text.";
	date: "$Date$";
	revision: "$Revision $"

class KEYWORD_TEXT_IMAGE

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
			Result := values.keyword_font
		end;
			
	foreground_color (values: GRAPHICAL_VALUES): COLOR is
			-- Foreground color
		do
			Result := values.keyword_color
		end;

end -- class KEYWORD_TEXT_IMAGE
