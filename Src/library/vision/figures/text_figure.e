
indexing

	status: "See notice at end of class";
	date: "$Date$";
	revision: "$Revision$"

class TEXT_FIGURE 

inherit

	TEXT_GEN;

	INTERIOR
		rename
			make as interior_make
		end

creation

	make

feature -- Initialization 

	make is
			-- Create a text.
		do
			init_fig (Void);
			!! text.make (1);
			!! font.make;
			!! top_left;
			ascent := 1;
			descent := 1;
			string_width := 1;
			font.set_name ("fixed");
			interior_make  ;
		end;

feature -- Output

	draw is
			-- Draw the current text.
		require else
			a_drawing_attached: not (drawing = Void)
		do
			if drawing.is_drawable then
				set_drawing_attributes (drawing);
				drawing.set_drawing_font (font);
				drawing.draw_text (base_left,text) 
			end
		end;

end -- class TEXT_FIGURE


--|----------------------------------------------------------------
--| EiffelVision: library of reusable components for ISE Eiffel 3.
--| Copyright (C) 1989, 1991, 1993, 1994, Interactive Software
--|   Engineering Inc.
--| All rights reserved. Duplication and distribution prohibited.
--|
--| 270 Storke Road, Suite 7, Goleta, CA 93117 USA
--| Telephone 805-685-1006
--| Fax 805-685-6869
--| Electronic mail <info@eiffel.com>
--| Customer support e-mail <eiffel@eiffel.com>
--|----------------------------------------------------------------
