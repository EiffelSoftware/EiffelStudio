indexing

	description: 
		"Graphical text representing comment text.";
	date: "$Date$";
	revision: "$Revision $"

class COMMENT_TEXT_IMAGE

inherit

	TEXT_FIGURE

feature -- Access

	font (values: GRAPHICAL_VALUES): FONT is
			-- Font to be used for text
		do
			Result := values.comment_font
		end;
			
	foreground_color (values: GRAPHICAL_VALUES): COLOR is
			-- Foreground color
		do
			Result := values.comment_color
		end;

end -- class COMMENT_TEXT_IMAGE
