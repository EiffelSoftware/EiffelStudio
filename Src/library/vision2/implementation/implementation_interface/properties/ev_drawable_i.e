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

feature -- Access

	foreground_color: EV_COLOR is
			-- Color used to draw primitives.
			-- Default: black.
		deferred
		end

	background_color: EV_COLOR is
			-- Color used for erasing of canvas.
			-- Default: white.
		deferred
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

	font: EV_FONT is
			-- Character appearance.
		deferred
		end

feature -- Element change

	set_background_color (a_color: EV_COLOR) is
			-- Assign `a_color' to `background_color'.
		require
			a_color_not_void: a_color /= Void
		deferred
		ensure
			-- background_color_assigned: background_color.is_equal (a_color)
		end

	set_foreground_color (a_color: EV_COLOR) is
			-- Assign `a_color' to `foreground_color'
		require
			a_color_not_void: a_color /= Void
		deferred
		ensure
			-- foreground_color_assigned: foreground_color.is_equal (a_color)
		end

	set_line_width (a_width: INTEGER) is
			-- Assign `a_width' to `line_width'.
		require
			a_width_positive_or_zero: a_width >= 0
		deferred
		ensure
			line_width_assigned: line_width = a_width
		end

	set_drawing_mode (a_mode: INTEGER) is
			-- Set drawing mode to `a_logical_mode'.
		require
			a_mode_valid: valid_drawing_mode (a_mode)
		deferred
		ensure
			drawing_mode_assigned: drawing_mode = a_mode
		end

	set_clip_area (an_area: EV_RECTANGLE) is
			-- Set area which will be refreshed.
		require
			an_area_not_void: an_area /= Void
		deferred
		ensure
			clip_area_assigned: clip_area.is_equal (an_area)
		end

	remove_clip_area is
			-- Do not apply any clipping.
		deferred
		ensure
			clip_area_void: clip_area = Void
		end

	set_tile (a_pixmap: EV_PIXMAP) is
			-- Set tile used to fill figures.
			-- Set to Void to use `background_color' to fill.
		require
			a_pixmap_not_void: a_pixmap /= Void
		deferred
		ensure
			tile_assigned: tile /= Void
		end

	remove_tile is
			-- Do not apply a tile when filling.
		deferred
		ensure
			tile_void: tile = Void
		end

	enable_dashed_line_style is
			-- Draw lines dashed.
		deferred
		ensure
			dashed_line_style_enabled: dashed_line_style
		end

	disable_dashed_line_style is
			-- Draw lines solid.
		deferred
		ensure
			dashed_line_style_disabled: not dashed_line_style
		end

	set_font (a_font: EV_FONT) is
			-- Set `font' to `a_font'.
		require
			a_font_not_void: a_font /= Void
		deferred
		ensure
			assigned: font.is_equal (a_font)
		end

feature -- Clearing operations

	clear is
			-- Erase `Current' with `background_color'.
		deferred
		end

	clear_rect (x1, y1, x2, y2: INTEGER) is
			-- Erase rectangle (`x1, `y1) - (`x2', `y2') with `background_color'.
		deferred
		end

feature -- Drawing operations

	draw_point (x, y: INTEGER) is
			-- Draw point at (`x', 'y').
		deferred
		end

	draw_text (x, y: INTEGER; a_text: STRING) is
			-- Draw `a_text' at (`x', 'y') using `font'.
		require
			a_text_not_void: a_text /= Void
		deferred
		end

	draw_segment (x1, y1, x2, y2: INTEGER) is
			-- Draw line segment from (`x1', 'y1') to (`x2', 'y2').
		deferred
		end

	draw_straight_line (x1, y1, x2, y2: INTEGER) is
			-- Draw infinite straight line through (`x1', 'y1') and (`x2', 'y2').
		deferred
		end

	draw_pixmap (x, y: INTEGER; a_pixmap: EV_PIXMAP) is
			-- Draw `a_pixmap' with upper-left corner on (`x', 'y').
		require
			a_pixmap_not_void: a_pixmap /= Void
		deferred
		end

	draw_arc (x, y, a_vertical_radius, a_horizontal_radius: INTEGER; a_start_angle, an_aperture: REAL) is
			-- Draw a part of an ellipse centered on (`x', 'y') with
			-- size `a_vertical_radius' and `a_horizontal_radius'.
			-- Start at `a_start_angle' and stop at `a_start_angle' + `an_aperture'.
			-- Angles are measured in radians.
		require
			a_vertical_radius_positive_or_zero: a_vertical_radius >= 0
			a_horizontal_radius_positive_or_zero: a_horizontal_radius >= 0
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

	draw_ellipse (x, y, a_vertical_radius, a_horizontal_radius: INTEGER) is
			-- Draw an ellipse centered on (`x', 'y') with
			-- size `a_vertical_radius' and `a_horizontal_radius'.
		require
			a_vertical_radius_positive_or_zero: a_vertical_radius >= 0
			a_horizontal_radius_positive_or_zero: a_horizontal_radius >= 0
		deferred
		end

	draw_polyline (points: ARRAY [EV_COORDINATES]; is_closed: BOOLEAN) is
			-- Draw line segments between subsequent points in
			-- `points'. If `is_closed' draw line segment between first
			-- and last point in `points'.
		require
			points_not_void: points /= Void
		deferred
		end

	draw_pie_slice (x, y, a_vertical_radius, a_horizontal_radius: INTEGER; a_start_angle, an_aperture: REAL) is
			-- Draw a part of an ellipse centered on (`x', 'y') with
			-- size `a_vertical_radius' and `a_horizontal_radius'.
			-- Start at `a_start_angle' and stop at `a_start_angle' + `an_aperture'.
			-- The arc is then closed by two segments through (`x', 'y').
			-- Angles are measured in radians.
		require
			a_vertical_radius_positive_or_zero: a_vertical_radius >= 0
			a_horizontal_radius_positive_or_zero: a_horizontal_radius >= 0
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

	fill_ellipse (x, y, a_vertical_radius, a_horizontal_radius: INTEGER) is
			-- Draw an ellipse centered on (`x', 'y') with
			-- size `a_vertical_radius' and `a_horizontal_radius'.
			-- Fill with `background_color'.
		require
			a_vertical_radius_positive_or_zero: a_vertical_radius >= 0
			a_horizontal_radius_positive_or_zero: a_horizontal_radius >= 0
		deferred
		end

	fill_polygon (points: ARRAY [EV_COORDINATES]) is
			-- Draw line segments between subsequent points in `points'.
			-- Fill with `background_color'.
		require
			points_not_void: points /= Void
		deferred
		end

	fill_pie_slice (x, y, a_vertical_radius, a_horizontal_radius: INTEGER; a_start_angle, an_aperture: REAL) is
			-- Draw a part of an ellipse centered on (`x', 'y') with
			-- size `a_vertical_radius' and `a_horizontal_radius'.
			-- Start at `a_start_angle' and stop at `a_start_angle' + `an_aperture'.
			-- The arc is then closed by two segments through (`x', 'y').
			-- Angles are measured in radians. Fill with `background_color'.
		require
			a_vertical_radius_positive_or_zero: a_vertical_radius >= 0
			a_horizontal_radius_positive_or_zero: a_horizontal_radius >= 0
		deferred
		end

feature {EV_ANY_I} -- Implementation

	interface: EV_DRAWABLE

end -- class EV_DRAWABLE_I

--!----------------------------------------------------------------
--! EiffelVision2: library of reusable components for ISE Eiffel.
--! Copyright (C) 1986-1999 Interactive Software Engineering Inc.
--! All rights reserved. Duplication and distribution prohibited.
--! May be used only with ISE Eiffel, under terms of user license. 
--! Contact ISE for any other use.
--!
--! Interactive Software Engineering Inc.
--! ISE Building, 2nd floor
--! 270 Storke Road, Goleta, CA 93117 USA
--! Telephone 805-685-1006, Fax 805-685-6869
--! Electronic mail <info@eiffel.com>
--! Customer support e-mail <support@eiffel.com>
--! For latest info see award-winning pages: http://www.eiffel.com
--!----------------------------------------------------------------

--|-----------------------------------------------------------------------------
--| CVS log
--|-----------------------------------------------------------------------------
--|
--| $Log$
--| Revision 1.14  2000/02/14 11:40:35  oconnor
--| merged changes from prerelease_20000214
--|
--| Revision 1.13.4.23  2000/02/04 04:00:10  oconnor
--| released
--|
--| Revision 1.13.4.22  2000/01/27 19:29:56  oconnor
--| added --| FIXME Not for release
--|
--| Revision 1.13.4.21  2000/01/24 23:54:20  oconnor
--| renamed EV_CLIP -> EV_RECTANGLE
--|
--| Revision 1.13.4.20  2000/01/22 00:55:32  brendel
--| Changed contracts about drawing_mode.
--|
--| Revision 1.13.4.19  2000/01/21 22:28:54  brendel
--| Uncommented set_background_color postcondition.
--|
--| Revision 1.13.4.18  2000/01/21 20:10:00  brendel
--| Improved contracts.
--|
--| Revision 1.13.4.17  2000/01/20 21:38:45  brendel
--| Added features remove_tile and remove_clip_area.
--|
--| Revision 1.13.4.16  2000/01/19 17:42:47  brendel
--| Renamed fill_color to background_color.
--| Renamed line_color to foreground_color.
--|
--| Revision 1.13.4.15  2000/01/18 16:33:17  brendel
--| Removed figure drawing routines.
--|
--| Revision 1.13.4.14  2000/01/18 01:28:38  king
--| Removed feature `is_drawable'.
--|
--| Revision 1.13.4.13  2000/01/17 23:34:32  brendel
--| Removed all preconditions `is_drawable' from all features.
--|
--| Revision 1.13.4.12  2000/01/11 00:48:58  king
--| Not fontable anymore. Has its own font features now.
--|
--| Revision 1.13.4.11  2000/01/07 00:49:57  king
--| Added features draw_figure_picture and draw_figure_pie_slice.
--|
--| Revision 1.13.4.10  1999/12/31 00:47:59  king
--| Corrected error in draw_figure_equilateral.
--|
--| Revision 1.13.4.9  1999/12/17 18:42:27  rogers
--| redefined interface to be a a more refined type.
--|
--| Revision 1.13.4.8  1999/12/09 00:14:56  brendel
--| Improved contracts.
--|
--| Revision 1.13.4.7  1999/12/08 19:43:41  brendel
--| Added features to comply with EV_DRAWABLE.
--|
--| Revision 1.13.4.6  1999/12/07 23:17:34  brendel
--| Changed EV_COORDINATES arg to x, y.
--| Changes EV_ANGLE to REAL (in radians).
--| Added draw_pie_slice and fill_pie_slice.
--| Removed `style' from *_arc.
--| Removed orientation from draw/fill_rectangle and draw/fill_ellipse.
--| Remaining to be implemented:
--|  - draw_figure_picture
--|  - draw_figure_slice
--|
--| in EV_DRAWABLE_IMP (GTK):
--|  - draw_text (because of font)
--|  - draw_straight_line
--|  - draw_pie_slice
--|
--| Revision 1.13.4.5  1999/12/07 18:29:08  brendel
--| Changed background_color to background_color.
--| Changed foreground_color to foreground_color.
--|
--| Revision 1.13.4.4  1999/12/06 18:19:04  brendel
--| Changed tag `drawable' to `is_drawable' and added it to all functions.
--|
--| Revision 1.13.4.3  1999/12/04 22:48:14  brendel
--| Is now fontable.
--|
--| Revision 1.13.4.2  1999/12/03 23:51:47  brendel
--| Changed comments and parameter names to those of EV_DRAWABLE.
--| Implementation of figure drawing routines now in here.
--| Implementation of *_ellipse now in here.
--| set_logical mode is REMOVED. Changed to set_drawing_mode.
--|
--| Revision 1.13.4.1  1999/11/24 17:30:06  oconnor
--| merged with DEVEL branch
--|
--| Revision 1.11.2.3  1999/11/04 23:10:35  oconnor
--| updates for new color model, removed exists: not destroyed
--|
--| Revision 1.11.2.2  1999/11/02 17:20:05  oconnor
--| Added CVS log, redoing creation sequence
--|
--|
--|-----------------------------------------------------------------------------
--| End of CVS log
--|-----------------------------------------------------------------------------
