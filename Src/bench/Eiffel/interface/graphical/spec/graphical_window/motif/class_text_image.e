indexing

	description: 
		"Graphical text representing normal formatted text.";
	date: "$Date$";
	revision: "$Revision $"

class CLASS_TEXT_IMAGE

inherit

	TEXT_FIGURE
		redefine
			stone
		end

feature -- Access

	stone: STONE
			-- Associated stone

	font (values: GRAPHICAL_VALUES): FONT is
			-- Font to be used for text
		do
			Result := values.class_font
		end;

	foreground_color (values: GRAPHICAL_VALUES): COLOR is
			-- Foreground color
		do
			Result := values.class_color
		end;

end -- class CLASS_TEXT_IMAGE
