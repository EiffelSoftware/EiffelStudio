--|---------------------------------------------------------------
--| Copyright (C) Interactive Software Engineering, Inc.        --
--|  270 Storke Road, Suite 7 Goleta, California 93117          --
--|                      (805) 685-1006                         --
--| All rights reserved. Duplication or distribution prohibited --
--|---------------------------------------------------------------

-- PATH: Description of a path.

class PATH 

inherit

	LOGICAL;

	CHILD_CLIP;

	DASHABLE;

	FILLABLE;

	FOREGROUND;

	BACKGROUND;

	LINE_WIDTH

creation

	make

feature 

	make is
			-- Create a path
		do
			!! dash_pattern.make;
			dash_pattern.add_right (4);
			dash_pattern.add_right (4);
			logical_function_mode := GXcopy;
			!! foreground_color.make
		end;

feature {FIGURE}

	set_drawing_attributes (drawing: DRAWING_I) is
			-- Set the attributes to `a_drawing'.
		require
			drawing_exists: not (drawing = Void)
		do
			drawing.set_logical_mode (logical_function_mode);
			drawing.set_subwindow_mode (subwindow_mode);
			drawing.set_line_width (line_width);
			drawing.set_line_style (line_style);
			drawing.set_fill_style (fill_style);
			if fill_style = FillTiled then
				drawing.set_tile (tile)
			else
				drawing.set_foreground_gc_color (foreground_color)
			end;
			if line_style /= LineSolid then
				drawing.set_dash_pattern (dash_pattern)
			end;
			if fill_style = FillOpaqueStippled then
				drawing.set_background_gc_color (background_color)
				elseif fill_style /= FillTiled then
				if line_style = LineDoubleDash then
					drawing.set_background_gc_color (background_color)
				end
			end;
			if (fill_style = FillOpaqueStippled) or (fill_style = FillStippled) then
				drawing.set_stipple (stipple)
			end
		end;

invariant

	(fill_style /= FillTiled) implies (not (foreground_color = Void));
	(fill_style = FillOpaqueStippled) implies (not (background_color = Void));
	((line_style = LineDoubleDash) and (fill_style /= FillTiled)) implies (not (background_color = Void));
	(line_style /= LineSolid) implies (not (dash_pattern = Void));
	(fill_style = FillTiled) implies (not (tile = Void));
	((fill_style = FillStippled) or (fill_style = FillOpaqueStippled)) implies (not (stipple = Void))

end
