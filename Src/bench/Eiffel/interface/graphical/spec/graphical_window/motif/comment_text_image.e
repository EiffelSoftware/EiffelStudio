indexing

	description: 
		"Graphical text representing comment text.";
	date: "$Date$";
	revision: "$Revision $"

class COMMENT_TEXT_IMAGE

inherit

	TEXT_FIGURE
		rename
			g_Comment_fg_color as foreground_color,
			g_Comment_font as font
		end

end -- class COMMENT_TEXT_IMAGE
