indexing

	description: 
		"Description of the interior of a figure.";
	date: "$Date$";
	revision: "$Revision $"

class EC_INTERIOR

inherit

	EC_FILLABLE

	EC_LOGICAL

	EC_FOREGROUND

	EC_BACKGROUND

creation

	make

feature -- Initialization

	make is
			-- Create an interior.
		do
			logical_function_mode := GXcopy
			!! foreground_color.make
		end

feature {EC_FIGURE} -- Implementation

	set_drawing_attributes (drawing: EV_DRAWABLE) is
			-- Set the attributes to `a_drawing'.
		require
			drawing_exists: not (drawing = Void)
		do
			drawing.set_logical_mode (logical_function_mode)
			--drawing.set_fill_style (fill_style)
			inspect
				fill_style
			when FillSolid then
				drawing.set_foreground_color (foreground_color)
			when FillTiled then
				--drawing.set_tile (tile)
			when FillStippled then
				drawing.set_foreground_color (foreground_color)
			--	drawing.set_stipple (stipple)
			when FillOpaqueStippled then
				drawing.set_foreground_color (foreground_color)
				drawing.set_background_color (background_color)
			--	drawing.set_stipple (stipple)
			end
		end

invariant

--	(fill_style = FillTiled) implies (not (tile = Void));
	--((fill_style = FillStippled) or (fill_style = FillOpaqueStippled)) implies
	--						(not (stipple = Void));
--	(fill_style /= FillTiled) implies (not (foreground_color = Void));
--	(fill_style = FillOpaqueStippled) implies (not (background_color = Void))


end -- class EC_INTERIOR
