indexing
	description	: "Object that represent the buffered screen of an editor window"
	author		: "Arnaud PICHERY [ aranud@mail.dotcom.fr ]"
	date		: "$Date$"
	revision	: "$Revision$"

class
	EDITOR_BUFFERED_SCREEN

inherit
	EV_PIXMAP
		redefine
			set_font,
			set_foreground_color
		end

create
	default_create,
	make_with_size

feature -- Access
	
	current_font_used: EDITOR_FONT
			-- Current font used to draw text.

	current_foreground_color_used: EV_COLOR
			-- Current foreground color.

feature -- Element change
	
	set_font (a_font: EDITOR_FONT) is
			-- Change the current font
		do
			if (a_font /= current_font_used) then
				current_font_used := a_font
				Precursor(a_font)
			end
		end
	
	set_foreground_color (a_color: EV_COLOR) is
			-- Change the current foreground color
		do
			if (a_color /= current_foreground_color_used) then
				current_foreground_color_used := a_color
				Precursor (a_color)
			end
		end

end -- class EDITOR_BUFFERED_SCREEN
