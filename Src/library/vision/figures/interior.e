indexing

	description: "Description of the interior of a figure";
	status: "See notice at end of class";
	date: "$Date$";
	revision: "$Revision$"

class

	INTERIOR 

inherit

	FILLABLE;

	LOGICAL;

	CHILD_CLIP;

	FOREGROUND;

	BACKGROUND

creation

	make

feature -- Initialization 

	make is
			-- Create an interior.
		do
			logical_function_mode := GXcopy;
			!! foreground_color.make;	
		end;

feature {FIGURE} -- Element change

	set_drawing_attributes (drawing: DRAWING_I) is
			-- Set the attributes to `a_drawing'.
		require
			drawing_exists: drawing /= Void
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

	tile_when_tiled: (fill_style = FillTiled) implies tile /= Void;
	stipple_when_stippled:
		((fill_style = FillStippled) or (fill_style = FillOpaqueStippled)) 
			implies stipple /= Void;
	foreground_color_when_not_tileD:
		(fill_style /= FillTiled) implies foreground_color /= Void;
	background_when_opaque_stipple:
		(fill_style = FillOpaqueStippled) implies background_color /= Void

end -- class INTERIOR

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
--| Customer support e-mail <support@eiffel.com>
--|----------------------------------------------------------------

