indexing
	description: "EiffelVision interior: description of the interior of a figure."
	status: "See notice at end of class"
	date: "$Date$"
	revision: "$Revision$"

class
	EV_INTERIOR

inherit

--	EV_FILLABLE

--	EV_CHILD_CLIPABLE

	EV_DRAWING_ATTRIBUTES
		redefine
			set_drawing_attributes
		end

creation

	make

feature {NONE}-- Initialization 

	make is
			-- Create an interior.
		do
			logical_function_mode := GXcopy
			!! foreground_color.make	
		end

feature {EV_FIGURE} -- Element change

	set_drawing_attributes (drawing: EV_DRAWABLE) is
			-- Set the attributes to `drawing'.
		do
			{EV_DRAWING_ATTRIBUTES} Precursor (drawing)
--			drawing.set_subwindow_mode (subwindow_mode)
--			drawing.set_fill_style (fill_style)
--			inspect
--				fill_style
--			when FillSolid then
--				drawing.set_foreground_gc_color (foreground_color)
--			when FillTiled then
--				drawing.set_tile (tile)
--			when FillStippled then
--				drawing.set_foreground_gc_color (foreground_color)
--				drawing.set_stipple (stipple)
--			when FillOpaqueStippled then
--				drawing.set_foreground_color (foreground_color)
--				drawing.set_background_color (background_color)
--				drawing.set_stipple (stipple)
--			end
		end

--invariant
--	tile_when_tiled: (fill_style = FillTiled) implies tile /= Void
--	stipple_when_stippled: ((fill_style = FillStippled) or
--			(fill_style = FillOpaqueStippled)) implies stipple /= Void
--	foreground_color_when_not_tiled: fill_style /= FillTiled implies
--			foreground_color /= Void
--	background_when_opaque_stipple: fill_style = FillOpaqueStippled implies
--			background_color /= Void

end -- class EV_INTERIOR

--|----------------------------------------------------------------
--| EiffelVision: library of reusable components for ISE Eiffel.
--| Copyright (C) 1986-1998 Interactive Software Engineering Inc.
--| All rights reserved. Duplication and distribution prohibited.
--| May be used only with ISE Eiffel, under terms of user license. 
--| Contact ISE for any other use.
--|
--| Interactive Software Engineering Inc.
--| ISE Building, 2nd floor
--| 270 Storke Road, Goleta, CA 93117 USA
--| Telephone 805-685-1006, Fax 805-685-6869
--| Electronic mail <info@eiffel.com>
--| Customer support e-mail <support@eiffel.com>
--| For latest info see award-winning pages: http://www.eiffel.com
--|----------------------------------------------------------------

