--|---------------------------------------------------------------
--|   Copyright (C) Interactive Software Engineering, Inc.      --
--|    270 Storke Road, Suite 7 Goleta, California 93117        --
--|                   (805) 685-1006                            --
--| All rights reserved. Duplication or distribution prohibited --
--|---------------------------------------------------------------

indexing

	date: "$Date$";
	revision: "$Revision$"

class TEXT_IMAGE

inherit

	TEXT_GEN
		redefine
			select, deselect
		end;

	FOREGROUND;

	BACKGROUND;

	CHILD_CLIP

creation

	make

feature -- Creation

	make is
			-- Create a text.
		do
			text.make (1);
			font.make;
			font.set_name ("fixed");
			top_left;
			foreground_color.Create;
			background_color.Create
		end;

feature

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
			select_text_image
		end;

	draw is
			-- Draw the current text.
		require else
			a_drawing_attached: not (drawing = Void)
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

	not (foreground_color = Void);
	not (background_color = Void)

end

