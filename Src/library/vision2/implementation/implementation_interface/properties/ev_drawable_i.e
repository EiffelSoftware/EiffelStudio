indexing
	description: "EiffelVision drawable. Implementation interface."
	status: "See notice at end of class"
	keywords: "figures, primitives, drawing, line, point, ellipse" 
	date: "$Date$"
	revision: "$Revision$"

deferred class
	EV_DRAWABLE_I

inherit
	EV_ANY_I
		redefine
			interface
		end

	SINGLE_MATH
		
	EV_DRAWABLE_CONSTANTS

	EV_COLORIZABLE_I
		redefine
			interface
		end

	EV_FONTABLE_I
		redefine
			interface
		end

feature -- Access

	width: INTEGER is
		-- Horizontal size in pixels.
	deferred
        ensure
            positive: Result > 0
        end

	height: INTEGER is
		-- Vertical size in pixels.
	deferred
	ensure
		positive: Result > 0
	end

	line_width: INTEGER is
			-- Line thickness.
		deferred
		end

	drawing_mode: INTEGER is
			-- Logical operation on pixels when drawing.
		deferred
		end

	clip_area: EV_RECTANGLE is
			-- Clip area used to clip drawing.
			-- If set to Void, no clipping is applied.
		deferred
		end

	tile: EV_PIXMAP is
			-- Pixmap that is used to instead of background_color.
			-- If set to Void, `background_color' is used to fill.
		deferred
		end

	dashed_line_style: BOOLEAN is
			-- Are lines drawn dashed?
		deferred
		end

feature -- Element change

	set_line_width (a_width: INTEGER) is
			-- Assign `a_width' to `line_width'.
		require
			a_width_positive_or_zero: a_width >= 0
		deferred
		ensure
			line_width_assigned: is_usable implies
				interface.line_width = a_width
		end

	set_drawing_mode (a_mode: INTEGER) is
			-- Set drawing mode to `a_logical_mode'.
		require
			a_mode_valid: valid_drawing_mode (a_mode)
		deferred
		ensure
			drawing_mode_assigned: is_usable implies
				interface.drawing_mode = a_mode
		end

	set_clip_area (an_area: EV_RECTANGLE) is
			-- Set area which will be refreshed.
		require
			an_area_not_void: an_area /= Void
		deferred
		ensure
			clip_area_assigned: is_usable implies
				interface.clip_area.is_equal (an_area)
		end

	remove_clip_area is
			-- Do not apply any clipping.
		deferred
		ensure
			clip_area_void: is_usable implies interface.clip_area = Void
		end

	set_tile (a_pixmap: EV_PIXMAP) is
			-- Set tile used to fill figures.
			-- Set to Void to use `background_color' to fill.
		require
			a_pixmap_not_void: a_pixmap /= Void
		deferred
		ensure
			tile_assigned: is_usable implies interface.tile /= Void
		end

	remove_tile is
			-- Do not apply a tile when filling.
		deferred
		ensure
			tile_void: is_usable implies interface.tile = Void
		end

	enable_dashed_line_style is
			-- Draw lines dashed.
		deferred
		ensure
			dashed_line_style_enabled: is_usable implies
				interface.dashed_line_style
		end

	disable_dashed_line_style is
			-- Draw lines solid.
		deferred
		ensure
			dashed_line_style_disabled: is_usable implies
				not interface.dashed_line_style
		end

feature -- Clearing and drawing operations

	clear is
			-- Erase `Current' with `background_color'.
		deferred
		end

	clear_rectangle (x1, y1, a_width, a_height: INTEGER) is
			-- Draw rectangle with upper-left corner on (`x', `y')
			-- with size `a_width' and `a_height' in `background_color'.
		deferred
		end

feature -- Drawing operations

	draw_point (x, y: INTEGER) is
			-- Draw point at (`x', 'y').
		deferred
		end

	draw_text (x, y: INTEGER; a_text: STRING) is
			-- Draw `a_text' with left of baseline at (`x', `y') using `font'.
		require
			a_text_not_void: a_text /= Void
		deferred
		end

	draw_text_top_left (x, y: INTEGER; a_text: STRING) is
			-- Draw `a_text' with top left corner at (`x', `y') using `font'.
		require
			a_text_not_void: a_text /= Void
		deferred
		end

	draw_segment (x1, y1, x2, y2: INTEGER) is
			-- Draw line segment from (`x1', 'y1') to (`x2', 'y2').
		deferred
		end
		
	draw_straight_line (x1, y1, x2, y2: INTEGER) is
			-- Draw infinite straight line through (`x1','y1') and (`x2','y2').
		local
			ax1, ax2, ay1, ay2, dx, dy: INTEGER
		do
			--| VB: Should work now. Draws lines that are too big.
			--| Catch worst cases like when `dy' approaches zero.
			--| This implementation is the same for GTK.
			dx := (x2 - x1)
			dy := (y2 - y1)
			if dy /= 0 then
				ax1 := x2 - ((dx / dy) * y2).rounded
				ax2 := x1 - ((dx / dy) * (y1 - height)).rounded
				ay1 := 0
				ay2 := height
			else
				ay1 := y1
				ay2 := y2
				ax1 := 0
				ax2 := width
			end
			draw_segment (ax1, ay1, ax2, ay2)			
		end

	draw_pixmap (x, y: INTEGER; a_pixmap: EV_PIXMAP) is
			-- Draw `a_pixmap' with upper-left corner on (`x', 'y').
		require
			a_pixmap_not_void: a_pixmap /= Void
		deferred
		end

	draw_sub_pixmap (x, y: INTEGER; a_pixmap: EV_PIXMAP; area: EV_RECTANGLE) is
			-- Draw `area' of `a_pixmap' with upper-left corner on (`x', `y').
		require
			a_pixmap_not_void: a_pixmap /= Void
			area_not_void: area /= Void
		deferred
		end

	draw_arc (x, y, a_bounding_width, a_bounding_height: INTEGER;
		a_start_angle, an_aperture: REAL) is
			-- Draw a part of an ellipse defined by a rectangular area with an
			-- upper left corner at `x',`y', width `a_bounding_width' and height
			-- `a_bounding_height'.
			-- Start at `a_start_angle' and stop at `a_start_angle' + `an_aperture'.
			-- Angles are measured in radians.
		require
			a_bounding_width_positive_or_zero: a_bounding_width >= 0
			a_bounding_width_positive_or_zero: a_bounding_height >= 0
		deferred
		end

	draw_rectangle (x, y, a_width, a_height: INTEGER) is
			-- Draw rectangle with upper-left corner on (`x', 'y')
			-- with size `a_width' and `a_height'.
		require
			a_width_positive_or_zero: a_width >= 0
			a_height_positive_or_zero: a_height >= 0
		deferred
		end

	draw_ellipse (x, y, a_bounding_width, a_bounding_height: INTEGER) is
			-- Draw an ellipse defined by a rectangular area with an
			-- upper left corner at `x',`y', width `a_bounding_width' and height
			-- `a_bounding_height'.
		require
			a_bounding_width_positive_or_zero: a_bounding_width >= 0
			a_bounding_height_positive_or_zero: a_bounding_height >= 0
		deferred
		end

	draw_polyline (points: ARRAY [EV_COORDINATE]; is_closed: BOOLEAN) is
			-- Draw line segments between subsequent points in
			-- `points'. If `is_closed' draw line segment between first
			-- and last point in `points'.
		require
			points_not_void: points /= Void
		deferred
		end

	draw_pie_slice (x, y, a_bounding_width, a_bounding_height: INTEGER;
	a_start_angle, an_aperture: REAL) is
			-- Draw part of an ellipse defined by a rectangular area with an
			-- upper left corner at `x',`y', width `a_bounding_width' and height
			-- `a_bounding_height'.
			-- Start at `a_start_angle' and stop at `a_start_angle' + `an_aperture'.
			-- The arc is then closed by two segments through (`x', 'y').
			-- Angles are measured in radians.
		require
			a_bounding_width_positive_or_zero: a_bounding_width >= 0
			a_bounding_height_positive_or_zero: a_bounding_height >= 0
		deferred
		end

feature -- Drawing operations (filled)

	fill_rectangle (x, y, a_width, a_height: INTEGER) is
			-- Draw rectangle with upper-left corner on (`x', 'y')
			-- with size `a_width' and `a_height'. Fill with `background_color'.
		require
			a_width_positive_or_zero: a_width >= 0
			a_height_positive_or_zero: a_height >= 0
		deferred
		end

	fill_ellipse (x, y, a_bounding_width, a_bounding_height: INTEGER) is
			-- Fill an ellipse defined by a rectangular area with an
			-- upper left corner at `x',`y', width `a_bounding_width' and height
			-- `a_bounding_height'.
		require
			a_bounding_width_positive_or_zero: a_bounding_width >= 0
			a_bounding_height_positive_or_zero: a_bounding_height >= 0
		deferred
		end

	fill_polygon (points: ARRAY [EV_COORDINATE]) is
			-- Draw line segments between subsequent points in `points'.
			-- Fill with `background_color'.
		require
			points_not_void: points /= Void
		deferred
		end

	fill_pie_slice (x, y, a_bounding_width, a_bounding_height: INTEGER;
	a_start_angle, an_aperture: REAL) is
			-- Fill part of an ellipse defined by a rectangular area with an
			-- upper left corner at `x',`y', width `a_bounding_width' and height
			-- `a_bounding_height'.
			-- Start at `a_start_angle' and stop at `a_start_angle' + `an_aperture'.
			-- The arc is then closed by two segments through (`x', 'y').
			-- Angles are measured in radians.
		require
			a_bounding_width_positive_or_zero: a_bounding_width >= 0
			a_bounding_height_positive_or_zero: a_bounding_height >= 0
		deferred
		end

feature {EV_ANY_I} -- Implementation

	interface: EV_DRAWABLE

end -- class EV_DRAWABLE_I

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

