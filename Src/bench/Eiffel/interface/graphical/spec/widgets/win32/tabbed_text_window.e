indexing
	description:
		"Text windows where tabulation characters are expanded %
			%to `tablength' blank characters. Widget that is able %
			%to edit text.";
	date: "$Date$";
	revision: "$Revision$"

class
	TABBED_TEXT_WINDOW

inherit
	TABBED_TEXT
		rename
			lower as lower_window,
			make as text_create,
			set_text as st_set_text,
			cursor as widget_cursor,
			set_cursor_position as st_set_cursor_position,
			set_top_character_position as st_set_top_character_position
		undefine
			is_equal, set_background_color, set_font
		redefine
			implementation
		end;

	SCROLLED_TEXT_WINDOW
		undefine
			make_word_wrapped, text_create,
			create_ev_widget_ww, create_ev_widget,
			copy, set_tab_length
		redefine
			implementation
		end

creation
	make,
	make_from_tool

feature -- Access

	implementation: TABBED_TEXT_I

end -- class TABBED_TEXT_WINDOW
