indexing
	description:
		"Eiffel Vision drawable. Objects that can be drawn on."
	note:
		"When line style is dashed and line width is bigger than one,%N%
		%lines are not guaranteed to be dashed on all platforms."
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
		undefine
			default_create
		end

feature -- Access

	foreground_color: EV_COLOR is
			-- Color used to draw primitives. Default: black.
		do
			Result := implementation.foreground_color
		ensure
			bridge_ok: Result.is_equal (implementation.foreground_color)
		end

	background_color: EV_COLOR is
			-- Color used for erasing of canvas. Default: white.
		do
			Result := implementation.background_color
		ensure
			bridge_ok: Result.is_equal (implementation.background_color)
		end

	line_width: INTEGER is
			-- Line thickness. Default: 1.
		do
			Result := implementation.line_width
		ensure
			bridge_ok: Result = implementation.line_width
		end

	drawing_mode: INTEGER is
			-- Logical operation on pixels when drawing.
			-- Default: Ev_drawing_mode_copy_enum.
		do
			Result := implementation.drawing_mode
		ensure
			bridge_ok: Result = implementation.drawing_mode
		end

	clip_area: EV_RECTANGLE is
			-- Rectangular to apply clipping on.
		do
			Result := implementation.clip_area
		ensure
			bridge_ok: (Result = Void) = (implementation.clip_area = Void)
		end

	tile: EV_PIXMAP is
			-- Pixmap that is used to draw filled primitives with
			-- instead of `foreground_color'.
		do
			Result := implementation.tile
		ensure
			bridge_ok: (Result = Void) = (implementation.tile = Void)
		end

	dashed_line_style: BOOLEAN is
			-- Are lines drawn dashed?
		do
			Result := implementation.dashed_line_style
		ensure
			bridge_ok: Result = implementation.dashed_line_style
		end

	font: EV_FONT is
			-- Character appearance.
		do
			Result := implementation.font
		ensure
			bridge_ok: Result = implementation.font
		end

feature -- Element change

	set_background_color (a_color: EV_COLOR) is
			-- Assign `a_color' to `background_color'.
		require
			a_color_not_void: a_color /= Void
		do
			implementation.set_background_color (a_color)
		ensure
			-- background_color_assigned: background_color.is_equal (a_color)
		end

	set_foreground_color (a_color: EV_COLOR) is
			-- Assign `a_color' to `foreground_color'
		require
			a_color_not_void: a_color /= Void
		do
			implementation.set_foreground_color (a_color)
		ensure
			-- foreground_color_assigned: foreground_color.is_equal (a_color)
		end

	set_line_width (a_width: INTEGER) is
			-- Assign `a_width' to `line_width'.
			-- See note at top.
		require
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
			a_mode_valid: valid_drawing_mode (a_mode)
		do
			implementation.set_drawing_mode (a_mode)
		ensure
			drawing_mode_assigned: drawing_mode = a_mode
		end

	set_clip_area (an_area: EV_RECTANGLE) is
			-- Set area which will be refreshed.
		require
			an_area_not_void: an_area /= Void
		do
			implementation.set_clip_area (an_area)
		ensure
			clip_area_assigned: clip_area.is_equal (an_area)
		end

	remove_clip_area is
			-- Do not apply any clipping.
		do
			implementation.remove_clip_area
		ensure
			clip_area_void: clip_area = Void
		end

	set_tile (a_pixmap: EV_PIXMAP) is
			-- Set tile used to fill figures.
			-- Set to Void to use `background_color' to fill.
		require
			a_pixmap_not_void: a_pixmap /= Void
		do
			implementation.set_tile (a_pixmap)
		ensure
			tile_assigned: tile /= Void
		end

	remove_tile is
			-- Do not apply a tile when filling.
		do
			implementation.remove_tile
		ensure
			tile_void: tile = Void
		end

	enable_dashed_line_style is
			-- Draw lines dashed.
			-- See note at top.
		do
			implementation.enable_dashed_line_style
		ensure
			dashed_line_style_enabled: dashed_line_style
		end

	disable_dashed_line_style is
			-- Draw lines solid.
		do
			implementation.disable_dashed_line_style
		ensure
			dashed_line_style_disabled: not dashed_line_style
		end

	set_font (a_font: EV_FONT) is
			-- Set `font' to `a_font'.
		require
			a_font_not_void: a_font /= Void
		do
			implementation.set_font (a_font)
		ensure
			assigned: font.is_equal (a_font)
		end

feature -- Clearing operations

	clear is
			-- Erase `Current' with `background_color'.
		do
			implementation.clear
		end

	clear_rect (x1, y1, x2, y2: INTEGER) is
			-- Erase rectangle (`x1, `y1') - (`x2', `y2') with
			-- `background_color'.
		do
			implementation.clear_rect (x1, y1, x2, y2)
		end

feature -- Drawing operations

	draw_point (x, y: INTEGER) is
			-- Draw point at (`x', `y').
		do
			implementation.draw_point (x, y)
		end

	draw_text (x, y: INTEGER; a_text: STRING) is
			-- Draw `a_text' at (`x', `y') using `font'.
		require
			a_text_not_void: a_text /= Void
		do
			implementation.draw_text (x, y, a_text)
		end

	draw_segment (x1, y1, x2, y2: INTEGER) is
			-- Draw line segment from (`x1', `y1') to (`x2', `y2').
		do
			implementation.draw_segment (x1, y1, x2, y2)
		end

	draw_straight_line (x1, y1, x2, y2: INTEGER) is
			-- Draw infinite straight line through (`x1', `y1') and
			-- (`x2', `y2').
		do
			implementation.draw_straight_line (x1, y1, x2, y2)
		end

	draw_pixmap (x, y: INTEGER; a_pixmap: EV_PIXMAP) is
			-- Draw `a_pixmap' with upper-left corner on (`x', `y').
		require
			a_pixmap_not_void: a_pixmap /= Void
		do
			implementation.draw_pixmap (x, y, a_pixmap)
		end

	draw_arc (x, y, a_vertical_radius, a_horizontal_radius: INTEGER;
		a_start_angle, an_aperture: REAL) is
			-- Draw a part of an ellipse centered on (`x', `y') with
			-- size `a_vertical_radius' and `a_horizontal_radius'.
			-- Start at `a_start_angle' and stop at `a_start_angle' +
			-- `an_aperture'. Angles are measured in radians, and go
			-- counterclockwise from the 3 o'clock angle.
		require
			a_vertical_radius_positive_or_zero: a_vertical_radius >= 0
			a_horizontal_radius_positive_or_zero: a_horizontal_radius >= 0
		do
			implementation.draw_arc (x, y, a_vertical_radius,
				a_horizontal_radius, a_start_angle, an_aperture)
		end

	draw_rectangle (x, y, a_width, a_height: INTEGER) is
			-- Draw rectangle with upper-left corner on (`x', `y')
			-- with size `a_width' and `a_height'.
		require
			a_width_positive_or_zero: a_width >= 0
			a_height_positive_or_zero: a_height >= 0
		do
			implementation.draw_rectangle (x, y, a_width, a_height)
		end

	draw_ellipse (x, y, a_vertical_radius, a_horizontal_radius: INTEGER) is
			-- Draw an ellipse centered on (`x', `y') with
			-- size `a_vertical_radius' and `a_horizontal_radius'.
		require
			a_vertical_radius_positive_or_zero: a_vertical_radius >= 0
			a_horizontal_radius_positive_or_zero: a_horizontal_radius >= 0
		do
			implementation.draw_ellipse (x, y, a_vertical_radius,
				a_horizontal_radius)
		end

	draw_polyline (points: ARRAY [EV_COORDINATES]; is_closed: BOOLEAN) is
			-- Draw line segments between subsequent points in
			-- `points'. If `is_closed' draw line segment between first
			-- and last point in `points'.
		require
			points_not_void: points /= Void
		do
			implementation.draw_polyline (points, is_closed)
		end

	draw_pie_slice (x, y, a_vertical_radius, a_horizontal_radius: INTEGER;
		a_start_angle, an_aperture: REAL) is
			-- Draw a part of an ellipse centered on (`x', `y') with
			-- size `a_vertical_radius' and `a_horizontal_radius'.
			-- Start at `a_start_angle' and stop at `a_start_angle' +
			-- `an_aperture'. The arc is then closed by two segments through
			-- (`x', `y'). Angles are measured in radians, start at the
			-- 3 o'clock angle and grow counterclockwise.
		require
			a_vertical_radius_positive_or_zero: a_vertical_radius >= 0
			a_horizontal_radius_positive_or_zero: a_horizontal_radius >= 0
		do
			implementation.draw_pie_slice (x, y, a_vertical_radius,
				a_horizontal_radius, a_start_angle, an_aperture)
		end

feature -- Drawing operations (filled)

	fill_rectangle (x, y, a_width, a_height: INTEGER) is
			-- Draw filled rectangle with upper-left corner on (`x', `y')
			-- with size `a_width' and `a_height'.
		require
			a_width_positive_or_zero: a_width >= 0
			a_height_positive_or_zero: a_height >= 0
		do
			implementation.fill_rectangle (x, y, a_width, a_height)
		end

	fill_ellipse (x, y, a_vertical_radius, a_horizontal_radius: INTEGER) is
			-- Draw filled ellipse centered on (`x', `y') with
			-- size `a_vertical_radius' and `a_horizontal_radius'.
		require
			a_vertical_radius_positive_or_zero: a_vertical_radius >= 0
			a_horizontal_radius_positive_or_zero: a_horizontal_radius >= 0
		do
			implementation.fill_ellipse (x, y, a_vertical_radius,
				a_horizontal_radius)
		end

	fill_polygon (points: ARRAY [EV_COORDINATES]) is
			-- Draw filled polygon between subsequent points in `points'.
		require
			points_not_void: points /= Void
		do
			implementation.fill_polygon (points)
		end

	fill_pie_slice (x, y, a_vertical_radius, a_horizontal_radius: INTEGER;
		a_start_angle, an_aperture: REAL) is
			-- Draw filled part of an ellipse centered on (`x', `y') with
			-- size `a_vertical_radius' and `a_horizontal_radius'.
			-- Start at `a_start_angle' and stop at `a_start_angle' +
			-- `an_aperture'. The arc is then closed by two segments through
			-- (`x', `y'). Angles are measured in radians, start at the 3
			-- o'clock angle and grow counterclockwise.
		require
			a_vertical_radius_positive_or_zero: a_vertical_radius >= 0
			a_horizontal_radius_positive_or_zero: a_horizontal_radius >= 0
		do
			implementation.fill_pie_slice (x, y, a_vertical_radius,
				a_horizontal_radius, a_start_angle, an_aperture)
		end

feature -- Drawing mode setting

	set_copy_mode is
			-- Set `drawing_mode' to normal.
		do
			implementation.set_drawing_mode (Ev_drawing_mode_copy)
		ensure
			drawing_mode_assigned: drawing_mode = Ev_drawing_mode_copy
		end

	set_xor_mode is
			-- Set `drawing_mode' to bitwise XOR.
		do
			implementation.set_drawing_mode (Ev_drawing_mode_xor)
		ensure
			drawing_mode_assigned: drawing_mode = Ev_drawing_mode_xor
		end

	set_invert_mode is
			-- Set `drawing_mode' to bitwise invert.
		do
			implementation.set_drawing_mode (Ev_drawing_mode_invert)
		ensure
			drawing_mode_assigned: drawing_mode = Ev_drawing_mode_invert
		end

	set_and_mode is
			-- Set `drawing_mode' to bitwise AND.
		do
			implementation.set_drawing_mode (Ev_drawing_mode_and)
		ensure
			drawing_mode_assigned: drawing_mode = Ev_drawing_mode_and
		end

	set_or_mode is
			-- Set `drawing_mode' to bitwise OR.
		do
			implementation.set_drawing_mode (Ev_drawing_mode_or)
		ensure
			drawing_mode_assigned: drawing_mode = Ev_drawing_mode_or
		end

feature {EV_ANY_I} -- Implementation

	implementation: EV_DRAWABLE_I

feature {EV_ANY} -- Contract support

	is_in_default_state: BOOLEAN is
			-- Is `Current' in its default state.
		do
			Result := {EV_ANY} Precursor and then
				--foreground_color.is_equal (create {EV_COLOR}.make_with_rgb (0, 0, 0)) and then
				--background_color.is_equal (create {EV_COLOR}.make_with_rgb (1, 1, 1)) and then
				line_width = 1 and then
				drawing_mode = Ev_drawing_mode_copy and then
				clip_area = Void and then
				tile = Void and then
				dashed_line_style = False and then
				font.is_equal (create {EV_FONT})
		end

feature -- Obsolete

	set_logical_mode (a_mode: INTEGER) is
			-- Set drawing mode to `a_logical_mode'.
		obsolete
			"Use: set_drawing_mode"
		do
			set_drawing_mode (a_mode)
		end

invariant
	font_not_void: font /= Void
	background_color_not_void: background_color /= Void
	foreground_color_not_void: foreground_color /= Void
	line_width_positive_or_zero: line_width >= 0
	drawing_mode_valid: valid_drawing_mode (drawing_mode)

end -- class EV_DRAWABLE

--!-----------------------------------------------------------------------------
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
--!-----------------------------------------------------------------------------

--|-----------------------------------------------------------------------------
--| CVS log
--|-----------------------------------------------------------------------------
--|
--| $Log$
--| Revision 1.16  2000/02/14 11:40:49  oconnor
--| merged changes from prerelease_20000214
--|
--| Revision 1.14.4.11.2.33  2000/01/28 20:00:09  oconnor
--| released
--|
--| Revision 1.14.4.11.2.32  2000/01/27 19:30:45  oconnor
--| added --| FIXME Not for release
--|
--| Revision 1.14.4.11.2.31  2000/01/25 22:19:43  brendel
--| Removed _enum from drawing mode constants.
--|
--| Revision 1.14.4.11.2.30  2000/01/24 23:54:22  oconnor
--| renamed EV_CLIP -> EV_RECTANGLE
--|
--| Revision 1.14.4.11.2.29  2000/01/22 02:29:02  oconnor
--| comments
--|
--| Revision 1.14.4.11.2.28  2000/01/22 00:54:25  brendel
--| Improved comments.
--| Changed contracts about valid drawing_mode.
--|
--| Revision 1.14.4.11.2.27  2000/01/21 22:30:20  brendel
--| Uncommented set_background_color postcondition.
--|
--| Revision 1.14.4.11.2.26  2000/01/21 20:04:24  brendel
--| Improved contracts.
--|
--| Revision 1.14.4.11.2.25  2000/01/20 21:38:45  brendel
--| Added features remove_tile and remove_clip_area.
--|
--| Revision 1.14.4.11.2.24  2000/01/20 00:11:59  brendel
--| Improved comments.
--|
--| Revision 1.14.4.11.2.23  2000/01/19 17:43:21  brendel
--| Renamed fill_color to background_color.
--| Renamed line_color to foreground_color.
--|
--| Revision 1.14.4.11.2.22  2000/01/18 22:43:22  brendel
--| Uncommented invariant.
--|
--| Revision 1.14.4.11.2.21  2000/01/18 18:10:17  brendel
--| Added `is_in_default_state'.
--|
--| Revision 1.14.4.11.2.20  2000/01/18 16:33:17  brendel
--| Removed figure drawing routines.
--|
--| Revision 1.14.4.11.2.19  2000/01/17 17:26:13  oconnor
--| comment improvements
--|
--| Revision 1.14.4.11.2.18  2000/01/15 00:57:11  oconnor
--| comments re: default colors
--|
--| Revision 1.14.4.11.2.17  2000/01/14 00:23:49  oconnor
--| removed draw_figure_arrow
--|
--| Revision 1.14.4.11.2.16  2000/01/14 00:04:58  oconnor
--| commented out postcondition pending implementation changes
--|
--| Revision 1.14.4.11.2.15  2000/01/13 23:37:26  oconnor
--| removed is drawable precondition
--|
--| Revision 1.14.4.11.2.14  2000/01/11 01:00:42  king
--| Removed inh. from fontable.
--| Added own font and set_font features.
--|
--| Revision 1.14.4.11.2.13  2000/01/07 00:49:57  king
--| Added features draw_figure_picture and draw_figure_pie_slice.
--|
--| Revision 1.14.4.11.2.12  1999/12/29 19:51:36  king
--| Formatting.
--|
--| Revision 1.14.4.11.2.11  1999/12/17 21:07:15  rogers
--| implementation is now exported to EV_ANY_I. TEMP invariant has been
--| commented out as it needs fixing.
--|
--| Revision 1.14.4.11.2.10  1999/12/09 18:18:39  brendel
--| Corrected description.
--|
--| Revision 1.14.4.11.2.9  1999/12/08 23:45:40  brendel
--| Removed old drawing modes.
--|
--| Revision 1.14.4.11.2.8  1999/12/08 19:42:58  brendel
--| Moved constants to new file: EV_DRAWABLE_CONSTANTS.
--| Renamed constants Gx* to Ev_drawing_mode_*.
--| Improved indexing clause.
--| Implemented features:
--|  - (set_) tile.
--|  - dashed_line_style.
--|  - (set_) clip_area.
--|
--| Revision 1.14.4.11.2.7  1999/12/07 23:17:34  brendel
--| Changed EV_COORDINATES arg to x, y.
--| Changes EV_ANGLE to REAL (in radians).
--| Added draw_pie_slice and fill_pie_slice.
--| Removed `style' from *_arc.
--| Removed orientation from draw/fill_rectangle and draw/fill_ellipse.
--| Remaining to be implemented:
--|  - draw_figure_picture
--|  - draw_figure_picture
--|
--| in EV_DRAWABLE_IMP (GTK):
--|  - draw_text (because of font)
--|  - draw_straight_line
--|  - draw_pie_slice
--|
--| Revision 1.14.4.11.2.6  1999/12/07 18:00:47  brendel
--| Changed background_color to background_color.
--| Changed foreground_color to foreground_color.
--|
--| Revision 1.14.4.11.2.5  1999/12/06 18:03:00  brendel
--| Improved contracts.
--| Changed constants to look like: Ev_drawing_mode_Clear instead of
--| Ev_drawing_mode_clear.
--|
--| Revision 1.14.4.11.2.4  1999/12/04 22:44:50  brendel
--| Improved EV_FONTABLE. EV_DRAWABLE is now fontable.
--|
--| Revision 1.14.4.11.2.3  1999/12/03 23:48:07  brendel
--| Improved contracts on functions.
--| Improved parameter names.
--| Improved comments.
--| Declared set_logical_mode obsolete: replaced by set_drawing_mode.
--| Moved implementation of Figure drawing routines to EV_DRAWABLE_I.
--| Inserted drawing-mode constants and convenience functions.
--|
--| Revision 1.14.4.11.2.2  1999/12/01 01:02:34  brendel
--| Rearranged externals to GEL or EV_C_GTK. Modified some features that relied
--| on specific things like return value BOOLEAN instead of INTEGER.
--|
--| Revision 1.14.4.11.2.1  1999/11/24 17:30:47  oconnor
--| merged with DEVEL branch
--|
--| Revision 1.14.2.3  1999/11/04 23:10:54  oconnor
--| updates for new color model, removed exists: not destroyed
--|
--| Revision 1.14.2.2  1999/11/02 17:20:12  oconnor
--| Added CVS log, redoing creation sequence
--|
--|-----------------------------------------------------------------------------
--| End of CVS log
--|-----------------------------------------------------------------------------
