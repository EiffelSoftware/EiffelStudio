indexing
	description: "EiffelVision drawable area. Implementation interface."
	status: "See notice at end of class"
	id: "$Id$"
	date: "$Date$"
	revision: "$Revision$"

deferred class
	EV_DRAWABLE_I

inherit
	EV_ANY_I

feature -- Access

	background_color: EV_COLOR is
			-- Color used for the background of the widget
		require
			exists: not destroyed
		deferred
		ensure
			valid_result: Result /= Void
		end

	foreground_color: EV_COLOR is
			-- Color used for the foreground of the drawable,
			-- used for the text and the drawings.
		require
			exists: not destroyed
		deferred
		ensure
			valid_result: Result /= Void
		end

	line_width: INTEGER is
			-- Width of line for device.
		require
			exists: not destroyed
			drawable: is_drawable
		deferred
		end

	logical_mode: INTEGER is
			-- Drawing mode
		require
			exists: not destroyed
			drawable: is_drawable
		deferred
		end

feature -- Status report

	is_drawable: BOOLEAN is
			-- Is the device drawable?
		require
			exitst: not destroyed
		deferred
		end

feature -- Element change

	set_background_color (color: EV_COLOR) is
			-- Make `color' the new `background_color'
		require
			exists: not destroyed
			valid_color: is_valid (color)
		deferred
		ensure
			background_color_set: background_color.same (color)
		end

	set_foreground_color (color: EV_COLOR) is
			-- Make `color' the new `foreground_color'
		require
			exists: not destroyed
			valid_color: is_valid (color)
		deferred
		ensure
			foreground_color_set: foreground_color.same (color)
		end

	set_line_width (value: INTEGER) is
			-- Set line to be displayed with width of `new_width'.
		require
			exists: not destroyed
			valid_width: value > 0
		deferred
		ensure
			line_width_set: --To implement
		end

	set_logical_mode (value: INTEGER) is
			-- Set drawing logical function to `value'.
		require
			exists: not destroyed
			mode_big_enough: value >= 0
			mode_small_enough: value <= 15
		deferred
		ensure
			mode_set: --To implement
		end

	set_font (ft: EV_FONT) is
			-- Set a font.
		require
			exists: not destroyed
			valid_font: is_valid (ft)
		deferred
		ensure
			font_set: -- To implement
		end

feature -- Clearing operations

	clear is
			-- Clear the entire area.
		require
			exists: not destroyed
		deferred
		end

	clear_rect (left, top, right, bottom: INTEGER) is
			-- Clear the rectangular area defined by
			-- `left', `top', `right', `bottom'.
		deferred
		end

feature -- Drawing operations

	draw_point (pt: EV_POINT) is
			-- Draw a point at the position `pt'.
		require
			valid_point: pt /= Void
		deferred
		end

	draw_text (pt: EV_POINT; text: STRING) is
			-- Draw `text' at the position `pt'
		require
			vlid_text: text /= Void
			valid_point: pt /= Void
		deferred
		end

	draw_segment (pt1, pt2: EV_POINT) is
			-- Draw a segment between `pt1' and `pt2'.
		require
			valid_point1: pt1 /= Void
			valid_point2: pt2 /= Void
		deferred
		end

	draw_polyline (pts: ARRAY [EV_POINT]; is_closed: BOOLEAN) is
			-- Draw a polyline, close it automatically if `is_closed'.
		require
			points_exists: pts /= Void
			points_large_enough: not pts.empty
		deferred
		end

	draw_rectangle (pt: EV_POINT; w, h: INTEGER; orientation: REAL) is
			-- Draw a rectangle whose center is `pt' and size is `w' and `h'
			-- and that has the orientation `orientation'.
		require
			valid_point: pt /= Void
			width_positive: w >= 0
			height_positive: h >= 0
			orientation_small_enough: orientation >= 0
			orientation_large_enough: orientation < 360
		deferred
		end

	draw_arc (pt: EV_POINT; r1, r2: INTEGER; start_angle, aperture, orientation: REAL; style: INTEGER) is
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
		deferred
		end

	copy_pixmap (pt: EV_POINT; pix : EV_PIXMAP) is
			-- Copy `pix' into the drawable at the point `pt'.
			-- If there is not enough space to create auxiliery bitmap (DDB) 
			-- exception will be raised
		require
			valid_point: pt /= Void
			valid_pixmap: is_valid (pix)
		deferred
		end

feature -- filling operations

	fill_polygon (pts: ARRAY [EV_POINT]) is
			 -- Fill a polygon.
		require
			points_exists: pts /= Void
			points_large_enough: not pts.empty
		deferred
		end

	fill_rectangle (pt: EV_POINT; w, h: INTEGER; orientation: REAL) is
			-- Fill a rectangle whose center is `pt' and size is `w' and `h'
			-- with an orientation `orientation'.
		require
			valid_point: pt /= Void
			width_positive: w >= 0
			height_positive: h >= 0
			orientation_small_enough: orientation >= 0
			orientation_large_enough: orientation < 360
		deferred
		end

	fill_arc (pt: EV_POINT; r1, r2 : INTEGER; start_angle, aperture, orientation: REAL; style: INTEGER) is
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
		deferred
		end

end -- class EV_DRAWABLE_I

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
