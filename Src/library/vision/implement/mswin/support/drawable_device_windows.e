indexing 
	description: "An abstraction for anything which can be drawn on";
	status: "See notice at end of class"; 
	date: "$Date$"; 
	revision: "$Revision$" 
 
deferred class
	DRAWABLE_DEVICE_WINDOWS
  
inherit 
	W_MAN_GEN

	BUTTONS_MANAGER_WINDOWS

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

	draw_brush: WEL_BRUSH
			-- Brush details

	drawing_font: FONT
			-- Font used for drawing

feature -- Status report

	height: INTEGER is
			-- Height of the screen (in raster lines - would you believe it?)
		deferred
		end

	is_drawable: BOOLEAN is
			-- Is the device drawable?
		do
			Result := drawing_dc /= Void and then drawing_dc.exists
		end

	max_count_for_draw_polyline : INTEGER is
			-- Maximum value for `points.count' for `draw_polyline'
		do
			Result := 1000
		end

	width: INTEGER is
			-- Width of the screen (in pixels)
		deferred
		end

	x: INTEGER is
			-- Current absolute horizontal coordinate of the mouse
		deferred
		end
    
	y: INTEGER is
			-- Current absolute vertical coordinate of the mouse
		deferred
		end

feature -- Status setting

	set_background_gc_color (background_color: COLOR) is
			-- Set background value of GC.
		require
			color_not_void: background_color /= Void
		do
			gc_bg_color ?= background_color.implementation
			if drawing_dc /= Void then
				update_dc
				drawing_dc.set_background_color (gc_bg_color)
			end
		end 

	set_cap_style (cap_style: INTEGER)is
			-- Specifies the appearance of ends of line.
		require
			cap_style >= 0;
			cap_style <= 3
		do
			-- Can't change cap style in Windows
		end

	set_clip (a_clip: CLIP) is
			-- Set a clip area.
		require
			a_clip_exists: a_clip /= Void
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

	set_dash_pattern (a_dash: DASH) is
			-- Set pattern of dash lengths.
			-- Not implemented in Windows
		require
			a_dash_exists: a_dash /= Void
			a_dash_valid: not a_dash.is_empty
		do
		end

	set_drawing_font (a_font: FONT) is
			-- Set a font.
		require
			font_exists: a_font /= Void
		do
			drawing_font := a_font
			if drawing_dc /= Void then
				update_font
			end
		end

	set_fill_style (a_fill_style: INTEGER) is
			-- Set the style of fill.
		do
			fill_style := a_fill_style
			if is_drawable then
				update_brush
			end
		end

	set_foreground_gc_color (foreground_color: COLOR) is
			-- Set foreground value of GC.
		require
			color_not_void: foreground_color /= Void
		do
			gc_fg_color ?= foreground_color.implementation
			if is_drawable then
				update_pen
				update_brush
			end
		end

	set_join_style (join_style: INTEGER) is
			-- Specifies type appearance of joints between consecutive lines.
			-- Not implemented in Windows
		require
			join_style >= 0
			join_style <= 2
		do
		end

	set_line_style (a_line_style: INTEGER) is
			-- Set line style.
			-- Only 0 and 2 (1 = 2)
		require
			a_line_style >= 0
			a_line_style <= 2
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
			if drawing_dc /= Void then
				update_pen
			end
		end

	set_line_width (new_width: INTEGER) is
			-- Set line to be displayed with width of `new_width'.
		require
			width_large_enough: new_width >= 0
		do
			line_width := new_width
			if drawing_dc /= Void then
				update_pen
			end
		end

	line_width: INTEGER 
			-- Width of line for device.

	set_logical_mode (a_mode: INTEGER) is
			-- Set drawing logical function to `a_mode'.
		require
			a_mode >= 0
			a_mode <= 15
		do
			logical_mode := a_mode
			if (drawing_dc /= Void) and then (drawing_dc.exists )then
				update_dc
			end
		end

	logical_mode: INTEGER
			-- Drawing mode

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
					clip_list.count + 1 - clip_list.index
				until
					clip_list.after
				loop
					clip_list.forth
				end
				clip_list.go_to (c)
			end
		end

	set_stipple (a_stipple: PIXMAP) is
			-- Set stipple used to fill figures
		require
			a_stipple_exists: a_stipple /= Void
			a_stipple_valid: a_stipple.is_valid
		local
			pw: PIXMAP_IMP
			dib: WEL_DIB
			bitmap: WEL_BITMAP
		do
			pw ?= a_stipple.implementation
			check 
				pixmap_windows_exists: pw /= Void
			end
			dib := pw.dib
			if dib /= Void then
				!! bitmap.make_by_dib (drawing_dc, dib, dib_rgb_colors)
				!! draw_brush.make_by_pattern (bitmap)
				if drawing_dc /= Void then
					update_brush
				end
			end
		end

	set_subwindow_mode (mode: INTEGER) is
			-- Set the subwindow mode.
		do
			-- Not implemented
		end

	set_tile (a_tile: PIXMAP) is
			-- Set tile used to fill figures
		require
			a_tile_exists: a_tile /= Void
			a_tile_valid: a_tile.is_valid
		do
			set_stipple (a_tile)
		end

feature -- Input

	copy_bitmap (a_point: COORD_XY; a_bitmap : PIXMAP) is
			-- Copy `a_bitmap' to the drawing at `a_point'.
			-- If there is not enough space to create auxiliery bitmap (DDB) 
			-- exception will be raised
		require
			a_point_exists: a_point /= Void
			a_bitmap_exists: a_bitmap /= Void
			a_bitmap_valid: a_bitmap.is_valid
			drawing_dc_not_void: drawing_dc /= Void
			drawing_dc_exists: drawing_dc.exists
		local
			pw: PIXMAP_IMP
			bitmap: WEL_BITMAP
			dib: WEL_DIB
			icon: WEL_ICON
		do
			pw ?= a_bitmap.implementation
			check
				pixmap_windows: pw /= Void
			end
			dib := pw.dib
			if dib /= Void then
				!! bitmap.make_by_dib (drawing_dc, dib, dib_rgb_colors)
				if bitmap.item = bitmap.item.default then
					-- windows function "CreateDIBitmap" failed
					exception_raise("Cannot create windows bitmap");
				end
				drawing_dc.draw_bitmap (bitmap, a_point.x, a_point.y, bitmap.width, bitmap.height)
				bitmap.delete
			else
				icon := pw.icon
				if icon /= Void then
					drawing_dc.draw_icon (icon, a_point.x, a_point.y)
				end
			end
		end

	copy_pixmap (a_point: COORD_XY; a_pixmap : PIXMAP) is
			-- Copy `a_pixmap' to the drawing at `a_point'.
		require
			a_point_exists: a_point /= Void
			a_pixmap_exists: a_pixmap /= Void
			a_pixmap_valid: a_pixmap.is_valid
			drawing_dc_not_void: drawing_dc /= Void
			drawing_dc_exists: drawing_dc.exists
		do
			copy_bitmap (a_point, a_pixmap)
		end

feature -- Output

	clear is
			-- Clear the entire area.
		do
			clear_rect (0, 0, width, height)
		end

	clear_rect (a_left, a_top, a_right, a_bottom: INTEGER) is
			-- Clear the rectangular area defined by
			-- `a_left', `a_top', `a_right', `a_bottom'.
		local
			color_ref: WEL_COLOR_REF
			background_brush, old_brush: WEL_BRUSH
			background_pen, old_pen: WEL_PEN
			a_rect: WEL_RECT
			old_rop2: INTEGER
		do
			if is_drawable then
				if bg_color /= Void then
					color_ref := bg_color
				else
					!! color_ref.make_system (Color_window)
				end
				old_rop2 := drawing_dc.rop2
				old_brush := drawing_dc.brush
				old_pen := drawing_dc.pen
				drawing_dc.set_rop2 (r2_copypen)
				!! a_rect.make (0, 0, width, height)
				!! background_brush.make_solid (color_ref)
				!! background_pen.make (Ps_solid, 1, color_ref)
				drawing_dc.select_brush (background_brush)
				drawing_dc.select_pen (background_pen)
				drawing_dc.rectangle (a_left, a_top, a_right, a_bottom)
				drawing_dc.set_rop2 (old_rop2)
				if old_brush /= Void then
					drawing_dc.select_brush (old_brush)
				end
				if old_pen /= Void then
					drawing_dc.select_pen (old_pen)
				end
			end
		end

	draw_arc (center: COORD_XY; radius1, radius2: INTEGER; angle1, angle2, orientation: REAL; arc_style: INTEGER) is
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
			drawing_dc_not_void: drawing_dc /= Void
		do
			draw_any_arc (center, radius1, radius2, angle1, angle2, orientation, arc_style, false)
		end

	draw_image_text (base: COORD_XY; text: STRING) is
			-- Draw text
		require
			text_exists: text /= Void
			base_exists: base /= Void
			drawing_dc_not_void: drawing_dc /= Void
		do
			drawing_dc.set_text_color (gc_fg_color)
			drawing_dc.set_background_color (gc_bg_color)
			drawing_dc.set_background_transparent
			set_text_alignment
			drawing_dc.text_out (base.x, base.y, text)
		end

	set_text_alignment is
			-- Set the default text alignment.
		require
			drawing_dc_not_void: drawing_dc /= Void
		do
			drawing_dc.set_text_alignment (ta_baseline)
		end

	draw_inf_line (point1, point2: COORD_XY) is
			-- Draw an infinite line traversing `point1' and `point2'.
		require
			point1_exists: point1 /= Void
			point2_exists: point2 /= Void
			not_same_point: not (point1.x = point2.x and point1.y = point2.y)
			drawing_dc_not_void: drawing_dc /= Void
		local
			x1, x2, y1, y2, dx, dy: INTEGER
		do
			drawing_dc.line (point1.x, point1.x, point2.x, point2.y)
			dx := (x2 - x1)
			dy := (y2 - y1)
			if point1.y /= point2.y then
				x1 := point1.x + ((dx / dy) * point1.y).rounded
				x2 := point1.x + ((dx / dy) * (point1.y - height)).rounded
				y1 := 0
				y2 := height
			else
				y1 := point1.y + ((dy / dx) * point1.x).rounded
				y2 := point1.y + ((dy / dx) * (point1.x - width)).rounded
				x1 := 0
				x2 := width
			end
			drawing_dc.line (x1, y1, x2, y2)
		end

	draw_point (a_point: COORD_XY) is
			-- Draw `a_point'.
		require
			point_exists: a_point /= Void
			drawing_dc_not_void: drawing_dc /= Void
		do
			drawing_dc.set_pixel (a_point.x, a_point.y, gc_fg_color)
		end

	draw_polyline (points: LIST [COORD_XY]; is_closed: BOOLEAN) is
			-- Draw a polyline, close it automatically if `is_closed'.
		require
			points_exists: points /= Void
			list_not_empty: not points.is_empty;
			drawing_dc_not_void: drawing_dc /= Void
		local
			p_array: ARRAY [INTEGER]
			i: INTEGER
			c: CURSOR
		do
			if is_closed then
				!! p_array.make (1, 2 * points.count + 2)
			else
				!! p_array.make (1, 2 * points.count)
			end
			i := 1
			from
				c := points.cursor
				points.start
			variant
				points.count + 1 - points.index
			until
				points.after
			loop
				p_array.put (points.item.x, i)
				i := i + 1
				p_array.put (points.item.y, i)
				points.forth
				i := i + 1
			end
			if is_closed then
				points.start
				p_array.put (points.item.x, i)
				i := i + 1
				p_array.put (points.item.y, i)
			end
			points.go_to (c)
			drawing_dc.polyline (p_array)
		end

	draw_rectangle (center: COORD_XY; rwidth, rheight: INTEGER; an_orientation: REAL) is
			-- Draw a rectangle whose center is `center' and
			-- whose size is `rwidth' and `rheight'.
		require
			center_exists: center /= Void
			width_positive: rwidth >= 0;
			height_positive: rheight >= 0;
			an_orientation_positive: an_orientation >= 0;
			an_orientation_less_than_360: an_orientation < 360
			drawing_dc_not_void: drawing_dc /= Void
		do
			draw_any_rectangle (center, rwidth, rheight, an_orientation, false)
		end

	draw_segment (point1, point2: COORD_XY) is
			-- Draw a segment between `point1' and `point2'.
		require
			point1_exists: point1 /= Void
			point2_exists: point2 /= Void
			drawing_dc_not_void: drawing_dc /= Void
		do
			drawing_dc.move_to (point1.x, point1.y)
			drawing_dc.line_to (point2.x, point2.y)
		end

	draw_text (base: COORD_XY; text: STRING) is
			-- Draw text
		require
			text_exists: text /= Void
			base_exists: base /= Void
			drawing_dc_not_void: drawing_dc /= Void
		do
			drawing_dc.set_text_color (gc_fg_color)
			drawing_dc.set_background_transparent
			drawing_dc.set_text_alignment (ta_baseline)
			drawing_dc.text_out (base.x, base.y, text)
		end

	fill_arc (center: COORD_XY; radius1, radius2 : INTEGER; angle1, angle2, orientation: REAL; arc_style: INTEGER) is
			-- Fill an arc centered in (`x', `y') with a great radius of
			-- `radius1' and a small radius of `radius2'
			-- beginnning at `angle1' and finishing at `angle1'+`angle2'
			-- and with an orientation of `orientation'.
		require
			center_exits: center /= Void
			positive_radius1: radius1 >= 0;
			positive_radius2: radius2 >= 0;
			positive_angle1: angle1 >= 0;
			positive_angle2: angle2 >= 0;
			valid_total_angle: angle1 + angle2 <= 360;
			positive_orientation: orientation >= 0;
			orientation_small_enough: orientation < 360;
			valid_arc_style: arc_style >= 0 and arc_style <= 1
		do
			draw_any_arc (center, radius1, radius2, angle1, angle2, orientation, arc_style, true)
		end

	fill_polygon (points: LIST [COORD_XY]) is
			 -- Fill a polygon.
		require
			points_exists: points /= Void
			list_with_two_points_at_least: points.count >= 3;
			list_not_too_large: points.count <= max_count_for_draw_polyline
			drawing_dc_not_void: drawing_dc /= Void
		local
			p_array: ARRAY [INTEGER]
			i: INTEGER
			c: CURSOR
		do
			if drawing_dc /= Void then
				!! p_array.make (1, 2 * points.count)
				i := 1
				from
					c := points.cursor
					points.start
				variant
					points.count + 1 - points.index
				until
					points.after
				loop
					p_array.put (points.item.x, i)
					i := i + 1
					p_array.put (points.item.y, i)
					points.forth
					i := i + 1
				end
				points.go_to (c)
				drawing_dc.polygon (p_array)
			end
		end

	fill_rectangle (center: COORD_XY; rwidth, rheight : INTEGER; an_orientation: REAL) is
			-- Fill a rectangle whose center is `center' and
			-- whose size is `rwidth' and `rheight'.
		require
			center_exists: center /= Void
			width_positive: rwidth >= 0;
			height_positive: rheight >= 0;
			an_orientation_positive: an_orientation >= 0;
			an_orientation_less_than_360: an_orientation < 360
			drawing_dc_not_void: drawing_dc /= Void
		do
			draw_any_rectangle (center, rwidth, rheight, an_orientation, true)
		end 

feature -- Implementation

	draw_any_arc (center: COORD_XY; radius1, radius2: INTEGER; angle1, angle2, orientation: REAL; arc_style: INTEGER; filled: BOOLEAN) is
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
			drawing_dc_not_void: drawing_dc /= Void
			drawing_dc_exists: drawing_dc.exists
		local
			left, top, right, bottom, x_start_arc, y_start_arc,
			x_end_arc, y_end_arc: INTEGER
			local_arc_points: ARRAY [INTEGER]
		do
			left := center.x - radius1
			right := center.x + radius1
			top := center.y - radius2
			bottom := center.y + radius2
			x_start_arc := center.x + (radius1 * cosine (angle1 * Pi / 180)).rounded
			y_start_arc := center.y - (radius2 * sine (angle1 * Pi / 180)).rounded
			x_end_arc := center.x + (radius1 * cosine ((angle1 + angle2) * Pi / 180)).rounded
			y_end_arc := center.y - (radius2 * sine ((angle1 + angle2) * Pi / 180)).rounded
			if orientation = 0.0 then
				if not filled then
					drawing_dc.arc (left, top, right, bottom, x_start_arc, y_start_arc, x_end_arc, y_end_arc)
				else
					if arc_style = 0 then
						drawing_dc.chord (left, top, right+1, bottom+1, x_start_arc, y_start_arc, x_end_arc, y_end_arc)
					elseif arc_style = 1 then
						drawing_dc.pie (left, top, right+1, bottom+1, x_start_arc, y_start_arc, x_end_arc, y_end_arc)
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
				drawing_dc.polyline (local_arc_points)
			end
		end

	draw_any_rectangle (center: COORD_XY; rwidth, rheight: INTEGER; an_orientation: REAL; filled: BOOLEAN) is
			-- Draw a rectangle whose center is `center' and
			-- whose size is `rwidth' and `rheight', it may be `filled'.
		require
			center_exists: center /= Void
			width_positive: rwidth >= 0;
			height_positive: rheight >= 0;
			an_orientation_positive: an_orientation >= 0;
			an_orientation_less_than_360: an_orientation < 360
			drawing_dc_not_void: drawing_dc /= Void
			drawing_dc_exists: drawing_dc.exists
		local
			x1, x2, x3, x4, y1, y2, y3, y4, offset: INTEGER
			points: ARRAY [INTEGER]
			null_brush: WEL_NULL_BRUSH
		do
			if not filled then
				if drawing_dc.brush /= Void then
					drawing_dc.unselect_brush
				end
				!! null_brush.make
				drawing_dc.select_brush (null_brush)
			else
				offset := 1
			end
			if an_orientation = 0.0 or an_orientation = 180.0 then
				drawing_dc.rectangle (center.x - (rwidth // 2), center.y - (rheight // 2),
					center.x + (rwidth // 2)+offset, center.y + (rheight // 2)+offset)
			else
				x1 := center.x + (rwidth //2 * cosine (an_orientation * Pi / 180)).rounded
				y1 := center.y + (rheight //2 * sine (an_orientation * Pi / 180)).rounded
				x2 := center.x - (rwidth //2 * cosine (an_orientation * Pi / 180)).rounded
				y2 := center.y + (rheight //2 * sine (an_orientation * Pi / 180)).rounded
				x3 := center.x - (rwidth //2 * cosine (an_orientation * Pi / 180)).rounded
				y3 := center.y - (rheight //2 * sine (an_orientation * Pi / 180)).rounded
				x4 := center.x + (rwidth //2 * cosine (an_orientation * Pi / 180)).rounded
				y4 := center.y - (rheight //2 * sine (an_orientation * Pi / 180)).rounded
				!! points.make (1, 8)
				points.put (x1, 1)
				points.put (y1, 2)
				points.put (x2, 3)
				points.put (y2, 4)
				points.put (x3, 5)
				points.put (y3, 6)
				points.put (x4, 7)
				points.put (y4, 8)
				drawing_dc.polyline (points)
			end
			if not filled and draw_brush /= Void then
				drawing_dc.select_brush (draw_brush)
			end
		end

	drawing_dc: WEL_DC
			-- DC for drawing

	set_drawing_dc (dc: WEL_DC) is
			-- Set `drawing_dc' as necessary
		require
			no_drawing_dc: drawing_dc = Void or not drawing_dc.exists
		do
			drawing_dc := dc
			update_dc
			update_brush
			if drawing_font /= Void then
				update_font
			end
			update_pen
		end

	update_brush is
			-- Update the `drawing_dc' due to brush details changing
		require
			drawing_dc: drawing_dc /= Void and drawing_dc.exists
		do
			inspect fill_style
				when 0 then
					!! draw_brush.make_solid (gc_fg_color)
				when 1 then
				when 2 then
					drawing_dc.set_text_color (gc_fg_color)
					drawing_dc.set_background_color (gc_bg_color)
				when 3 then
					drawing_dc.set_text_color (gc_fg_color)
				end
			drawing_dc.select_brush (draw_brush)
		end

	update_dc is
			-- Update the `drawing_dc' due to dc details changing
		require
			drawing_dc: drawing_dc /= Void and drawing_dc.exists
		do
			debug ("RASTER OPERATIONS")
				print ("update_dc")
				print (logical_mode)
				print ("%N")
			end
				inspect
				logical_mode
			when 0 then
				drawing_dc.set_rop2 (r2_black)
			when 1 then
				drawing_dc.set_rop2 (r2_maskpen)
			when 2 then
				drawing_dc.set_rop2 (r2_maskpennot)
			when 3 then
				drawing_dc.set_rop2 (r2_copypen)
			when 4 then
				drawing_dc.set_rop2 (r2_masknotpen)
			when 5 then
				drawing_dc.set_rop2 (r2_nop)
			when 6 then
				drawing_dc.set_rop2 (r2_xorpen)
			when 7 then
				drawing_dc.set_rop2 (r2_mergepen)
			when 8 then
				drawing_dc.set_rop2 (r2_notmergepen)
			when 9 then
				drawing_dc.set_rop2 (r2_notxorpen)
			when 10 then
				drawing_dc.set_rop2 (r2_not)
			when 11 then
				drawing_dc.set_rop2 (r2_mergepennot)
			when 12 then
				drawing_dc.set_rop2 (r2_notcopypen)
			when 13 then
				drawing_dc.set_rop2 (r2_mergenotpen)
			when 14 then
				drawing_dc.set_rop2 (r2_notmaskpen)
			when 15 then
				drawing_dc.set_rop2 (r2_white)
			end
		end

	update_font is
			-- Update the `drawing_dc' due to font details changing
		require
			drawing_dc: drawing_dc /= Void and drawing_dc.exists
			drawing_font: drawing_font /= Void
		local
			fw: FONT_IMP
		do
			fw ?= drawing_font.implementation
			drawing_dc.select_font (fw.wel_font)
		end

	update_pen is
			-- Update the `drawing_dc' due to pen details changing
		require
			drawing_dc: drawing_dc /= Void and drawing_dc.exists
		local
			pen: WEL_PEN
		do
			!! pen.make (line_style, line_width, gc_fg_color)
			if drawing_dc.pen /= Void then
				drawing_dc.unselect_pen
			end
			drawing_dc.select_pen (pen)
		end

	unset_drawing_dc is
			-- Return `drawing_dc' to original state
		require
			drawing_dc_exists: drawing_dc /= Void and drawing_dc.exists
		do
			drawing_dc.unselect_all
			drawing_dc := Void	
		end

feature {NONE} -- Implementation

	line_style: INTEGER
			-- Style of a line

	bg_color: WEL_COLOR_REF
			-- Background color

	gc_bg_color: WEL_COLOR_REF
			-- Background color for the GC

	gc_fg_color: WEL_COLOR_REF
			-- Foreground color

	fill_style: INTEGER
			-- Style to fill figures

	clip_list: LINKED_LIST [POINTER]
			-- List of clipping areas

	arc_points (center: COORD_XY; radius1, radius2: INTEGER; 
				angle1, angle2, orientation: REAL): ARRAY [INTEGER] is
			-- Returns the list of an arbitrary number of ordonated points composing the arc
		local
			nb_fracs, loop_angle, angle_inc, sino, coso, ell_x, ell_y, rot_x, rot_y: DOUBLE
			segment_count, i, center_x, center_y: INTEGER
		do
			coso := cosine (- orientation * deg_rad_rate)
			sino := sine (- orientation * deg_rad_rate)
			center_x := center.x
			center_y := center.y
			nb_fracs := 4 * radius1.max(radius2) * angle2 * deg_rad_rate
			segment_count := nb_fracs.rounded
			angle_inc := - angle2 * deg_rad_rate / segment_count
			loop_angle := angle1
			if loop_angle < 180 then
				loop_angle := - loop_angle
			end
			!!Result.make (1, 2 * (segment_count + 1))
			from
				i := 0
			until
				i > segment_count
			loop
				ell_x := radius1 * cosine (loop_angle)
				ell_y := radius2 * sine (loop_angle)
				rot_x := center_x + ell_x * coso - ell_y * sino
				rot_y := center_y + ell_x * sino + ell_y * coso
				Result.put (rot_x.rounded, 2 * i + 1)
				Result.put (rot_y.rounded, 2 * i + 2)
				loop_angle := loop_angle + angle_inc
				i := i + 1
			end
		end

	deg_rad_rate: DOUBLE is
			-- degrees into radians conversion constant
		once
			Result := Pi / 180
		end

end -- class DRAWABLE_DEVICE_WINDOWS
 

--|----------------------------------------------------------------
--| EiffelVision: library of reusable components for ISE Eiffel.
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

