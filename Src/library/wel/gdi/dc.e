indexing
	description: "General notion of a device context."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

deferred class
	WEL_DC

inherit
	WEL_ANY

	WEL_DT_CONSTANTS
		export
			{NONE} all
		end

	WEL_RASTER_OPERATIONS_CONSTANTS
		export
			{NONE} all
		end

feature -- Access

	pen: WEL_PEN
			-- Current pen selected

	brush: WEL_BRUSH
			-- Current brush selected

	palette: WEL_PALETTE
			-- Current palette selected

	region: WEL_REGION
			-- Current region selected

	font: WEL_FONT
			-- Current font selected

	bitmap: WEL_BITMAP
			-- Current bitmap selected

feature -- Status report

	pen_selected: BOOLEAN is
			-- Is a pen selected?
		do
			Result := pen /= Void
		end

	brush_selected: BOOLEAN is
			-- Is a brush selected?
		do
			Result := brush /= Void
		end

	palette_selected: BOOLEAN is
			-- Is a palette selected?
		do
			Result := palette /= Void
		end

	region_selected: BOOLEAN is
			-- Is a region selected?
		do
			Result := region /= Void
		end

	font_selected: BOOLEAN is
			-- Is a font selected?
		do
			Result := font /= Void
		end

	bitmap_selected: BOOLEAN is
			-- Is a bitmap selected?
		do
			Result := bitmap /= Void
		end

	is_transparent: BOOLEAN is
			-- Does the background mode is transparent?
		require
			exists: exists
		do
			Result := cwin_get_bk_mode (item) = Transparent
		end

	is_opaque: BOOLEAN is
			-- Does the background mode is opaque?
		require
			exists: exists
		do
			Result := cwin_get_bk_mode (item) = Opaque
		end

	background_color: WEL_COLOR_REF is
		require
			exists: exists
		do
			!! Result.make_by_pointer (cwin_get_bk_color (item))
		ensure
			result_not_void: Result /= Void
			result_exists: Result.exists
		end

	text_color: WEL_COLOR_REF is
		require
			exists: exists
		do
			!! Result.make_by_pointer (cwin_get_text_color (item))
		ensure
			result_not_void: Result /= Void
			result_exists: Result.exists
		end

	rop2: INTEGER is
			-- Current drawing mode
		require
			exists: exists
		do
			Result := cwin_get_rop2 (item)
		end

	pixel_color (x, y: INTEGER): WEL_COLOR_REF is
			-- Color located at `x', `y' position
		require
			exists: exists
		do
			!! Result.make_by_pointer (cwin_get_pixel (item, x, y))
		ensure
			result_not_void: Result /= Void
			result_exists: Result.exists
		end

	viewport_origin: WEL_POINT is
			-- Viewport origin for the dc
		require
			exists: exists
		do
			!! Result.make (0, 0)
			cwin_get_viewport_org_ex (item, Result.item)
		ensure
			result_not_void: Result /= Void
		end

	viewport_extent: WEL_SIZE is
			-- Retrieve the size of the current viewport for the dc.
		require
			exists: exists
		do
			!! Result.make (0, 0)
			cwin_get_viewport_ext_ex (item, Result.item)
		ensure
			result_not_void: Result /= Void
		end

	window_origin: WEL_POINT is
			-- Window origin for the dc
		require
			exists: exists
		do
			!! Result.make (0, 0)
			cwin_get_window_org_ex (item, Result.item)
		ensure
			result_not_void: Result /= Void
		end

	window_extent: WEL_SIZE is
			-- Window extent for the dc
		require
			exists: exists
		do
			!! Result.make (0, 0)
			cwin_get_window_ext_ex (item, Result.item)
		ensure
			result_not_void: Result /= Void
		end

	position: WEL_POINT is
			-- Current position in logical coordinates
		require
			exists: exists
		do
			!! Result.make (0, 0)
			cwin_get_current_position_ex (item, Result.item)
		ensure
			result_exists: Result /= Void
		end

	string_size (s: STRING): WEL_SIZE is
			-- Size of the string `s' using the selected font
		require
			exists: exists
			s_exists: s /= Void
		local
			a: ANY
		do
			a := s.to_c
			!! Result.make (0, 0)
			cwin_get_text_extend_point (item, $a, s.count,
				Result.item)
		ensure
			result_exists: Result /= Void
			positive_width: Result.width >= 0
			positive_height: Result.height >= 0
		end

	string_width (s: STRING): INTEGER is
			-- Width of the string `s' using the selected font
		require
			exists: exists
			s_exists: s /= Void
		do
			Result := string_size (s).width
		ensure
			positive_result: Result >= 0
		end

	string_height (s: STRING): INTEGER is
			-- Height of the string `s' using the selected font
		require
			exists: exists
			s_exists: s /= Void
		do
			Result := string_size (s).height
		ensure
			positive_result: Result >= 0
		end

	device_caps (capability: INTEGER): INTEGER is
			-- Give device-specific information about
			-- the current display device.
			-- See class WEL_CAPABILITIES_CONSTANTS for
			-- `capability' values and results.
		require
			exists: exists
		do
			Result := cwin_device_caps (item, capability)
		end

	map_mode: INTEGER is
			-- Current mapping mode
		require
			exists: exists
		do
			Result := cwin_get_map_mode (item)
		end

feature -- Status setting

	set_map_mode (mode: INTEGER) is
			-- Set the mapping mode `mode' of the device context.
		require
			exists: exists
		do
			cwin_set_map_mode (item, mode)
		ensure
			map_mode_set: map_mode = mode
		end

	set_window_extent (x_extent, y_extent: INTEGER) is
			-- Set the `x_extent' and `y_extent' of the window
			-- associated with the device context
		require
			exists: exists
		do
			cwin_set_window_ext_ex (item, x_extent, y_extent,
				default_pointer)
		end

	set_window_origin (x_origin, y_origin: INTEGER) is
			-- Set the `x_origin' and `y_origin' of the window
			-- associated with the device context
		require
			exists: exists
		do
			cwin_set_window_ext_ex (item, x_origin, y_origin,
				default_pointer)
		end

	set_viewport_extent (x_extent, y_extent: INTEGER) is
			-- Set the `x_extent' and `y_extent' of the viewport
			-- associated with the device context
		require
			exists: exists
		do
			cwin_set_viewport_ext_ex (item, x_extent, y_extent,
				default_pointer)
                end

	set_viewport_origin (x_origin, y_origin: INTEGER) is
			-- Set the `x_origin' and `y_origin' of the viewport
			-- associated with the device context
		require
			exists: exists
		do
			cwin_set_viewport_org_ex (item, x_origin, y_origin,
				default_pointer)
		end

	set_bk_color (color: WEL_COLOR_REF) is
			-- Set the `background_color' to `color'
		require
			exists: exists
			color_not_void: color /= Void
			color_exists: color.exists
		do
			cwin_set_bk_color (item, color.item)
		ensure
			color_set: background_color.item = color.item
		end

	set_text_color (color: WEL_COLOR_REF) is
			-- Set the `text_color' to `color'.
		require
			exists: exists
			color_not_void: color /= Void
			color_exists: color.exists
		do
			cwin_set_text_color (item, color.item)
		ensure
			color_set: text_color.item = color.item
		end

	set_background_opaque is
			-- Set the background mode to opaque
		require
			exists: exists
		do
			cwin_set_bk_mode (item, Opaque)
		ensure
			is_opaque: is_opaque
		end

	set_background_transparent is
			-- Set the background mode to transparent
		require
			exists: exists
		do
			cwin_set_bk_mode (item, Transparent)
		ensure
			is_transparent: is_transparent
		end

	set_rop2 (mode: INTEGER) is
			-- Set the current drawing mode with `mode'
			-- For `mode' values, see class WEL_ROP2_CONSTANTS
		require
			exists: exists
		do
			cwin_set_rop2 (item, mode)
		ensure
			mode_set: mode = rop2
		end

feature -- Status setting

	select_palette (a_palette: WEL_PALETTE) is
			-- Select the `a_palette' as the current palette.
		require
			exists: exists
			a_palette_not_void: a_palette /= Void
			a_palette_exists: a_palette.exists
		do
			if palette_selected then
				cwin_select_palette (item, a_palette.item,
					False)
			else
				old_hpalette := cwin_select_palette_result (item,
					a_palette.item, False)
				check
					old_hpalette_not_null:
						old_hpalette /= default_pointer
				end
			end
			palette := a_palette
		end

	select_pen (a_pen: WEL_PEN) is
			-- Select the `a_pen' as the current pen.
		require
			exists: exists
			a_pen_not_void: a_pen /= Void
			a_pen_exists: a_pen.exists
		do
			if pen_selected then
				cwin_select_object (item, a_pen.item)
			else
				old_hpen := cwin_select_object_result (item,
					a_pen.item)
				check
					old_hpen_not_null:
						old_hpen /= default_pointer
				end
			end
			pen := a_pen
		ensure
			pen_set: pen = a_pen
			pen_selected: pen_selected
		end

	select_brush (a_brush: WEL_BRUSH) is
			-- Select the `a_brush' as the current brush.
		require
			exists: exists
			a_brush_not_void: a_brush /= Void
			a_brush_exists: a_brush.exists
		do
			if brush_selected then
				cwin_select_object (item, a_brush.item)
			else
				old_hbrush := cwin_select_object_result (item,
					a_brush.item)
				check
					old_hbrush_not_null:
						old_hbrush /= default_pointer
				end
			end
			brush := a_brush
		ensure
			brush_set: brush = a_brush
			brush_selected: brush_selected
		end

	select_region (a_region: WEL_REGION) is
			-- Select the `a_region' as the current region.
		require
			exists: exists
			a_region_not_void: a_region /= Void
			a_region_exists: a_region.exists
		do
			if region_selected then
				cwin_select_object (item, a_region.item)
			else
				old_hregion := cwin_select_object_result (item,
					a_region.item)
				check
					old_hregion_not_null:
						old_hregion /= default_pointer
				end
			end
			region := a_region
		ensure
			region_set: region = a_region
			region_selected: region_selected
		end

	select_font (a_font: WEL_FONT) is
			-- Select the `a_font' as the current font.
		require
			exists: exists
			a_font_not_void: a_font /= Void
			a_font_exists: a_font.exists
		do
			if font_selected then
				cwin_select_object (item, a_font.item)
			else
				old_hfont := cwin_select_object_result (item,
					a_font.item)
				check
					hfont_not_null:
						old_hfont /= default_pointer
				end
			end
			font := a_font
		ensure
			font_set: font = a_font
			font_selected: font_selected
		end

	select_bitmap (a_bitmap: WEL_BITMAP) is
			-- Select the `a_bitmap' as the current bitmap.
		require
			exists: exists
			a_bitmap_not_void: a_bitmap /= Void
			a_bitmap_exists: a_bitmap.exists
		do
			if bitmap_selected then
				cwin_select_object (item, a_bitmap.item)
			else
				old_hbitmap := cwin_select_object_result (item,
					a_bitmap.item)
				check
					hbitmap_not_null:
						old_hbitmap /= default_pointer
				end
			end
			bitmap := a_bitmap
		ensure
			bitmap_set: bitmap = a_bitmap
			bitmap_selected: bitmap_selected
		end

	unselect_pen is
			-- Deselect the pen and restore the old one
		require
			exists: exists
		do
			if pen_selected then
				check
					old_hpen_not_null:
						old_hpen /= default_pointer
				end
				cwin_select_object (item, old_hpen)
				pen := Void
			end
		ensure
			pen_not_selected: not pen_selected
		end

	unselect_brush is
			-- Deselect the brush and restore the old one
		require
			exists: exists
		do
			if brush_selected then
				check
					old_hbrush_not_null:
						old_hbrush /= default_pointer
				end
				cwin_select_object (item, old_hbrush)
				brush := Void
			end
		ensure
			brush_not_selected: not brush_selected
		end

	unselect_region is
			-- Deselect the region and restore the old one
		require
			exists: exists
		do
			if region_selected then
				check
					old_hregion_not_null:
						old_hregion /= default_pointer
				end
				cwin_select_object (item, old_hregion)
				region := Void
			end
		ensure
			region_not_selected: not region_selected
		end

	unselect_palette is
			-- Deselect the palette and restore the old one
		require
			exists: exists
		do
			if palette_selected then
				check
					old_hpalette_not_null:
						old_hpalette /= default_pointer
				end
				cwin_select_palette (item, old_hpalette, false)
				palette := Void
			end
		ensure
			palette_not_selected: not palette_selected
		end

	unselect_font is
			-- Deselect the font and restore the old one
		require
			exists: exists
		do
			if font_selected then
				check
					old_hfont_not_null:
						old_hfont /= default_pointer
				end
				cwin_select_object (item, old_hfont)
				font := Void
			end
		ensure
			font_not_selected: not font_selected
		end

	unselect_bitmap is
			-- Deselect the bitmap and restore the old one
		require
			exists: exists
		do
			if bitmap_selected then
				check
					old_hbitmap_not_null:
						old_hbitmap /= default_pointer
				end
				cwin_select_object (item, old_hbitmap)
				bitmap := Void
			end
		ensure
			bitmap_not_selected: not bitmap_selected
		end

	unselect_all is
			-- Deselect all objects and restore the old ones
		require
			exists: exists
		do
			unselect_pen
			unselect_brush
			unselect_region
			unselect_palette
			unselect_font
			unselect_bitmap
		ensure
			pen_not_selected: not pen_selected
			brush_not_selected: not brush_selected
			region_not_selected: not region_selected
			palette_not_selected: not palette_selected
			font_not_selected: not font_selected
			bitmap_not_selected: not bitmap_selected
		end

feature -- Basic operations

	realize_palette is
			-- Map palette entries from the current logical
			-- palette on the system palette
		require
			exists: exists
			palette_selected: palette_selected
		do
			cwin_realize_palette (item)
		end

	select_clip_region (a_region: WEL_REGION) is
			-- Select `a_region' as the current clipping region
		do
			cwin_select_clip_rgn (item, a_region.item)
		end

	text_out (x, y: INTEGER; string: STRING) is
			-- Write `string' on `x' and `y' position
		require
			exists: exists
			string_not_void: string /= Void
		local
			a: ANY
		do
			a := string.to_c
			cwin_text_out (item, x, y, $a, string.count)
		end

	draw_text (string: STRING; rect: WEL_RECT; format: INTEGER) is
			-- Draw the text `string' inside 
			-- the `rect' using `format'
			-- See class WEL_DT_CONSTANTS for `format' value
		require
			exists: exists
			string_not_void: string /= Void
			rect_not_void: rect /= Void
		local
			a: ANY
		do
			a := string.to_c
			cwin_draw_text (item, $a, string.count, rect.item,
				format)
		end

	draw_centered_text (string: STRING; rect: WEL_RECT) is
			-- Draw the text `string' centered in `rect'.
		require
			exists: exists
			string_not_void: string /= Void
			rect_not_void: rect /= Void
			rect_exists: rect.exists
		local
			a: ANY
		do
			a := string.to_c
			cwin_draw_text (item, $a, string.count, rect.item,
				Dt_singleline + Dt_center + Dt_vcenter)
		end

	draw_bitmap (a_bitmap: WEL_BITMAP; x, y, width, height: INTEGER) is
			-- Draw `bitmap' at the `x', `y' position
			-- using `width' and `height'.
		require
			exists: exists
			a_bitmap_not_void: a_bitmap /= Void
			a_bitmap_exists: a_bitmap.exists
		local
			bitmap_dc: WEL_COMPATIBLE_DC
		do
			!! bitmap_dc.make (Current)
			if palette_selected then
				bitmap_dc.select_palette (palette)
				bitmap_dc.realize_palette
			end
			bitmap_dc.select_bitmap (a_bitmap)
			bit_blt (x, y, width, height, bitmap_dc, 0, 0, Srccopy)
			bitmap_dc.unselect_bitmap
			bitmap_dc.unselect_palette
		end

	draw_icon (icon: WEL_ICON; x, y: INTEGER) is
			-- Draw `icon' at the `x', `y' position.
		require
			exists: exists
			icon_not_void: icon /= Void
			icon_exists: icon.exists
		do
			cwin_draw_icon (item, x, y, icon.item)
		end

	set_pixel (x, y: INTEGER; color: WEL_COLOR_REF) is
			-- Set the pixel at `x', `y' position
			-- with the `color' color.
		require
			exists: exists
			color_not_void: color /= Void
			color_exists: color.exists
		do
			cwin_set_pixel (item, x, y, color.item)
		end

	line (x1, y1, x2, y2: INTEGER) is
			-- Draw a line from `x1', `y1' to `x2', `y2'
		require
			exists: exists
		do
			move_to (x1, y1)
			line_to (x2, y2)
		end

	poly_line (points: ARRAY [INTEGER]) is
		require
			exists: exists
			points_not_void: points /= Void
			points_count: points.count \\ 2 = 0
		local
			a: ANY
		do
			a := points.to_c
			cwin_poly_line (item, $a, points.count // 2)
		end

	line_to (x, y: INTEGER) is
			-- Draw a line from the current position
			-- to `x', `y' position
		require
			exists: exists
		do
			cwin_line_to (item, x, y)
		end

	move_to (x, y: INTEGER) is
			-- Set the current position to `x', `y' position
		require
			exists: exists
		do
			cwin_move_to_ex (item, x, y, default_pointer)
		end

	rectangle (left, top, right, bottom: INTEGER) is
			-- Draw a rectangle from `left', `top'
			-- to `right', `botton'
		require
			exists: exists
		do
			cwin_rectangle (item, left, top, right, bottom)
		end

	fill_rect (a_rect: WEL_RECT; a_brush: WEL_BRUSH) is
			-- Fill a `a_rect' by using `a_brush' to fill it.
		require
			exists: exists
			a_rect_not_void: a_rect /= Void
			a_rect_exists: a_rect.exists
			a_brush_not_void: a_brush /= Void
			a_brush_exists: a_brush.exists
		do
			cwin_fill_rect (item, a_rect.item, a_brush.item)
		end

	polygon (points: ARRAY [INTEGER]) is
			-- Draw a polygon consisting of two or more points
			-- connected by lines.
		require
			exists: exists
			points_not_void: points /= Void
			points_count: points.count \\ 2 = 0
		local
			a: ANY
		do
			a := points.to_c
			cwin_polygon (item, $a, points.count // 2)
		end

	ellipse (left, top, right, bottom: INTEGER) is
			-- Draw an ellipse into a rectangle specified by
			-- `left', `top' and `right', `bottom'
		require
			exists: exists
		do
			cwin_ellipse (item, left, top, right, bottom)
		end

	arc (left, top, right, bottom, x_start_arc, y_start_arc,
			x_end_arc, y_end_arc: INTEGER) is
			-- Draw an elliptical arc into a rectangle specified
			-- by `left', `top' and `right', `bottom', starting
			-- at `x_start_arc', `y_start_arc' and ending at
			-- `x_end_arc', `y_end_arc'
		require
			exists: exists
		do
			cwin_arc (item, left, top, right, bottom, x_start_arc,
				y_start_arc, x_end_arc, y_end_arc)
		end

	chord (left, top, right, bottom, x_start_line, y_start_line,
			x_end_line, y_end_line: INTEGER) is
			-- Draw a chord into a rectangle specified
			-- by `left', `top' and `right', `bottom', starting
			-- at `x_start_line', `y_start_line' and ending at
			-- `x_end_line', `y_end_line'
		require
			exists: exists
		do
			cwin_chord (item, left, top, right, bottom, x_start_line,
				y_start_line, x_end_line, y_end_line)
		end

	pie (left, top, right, bottom, x_start_point, y_start_point,
			x_end_point, y_end_point: INTEGER) is
			-- Draw a pie-shaped wedge by drawing an elliptical
			-- arc whose center and two endpoints are joined
			-- by lines. The pie is drawn into a rectangle
			-- specified by `left', `top' and `right', `bottom',
			-- starting at `x_start_point', `y_start_point'
			-- and ending at `x_end_point', `y_end_point'
		require
			exists: exists
		do
			cwin_pie (item, left, top, right, bottom, x_start_point,
				y_start_point, x_end_point, y_end_point)
		end

	round_rect (left, top, right, bottom, ellipse_width,
			ellipse_height: INTEGER) is
			-- Draw a rectangle from `left', `top' to
			-- `right', `bottom' with rounded corners.
			-- The rounded corners are specified by the
			-- `ellipse_width' and `ellipse_height'
		require
			exists: exists
		do
			cwin_round_rect (item, left, top, right, bottom,
				ellipse_width, ellipse_height)
		end

	copy_dc (dc_source: WEL_DC; rect: WEL_RECT) is
			-- Copy the content of `rect' in `dc_source'
			-- to the current dc.
		require
			exists: exists
			rect_not_void: rect /= Void
			rect_exists: rect.exists
			dc_source_not_void: dc_source /= Void
			dc_source_exists: dc_source.exists
		do
			cwin_bit_blt (item, rect.left, rect.top, rect.width,
				rect.height, dc_source.item, rect.left,
				rect.top, Srccopy)
		end

	bit_blt (x_destination, y_destination, width, height: INTEGER;
			dc_source: WEL_DC; x_source, y_source,
			raster_operation: INTEGER) is
			-- Copy a bitmap from the `dc_source' to
			-- the current device context, from `x_source',
			-- `y_source' to `x_destination', `y_destination',
			-- using `width' and `height' with `raster_operation'.
			-- See class WEL_RASTER_OPERATIONS_CONSTANTS for
			-- `raster_operations' values
		require
			exists: exists
			positive_width: width >= 0
			positive_height: height >= 0
			dc_source_not_void: dc_source /= Void
			dc_source_exists: dc_source.exists
		do
			cwin_bit_blt (item, x_destination, y_destination,
				width, height, dc_source.item, x_source,
				y_source, raster_operation)
		end

	stretch_blt (x_destination, y_destination, width_destination,
				height_destination: INTEGER; dc_source: WEL_DC;
				x_source, y_source, width_source, height_source,
				raster_operation: INTEGER) is
			-- Copy a bitmap from the `dc_source' to
			-- the current device context, from `x_source',
			-- `y_source' to `x_destination', `y_destination',
			-- using `width' and `height' with `raster_operation'.
			-- See class WEL_RASTER_OPERATIONS_CONSTANTS for
			-- `raster_operations' values.
		require
			exists: exists
			positive_width_destination: width_destination >= 0
			positive_height_destination: height_destination >= 0
			positive_width_source: width_source >= 0
			positive_height_source: height_source >= 0
			dc_source_not_void: dc_source /= Void
			dc_source_exists: dc_source.exists
		do
			cwin_stretch_blt (item, x_destination, y_destination,
				width_destination, height_destination,
				dc_source.item, x_source, y_source,
				width_source, height_source, raster_operation)
		end

	stretch_di_bits (x_destination, y_destination, width, height, x_source,
				y_source, dib_width, dib_height: INTEGER;
				a_dib: WEL_DIB; rgb_mode,
				raster_operation: INTEGER) is
			-- Copy a dib to the current device context, from
			-- `x_source', `y_source' to `x_destination',
			-- `y_destination', using `width' and `height'
			-- with `raster_operation' and 'rgb_mode'
			-- See class WEL_RASTER_OPERATIONS_CONSTANTS for
			-- `raster_operations' values
			-- See class WEL_DIB_COLORS_CONSTANTS for
			-- `rgb_mode' values
		require
			exists: exists
			positive_width: width >= 0
			positive_height: height >= 0
			a_dib_not_void: a_dib /= Void
			a_dib_exists: a_dib.exists
		do
			cwin_stretch_di_bits (item, x_destination,
				y_destination, width, height, x_source,
				y_source, dib_width, dib_height,
				a_dib.item_bits, a_dib.item, rgb_mode,
				raster_operation)
		end

	set_stretch_blt_mode (a_mode: INTEGER) is
			-- See class WEL_DIB_COLORS_CONSTANTS
			-- for `a_mode' values.
		require
			exists: exists
		do
			cwin_set_stretch_blt_mode (item, a_mode)
		end

	pat_blt (x_destination, y_destination, width, height: INTEGER;
			raster_operation: INTEGER) is
			-- Copy a bitmap from the `dc_source' to
			-- `y_source' to `x_destination', `y_destination',
			-- using with `raster_operation'.
			-- See class WEL_RASTER_OPERATIONS_CONSTANTS for
			-- `raster_operations' values
		require
			exists: exists
			positive_width: width >= 0
			positive_height: height >= 0
		do
			cwin_pat_blt (item, x_destination, y_destination,
				width, height, raster_operation)
		end

feature {NONE} -- Implementation

	old_hpen: POINTER
		-- Old hpen selected

	old_hbrush: POINTER
		-- Old hbrush selected

	old_hregion: POINTER
		-- Old hregion selected

	old_hpalette: POINTER
		-- Old hpalette selected

	old_hfont: POINTER
		-- Old hfont selected

	old_hbitmap: POINTER
		-- Old hbitmap selected

feature {NONE} -- Externals

	cwin_text_out (hdc: POINTER; x, y: INTEGER; string: POINTER;
			length: INTEGER) is
			-- SDK TextOut
		external
			"C [macro <wel.h>] (HDC, int, int, LPCSTR, int)"
		alias
			"TextOut"
		end

	cwin_draw_text (hdc: POINTER; string: POINTER; length: INTEGER; 
			rect: POINTER; format: INTEGER) is
			-- SDK DrawText
		external
			"C [macro <wel.h>] (HDC, LPCSTR, int, LPRECT, UINT)"
		alias
			"DrawText"
		end

	cwin_draw_icon (hdc: POINTER; x, y: INTEGER; hicon: POINTER) is
			-- SDK DrawIcon
		external
			"C [macro <wel.h>] (HDC, int, int, HICON)"
		alias
			"DrawIcon"
		end

	cwin_set_pixel (hdc: POINTER; x, y: INTEGER; color: POINTER) is
			-- SDK SetPixel
		external
			"C [macro <wel.h>] (HDC, int, int, COLORREF)"
		alias
			"SetPixel"
		end

	cwin_get_pixel (hdc: POINTER; x, y: INTEGER): POINTER is
			-- SDK GetPixel
		external
			"C [macro <wel.h>] (HDC, int, int): EIF_POINTER"
		alias
			"GetPixel"
		end

	cwin_move_to_ex (hdc: POINTER; x, y: INTEGER; point: POINTER) is
			-- SDK MoveToEx
		external
			"C [macro <wel.h>] (HDC, int, int, LPPOINT)"
		alias
			"MoveToEx"
		end

	cwin_line_to (hdc: POINTER; x, y: INTEGER) is
			-- SDK LineTo
		external
			"C [macro <wel.h>] (HDC, int, int)"
		alias
			"LineTo"
		end

	cwin_poly_line (hdc, pts: POINTER; num: INTEGER) is
			-- SDK Polyline
		external
			"C [macro <wel.h>] (HDC, POINT *, int)"
		alias
			"Polyline"
		end

	cwin_rectangle (hdc: POINTER; x1, y1, x2, y2: INTEGER) is
			-- SDK Rectangle
		external
			"C [macro <wel.h>] (HDC, int, int, int, int)"
		alias
			"Rectangle"
		end

	cwin_fill_rect (hdc, rect, hbrush: POINTER) is
			-- SDK FillRect
		external
			"C [macro <wel.h>] (HDC, RECT *, HBRUSH)"
		alias
			"FillRect"
		end

	cwin_polygon (hdc, pts: POINTER; num: INTEGER) is
			-- SDK Polygon
		external
			"C [macro <wel.h>] (HDC, POINT *, int)"
		alias
			"Polygon"
		end

	cwin_ellipse (hdc: POINTER; x1, y1, x2, y2: INTEGER) is
			-- SDK Ellipse
		external
			"C [macro <wel.h>] (HDC, int, int, int, int)"
		alias
			"Ellipse"
		end

	cwin_arc (hdc: POINTER; x1, y1, x2, y2, x_start, y_start,
			x_end, y_end: INTEGER) is
			-- SDK Arc
		external
			"C [macro <wel.h>] (HDC, int, int, int, %
				%int, int, int, int, int)"
		alias
			"Arc"
		end

	cwin_chord (hdc: POINTER; x1, y1, x2, y2, x_start, y_start,
			x_end, y_end: INTEGER) is
			-- SDK Chord
		external
			"C [macro <wel.h>] (HDC, int, int, int, %
				%int, int, int, int, int)"
		alias
			"Chord"
		end

	cwin_pie (hdc: POINTER; x1, y1, x2, y2, x_start, y_start,
			x_end, y_end: INTEGER) is
			-- SDK Pie
		external
			"C [macro <wel.h>] (HDC, int, int, int, %
				%int, int, int, int, int)"
		alias
			"Pie"
		end

	cwin_round_rect (hdc: POINTER; x1, y1, x2, y2, width,
			height: INTEGER) is
			-- SDK RoundRect
		external
			"C [macro <wel.h>] (HDC, int, int, int, int, int, int)"
		alias
			"RoundRect"
		end

	cwin_bit_blt (hdc_dest: POINTER; x_dest, y_dest, width, height: INTEGER;
			hdc_src: POINTER; x_src, y_src, rop: INTEGER) is
			-- SDK BitBlt
		external
			"C [macro <wel.h>] (HDC, int, int, int, int, HDC, %
				%int, int, DWORD)"
		alias
			"BitBlt"
		end

	cwin_stretch_di_bits (hdc: POINTER; xdest, ydest, cxdest, cydest, xsrc,
			ysrc, cxsrc, cysrc: INTEGER; lpvBits,
			lpbmi: POINTER; color_use, rop: INTEGER) is
			-- SDK StretchDIBits
		external
			"C [macro <wel.h>] (HDC,int, int, int, int, int, int, %
				%int, int, void *, LPBITMAPINFO, UINT, DWORD)"
		alias
			"StretchDIBits"
		end

	cwin_stretch_blt (hdc_dest: POINTER; x_dest, y_dest, width_dest,
			height_dest: INTEGER; hdc_src: POINTER; x_src, y_src,
			width_src, height_src, rop: INTEGER) is
			-- SDK StretchBlt
		external
			"C [macro <wel.h>] (HDC, int, int, int, int, HDC, %
				%int, int, int, int, DWORD)"
		alias
			"StretchBlt"
		end

	cwin_set_stretch_blt_mode (hdc: POINTER; a_mode: INTEGER) is
			-- SDK SetStretchBltMode
		external
			"C [macro <wel.h>] (HDC, int)"
		alias
			"SetStretchBltMode"
		end

	cwin_pat_blt (hdc_dest: POINTER; x_dest, y_dest, width, height: INTEGER;
			rop: INTEGER) is
			-- SDK PatBlt
		external
			"C [macro <wel.h>] (HDC, int, int, int, int, DWORD)"
		alias
			"PatBlt"
		end

	cwin_realize_palette (hdc: POINTER) is
			-- SDK RealizePalette
		external
			"C [macro <wel.h>] (HDC)"
		alias
			"RealizePalette"
		end

	cwin_select_palette (hdc, hgpal: POINTER; palback: BOOLEAN) is
			-- SDK SelectPalette
		external
			"C [macro <wel.h>] (HDC, HPALETTE, BOOL)"
		alias
			"SelectPalette"
		end

	cwin_select_palette_result (hdc, hgpal: POINTER;
			palback: BOOLEAN): POINTER is
			-- SDK SelectPalette
		external
			"C [macro <wel.h>] (HDC, HPALETTE, BOOL): EIF_POINTER"
		alias
			"SelectPalette"
		end

	cwin_select_object_result (hdc, hgdi_obj: POINTER): POINTER is
			-- SDK SelectObject
		external
			"C [macro <wel.h>] (HDC, HGDIOBJ): EIF_POINTER"
		alias
			"SelectObject"
		end

	cwin_select_object (hdc, hgdi_obj: POINTER) is
			-- SDK SelectObject
		external
			"C [macro <wel.h>] (HDC, HGDIOBJ)"
		alias
			"SelectObject"
		end

	cwin_select_clip_rgn (hdc, hrgn: POINTER) is
			-- SDK SelectClipRgn
		external
			"C [macro <wel.h>] (HDC, HRGN)"
		alias
			"SelectClipRgn"
		end

	cwin_create_dc (a_driver, a_device, a_output,
			init_data: POINTER): POINTER is
			-- SDK CreateDC
		external
			"C [macro <wel.h>] (LPCSTR, LPCSTR, LPCSTR, %
				%void *): EIF_POINTER"
		alias
			"CreateDC"
		end

	cwin_delete_dc (hdc: POINTER) is
			-- SDK DeleteDC
		external
			"C [macro <wel.h>] (HDC)"
		alias
			"DeleteDC"
		end

	cwin_set_map_mode (hdc: POINTER; mode: INTEGER) is
			-- SDK SetMapMode
		external
			"C [macro <wel.h>] (HDC, int)"
		alias
			"SetMapMode"
		end

	cwin_get_map_mode (hdc: POINTER): INTEGER is
			-- SDK GetMapMode
		external
			"C [macro <wel.h>] (HDC): EIF_INTEGER"
		alias
			"GetMapMode"
		end

	cwin_set_window_ext_ex (hdc: POINTER; x_extent, y_extent: INTEGER;
			size: POINTER) is
			-- SDK SetWindowExtEx
		external
			"C [macro <wel.h>] (HDC, int, int, LPSIZE)"
		alias
			"SetWindowExtEx"
		end

	cwin_set_window_org_ex (hdc: POINTER; x_origin, y_origin: INTEGER;
			size: POINTER) is
			-- SDK SetWindowOrgEx
		external
			"C [macro <wel.h>] (HDC, int, int, LPPOINT)"
		alias
			"SetWindowOrgEx"
		end

	cwin_set_viewport_ext_ex (hdc: POINTER; x_extent, y_extent: INTEGER;
			size: POINTER) is
			-- SDK SetViewportExt
		external
			"C [macro <wel.h>] (HDC, int, int, LPSIZE)"
		alias
			"SetViewportExtEx"
		end

	cwin_set_viewport_org_ex (hdc: POINTER; x_origin, y_origin: INTEGER;
			size: POINTER) is
			-- SDK SetViewportOrgEx
		external
			"C [macro <wel.h>] (HDC, int, int, LPPOINT)"
		alias
			"SetViewportOrgEx"
		end

	cwin_set_bk_mode (hdc: POINTER; mode: INTEGER) is
			-- SDK SetBkMode
		external
			"C [macro <wel.h>] (HDC, int)"
		alias
			"SetBkMode"
		end

	cwin_get_bk_mode (hdc: POINTER): INTEGER is
			-- SDK GetBkMode
		external
			"C [macro <wel.h>] (HDC): EIF_INTEGER"
		alias
			"GetBkMode"
		end

	cwin_set_bk_color (hdc, color: POINTER) is
			-- SDK SetBkColor
		external
			"C [macro <wel.h>] (HDC, COLORREF)"
		alias
			"SetBkColor"
		end

	cwin_get_bk_color (hdc: POINTER): POINTER is
			-- SDK GetBkColor
		external
			"C [macro <wel.h>] (HDC): EIF_POINTER"
		alias
			"GetBkColor"
		end

	cwin_set_text_color (hdc, color: POINTER) is
			-- SDK SetBkColor
		external
			"C [macro <wel.h>] (HDC, COLORREF)"
		alias
			"SetTextColor"
		end

	cwin_get_text_color (hdc: POINTER): POINTER is
			-- SDK GetBkColor
		external
			"C [macro <wel.h>] (HDC): EIF_POINTER"
		alias
			"GetTextColor"
		end

	cwin_set_rop2 (hdc: POINTER; mode: INTEGER) is
			-- SDK SetROP2
		external
			"C [macro <wel.h>] (HDC, int)"
		alias
			"SetROP2"
		end

	cwin_get_rop2 (hdc: POINTER): INTEGER is
			-- SDK GetROP2
		external
			"C [macro <wel.h>] (HDC): EIF_INTEGER"
		alias
			"GetROP2"
		end

	cwin_get_text_extend_point (hdc: POINTER; s: POINTER; len: INTEGER;
			si: POINTER) is
			-- SDK GetTextExtentPoint
		external
			"C [macro <wel.h>] (HDC, LPCSTR, int, LPSIZE)"
		alias
			"GetTextExtentPoint"
		end

	cwin_device_caps (hdc: POINTER; capability: INTEGER): INTEGER is
			-- SDK GetDeviceCaps
		external
			"C [macro <wel.h>] (HDC, int): EIF_INTEGER"
		alias
			"GetDeviceCaps"
		end

	cwin_get_window_org_ex (hdc, point: POINTER) is
			-- SDK GetWindowOrgEx
		external
			"C [macro <wel.h>] (HDC, LPPOINT)"
		alias
			"GetWindowOrgEx"
		end

	cwin_get_window_ext_ex (hdc, point: POINTER) is
			-- SDK GetWindowExtEx
		external
			"C [macro <wel.h>] (HDC, LPSIZE)"
		alias
			"GetWindowExtEx"
		end

	cwin_get_viewport_org_ex (hdc, point: POINTER) is
			-- SDK GetViewportOrgEx
		external
			"C [macro <wel.h>] (HDC, LPPOINT)"
		alias
			"GetViewportOrgEx"
		end

	cwin_get_viewport_ext_ex (hdc, point: POINTER) is
			-- SDK GetViewportExtEx
		external
			"C [macro <wel.h>] (HDC, LPSIZE)"
		alias
			"GetViewportExtEx"
		end

	cwin_get_current_position_ex (hdc, point: POINTER) is
			-- SDK GetCurrentPositionEx
		external
			"C [macro <wel.h>] (HDC, POINT *)"
		alias
			"GetCurrentPositionEx"
		end

	Opaque: INTEGER is
		external
			"C [macro <wel.h>]"
		alias
			"OPAQUE"
		end

	Transparent: INTEGER is
		external
			"C [macro <wel.h>]"
		alias
			"TRANSPARENT"
		end

invariant
	valid_background_mode: exists implies is_opaque /= is_transparent

end -- class WEL_DC

--|-------------------------------------------------------------------------
--| Windows Eiffel Library: library of reusable components for ISE Eiffel 3.
--| Copyright (C) 1995, Interactive Software Engineering, Inc.
--| All rights reserved. Duplication and distribution prohibited.
--|
--| 270 Storke Road, Suite 7, Goleta, CA 93117 USA
--| Telephone 805-685-1006
--| Fax 805-685-6869
--| Information e-mail <info@eiffel.com>
--| Customer support e-mail <support@eiffel.com>
--|-------------------------------------------------------------------------
