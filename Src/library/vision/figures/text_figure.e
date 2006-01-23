indexing

	status: "See notice at end of class.";
	date: "$Date$";
	revision: "$Revision$"

class

	TEXT_FIGURE 

inherit

	TEXT_GEN;

	INTERIOR
		rename
			make as interior_make
		end

create

	make

feature -- Initialization 

	make is
			-- Create a text.
		do
			init_fig (Void);
			create text.make (1);
			create font.make;
			create top_left;
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
			a_drawing_attached: drawing /= Void
		do
			if drawing.is_drawable then
				set_drawing_attributes (drawing);
				drawing.set_drawing_font (font);
				drawing.draw_text (base_left,text) 
			end
		end;

indexing
	copyright:	"Copyright (c) 1984-2006, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			 Eiffel Software
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"




end -- class TEXT_FIGURE

