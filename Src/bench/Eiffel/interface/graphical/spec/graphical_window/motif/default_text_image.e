indexing

	description: 
		"Graphical text representing text in output_window.";
	date: "$Date$";
	revision: "$Revision $"

class DEFAULT_TEXT_IMAGE

inherit

	TEXT_FIGURE
		rename
			g_Text_fg_color as foreground_color,
			g_Text_font as font
		end;

end -- class DEFAULT_TEXT_IMAGE
