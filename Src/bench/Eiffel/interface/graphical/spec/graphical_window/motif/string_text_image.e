indexing

	description: 
		"Graphical text representing text in output_window.";
	date: "$Date$";
	revision: "$Revision $"

class STRING_TEXT_IMAGE

inherit

	TEXT_FIGURE

feature -- Access

	font (values: GRAPHICAL_VALUES): FONT is
			-- Font to be used for text
		do
			Result := values.string_text_font
		end;
			
	foreground_color (values: GRAPHICAL_VALUES): COLOR is
			-- Foreground color
		do
			Result := values.string_text_color
		end;

end -- class STRING_TEXT_IMAGE
