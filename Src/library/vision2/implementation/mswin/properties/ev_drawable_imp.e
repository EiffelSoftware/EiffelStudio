indexing
	description: "EiffelVision drawable area. Mswindows implementation."
	status: "See notice at end of class"
	id: "$Id$"
	date: "$Date$"
	revision: "$Revision$"

deferred class
	EV_DRAWABLE_IMP

inherit
	EV_DRAWABLE_I

	WEL_DIB_COLORS_CONSTANTS
		export
			{NONE} all
		end

	WEL_ROP2_CONSTANTS
		export
			{NONE} all
		end

	WEL_TA_CONSTANTS
		export
			{NONE} all
		end

	WEL_WINDOWS_ROUTINES
		export
			{NONE} all
		end

	WEL_COLOR_CONSTANTS
		export
			{NONE} all
		end

	WEL_PS_CONSTANTS
		export
			{NONE} all
		end

	WEL_BRUSH_STYLE_CONSTANTS
		export
			{NONE} all
		end

	WEL_HS_CONSTANTS
		export
			{NONE} all
		end

	DOUBLE_MATH
		export
			{NONE} all
		end

	MATH_CONST
		export
			{NONE} all
		end

	EXCEPTIONS
		rename
			raise as exception_raise,
			class_name as exception_class_name
		end

feature -- Access

	dc: WEL_DC is
			-- DC for drawing
		deferred
		end

	foreground_color: EV_COLOR is
			-- Current foreground color
		do
			if foreground_color_imp /= Void then
				Result ?= foreground_color_imp.interface
			else
				Result := Void
			end
		end

	background_color: EV_COLOR is
			-- Current background color
		local
			wel: WEL_COLOR_REF
		do
			wel := dc.background_color
			if wel /= Void then
				!! Result.make_rgb (wel.red, wel.green, wel.blue)
			else
				Result := Void
			end
		end

	line_width: INTEGER 
			-- Width of line for device.

	logical_mode: INTEGER
			-- Drawing mode

feature -- Measurement

	width: INTEGER is
			-- Width of the widget
		deferred
		end

	height: INTEGER is
			-- Height of the widget
		deferred
		end

feature -- Status report

	is_drawable: BOOLEAN is
			-- Is the device drawable?
		do
			Result := dc /= Void and then dc.exists
		end

feature -- Element change

	set_background_color (color: EV_COLOR) is
			-- Set background value of GC.
		local
			color_imp: EV_COLOR_IMP
		do
			color_imp ?= color.implementation
			check
				valid_cast: color_imp /= Void
			end
			if dc /= Void then
				update_dc
				dc.set_background_color (color_imp)
			end
		end 

	set_foreground_color (color: EV_COLOR) is
			-- Set foreground value of GC.
		do
			foreground_color_imp ?= color.implementation
			check
				valid_cast: foreground_color_imp /= Void
			end
			if is_drawable then
				update_pen
				update_brush
			end
		end

	set_line_width (value: INTEGER) is
			-- Set line to be displayed with width of `value'.
		do
			line_width := value
			if dc /= Void then
				update_pen
			end
		end

	set_logical_mode (value: INTEGER) is
			-- Set drawing logical function to `value'.
		do
			logical_mode := value
			if (dc /= Void) and then (dc.exists) then
				update_dc
			end
		end

	set_font (a_font: EV_FONT) is
			-- Set a font.
		do
			font := a_font
			if dc /= Void then
				update_font
			end
		end

feature -- Clearing operations

	clear is
			-- Clear the entire area.
		do
			clear_rect (0, 0, width, height)
		end

	clear_rect (a_left, a_top, a_right, a_bottom: INTEGER) is
			-- Clear the rectangular area defined by
			-- `a_left', `a_top', `a_right', `a_bottom'.
		local
			old_rop2: INTEGER
			old_brush: WEL_BRUSH
			old_pen: WEL_PEN
			a_rect: WEL_RECT
		do
			if is_drawable then
				-- We store the old values.
				old_rop2 := dc.rop2
				old_brush := dc.brush
				old_pen := dc.pen

				-- We set the new values
				dc.set_rop2 (r2_copypen)
				dc.select_brush (background_brush)
				dc.select_pen (background_pen)

				-- We clear the area.
				!! a_rect.make (0, 0, width, height)
				dc.rectangle (a_left, a_top, a_right, a_bottom)

				-- We reset the old values
				dc.set_rop2 (old_rop2)
				if old_brush /= Void then
					dc.select_brush (old_brush)
				end
				if old_pen /= Void then
					dc.select_pen (old_pen)
				end
			end
		end

feature -- Drawing operations

	draw_point (pt: EV_COORDINATES) is
			-- Draw `a_point'.
		require else
			dc_not_void: dc /= Void
		do
			dc.set_pixel (pt.x, pt.y, foreground_color_imp)
		end

	draw_text (pt: EV_COORDINATES; text: STRING) is
			-- Draw text
		require else
			dc_not_void: dc /= Void
		do
			dc.set_text_color (foreground_color_imp)
			dc.set_background_transparent
			dc.set_text_alignment (ta_baseline)
			dc.text_out (pt.x, pt.y, text)
		end

	draw_segment (pt1, pt2: EV_COORDINATES) is
			-- Draw a segment between `pt1' and `pt2'.
		require else
			dc_not_void: dc /= Void
		do
			dc.move_to (pt1.x, pt1.y)
			dc.line_to (pt2.x, pt2.y)
		end

	draw_straight_line (point1, point2: EV_COORDINATES) is
			-- Draw an infinite line traversing `point1' and `point2'.
		require else
			dc_not_void: dc /= Void
		local
			x1, x2, y1, y2, dx, dy: INTEGER
		do
			dx := (point2.x - point1.x)
			dy := (point2.y - point1.y)
			if point1.y /= point2.y then
				x1 := point1.x - ((dx / dy) * point1.y).rounded
				x2 := point1.x - ((dx / dy) * (point1.y - height)).rounded
				y1 := 0
				y2 := height
			else
				y1 := point1.y - ((dy / dx) * point1.x).rounded
				y2 := point1.y - ((dy / dx) * (point1.x - width)).rounded
				x1 := 0
				x2 := width
			end
			dc.line (x1, y1, x2, y2)
		end

	draw_polyline (pts: ARRAY [EV_COORDINATES]; is_closed: BOOLEAN) is
			-- Draw a polyline, close it automatically if `is_closed'.
		require else
			dc_not_void: dc /= Void
		local
			flat_points: ARRAY [INTEGER]
			flat_index: INTEGER
			i: INTEGER
			c: CURSOR
		do
			if is_closed then
				!! flat_points.make (1, 2 * pts.count + 2)
			else
				!! flat_points.make (1, 2 * pts.count)
			end
			flat_index := 1
			from
				i := pts.lower
			until
				i > pts.upper
			loop
				flat_points.put ((pts.item (i)).x, flat_index)
				flat_index := flat_index + 1
				flat_points.put ((pts.item (i)).y, flat_index)
				i := i + 1
				flat_index := flat_index + 1
			end
			if is_closed then
				i := pts.lower
				flat_points.put ((pts.item (i)).x, flat_index)
				flat_index := flat_index + 1
				flat_points.put ((pts.item (i)).y, flat_index)
			end
			dc.polyline (flat_points)
		end

	draw_rectangle (pt: EV_COORDINATES; w, h: INTEGER; orientation: REAL) is
			-- Draw a rectangle whose center is `pt' and size is `w' and `h'
			-- and that has the orientation `orientation'.
		require else
			dc_not_void: dc /= Void
		do
			draw_any_rectangle (pt, w, h, orientation, false)
		end

	draw_arc (pt: EV_COORDINATES; r1, r2: INTEGER; start_angle, aperture, orientation: REAL; style: INTEGER) is
			-- Draw an arc centered in `pt' with a great radius of `r1' and a small radius
			-- of `r2' beginnning at `start_angle' and finishing at `start_angle + aperture'
			-- and with an orientation of `orientation' using the style `style'.
			-- The meaning of the style is the following :
			--   -1 : no link between the first and the last point
			--    0 : the first point is linked to the last point
			--    1 : the first and the last point are linked to the center `pt'
		require else
			dc_not_void: dc /= Void
		do
			draw_any_arc (pt, r1, r2, start_angle, aperture, orientation, style, false)
		end

	draw_pixmap (pt: EV_COORDINATES; pix : EV_PIXMAP) is
			-- Copy `pix' into the drawable at the point `pt'.
		local
			pix_imp: EV_PIXMAP_IMP
		do
			pix_imp ?= pix.implementation
			check
				valid_cast: pix_imp /= Void
			end
			dc.draw_bitmap (pix_imp.dc.bitmap, pt.x, pt.y, pix_imp.width, pix_imp.height)
		end

feature -- Filling operations

	fill_polygon (pts: ARRAY [EV_COORDINATES]) is
			 -- Fill a polygon.
		require else
			dc_not_void: dc /= Void
		local
			flat_points: ARRAY [INTEGER]
			i, flat_i: INTEGER
		do
			if dc /= Void then
				!! flat_points.make (1, 2 * pts.count)
				flat_i := 1
				from
					i := pts.lower
				until
					i > pts.upper
				loop
					flat_points.put ((pts.item (i)).x, flat_i)
					flat_i := flat_i + 1
					flat_points.put ((pts.item (i)).y, flat_i)
					flat_i := flat_i + 1
					i := i + 1
				end
				dc.polygon (flat_points)
			end
		end

	fill_rectangle (pt: EV_COORDINATES; w, h: INTEGER; orientation: REAL) is
			-- Fill a rectangle whose center is `pt' and size is `w' and `h'
			-- with an orientation `orientation'.
		require else
			dc_not_void: dc /= Void
		do
			draw_any_rectangle (pt, w, h, orientation, true)
		end 

	fill_arc (pt: EV_COORDINATES; r1, r2 : INTEGER; start_angle, aperture, orientation: REAL; style: INTEGER) is
			-- Fill an arc centered in `pt' with a great radius of `r1' and a small radius
			-- of `r2' beginnning at `start_angle' and finishing at `start_angle + aperture'
			-- and with an orientation of `orientation' using the style `style'.
			-- The meaning of the style is the following :
			--   -1 : no link between the first and the last point
			--    0 : the first point is linked to the last point
			--    1 : the first and the last point are linked to the center `pt'
		do
			draw_any_arc (pt, r1, r2, start_angle, aperture, orientation, style, true)
		end

feature {NONE} -- Implementation access

	brush: WEL_BRUSH
			-- Brush details

	font: EV_FONT
			-- Font used for drawing

	line_style: INTEGER
			-- Style of a line

	fill_style: INTEGER
			-- Style to fill figures

	clip_list: LINKED_LIST [POINTER]
			-- List of clipping areas

	foreground_color_imp: EV_COLOR_IMP
			-- Color used for the foreground of the drawable,
			-- used for the text and the drawings.

feature {NONE} -- Implementation

	background_brush: WEL_BRUSH is
			-- Brush used to paint the background.
			-- Need to be redefine to appear white.
		do
			if dc /= Void then
				!! Result.make_solid (dc.background_color)
			else
				Result := Void
			end
		end

	background_pen: WEL_PEN is
			-- Pen used to paint the background.
		do
			!! Result.make (ps_solid, 1, dc.background_color)
		end

	update_brush is
			-- Update the `dc' due to brush details changing
		require
			dc: dc /= Void and dc.exists
		do
			inspect fill_style
				when 0 then
					!! brush.make_solid (foreground_color_imp)
				when 1 then
				when 2 then
					dc.set_text_color (foreground_color_imp)
				when 3 then
					dc.set_text_color (foreground_color_imp)
				end
			dc.select_brush (brush)
		end

	update_dc is
			-- Update the `dc' due to dc details changing
		require
			dc: dc /= Void and dc.exists
		do
			debug ("RASTER OPERATIONS")
				print ("update_dc")
				print (logical_mode)
				print ("%N")
			end
				inspect
				logical_mode
			when 0 then
				dc.set_rop2 (r2_black)
			when 1 then
				dc.set_rop2 (r2_maskpen)
			when 2 then
				dc.set_rop2 (r2_maskpennot)
			when 3 then
				dc.set_rop2 (r2_copypen)
			when 4 then
				dc.set_rop2 (r2_masknotpen)
			when 5 then
				dc.set_rop2 (r2_nop)
			when 6 then
				dc.set_rop2 (r2_xorpen)
			when 7 then
				dc.set_rop2 (r2_mergepen)
			when 8 then
				dc.set_rop2 (r2_notmergepen)
			when 9 then
				dc.set_rop2 (r2_notxorpen)
			when 10 then
				dc.set_rop2 (r2_not)
			when 11 then
				dc.set_rop2 (r2_mergepennot)
			when 12 then
				dc.set_rop2 (r2_notcopypen)
			when 13 then
				dc.set_rop2 (r2_mergenotpen)
			when 14 then
				dc.set_rop2 (r2_notmaskpen)
			when 15 then
				dc.set_rop2 (r2_white)
			end
		end

	update_font is
			-- Update the `dc' due to font details changing
		require
			dc: dc /= Void and dc.exists
			font: font /= Void
		local
			fw: EV_FONT_IMP
		do
			fw ?= font.implementation
			dc.select_font (fw.wel_font)
		end

	update_pen is
			-- Update the `dc' due to pen details changing
		require
			dc: dc /= Void and dc.exists
		local
			pen: WEL_PEN
		do
			!! pen.make (line_style, line_width, foreground_color_imp)
			if dc.pen /= Void then
				dc.unselect_pen
			end
			dc.select_pen (pen)
		end

--	set_dc (dc: like dc) is
--			-- Set `dc' as necessary
--		require
--			no_dc: dc = Void or not dc.exists
--		do
--			dc := dc
--			update_dc
--			update_brush
--			if font /= Void then
--				update_font
--			end
--			update_pen
--		end

--	unset_dc is
--			-- Return `dc' to original state
--		require
--			dc_exists: dc /= Void and dc.exists
--		do
--			dc.unselect_all
--			dc := Void	
--		end

feature {NONE} -- Basic operations

	draw_any_rectangle (center: EV_COORDINATES; rw, rh: INTEGER; an_orientation: REAL; filled: BOOLEAN) is
			-- Draw a rectangle whose center is `center' and
			-- whose size is `rwidth' and `rheight', it may be `filled'.
		require
			center_exists: center /= Void
			width_positive: rw >= 0;
			height_positive: rh >= 0;
			an_orientation_positive: an_orientation >= 0;
			an_orientation_less_than_360: an_orientation < 360
			dc_not_void: dc /= Void
			dc_exists: dc.exists
		local
			x, y, offset: INTEGER
			cos, sin: REAL
			points: ARRAY [INTEGER]
			null_brush: WEL_NULL_BRUSH
		do
			if not filled then
				if dc.brush /= Void then
					dc.unselect_brush
				end
				!! null_brush.make
				dc.select_brush (null_brush)
			else
				offset := 1
			end
			if an_orientation = 0.0 or an_orientation = 180.0 then
				dc.rectangle (center.x - (rw // 2), center.y + (rh // 2),
					center.x + (rw // 2) + offset, center.y - (rh // 2) + offset)
			else
				!! points.make (1, 10)
				sin := sine (an_orientation * deg_to_rad)
				cos := cosine (an_orientation * deg_to_rad)
				x := ((rh * sin + rw * cos) / 2).rounded
				y := ((rh * cos - rw * sin) / 2).rounded
				points.put (center.x + x, 1)
				points.put (center.y + y, 2)
				points.put (center.x - x, 5)
				points.put (center.y - y, 6)
				points.put (center.x + x, 9)
				points.put (center.y + y, 10)
				x := ((rh * sin - rw * cos) / 2).rounded
				y := ((rh * cos + rw * sin) / 2).rounded
				points.put (center.x + x, 3)
				points.put (center.y + y, 4)
				points.put (center.x - x, 7)
				points.put (center.y - y, 8)
				dc.polyline (points)
			end
			if not filled and brush /= Void then
				dc.select_brush (brush)
			end
		end

	draw_any_arc (center: EV_COORDINATES; radius1, radius2: INTEGER; angle1, angle2, orientation: REAL; arc_style: INTEGER; filled: BOOLEAN) is
			-- Draw an arc centered in (`x', `y') with a great radius of
			-- `radius1' and a small radius of `radius2'
			-- beginnning at `angle1' and finishing at `angle1'+`angle2'
			-- and with an orientation of `orientation'.
		require
			center_exists: center /= Void
			positive_radius1: radius1 >= 0;
			positive_radius2: radius2 >= 0;
			positive_angle1: angle1 >= 0;
			positive_angle2: angle2 >= 0;
			valid_total_angle: angle1+angle2 <= 360;
			positive_orientation: orientation >= 0;
			orientation_small_enough: orientation < 360;
			valid_arc_style: arc_style >= -1 and arc_style <= 1
			dc_not_void: dc /= Void
			dc_exists: dc.exists
		local
			left, top, right, bottom, x_start_arc, y_start_arc,
			x_end_arc, y_end_arc: INTEGER
			null_brush: WEL_NULL_BRUSH
			local_arc_points: ARRAY [INTEGER]
		do
			if orientation = 0.0 then
				left := center.x - radius1
				right := center.x + radius1
				top := center.y - radius2
				bottom := center.y + radius2
				x_start_arc := center.x + (radius1 * cosine (angle1 * Pi / 180)).rounded
				y_start_arc := center.y - (radius2 * sine (angle1 * Pi / 180)).rounded
				x_end_arc := center.x + (radius1 * cosine ((angle1 + angle2) * Pi / 180)).rounded
				y_end_arc := center.y - (radius2 * sine ((angle1 + angle2) * Pi / 180)).rounded
				if not filled then
					dc.arc (left, top, right, bottom, x_start_arc, y_start_arc, x_end_arc, y_end_arc)
				else
					if arc_style = 0 then
						dc.chord (left, top, right+1, bottom+1, x_start_arc, y_start_arc, x_end_arc, y_end_arc)
					elseif arc_style = 1 then
						dc.pie (left, top, right+1, bottom+1, x_start_arc, y_start_arc, x_end_arc, y_end_arc)
					end
				end
			else
				local_arc_points := arc_points (center, radius1, radius2, angle1, angle2, orientation);
				if arc_style = 0 then
					local_arc_points.force (local_arc_points @ 1, local_arc_points.upper  + 1)
					local_arc_points.force (local_arc_points @ 2, local_arc_points.upper + 1)
				elseif arc_style = 1 then
					local_arc_points.force (center.x, local_arc_points.upper + 1)
					local_arc_points.force (center.y, local_arc_points.upper + 1)
					local_arc_points.force (local_arc_points @ 1, local_arc_points.upper + 1)
					local_arc_points.force (local_arc_points @ 2, local_arc_points.upper + 1)
				end;
				dc.polyline (local_arc_points)
			end
		end

	arc_points (center: EV_COORDINATES; radius1, radius2: INTEGER; 
				angle1, angle2, orientation: REAL): ARRAY [INTEGER] is
			-- Returns the list of an arbitrary number of ordonated points composing the arc
		local
			nb_fracs, loop_angle, angle_inc, sino, coso, ell_x, ell_y, rot_x, rot_y: DOUBLE
			segment_count, i, center_x, center_y: INTEGER
		do
			coso := cosine (orientation * deg_to_rad)
			sino := sine (orientation * deg_to_rad)
			center_x := center.x
			center_y := center.y
			nb_fracs := 4 * radius1.max(radius2) * angle2 * deg_to_rad
			segment_count := nb_fracs.rounded
			angle_inc := angle2 * deg_to_rad / segment_count
			loop_angle := angle1
			!!Result.make (1, 2 * (segment_count + 1))
			from
				i := 0
			until
				i > segment_count
			loop
				ell_x := radius1 * cosine (loop_angle)
				ell_y := radius2 * sine (loop_angle)
				rot_x := center_x + ell_x * coso + ell_y * sino
				rot_y := center_y - ell_x * sino + ell_y * coso
				Result.put (rot_x.rounded, 2 * i + 1)
				Result.put (rot_y.rounded, 2 * i + 2)
				loop_angle := loop_angle + angle_inc
				i := i + 1
			end
		end

	deg_to_rad: DOUBLE is
			-- degrees into radians conversion constant
		once
			Result := Pi / 180
		end

feature {NONE} -- To check -- Temp

	set_no_clip is
			-- Remove all clip area.
		local
			c: CURSOR
		do
			if clip_list /= Void then
				from
					c:= clip_list.cursor
					clip_list.start
				variant
					clip_list.count - clip_list.index
				until
					clip_list.after
				loop
					clip_list.forth
				end
				clip_list.go_to (c)
			end
		end

-- 	set_text_alignment is
 --			-- Set the default text alignment.
 --		require
 --			dc_not_void: dc /= Void
 --		do
 --			dc.set_text_alignment (ta_baseline)
 --		end

	set_clip (a_clip: EV_CLIP) is
			-- Set a clip area.
		local
			x1, y1, x2, y2: INTEGER
		do
			if clip_list = Void then
				!! clip_list.make
			end
			x1 := a_clip.upper_left.x
			y1 := a_clip.upper_left.y
			x2 := a_clip.width - a_clip.upper_left.x
			y2 := a_clip.height - a_clip.upper_left.y
		end

	set_fill_style (a_fill_style: INTEGER) is
			-- Set the style of fill.
		do
			fill_style := a_fill_style
			if is_drawable then
				update_brush
			end
		end

	set_line_style (a_line_style: INTEGER) is
			-- Set line style.
			-- Only 0 and 2 (1 = 2)
		do
			if a_line_style = 0 then -- Solid
				line_style := 0
			else
				line_style := 2
				-- Windows does not permit a dashed line
				-- when width > 1
				if line_width > 1 then
					line_width := 1
				end
			end
			if dc /= Void then
				update_pen
			end
		end

	set_stipple (a_stipple: EV_PIXMAP) is
			-- Set stipple used to fill figures
		local
			pw: EV_PIXMAP_IMP
			dib: WEL_DIB
--			bitmap: WEL_BITMAP
		do
--			pw ?= a_stipple.implementation
--			check 
--				pixmap_windows_exists: pw /= Void
--			end
--			!! brush.make_by_pattern (pw.bitmap)
--			if dc /= Void then
--				update_brush
--			end
---			dib := pw.dib
--			if dib /= Void then
--				!! bitmap.make_by_dib (dc, dib, dib_rgb_colors)
--				!! brush.make_by_pattern (bitmap)
--				if dc /= Void then
--					update_brush
--				end
--			end
		end

	set_tile (a_tile: EV_PIXMAP) is
			-- Set tile used to fill figures
		local
			a_color: WEL_COLOR_REF
		do
			set_stipple (a_tile)
		end

	copy_pixmap (a_point: EV_COORDINATES; a_pixmap: EV_PIXMAP) is
			-- Copy `a_pixmap' to the drawing at `a_point'.
			-- If there is not enough space to create auxiliery bitmap (DDB) 
			-- exception will be raised
		require else
			dc_not_void: dc /= Void
			dc_exists: dc.exists
		local
--			pw: EV_PIXMAP_IMP
--			bitmap: WEL_BITMAP
--			dib: WEL_DIB
--			icon: WEL_ICON
		do
--			pw ?= a_pixmap.implementation
--			check
--				pixmap_windows: pw /= Void
--			end
--			if pw.bitmap.item = pw.bitmap.item.default then
---				-- windows function "CreateDIBitmap" failed
--				exception_raise("Can not create windows bitmap");
--			end
--			dc.draw_bitmap (pw.bitmap, a_point.x, a_point.y, pw.width, pw.height)
---			pw.destroy

----			dib := pw.dib
----			if dib /= Void then
----				!! bitmap.make_by_dib (dc, dib, dib_rgb_colors)
----				if bitmap.item = bitmap.item.default then
----					-- windows function "CreateDIBitmap" failed
----					exception_raise("Can not create windows bitmap");
----				end
----				dc.draw_bitmap (bitmap, a_point.x, a_point.y, bitmap.width, bitmap.height)
----				bitmap.delete
----			else
----				icon := pw.icon
----				if icon /= Void then
----					dc.draw_icon (icon, a_point.x, a_point.y)
----				end
----			end
		end

end -- class EV_DRAWABLE_IMP

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
