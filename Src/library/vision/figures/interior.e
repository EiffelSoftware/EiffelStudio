--|---------------------------------------------------------------
--| Copyright (C) Interactive Software Engineering, Inc.        --
--|  270 Storke Road, Suite 7 Goleta, California 93117          --
--|                      (805) 685-1006                         --
--| All rights reserved. Duplication or distribution prohibited --
--|---------------------------------------------------------------

-- INTERIOR: Description of the interior of a figure.

class INTERIOR 

inherit

	FILLABLE;

	LOGICAL;

	CHILD_CLIP;

	FOREGROUND;

	BACKGROUND

creation

	make

feature 

	make is
			-- Create an interior.
		do
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
			drawing.set_fill_style (fill_style);
			inspect
				fill_style
			when FillSolid then
				drawing.set_foreground_gc_color (foreground_color)
			when FillTiled then
				drawing.set_tile (tile)
			when FillStippled then
				drawing.set_foreground_gc_color (foreground_color);
				drawing.set_stipple (stipple)
			when FillOpaqueStippled then
				drawing.set_foreground_gc_color (foreground_color);
				drawing.set_background_gc_color (background_color);
				drawing.set_stipple (stipple)
			end
		end;

invariant

	(fill_style = FillTiled) implies (not (tile = Void));
	((fill_style = FillStippled) or (fill_style = FillOpaqueStippled)) implies (not (stipple = Void));
	(fill_style /= FillTiled) implies (not (foreground_color = Void));
	(fill_style = FillOpaqueStippled) implies (not (background_color = Void))

end
