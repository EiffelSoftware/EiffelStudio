indexing

	description: "EiffelCase's painter.";
	date: "$Date$";
	revision: "$Revision $"

class PATCH_PAINTER 

inherit

	ONCES

	CONSTANTS

feature -- Initialization

	initialize_root_painter is
			-- Make a root painter.
		do
			--set_drawing (windows.screen)
			set_logical_mode (10)
			set_subwindow_mode (1)
			set_line_width (2)
			-- For drawing labels
		--	drawing_i.set_drawing_font (Resources.link_label_font)
		end

feature -- Properties

	drawing_i: EV_DRAWABLE
			-- Implementation of the drawing set

	is_drawable: BOOLEAN is
			-- Is Current painter drawable?
		require
			has_drawing_associated: drawing_i /= void
		do
			Result := drawing_i.is_drawable
		end;
	
feature -- Setting

	set_drawing (a_drawing: EV_DRAWABLE) is
			-- Set the drawing one which all routines are directed.
		do
			drawing_i := a_drawing
		ensure
			--(a_drawing /= void) implies (drawing_i = a_drawing.implementation)
		end; -- set_drawing

	set_foreground_color (a_color: EV_COLOR) is
			-- Set foreground color.
		require
			color_exists: a_color /= void
		do
			drawing_i.set_foreground_color (a_color)
		end;

	set_background_color (a_color: EV_COLOR) is
			-- Set background color.
		require
			color_exists: a_color /= void
		do
			drawing_i.set_background_color (a_color)
		end;

	set_line_width (new_width: INTEGER) is
			-- Set the width (in pixel) of lines.
		require
			new_width >= 0
 			drawing_set: not (drawing_i = Void)
		do
			drawing_i.set_line_width (new_width)
		end; -- set_line_width

	set_line_style (new_style: INTEGER) is
			-- Set the style (dashed, solid, ...) of lines.
		require
			new_style >= 0;
			new_style <= 2;
			drawing_set: not (drawing_i = Void)
		do
			--set_line_style (new_style)
		end; -- set_line_style

	set_logical_mode (a_mode: INTEGER) is
			-- Set drawing logical function to `a_mode'.
		require
			a_mode >= 0;
			a_mode <= 15;
			drawing_set: not (drawing_i = Void)
		do
			drawing_i.set_logical_mode (a_mode)
		end -- set_logical_mode

	set_subwindow_mode (a_mode: INTEGER) is
			-- Set subwindow mode to `a_mode'.
		require
			a_mode >= 0;
			a_mode <= 1;
			drawing_set: not (drawing_i = Void)
		do
		--	drawing_i.set_subwindow_mode (a_mode)
		end -- set_subwindow_mode

feature -- Output

	draw_text (x, y: INTEGER; text: STRING) is
			-- Draw a point at (`x', `y').
		require
			drawing_set: not (drawing_i = Void)
		do
			drawing_i.draw_text(coord_xy (x, y), text)
		end; -- draw_point

	draw_point (x, y: INTEGER) is
			-- Draw a point at (`x', `y').
		require
			drawing_set: not (drawing_i = Void)
		do
			drawing_i.draw_point (coord_xy (x, y))
		end; -- draw_point

	draw_segment (x1, y1, x2, y2: INTEGER) is
			-- Draw a segment between (`x1', `y1') and (`x2', `y2').
		require
			drawing_set: not (drawing_i = Void)
		do
			-- pascalf
			-- This is to avoid the bad traces that occured 
			-- when a window were on the top of the current
			-- workarea. Bad patch !! but this comes from
			-- the drawing_area which has something which 
			-- does not work fine...
			set_logical_mode (10);
			set_subwindow_mode (1);
			set_line_width (2)
			--

			drawing_i.draw_segment (coord_xy (x1, y1), coord_xy (x2, y2))
		end; -- draw_segment

	draw_rectangle (x, y, w, h: INTEGER) is
			-- Draw a rectangle from (`x', `y') of size `width' x `height'.
		require
			drawing_set: not (drawing_i = Void);
			w_positive: w >= 0;
			h_positive: h >= 0
		do
			drawing_i.draw_rectangle (coord_xy (x+(w // 2), y+(h // 2)), w, h, 0)
		end; -- draw_rectangle

	draw_arc (x, y, radius1, radius2: INTEGER; angle1, angle2, orientation: REAL) is
			-- Draw an arc.
		require
			drawing_set: not (drawing_i = Void);
			radius1 >= 0;
			radius2 >= 0;
			angle1 >= 0;
			angle2 >= 0;
			angle1+angle2 <= 23040;
			orientation >= 0;
			orientation < 360
		do
			drawing_i.draw_arc (coord_xy (x, y), radius1, radius2, angle1, angle2, orientation, -1)
		end; -- draw_arc

	draw_rectangle_from_to (x00, y00, x01, y01: INTEGER) is
			-- Draw a rectangle from (x00, y00) to (x01, y01).
		local
			up_left_x, up_left_y, width, height: INTEGER
		do
			if x01 > x00 then
				up_left_x := x00;
				width := x01-x00
			else
				up_left_x := x01;
				width := x00-x01
			end;
			if y01 > y00 then
				up_left_y := y00;
				height := y01-y00
			else
				up_left_y := y01;
				height := y00-y01
			end;
			if width = 0 then
				width := 1
			end;
			if height = 0 then
				height := 1
			end;
			draw_rectangle (up_left_x, up_left_y, width, height)
		end;

feature {NONE} -- Implementation

	coord_xy (x, y: INTEGER): EC_COORD_XY is
			-- Coordinates based on `x' and `y'
		do
			!!Result;
			Result.set (x, y)
		ensure
			x_set: Result.x = x;
			y_set: Result.y = y
		end

end -- class PATCH_PAINTER
