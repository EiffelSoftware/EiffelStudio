
-- PAINTER: Set of routines for drawing.

indexing

	date: "$Date$";
	revision: "$Revision$"

class PAINTER 

inherit

	G_ANY
		export
			{NONE} all
		end;

	W_MAN_GEN
		export
			{NONE} all
		end

feature 

	set_font (a_font: FONT) is
			-- Set the font used to draw texts.
		require
			drawing_set: valid_drawing;
			a_font_exists: not (a_font = Void)
		do
			drawing_i.set_drawing_font (a_font)
		end;

	draw_text (x, y: INTEGER; a_text: STRING) is
			-- Draw `a_text' at `x', `y'.
		require
			a_text_exists: not (a_text = Void)
		do
			drawing_i.draw_text (coord_xy (x, y), a_text)
		end;

    fill_polygon (points: LIST [COORD_XY]) is
            -- Fill a polygon.
        require
            points_exists: not (points = Void);
            list_with_two_points_at_least: points.count >= 3
		do
			drawing_i.fill_polygon (points)
		end;

feature {NONE}

	coord_xy (x, y: INTEGER): COORD_XY is
			-- Set of coordinates
		do
			!! Result;
			Result.set (x, y)
		ensure
			Result.x = x;
			Result.y = y
		end;

	is_drawable: BOOLEAN is
			-- Can we draw on the window ?
		require
			drawing_set: valid_drawing;
		do
			Result := drawing_i.is_drawable
		end;

feature 

	valid_drawing: BOOLEAN is
		do
			Result := drawing_i /= Void;
		end;

	set_foreground (color: COLOR) is
			-- Set the color to use for the foreground.
		require
			drawing_set: valid_drawing;
            color_exists: not (color = Void)
		do
			drawing_i.set_foreground_gc_color (color)
		end;

	draw_point (x, y: INTEGER) is
			-- Draw a point at (`x', `y').
		require
			drawing_set: valid_drawing;
		do
			drawing_i.draw_point (coord_xy (x, y))
		end;

	draw_rectangle (x, y, width, height: INTEGER; orientation: REAL) is
			-- Draw a rectangle whose center is at (`x', `y'),
			-- whose size is (`width', `height').
		require
			drawing_set: valid_drawing;
			width_positive: width >= 0;
            height_positive: height >= 0;
            orientation_positive: orientation >= 0;
            orientation_less_than_360: orientation < 360
		do
			drawing_i.draw_rectangle (coord_xy (x, y), width, height, orientation)
		end;

	fill_rectangle (x, y, width, height: INTEGER; orientation: REAL) is
            -- Fill a rectangle whose center is at (`x', `y'),
            -- whose size is (`width', `height').
        require
            drawing_set: valid_drawing;
            width_positive: width >= 0;
            height_positive: height >= 0;
            orientation_positive: orientation >= 0;
            orientation_less_than_360: orientation < 360
        do
            drawing_i.fill_rectangle (coord_xy (x, y), width, height, orientation)
        end;

	draw_segment (x1, y1, x2, y2: INTEGER) is
			-- Draw a segment between (`x1', `y1') and (`x2', `y2').
		require
			drawing_set: valid_drawing;
		do
			drawing_i.draw_segment (coord_xy (x1, y1), coord_xy (x2, y2))
		end;

feature {NONE}

	drawing_i: DRAWING_I;
			-- Implementation of the drawing set

feature 

	set_drawing (a_drawing: DRAWING) is
			-- Set the drawing one which all routines are directed.
		do
			if (a_drawing = Void) then
				drawing_i := Void
			else
				drawing_i := a_drawing.implementation
			end
		ensure
			(not (a_drawing = Void)) implies (drawing_i = a_drawing.implementation)
		end;

	set_logical_mode (a_mode: INTEGER) is
			-- Set drawing logical function to `a_mode'.
		require
			a_mode >= 0;
			a_mode <= 15;
			drawing_set: valid_drawing;
		do
			drawing_i.set_logical_mode (a_mode)
		end;

feature {NONE}

	set_subwindow_mode (a_mode: INTEGER) is
			-- Set subwindow mode to `a_mode'.
		require
			a_mode >= 0;
			a_mode <= 1;
			drawing_set: valid_drawing;
		do
			drawing_i.set_subwindow_mode (a_mode)
		end

end


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
