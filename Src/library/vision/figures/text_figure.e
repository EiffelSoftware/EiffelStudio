--|---------------------------------------------------------------
--|   Copyright (C) Interactive Software Engineering, Inc.      --
--|    270 Storke Road, Suite 7 Goleta, California 93117        --
--|                   (805) 685-1006                            --
--| All rights reserved. Duplication or distribution prohibited --
--|---------------------------------------------------------------

indexing

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

feature 

	make is
			-- Create a text.
		do
			!! text.make (1);
			!! font.make;
			font.set_name ("fixed");
			interior_make;
			!! top_left
		end;

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

end
