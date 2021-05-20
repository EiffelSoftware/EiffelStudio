note
	description: "[
		Abstraction for objects onto which graphical primitives may be applied.

		Note: When line style is dashed and line width is bigger than one,
		lines are not guaranteed to be dashed on all platforms.
		All drawing operations are performed in the current
		foreground color unless otherwise stated. i.e. `clear_rectangle'
		uses the current background color.
		]"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	keywords: "figure, primitive, drawing, line, point, ellipse"
	date: "$Date$"
	revision: "$Revision$"

deferred class
	EV_DRAWABLE

inherit
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

	EV_DRAWABLE_CONSTANTS
		export
			{NONE} all
			{ANY} valid_drawing_mode
		undefine
			default_create,
			copy
		end

feature -- Access

	line_width: INTEGER
			-- Line thickness. Default: 1.
		require
			not_destroyed: not is_destroyed
		do
			Result := implementation.line_width
		ensure
			bridge_ok: Result = implementation.line_width
		end

	drawing_mode: INTEGER
			-- Logical operation on pixels when drawing.
			-- Default: drawing_mode_copy.
		require
			not_destroyed: not is_destroyed
		do
			Result := implementation.drawing_mode
		ensure
			bridge_ok: Result = implementation.drawing_mode
		end

	clip_area: detachable EV_RECTANGLE
			-- Rectangular area to apply clipping on.
		require
			not_destroyed: not is_destroyed
		do
			Result := implementation.clip_area
		ensure
			bridge_ok: (Result = Void) = (implementation.clip_area = Void)
		end

	tile: detachable EV_PIXMAP
			-- Pixmap that is used to draw filled primitives with
			-- instead of `foreground_color'.
		require
			not_destroyed: not is_destroyed
		do
			Result := implementation.tile
		ensure
			bridge_ok: (Result = Void) = (implementation.tile = Void)
		end

	dashed_line_style: BOOLEAN
			-- Are lines drawn dashed?
		require
			not_destroyed: not is_destroyed
		do
			Result := implementation.dashed_line_style
		ensure
			bridge_ok: Result = implementation.dashed_line_style
		end

feature -- Measurement

	width: INTEGER
			-- Horizontal size in pixels.
		require
			not_destroyed: not is_destroyed
		deferred
		end

	height: INTEGER
			-- Vertical size in pixels.
		require
			not_destroyed: not is_destroyed
		deferred
		end

feature -- Duplication

	sub_pixmap (area: EV_RECTANGLE): EV_PIXMAP
			-- Return a pixmap region of `Current' represented by rectangle `area'
		require
			not_destroyed: not is_destroyed
			area_not_void: area /= Void
		do
			Result := implementation.sub_pixmap (area)
		ensure
			result_not_void: Result /= Void
		end

feature -- Element change

	set_line_width (a_width: INTEGER)
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

	set_drawing_mode (a_mode: INTEGER)
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

	set_clip_area (an_area: EV_RECTANGLE)
			-- Set area which will be refreshed.
		require
			not_destroyed: not is_destroyed
			an_area_not_void: an_area /= Void
		do
			implementation.set_clip_area (an_area)
		ensure
			clip_area_assigned: attached clip_area as l_clip_area and then l_clip_area.is_equal (an_area)
		end

	set_clip_region (a_region: EV_REGION)
			-- Set region which will be refreshed.
		require
			not_destroyed: not is_destroyed
			a_region_not_void: a_region /= Void
		do
			implementation.set_clip_region (a_region)
		end

	remove_clip_area, remove_clipping
			-- Do not apply any clipping.
		require
			not_destroyed: not is_destroyed
		do
			implementation.remove_clipping
		ensure
			clip_area_void: clip_area = Void
		end

	set_tile (a_pixmap: EV_PIXMAP)
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

	remove_tile
			-- Do not apply a tile when filling.
		require
			not_destroyed: not is_destroyed
		do
			implementation.remove_tile
		ensure
			tile_void: tile = Void
		end

	enable_dashed_line_style
			-- Draw lines dashed.
			-- See note at top.
		require
			not_destroyed: not is_destroyed
		do
			implementation.enable_dashed_line_style
		ensure
			dashed_line_style_enabled: dashed_line_style
		end

	disable_dashed_line_style
			-- Draw lines solid.
		require
			not_destroyed: not is_destroyed
		do
			implementation.disable_dashed_line_style
		ensure
			dashed_line_style_disabled: not dashed_line_style
		end

feature -- Session

	start_drawing_session
			-- Start a drawing session.
			-- Used for optimization, to group sequence of drawings.
			-- note: as a drawing session can be inside another drawing session
			-- `end_drawing_session` has to be called as many time as `start_drawing_session` was called.
		do
			implementation.start_drawing_session
		end

	end_drawing_session
			-- End a drawing session.
			-- Used for optimization, to group sequence of drawings.
			-- note: as a drawing session can be inside another drawing session
			-- `end_drawing_session` has to be called as many time as `start_drawing_session` was called.
		do
			implementation.end_drawing_session
		end

feature -- Clearing operations

	clear
			-- Erase `Current' with `background_color'.
		require
			not_destroyed: not is_destroyed
		do
			implementation.clear
		end

	clear_rectangle (x, y, a_width, a_height: INTEGER)
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

	draw_point (x, y: INTEGER)
			-- Draw point at (`x', `y').
		require
			not_destroyed: not is_destroyed
		do
			implementation.draw_point (x, y)
		end

	draw_text (x, y: INTEGER; a_text: READABLE_STRING_GENERAL)
			-- Draw `a_text' with left of baseline at (`x', `y') using `font'.
		require
			not_destroyed: not is_destroyed
			a_text_not_void: a_text /= Void
		do
			implementation.draw_text (x, y, a_text)
		end

	draw_rotated_text (x, y: INTEGER; angle: REAL; a_text: READABLE_STRING_GENERAL)
			-- Draw rotated text `a_text' with left of baseline at (`x', `y') using `font'.
			-- Rotation is number of `angle' radians counter-clockwise from horizontal plane.
		require
			not_destroyed: not is_destroyed
			a_text_not_void: a_text /= Void
		do
			implementation.draw_rotated_text (x, y, angle, a_text)
		end

	draw_text_top_left (x, y: INTEGER; a_text: READABLE_STRING_GENERAL)
			-- Draw `a_text' with top left corner at (`x', `y') using `font'.
		require
			not_destroyed: not is_destroyed
			a_text_not_void: a_text /= Void
		do
			implementation.draw_text_top_left (x, y, a_text)
		end

	draw_ellipsed_text (x, y: INTEGER; a_text: READABLE_STRING_GENERAL; clipping_width: INTEGER)
			-- Draw `a_text' with left of baseline at (`x', `y') using `font'.
			-- Text is clipped to `clipping_width' in pixels and ellipses are displayed
			-- to show truncated characters if any.
		require
			not_destroyed: not is_destroyed
			a_text_not_void: a_text /= Void
			clipping_width_positive: clipping_width >= 0
		do
			implementation.draw_ellipsed_text (x, y, a_text, clipping_width)
		end

	draw_ellipsed_text_top_left (x, y: INTEGER; a_text: READABLE_STRING_GENERAL; clipping_width: INTEGER)
			-- Draw `a_text' with top left corner at (`x', `y') using `font'.
			-- Text is clipped to `clipping_width' in pixels and ellipses are displayed
			-- to show truncated characters if any.
		require
			not_destroyed: not is_destroyed
			a_text_not_void: a_text /= Void
			clipping_width_positive: clipping_width >= 0
		do
			implementation.draw_ellipsed_text_top_left (x, y, a_text, clipping_width)
		end

	draw_segment (x1, y1, x2, y2: INTEGER)
			-- Draw line segment from (`x1', `y1') to (`x2', `y2').
		require
			not_destroyed: not is_destroyed
		do
			implementation.draw_segment (x1, y1, x2, y2)
		end

	draw_straight_line (x1, y1, x2, y2: INTEGER)
			-- Draw infinite straight line through (`x1', `y1') and
			-- (`x2', `y2').
		require
			not_destroyed: not is_destroyed
			points_not_equal: x1 /= x2 or y1 /= y2
		do
			implementation.draw_straight_line (x1, y1, x2, y2)
		end

	draw_pixmap (x, y: INTEGER; a_pixmap: EV_PIXMAP)
			-- Draw `a_pixmap' with upper-left corner on (`x', `y').
		require
			not_destroyed: not is_destroyed
			a_pixmap_not_void: a_pixmap /= Void
		do
			implementation.draw_pixmap (x, y, a_pixmap)
		end

	draw_sub_pixmap (x, y: INTEGER; a_pixmap: EV_PIXMAP; area: EV_RECTANGLE)
			-- Draw `area' of `a_pixmap' with upper-left corner on (`x', `y').
		require
			not_destroyed: not is_destroyed
			a_pixmap_not_void: a_pixmap /= Void
			area_not_void: area /= Void
		do
			implementation.draw_sub_pixmap (x, y, a_pixmap, area)
		end

	draw_sub_pixel_buffer (x, y: INTEGER; a_pixel_buffer: EV_PIXEL_BUFFER; area: EV_RECTANGLE)
			-- Draw `area' of `a_pixel_buffer with upper-left corner on (`x', `y').
		require
			not_destroyed: not is_destroyed
			a_pixel_buffer_not_void: a_pixel_buffer /= Void
			area_not_void: area /= Void
		do
			implementation.draw_sub_pixel_buffer (x, y, a_pixel_buffer, area)
		end

	draw_arc (x, y, a_bounding_width, a_bounding_height: INTEGER;
		a_start_angle, an_aperture: REAL)
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

	draw_rectangle (x, y, a_width, a_height: INTEGER)
			-- Draw rectangle with upper-left corner on (`x', `y')
			-- with size `a_width' and `a_height'.
		require
			not_destroyed: not is_destroyed
			a_width_positive_or_zero: a_width >= 0
			a_height_positive_or_zero: a_height >= 0
		do
			implementation.draw_rectangle (x, y, a_width, a_height)
		end

	draw_ellipse (x, y, a_bounding_width, a_bounding_height: INTEGER)
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

	draw_polyline (points: ARRAY [EV_COORDINATE]; is_closed: BOOLEAN)
			-- Draw line segments between subsequent points in
			-- `points'. If `is_closed' draw line segment between first
			-- and last point in `points'.
		require
			not_destroyed: not is_destroyed
			points_not_void: points /= Void
--			points_contains_no_void_items: not points.has (Void)
			points_contains_first_and_last: points.count >= 2
		do
			implementation.draw_polyline (points, is_closed)
		end

	draw_pie_slice (x, y, a_bounding_width, a_bounding_height: INTEGER;
		a_start_angle, an_aperture: REAL)
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

	fill_rectangle (x, y, a_width, a_height: INTEGER)
			-- Draw filled rectangle with upper-left corner on (`x', `y')
			-- with size `a_width' and `a_height'.
		require
			not_destroyed: not is_destroyed
			a_width_positive_or_zero: a_width >= 0
			a_height_positive_or_zero: a_height >= 0
		do
			implementation.fill_rectangle (x, y, a_width, a_height)
		end

	fill_ellipse (x, y, a_bounding_width, a_bounding_height: INTEGER)
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

	fill_polygon (points: ARRAY [EV_COORDINATE])
			-- Draw filled polygon between subsequent points in `points'.
		require
			not_destroyed: not is_destroyed
			points_not_void: points /= Void
--			points_contains_no_void_items: not points.has (Void)
			points_contains_first_and_last: points.count >= 2
		do
			implementation.fill_polygon (points)
		end

	fill_pie_slice (x, y, a_bounding_width, a_bounding_height: INTEGER;
		a_start_angle, an_aperture: REAL)
			-- Fill part of an ellipse defined by a rectangular area with an
			-- upper left corner at `x',`y', width `a_bounding_width' and height
			-- `a_bounding_height'.
			-- Start at `a_start_angle' and stop at `a_start_angle' + `an_aperture'.
			-- The arc is then closed by two segments through (`x', `y').
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

	set_copy_mode
			-- Set `drawing_mode' to normal.
		require
			not_destroyed: not is_destroyed
		do
			implementation.set_drawing_mode (drawing_mode_copy)
		ensure
			drawing_mode_assigned: drawing_mode = drawing_mode_copy
		end

	set_xor_mode
			-- Set `drawing_mode' to bitwise XOR.
		require
			not_destroyed: not is_destroyed
		do
			implementation.set_drawing_mode (drawing_mode_xor)
		ensure
			drawing_mode_assigned: drawing_mode = drawing_mode_xor
		end

	set_invert_mode
			-- Set `drawing_mode' to bitwise invert.
		require
			not_destroyed: not is_destroyed
		do
			implementation.set_drawing_mode (drawing_mode_invert)
		ensure
			drawing_mode_assigned: drawing_mode = drawing_mode_invert
		end

	set_and_mode
			-- Set `drawing_mode' to bitwise AND.
		require
			not_destroyed: not is_destroyed
		do
			implementation.set_drawing_mode (drawing_mode_and)
		ensure
			drawing_mode_assigned: drawing_mode = drawing_mode_and
		end

	set_or_mode
			-- Set `drawing_mode' to bitwise OR.
		require
			not_destroyed: not is_destroyed
		do
			implementation.set_drawing_mode (drawing_mode_or)
		ensure
			drawing_mode_assigned: drawing_mode = drawing_mode_or
		end

	set_anti_aliasing (value: BOOLEAN)
			-- Enable (if `value`) or disable (if `not value`) anti-aliasing (if supported) when drawing.
		do
			implementation.set_anti_aliasing (value)
		end

feature {NONE} -- Contract support

	is_in_default_state: BOOLEAN
			-- Is `Current' in its default state.
		do
			Result := True or Precursor {EV_COLORIZABLE} and then
				line_width = 1 and then
				drawing_mode = drawing_mode_copy and then
				clip_area = Void and then
				tile = Void and then
				dashed_line_style = False
		end

feature {EV_ANY, EV_ANY_I, EV_ANY_HANDLER} -- Implementation

	implementation: EV_DRAWABLE_I

invariant
	line_width_positive_or_zero: is_usable implies line_width >= 0
	drawing_mode_valid: is_usable implies valid_drawing_mode (drawing_mode)

note
	copyright:	"Copyright (c) 1984-2021, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"

end
