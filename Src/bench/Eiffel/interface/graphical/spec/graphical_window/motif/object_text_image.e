indexing

	description: 
		"Graphical text representing object text.";
	date: "$Date$";
	revision: "$Revision $"

class OBJECT_TEXT_IMAGE

inherit

	TEXT_FIGURE
		redefine
			stone
		end

feature -- Access

	stone: OBJECT_STONE
			-- Associated stone

	font (values: GRAPHICAL_VALUES): FONT is
			-- Font to be used for text
		do
			Result := values.object_font
		end;
			
	foreground_color (values: GRAPHICAL_VALUES): COLOR is
			-- Foreground color
		do
			Result := values.object_color
		end;

end -- class OBJECT_TEXT_IMAGE
