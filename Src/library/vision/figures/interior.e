indexing

	description: "Description of the interior of a figure"
	legal: "See notice at end of class.";
	status: "See notice at end of class.";
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

create

	make

feature -- Initialization 

	make is
			-- Create an interior.
		do
			logical_function_mode := GXcopy;
			create foreground_color.make;	
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




end -- class INTERIOR

