indexing

	status: "See notice at end of class";
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

end -- class TEXT_FIGURE

--|----------------------------------------------------------------
--| EiffelVision: library of reusable components for ISE Eiffel.
--| Copyright (C) 1985-2004 Eiffel Software. All rights reserved.
--| Duplication and distribution prohibited.  May be used only with
--| ISE Eiffel, under terms of user license.
--| Contact Eiffel Software for any other use.
--|
--| Interactive Software Engineering Inc.
--| dba Eiffel Software
--| 356 Storke Road, Goleta, CA 93117 USA
--| Telephone 805-685-1006, Fax 805-685-6869
--| Contact us at: http://www.eiffel.com/general/email.html
--| Customer support: http://support.eiffel.com
--| For latest info on our award winning products, visit:
--|	http://www.eiffel.com
--|----------------------------------------------------------------

