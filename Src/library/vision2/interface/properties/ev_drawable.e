indexing
	description: "EiffelVision drawable. A drawable is a%
			% container on which the user can draw pixmaps%
			% or his own figures. It's a deferred class."
	status: "See notice at end of class"
	id: "$Id$"
	date: "$Date$"
	revision: "$Revision$"

class 
	EV_DRAWABLE

inherit
	EV_ANY
		redefine
			implementation
		end

feature -- Access

	background_color: EV_COLOR is
			-- Color used for the background of the widget
		require
			exists: not destroyed
		do
			Result := implementation.background_color
		ensure
			valid_result: Result /= Void
		end

	foreground_color: EV_COLOR is
			-- Color used for the foreground of the widget
			-- usually the text.
		require
			exists: not destroyed
		do
			Result := implementation.foreground_color
		ensure
			valid_result: Result /= Void
		end

	line_width: INTEGER is
			-- Width of line for device.
		require
			exists: not destroyed
			drawable: is_drawable
		do
			Result := implementation.line_width
		end

	logical_mode: INTEGER is
			-- Drawing mode
		require
			exists: not destroyed
			drawable: is_drawable
		do
			Result := implementation.logical_mode
		end

feature -- Status report

	is_drawable: BOOLEAN is
			-- Is the device drawable?
		require
			exitst: not destroyed
		do
			Result :=  implementation.is_drawable
		end

feature -- Element change

	set_background_color (color: EV_COLOR) is
			-- Make `color' the new `background_color'
		require
			exists: not destroyed
			valid_color: is_valid (color)
		do
			implementation.set_background_color (color)
		ensure
			background_color_set: background_color.same (color)
		end

	set_foreground_color (color: EV_COLOR) is
			-- Make `color' the new `foreground_color'
		require
			exists: not destroyed
			valid_color: is_valid (color)
		do
			implementation.set_foreground_color (color)
		ensure
			foreground_color_set: foreground_color.same (color)
		end

	set_line_width (value: INTEGER) is
			-- Set line to be displayed with width of `new_width'.
		require
			exists: not destroyed
			valid_width: value > 0
		do
			implementation.set_line_width (value)
		ensure
			line_width_set: --To implement
		end

	set_logical_mode (value: INTEGER) is
			-- Set drawing logical function to `value'.
		require
			exists: not destroyed
			mode_big_enough: value >= 0
			mode_small_enough: value <= 15
		do
			implementation.set_logical_mode (value)
		ensure
			mode_set: --To implement
		end

	set_font (ft: EV_FONT) is
			-- Set a font.
		require
			exists: not destroyed
			valid_font: is_valid (ft)
		do
			implementation.set_font (ft)
		ensure
			font_set: -- To implement
		end

feature -- Clearing operations

	clear is
			-- Clear the entire area.
		require
			exists: not destroyed
		do
			implementation.clear
		end

	clear_rect (left, top, right, bottom: INTEGER) is
			-- Clear the rectangular area defined by
			-- `left', `top', `right', `bottom'.
		do
			implementation.clear_rect (left, top, right, bottom)
		end

feature -- Drawing operations

	draw_point (pt: EV_COORDINATES) is
			-- Draw a point at the position `pt'.
		require
			valid_point: pt /= Void
		do
			implementation.draw_point (pt)
		end

	draw_text (pt: EV_COORDINATES; text: STRING) is
			-- Draw `text' at the position `pt'
		require
			vlid_text: text /= Void
			valid_point: pt /= Void
		do
			implementation.draw_text (pt, text)
		end

	draw_segment (pt1, pt2: EV_COORDINATES) is
			-- Draw a segment between `pt1' and `pt2'.
		require
			valid_point1: pt1 /= Void
			valid_point2: pt2 /= Void
		do
			implementation.draw_segment (pt1, pt2)
		end

	draw_polyline (pts: ARRAY [EV_COORDINATES]; is_closed: BOOLEAN) is
			-- Draw a polyline, close it automatically if `is_closed'.
		require
			points_exists: pts /= Void
			points_large_enough: not pts.empty
			points_small_enough: pts.count <= max_count_for_draw_polyline
		do
			implementation.draw_polyline (pts, is_closed)
		end

	draw_rectangle (pt: EV_COORDINATES; w, h: INTEGER; orientation: REAL) is
			-- Draw a rectangle whose center is `pt' and size is `w' and `h'
			-- and that has the orientation `orientation'.
		require
			valid_point: pt /= Void
			width_positive: w >= 0
			height_positive: h >= 0
			orientation_small_enough: orientation >= 0
			orientation_large_enough: orientation < 360
		do
			implementation.draw_rectangle (pt, w, h, orientation)
		end

	draw_arc (pt: EV_COORDINATES; r1, r2: INTEGER; start_angle, aperture, orientation: REAL; style: INTEGER) is
			-- Draw an arc centered in `pt' with a great radius of `r1' and a small radius
			-- of `r2' beginnning at `start_angle' and finishing at `start_angle + aperture'
			-- and with an orientation of `orientation' using the style `style'.
			-- The meaning of the style is the following :
			--   -1 : no link between the first and the last point
			--    0 : the first point is linked to the last point
			--    1 : the first and the last point are linked to the center `pt'
		require
			valid_point: pt /= Void
			positive_radius1: r1 >= 0;
			positive_radius2: r2 >= 0;
			positive_start_angle: start_angle >= 0;
			positive_aperture: aperture >= 0;
	--		valid_total_angle: angle1+angle2 <= 360;
			orientation_large_enough: orientation >= 0;
			orientation_small_enough: orientation < 360;
			valid_style: style >= -1 and style <= 1
		do
			implementation.draw_arc (pt, r1, r2, start_angle, aperture, orientation, style)
		end

	draw_ellipse (pt: EV_COORDINATES; r1, r2: INTEGER; orientation: REAL) is
			-- Draw an ellipse centered in `pt' with a great radius of `r1' and a small radius
			-- of `r2' with the orientation `orientation'.
		require
			valid_point: pt /= Void
			positive_radius1: r1 >= 0;
			positive_radius2: r2 >= 0;
			orientation_large_enough: orientation >= 0;
			orientation_small_enough: orientation < 360;
		do
			draw_arc (pt, r1, r2, 0, 360, orientation, -1)
		end

	draw_pixmap (pt: EV_COORDINATES; pix : EV_PIXMAP) is
			-- Copy `pix' into the drawable at the point `pt'.
		require
			valid_point: pt /= Void
			valid_pixmap: is_valid (pix)
		do
			implementation.draw_pixmap (pt, pix)
		end

feature -- filling operations

	fill_polygon (pts: ARRAY [EV_COORDINATES]) is
			 -- Fill a polygon.
		require
			points_exists: pts /= Void
			points_large_enough: not pts.empty
			points_small_enough: pts.count <= max_count_for_draw_polyline
		do
			implementation.fill_polygon (pts)
		end

	fill_rectangle (pt: EV_COORDINATES; w, h: INTEGER; orientation: REAL) is
			-- Fill a rectangle whose center is `pt' and size is `w' and `h'
			-- with an orientation `orientation'.
		require
			valid_point: pt /= Void
			width_positive: w >= 0
			height_positive: h >= 0
			orientation_small_enough: orientation >= 0
			orientation_large_enough: orientation < 360
		do
			implementation.fill_rectangle (pt, w, h, orientation)
		end

	fill_arc (pt: EV_COORDINATES; r1, r2 : INTEGER; start_angle, aperture, orientation: REAL; style: INTEGER) is
			-- Fill an arc centered in `pt' with a great radius of `r1' and a small radius
			-- of `r2' beginnning at `start_angle' and finishing at `start_angle + aperture'
			-- and with an orientation of `orientation' using the style `style'.
			-- The meaning of the style is the following :
			--   -1 : no link between the first and the last point
			--    0 : the first point is linked to the last point
			--    1 : the first and the last point are linked to the center `pt'
		require
			valid_point: pt /= Void
			positive_radius1: r1 >= 0;
			positive_radius2: r2 >= 0;
			positive_start_angle: start_angle >= 0;
			positive_aperture: aperture >= 0;
	--		valid_total_angle: angle1+angle2 <= 360;
			orientation_large_enough: orientation >= 0;
			orientation_small_enough: orientation < 360;
			valid_style: style >= -1 and style <= 1
		do
			implementation.fill_arc (pt, r1, r2, start_angle, aperture, orientation, style)
		end

	fill_ellipse (pt: EV_COORDINATES; r1, r2: INTEGER; orientation: REAL) is
			-- Fill an ellipse centered in `pt' with a great radius of `r1' and a small radius
			-- of `r2' with the orientation `orientation'.
		require
			valid_point: pt /= Void
			positive_radius1: r1 >= 0;
			positive_radius2: r2 >= 0;
			orientation_large_enough: orientation >= 0;
			orientation_small_enough: orientation < 360;
		do
			fill_arc (pt, r1, r2, 0, 360, orientation, -1)
		end

feature -- Assertion feature

	max_count_for_draw_polyline : INTEGER is
			-- Maximum value for `points.count' for `draw_polyline'
		do
			Result := 1000
		end

feature {NONE} -- To verify : status settings

--	set_clip (a_clip: EV_RECTANGLE) is
--			-- Set a clip area which need to be refreshed.
--		require
--			exists: not destroyed
--		do
--			implementation.set_clip (a_clip)
--		end

--	set_no_clip is
--			-- Remove all clip area.
--		require
--			exists: not destroyed
--		do
--			implementation.set_no_clip
--		end

--	set_clip (a_clip: EV_RECTANGLE) is
--			-- Set a clip area.
--		require
--			exitst: not destroyed
--			valid_rectangle: -- To implement
--		do
--			implementation.set_clip (a_clip)
--		ensure
--			clip_set: -- To implement
--		end

--	set_fill_style (value: INTEGER) is
--			-- Set the style of fill.
--		require
--			exists: not destroyed
--			valid_fill_style: -- To implement
--		do
---			implementation.set_fill_style (value)
--		ensure
--			style_set: --To implement
--		end

--	set_line_style (value: INTEGER) is
--			-- Set line style.
---		require
--			exists: not destroyed
--			valid_line_style: --To implement
--		do
--			implementation.set_line_style (value)
--		end


--	set_no_clip is
--			-- Remove all clip area.
--		require
--			exists: not destroyed
--		do
--			implementation.set_no_clip
--		end

--	set_stipple (pix: EV_PIXMAP) is
--			-- Set stipple used to fill figures
--		require
--			exits: not destroyed
--			valid_pixmap: is_valid (pix)
--		do
--			implementation.set_stipple (pix)
--		ensure
--			stipple_set: --To implement
--		end

--	set_tile (pix: EV_PIXMAP) is
--			-- Set tile used to fill figures
--		require
--			exits: not destroyed
--			valid_pixmap: is_valid (pix)
--		do
--			implementation.set_tile (pix)
--		ensure
--			tile_set: --To implement
--		end

feature {NONE} -- To verify or implement: TEMP

-- 	set_text_alignment is
 --			-- Set the default text alignment.
 --		require
 --			drawing_dc_not_void: drawing_dc /= Void
 --		do
 --			drawing_dc.set_text_alignment (ta_baseline)
 --		end

	-- Verified: Post-condition violation: Double_ref
--	draw_inf_line (pt1, pt2: EV_COORDINATES) is
--			-- Draw an infinite line traversing `point1' and `point2'.
--		do
--			implementation.draw_inf_line (pt1, pt2)
--		end

feature -- Implementation

	implementation: EV_DRAWABLE_I

end -- class EV_DRAWABLE

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
