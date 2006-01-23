indexing

	status: "See notice at end of class.";
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

create

	make

feature -- Initialization

	make  is
			-- Create a text.
		do
			init_fig (Void);
			create text.make (1);
			create font.make;
			create top_left;
			font.set_name ("fixed");
			ascent := 1;
			descent := 1;
			string_width := 1;
			create foreground_color.make;
			create background_color.make;
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




end -- class TEXT_IMAGE

