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
			set_font
		end

create
	default_create,
	make_with_size

feature -- Access
	
	current_font_used: EDITOR_FONT
			-- Current font used to draw text.

feature -- Element change
	
	set_font(a_font: EDITOR_FONT) is
			-- Change the current font
		do
			if (a_font /= current_font_used) then
				current_font_used := a_font
				Precursor(a_font)
			end
		end

end -- class EDITOR_BUFFERED_SCREEN
