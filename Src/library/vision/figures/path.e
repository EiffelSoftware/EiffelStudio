indexing

	description: "Description of a path"
	legal: "See notice at end of class.";
	status: "See notice at end of class.";
	date: "$Date$";
	revision: "$Revision$"

class

	PATH 

inherit

	LOGICAL;

	CHILD_CLIP;

	DASHABLE;

	FILLABLE;

	FOREGROUND;

	BACKGROUND;

	LINE_WIDTH;

create

	make

feature -- Initialization 

	make is
			-- Create a path
		do
			create dash_pattern.make;
			dash_pattern.put_right (4);
			dash_pattern.put_right (4);
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

	foreground_when_not_tiled:
		 (fill_style /= FillTiled) implies foreground_color /= Void;
	background_when_Opaque_Stippled:
		(fill_style = FillOpaqueStippled) implies background_color /= Void;
	backgropund_on_double_dash:	
		((line_style = LineDoubleDash) and (fill_style /= FillTiled)) implies 
			background_color /= Void;
	dash_pattern_on_non_solid: 
		(line_style /= LineSolid) implies dash_pattern /= Void;
	tile_on_tiled: (fill_style = FillTiled) implies tile /= Void;
	stipple_on_stippled: 
		((fill_style = FillStippled) or (fill_style = FillOpaqueStippled)) 
			implies stipple /= Void

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




end -- class PATH

