indexing

	description:	
		"Text windows where tabulation characters are expanded %
			%to `tablength' blank characters. Widget that is able %
			%to edit text.";
	date: "$Date$";
	revision: "$Revision$"

class
	GRAPHICAL_TEXT_WINDOW

inherit

	TABBED_TEXT
		rename
			lower as lower_window,
			make as text_create,
			set_text as st_set_text,
			cursor as widget_cursor,
			set_cursor_position as st_set_cursor_position
		undefine
			is_equal, set_font, set_background_color
		redefine
			implementation
		end;

	SCROLLED_TEXT_WINDOW
		undefine 
			make_word_wrapped, text_create,
			consistent, create_ev_widget_ww, create_ev_widget,
            copy, setup, set_tab_length, tab_length
		redefine
			implementation
		end

creation

	make

feature -- Access

	implementation: TABBED_TEXT_I

end -- class GRAPHICAL_TEXT_WINDOW
