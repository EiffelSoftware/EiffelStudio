indexing

	status: "See notice at end of class";
	date: "$Date$";
	revision: "$Revision$"

class

	TEXT_IMAGE

inherit

	TEXT_GEN
		redefine
			select_figure, deselect
		end;

	FOREGROUND;

	BACKGROUND;

	CHILD_CLIP

creation

	make

feature -- Initialization

	make  is
			-- Create a text.
		do
			init_fig (Void);
			!!text.make (1);
			!!font.make;
			!! top_left;
			font.set_name ("fixed");
			ascent := 1;
			descent := 1;
			string_width := 1;
			!!foreground_color.make;
			!!background_color.make;
		end;

feature -- Output

	select_figure is
			-- select the text image
		local
			temp: COLOR
		do
			temp := foreground_color;
			set_foreground_color (background_color);
			set_background_color (temp);
		end;

	deselect is
			-- deselect the text image
		do
-- FIX ME			select_text_image
		end;

	draw is
			-- Draw the current text.
		require else
			a_drawing_attached: drawing /= Void
		do
			if drawing.is_drawable then
				drawing.set_subwindow_mode (subwindow_mode);
				drawing.set_foreground_gc_color (foreground_color);
				drawing.set_background_gc_color (background_color);
				drawing.set_drawing_font (font);
				drawing.draw_image_text (base_left, text)
			end
		end

invariant

	foreground_color_exists: foreground_color /= Void;
	background_color_exists: background_color /= Void

end -- class TEXT_IMAGE


--|----------------------------------------------------------------
--| EiffelVision: library of reusable components for ISE Eiffel.
--| Copyright (C) 1986-2001 Interactive Software Engineering Inc.
--| All rights reserved. Duplication and distribution prohibited.
--| May be used only with ISE Eiffel, under terms of user license. 
--| Contact ISE for any other use.
--|
--| Interactive Software Engineering Inc.
--| ISE Building
--| 360 Storke Road, Goleta, CA 93117 USA
--| Telephone 805-685-1006, Fax 805-685-6869
--| Electronic mail <info@eiffel.com>
--| Customer support: http://support.eiffel.com>
--| For latest info see award-winning pages: http://www.eiffel.com
--|----------------------------------------------------------------

