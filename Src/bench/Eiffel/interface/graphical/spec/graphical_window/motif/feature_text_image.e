indexing

	description: 
		"Graphical text representing feature text.";
	date: "$Date$";
	revision: "$Revision $"

class FEATURE_TEXT_IMAGE

inherit

	TEXT_FIGURE
		redefine
			stone
		end

feature -- Access

	stone: FEATURE_STONE
			-- Associated stone

	font (values: GRAPHICAL_VALUES): FONT is
			-- Font to be used for text
		do
			Result := values.feature_font
		end;
			
	foreground_color (values: GRAPHICAL_VALUES): COLOR is
			-- Foreground color
		do
			Result := values.feature_color
		end;

end -- class FEATURE_TEXT_IMAGE
