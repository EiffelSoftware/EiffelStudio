indexing

	description: 
		"Graphical text representing text in output_window.";
	date: "$Date$";
	revision: "$Revision $"

class DEFAULT_TEXT_IMAGE

inherit

	TEXT_FIGURE
		rename
			g_Default_text_fg_color as foreground_color,
			g_Default_text_font as font
		end;

end -- class DEFAULT_TEXT_IMAGE
