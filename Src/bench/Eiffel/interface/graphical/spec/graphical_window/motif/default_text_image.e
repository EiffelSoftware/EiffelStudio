indexing

	description: 
		"Graphical text representing text in output_window.";
	date: "$Date$";
	revision: "$Revision $"

class DEFAULT_TEXT_IMAGE

inherit

	TEXT_FIGURE

feature -- Access

	font (values: GRAPHICAL_VALUES): FONT is
			-- Font to be used for text
		do
			Result := values.default_text_font
		end;
			
	foreground_color (values: GRAPHICAL_VALUES): COLOR is
			-- Foreground color
		do
			Result := values.default_text_color
		end;

end -- class DEFAULT_TEXT_IMAGE
