indexing

	description: "Description of a path";
	status: "See notice at end of class";
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

creation

	make

feature -- Initialization 

	make is
			-- Create a path
		do
			!! dash_pattern.make;
			dash_pattern.put_right (4);
			dash_pattern.put_right (4);
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

end -- class PATH



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

