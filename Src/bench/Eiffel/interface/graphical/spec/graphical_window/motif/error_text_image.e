indexing

	description: 
		"Graphical text representing error text.";
	date: "$Date$";
	revision: "$Revision $"

class ERROR_TEXT_IMAGE

inherit

	TEXT_FIGURE
		redefine
			stone
		end

feature -- Access

	stone: ERROR_STONE
			-- Associated stone

	font (values: GRAPHICAL_VALUES): FONT is
			-- Font to be used for text
		do
			Result := values.error_font
		end;
			
	foreground_color (values: GRAPHICAL_VALUES): COLOR is
			-- Foreground color
		do
			Result := values.error_color
		end;

end -- class ERROR_TEXT_IMAGE
