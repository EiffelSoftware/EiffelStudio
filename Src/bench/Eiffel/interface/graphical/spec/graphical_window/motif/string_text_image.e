indexing

	description: 
		"Graphical text representing text in output_window.";
	date: "$Date$";
	revision: "$Revision $"

class STRING_TEXT_IMAGE

inherit

	TEXT_FIGURE
		rename
			g_String_text_fg_color as foreground_color,
			g_String_text_font as font
		end;

end -- class STRING_TEXT_IMAGE
