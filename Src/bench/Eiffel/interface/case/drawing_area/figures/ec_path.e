indexing

	description: 
		"Description of a graphic path.";
	date: "$Date$";
	revision: "$Revision $"

class EC_PATH 

inherit

	EC_LOGICAL

	EC_CHILD_CLIP

	EC_DASHABLE

	EC_FILLABLE

	EC_FOREGROUND

	EC_BACKGROUND

	EC_LINE_WIDTH

creation

	make

feature -- Initialization

	make is
			-- Create a path
		do
			!! dash_pattern.make
			dash_pattern.extend (4)
			dash_pattern.extend (4)
			logical_function_mode := GXcopy
			!! foreground_color.make
			line_width := 1
		end -- make

feature {EC_FIGURE} -- Implementation

	set_drawing_attributes (drawing: EV_DRAWABLE) is
			-- Set the attributes to `a_drawing'.
		require
			drawing_exists: not (drawing = Void)
		do
			drawing.set_logical_mode (logical_function_mode)
			--drawing.set_subwindow_mode (subwindow_mode)
			drawing.set_line_width (line_width)
			--drawing.set_line_style (line_style)
			--drawing.set_fill_style (fill_style)
			if fill_style = FillTiled then
				--drawing.set_tile (tile)
			else
				drawing.set_foreground_color (foreground_color)
			end;
			if line_style /= LineSolid then
				--drawing.set_dash_pattern (dash_pattern)
			end;
			if fill_style = FillOpaqueStippled then
				drawing.set_background_color (background_color)
			elseif fill_style /= FillTiled then
				if line_style = LineDoubleDash then
					drawing.set_background_color	(background_color)
				end
			end;
			if (fill_style = FillOpaqueStippled) or (fill_style = FillStippled)
				then
					--drawing.set_stipple (stipple)
				end
		end

invariant

--	(fill_style /= FillTiled) implies (not (foreground_color = Void));
--	(fill_style = FillOpaqueStippled) implies (not (background_color = Void));
--	((line_style = LineDoubleDash) and (fill_style /= FillTiled)) implies
	--						(not (background_color = Void));
--	(line_style /= LineSolid) implies (not (dash_pattern = Void));
	--(fill_style = FillTiled) implies (not (tile = Void));
--	((fill_style = FillStippled) or (fill_style = FillOpaqueStippled)) implies
	--						(not (stipple = Void))

end -- class EC_PATH
