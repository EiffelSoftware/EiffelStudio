indexing

	description: 
		"Cursor position in a scrolled text widget.";
	date: "$Date$";
	revision: "$Revision $"

class GRAPHICAL_WINDOW_CURSOR

inherit

	CURSOR

create
	make

feature {NONE} -- Initialization

	make (x0, y0: INTEGER) is
			-- Create a text_window cursor position
			-- with positions `c_pos' and `top_c'.
		do
			x := x0;
			y := y0;
		end;

feature -- Access

	x, y: INTEGER
			-- Current coordinate position

end -- class SCROLLED_WINDOW_CURSOR
