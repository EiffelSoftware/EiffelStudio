indexing
	description:
		"Abstraction for objects onto which graphical primitives may be%N%
		%applied."
	note:
		"When line style is dashed and line width is bigger than one,%N%
		%lines are not guaranteed to be dashed on all platforms.%N%
		%All drawing operations are performed in the current%N%
		%foreground color unless otherwise stated. i.e. `clear_rectangle'%N%
		% uses the current background color."
	status: "See notice at end of class"
	keywords: "figure, primitive, drawing, line, point, ellipse" 
	date: "$Date$"
	revision: "$Revision$"

deferred class 
	EV_DRAWABLE

inherit
	EV_ANY
		redefine
			implementation,
			is_in_default_state
		end

	EV_DRAWABLE_CONSTANTS
		export
			{NONE} all
			{ANY} valid_drawing_mode
		undefine
			default_create,
			copy
		end

	EV_COLORIZABLE
		redefine
			implementation,
			is_in_default_state
		end

	EV_FONTABLE
		redefine
			implementation,
			is_in_default_state
		end

feature -- Access

	line_width: INTEGER is
			-- Line thickness. Default: 1.
		require
			not_destroyed: not is_destroyed
		do
			Result := implementation.line_width
		ensure
			bridge_ok: Result = implementation.line_width
		end

	drawing_mode: INTEGER is
			-- Logical operation on pixels when drawing.
			-- Default: drawing_mode_copy.
		require
			not_destroyed: not is_destroyed
		do
			Result := implementation.drawing_mode
		ensure
			bridge_ok: Result = implementation.drawing_mode
		end

	clip_area: EV_RECTANGLE is
			-- Rectangular area to apply clipping on.
		require
			not_destroyed: not is_destroyed
		do
			Result := implementation.clip_area
		ensure
			bridge_ok: (Result = Void) = (implementation.clip_area = Void)
		end

	tile: EV_PIXMAP is
			-- Pixmap that is used to draw filled primitives with
			-- instead of `foreground_color'.
		require
			not_destroyed: not is_destroyed
		do
			Result := implementation.tile
		ensure
			bridge_ok: (Result = Void) = (implementation.tile = Void)
		end

	dashed_line_style: BOOLEAN is
			-- Are lines drawn dashed?
		require
			not_destroyed: not is_destroyed
		do
			Result := implementation.dashed_line_style
		ensure
			bridge_ok: Result = implementation.dashed_line_style
		end

feature -- Measurement

	width: INTEGER is
			-- Horizontal size in pixels.
		require
			not_destroyed: not is_destroyed
		deferred
		end

	height: INTEGER is
			-- Vertical size in pixels.
		require
			not_destroyed: not is_destroyed
		deferred
		end

feature -- Element change

	set_line_width (a_width: INTEGER) is
			-- Assign `a_width' to `line_width'.
			-- See note at top.
		require
			not_destroyed: not is_destroyed
			a_width_positive_or_zero: a_width >= 0
		do
			implementation.set_line_width (a_width)
		ensure
			line_width_assigned: line_width = a_width
		end

	set_drawing_mode (a_mode: INTEGER) is
			-- Set drawing mode to `a_logical_mode'.
			--| See below for convenience setting functions.
		require
			not_destroyed: not is_destroyed
			a_mode_valid: valid_drawing_mode (a_mode)
		do
			implementation.set_drawing_mode (a_mode)
		ensure
			drawing_mode_assigned: drawing_mode = a_mode
		end

	set_clip_area (an_area: EV_RECTANGLE) is
			-- Set area which will be refreshed.
		require
			not_destroyed: not is_destroyed
			an_area_not_void: an_area /= Void
		do
			implementation.set_clip_area (an_area)
		ensure
			clip_area_assigned: clip_area.is_equal (an_area)
		end

	remove_clip_area is
			-- Do not apply any clipping.
		require
			not_destroyed: not is_destroyed
		do
			implementation.remove_clip_area
		ensure
			clip_area_void: clip_area = Void
		end

	set_tile (a_pixmap: EV_PIXMAP) is
			-- Set tile used to fill figures.
			-- Set to Void to use `background_color' to fill.
		require
			not_destroyed: not is_destroyed
			a_pixmap_not_void: a_pixmap /= Void
		do
			implementation.set_tile (a_pixmap)
		ensure
			tile_assigned: tile /= Void
		end

	remove_tile is
			-- Do not apply a tile when filling.
		require
			not_destroyed: not is_destroyed
		do
			implementation.remove_tile
		ensure
			tile_void: tile = Void
		end

	enable_dashed_line_style is
			-- Draw lines dashed.
			-- See note at top.
		require
			not_destroyed: not is_destroyed
		do
			implementation.enable_dashed_line_style
		ensure
			dashed_line_style_enabled: dashed_line_style
		end

	disable_dashed_line_style is
			-- Draw lines solid.
		require
			not_destroyed: not is_destroyed
		do
			implementation.disable_dashed_line_style
		ensure
			dashed_line_style_disabled: not dashed_line_style
		end

feature -- Clearing operations

	clear is
			-- Erase `Current' with `background_color'.
		require
			not_destroyed: not is_destroyed
		do
			implementation.clear
		end

	clear_rectangle (x, y, a_width, a_height: INTEGER) is
			-- Draw rectangle with upper-left corner on (`x', `y')
			-- with size `a_width' and `a_height' in `background_color'.
		require
			not_destroyed: not is_destroyed
			a_width_positive_or_zero: a_width >= 0
			a_height_positive_or_zero: a_height >= 0
		do
			implementation.clear_rectangle (x, y, a_width, a_height)
		end

feature -- Drawing operations

	draw_point (x, y: INTEGER) is
			-- Draw point at (`x', `y').
		require
			not_destroyed: not is_destroyed
		do
			implementation.draw_point (x, y)
		end

	draw_text (x, y: INTEGER; a_text: STRING) is
			-- Draw `a_text' with left of baseline at (`x', `y') using `font'.
		require
			not_destroyed: not is_destroyed
			a_text_not_void: a_text /= Void
		do
			implementation.draw_text (x, y, a_text)
		end

	draw_text_top_left (x, y: INTEGER; a_text: STRING) is
			-- Draw `a_text' with top left corner at (`x', `y') using `font'.
		require
			not_destroyed: not is_destroyed
			a_text_not_void: a_text /= Void
		do
			implementation.draw_text_top_left (x, y, a_text)
		end

	draw_segment (x1, y1, x2, y2: INTEGER) is
			-- Draw line segment from (`x1', `y1') to (`x2', `y2').
		require
			not_destroyed: not is_destroyed
		do
			implementation.draw_segment (x1, y1, x2, y2)
		end

	draw_straight_line (x1, y1, x2, y2: INTEGER) is
			-- Draw infinite straight line through (`x1', `y1') and
			-- (`x2', `y2').
		require
			not_destroyed: not is_destroyed
		do
			implementation.draw_straight_line (x1, y1, x2, y2)
		end

	draw_pixmap (x, y: INTEGER; a_pixmap: EV_PIXMAP) is
			-- Draw `a_pixmap' with upper-left corner on (`x', `y').
		require
			not_destroyed: not is_destroyed
			a_pixmap_not_void: a_pixmap /= Void
		do
			implementation.draw_pixmap (x, y, a_pixmap)
		end

	draw_sub_pixmap (x, y: INTEGER; a_pixmap: EV_PIXMAP; area: EV_RECTANGLE) is
			-- Draw `area' of `a_pixmap' with upper-left corner on (`x', `y').
		require
			not_destroyed: not is_destroyed
			a_pixmap_not_void: a_pixmap /= Void
			area_not_void: area /= Void
		do
			implementation.draw_sub_pixmap (x, y, a_pixmap, area)
		end

	draw_arc (x, y, a_bounding_width, a_bounding_height: INTEGER;
		a_start_angle, an_aperture: REAL) is
			-- Draw part of an ellipse defined by a rectangular area with an
			-- upper left corner at `x',`y', width `a_bounding_width' and height
			-- `a_bounding_height'.
			-- Start at `a_start_angle' and stop at `a_start_angle' + `an_aperture'.
			-- Angles are measured in radians, and go
			-- counterclockwise from the 3 o'clock angle.
		require
			not_destroyed: not is_destroyed
			a_bounding_width_positive_or_zero: a_bounding_width >= 0
			a_bounding_height_positive_or_zero: a_bounding_width >= 0
		do
			implementation.draw_arc (x, y, a_bounding_width,
				a_bounding_height, a_start_angle, an_aperture)
		end

	draw_rectangle (x, y, a_width, a_height: INTEGER) is
			-- Draw rectangle with upper-left corner on (`x', `y')
			-- with size `a_width' and `a_height'.
		require
			not_destroyed: not is_destroyed
			a_width_positive_or_zero: a_width >= 0
			a_height_positive_or_zero: a_height >= 0
		do
			implementation.draw_rectangle (x, y, a_width, a_height)
		end

	draw_ellipse (x, y, a_bounding_width, a_bounding_height: INTEGER) is
			-- Draw an ellipse defined by a rectangular area with an
			-- upper left corner at `x',`y', width `a_bounding_width' and height
			-- `a_bounding_height'.
		require
			not_destroyed: not is_destroyed
			a_bounding_width_positive_or_zero: a_bounding_width >= 0
			a_bounding_height_positive_or_zero: a_bounding_height >= 0
		do
			implementation.draw_ellipse (x, y, a_bounding_width,
				a_bounding_height)
		end

	draw_polyline (points: ARRAY [EV_COORDINATE]; is_closed: BOOLEAN) is
			-- Draw line segments between subsequent points in
			-- `points'. If `is_closed' draw line segment between first
			-- and last point in `points'.
		require
			not_destroyed: not is_destroyed
			points_not_void: points /= Void
		do
			implementation.draw_polyline (points, is_closed)
		end

	draw_pie_slice (x, y, a_bounding_width, a_bounding_height: INTEGER;
		a_start_angle, an_aperture: REAL) is
			-- Draw part of an ellipse defined by a rectangular area with an
			-- upper left corner at `x',`y', width `a_bounding_width' and height
			-- `a_bounding_height'.
			-- Start at `a_start_angle' and stop at `a_start_angle' + `an_aperture'.
			-- The arc is then closed by two segments through (`x', 'y').
			-- Angles are measured in radians, start at the
			-- 3 o'clock angle and grow counterclockwise.
		require
			not_destroyed: not is_destroyed
			a_bounding_width_positive_or_zero: a_bounding_width >= 0
			a_bounding_height_positive_or_zero: a_bounding_height >= 0
		do
			implementation.draw_pie_slice (x, y, a_bounding_width,
				a_bounding_height, a_start_angle, an_aperture)
		end

feature -- Drawing operations (filled)

	fill_rectangle (x, y, a_width, a_height: INTEGER) is
			-- Draw filled rectangle with upper-left corner on (`x', `y')
			-- with size `a_width' and `a_height'.
		require
			not_destroyed: not is_destroyed
			a_width_positive_or_zero: a_width >= 0
			a_height_positive_or_zero: a_height >= 0
		do
			implementation.fill_rectangle (x, y, a_width, a_height)
		end

	fill_ellipse (x, y, a_bounding_width, a_bounding_height: INTEGER) is
			-- Fill an ellipse defined by a rectangular area with an
			-- upper left corner at `x',`y', width `a_bounding_width' and height
			-- `a_bounding_height'.
		require
			not_destroyed: not is_destroyed
			a_bounding_width_positive_or_zero: a_bounding_width >= 0
			a_bounding_height_positive_or_zero: a_bounding_height >= 0
		do
			implementation.fill_ellipse (x, y, a_bounding_width,
				a_bounding_height)
		end

	fill_polygon (points: ARRAY [EV_COORDINATE]) is
			-- Draw filled polygon between subsequent points in `points'.
		require
			not_destroyed: not is_destroyed
			points_not_void: points /= Void
		do
			implementation.fill_polygon (points)
		end

	fill_pie_slice (x, y, a_bounding_width, a_bounding_height: INTEGER;
		a_start_angle, an_aperture: REAL) is
			-- Fill part of an ellipse defined by a rectangular area with an
			-- upper left corner at `x',`y', width `a_bounding_width' and height
			-- `a_bounding_height'.
			-- Start at `a_start_angle' and stop at `a_start_angle' + `an_aperture'.
			-- The arc is then closed by two segments through (`x', 'y').
			-- Angles are measured in radians, start at the 3
			-- o'clock angle and grow counterclockwise.
		require
			not_destroyed: not is_destroyed
			a_bounding_width_positive_or_zero: a_bounding_width >= 0
			a_bounding_height_positive_or_zero: a_bounding_height >= 0
		do
			implementation.fill_pie_slice (x, y, a_bounding_width,
				a_bounding_height, a_start_angle, an_aperture)
		end

feature -- Drawing mode setting

	set_copy_mode is
			-- Set `drawing_mode' to normal.
		require
			not_destroyed: not is_destroyed
		do
			implementation.set_drawing_mode (drawing_mode_copy)
		ensure
			drawing_mode_assigned: drawing_mode = drawing_mode_copy
		end

	set_xor_mode is
			-- Set `drawing_mode' to bitwise XOR.
		require
			not_destroyed: not is_destroyed
		do
			implementation.set_drawing_mode (drawing_mode_xor)
		ensure
			drawing_mode_assigned: drawing_mode = drawing_mode_xor
		end

	set_invert_mode is
			-- Set `drawing_mode' to bitwise invert.
		require
			not_destroyed: not is_destroyed
		do
			implementation.set_drawing_mode (drawing_mode_invert)
		ensure
			drawing_mode_assigned: drawing_mode = drawing_mode_invert
		end

	set_and_mode is
			-- Set `drawing_mode' to bitwise AND.
		require
			not_destroyed: not is_destroyed
		do
			implementation.set_drawing_mode (drawing_mode_and)
		ensure
			drawing_mode_assigned: drawing_mode = drawing_mode_and
		end

	set_or_mode is
			-- Set `drawing_mode' to bitwise OR.
		require
			not_destroyed: not is_destroyed
		do
			implementation.set_drawing_mode (drawing_mode_or)
		ensure
			drawing_mode_assigned: drawing_mode = drawing_mode_or
		end

feature {NONE} -- Contract support

	is_in_default_state: BOOLEAN is
			-- Is `Current' in its default state.
		do
			Result := Precursor {EV_ANY} and then
				line_width = 1 and then
				drawing_mode = drawing_mode_copy and then
				clip_area = Void and then
				tile = Void and then
				dashed_line_style = False
		end

feature {EV_ANY_I} -- Implementation

	implementation: EV_DRAWABLE_I

invariant
	line_width_positive_or_zero: is_usable implies line_width >= 0
	drawing_mode_valid: is_usable implies valid_drawing_mode (drawing_mode)

end -- class EV_DRAWABLE

--|----------------------------------------------------------------
--| EiffelVision2: library of reusable components for ISE Eiffel.
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

