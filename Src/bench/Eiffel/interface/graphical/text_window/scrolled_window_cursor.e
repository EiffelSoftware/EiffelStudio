indexing

	description: 
		"Cursor position in a scrolled text widget.";
	date: "$Date$";
	revision: "$Revision $"

class SCROLLED_WINDOW_CURSOR

inherit

	CURSOR

create
	make

feature {NONE} -- Initialization

	make (c_pos, top_c: INTEGER) is
			-- Create a text_window cursor position
			-- with positions `c_pos' and `top_c'.
		require
			valid_pos: c_pos >= 0 and then top_c >= 0
		do
			cursor_position := c_pos;
			top_character_position := top_c;
		end;

feature -- Access

	cursor_position: INTEGER
			-- Current cursor position in scrolled text

	top_character_position: INTEGER
			-- Character position at the top left position

end -- class SCROLLED_WINDOW_CURSOR
