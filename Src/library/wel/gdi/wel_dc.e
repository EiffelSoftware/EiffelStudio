indexing
	description: "General notion of a device context."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

deferred class
	WEL_DC

inherit
	WEL_ANY
		undefine
			dispose
		end

	WEL_REFERENCE_TRACKABLE

	WEL_DT_CONSTANTS
		export
			{NONE} all
		end

	WEL_RASTER_OPERATIONS_CONSTANTS
		export
			{NONE} all
		end

	WEL_DIB_COLORS_CONSTANTS
		export
			{NONE} all
			{ANY} valid_dib_colors_constant
		end

	WEL_STRETCH_MODE_CONSTANTS
		export
			{NONE} all
			{ANY} valid_stretch_mode_constant
		end

	WEL_FLOOD_FILL_CONSTANTS
		export
			{NONE} all
		end

	WEL_TA_CONSTANTS
		export
			{NONE} all
			{ANY} valid_text_alignement_constant
		end

	WEL_MM_CONSTANTS
		export
			{NONE} all
			{ANY} valid_map_mode_constant
		end

	WEL_POLYGON_FILL_MODE_CONSTANTS
		export
			{NONE} all
			{ANY} valid_polygon_fill_mode_constant
		end

	WEL_ROP2_CONSTANTS
		export
			{NONE} all
			{ANY} valid_rop2_constant
		end

	WEL_CAPABILITIES_CONSTANTS
		export
			{NONE} all
		end

	WEL_WORD_OPERATIONS
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

feature -- Basic operations

	get is
			-- Get the device context
		deferred
		end

	release is
			-- Release the device context
		deferred
		end

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
			-- Is the background mode transparent?
		require
			exists: exists
		do
			Result := cwin_get_bk_mode (item) = Transparent
		end

	is_opaque: BOOLEAN is
			-- Is the background mode opaque?
		require
			exists: exists
		do
			Result := cwin_get_bk_mode (item) = Opaque
		end

	background_color: WEL_COLOR_REF is
			-- Current color of the background
		require
			exists: exists
		do
			create Result.make_by_color (cwin_get_bk_color (item))
		ensure
			result_not_void: Result /= Void
		end

	text_color: WEL_COLOR_REF is
			-- Current color of the text
		require
			exists: exists
		do
			create Result.make_by_color (cwin_get_text_color (item))
		ensure
			result_not_void: Result /= Void
		end

	rop2: INTEGER is
			-- Current drawing mode
		require
			exists: exists
		do
			Result := cwin_get_rop2 (item)
		ensure
			valid_result: valid_rop2_constant (Result)
		end

	text_alignment: INTEGER is
			-- Current text alignement flags
		require
			exists: exists
		do
			Result := cwin_get_text_align (item)
		end

	pixel_color (x, y: INTEGER): WEL_COLOR_REF is
			-- Color located at `x', `y' position
		require
			exists: exists
		do
			create Result.make_by_color (cwin_get_pixel (item, x, y))
		ensure
			result_not_void: Result /= Void
		end

	viewport_origin: WEL_POINT is
			-- Viewport origin for the dc
		require
			exists: exists
		do
			create Result.make (0, 0)
			cwin_get_viewport_org_ex (item, Result.item)
		ensure
			result_not_void: Result /= Void
		end

	viewport_extent: WEL_SIZE is
			-- Retrieve the size of the current viewport for the dc.
		require
			exists: exists
		do
			create Result.make (0, 0)
			cwin_get_viewport_ext_ex (item, Result.item)
		ensure
			result_not_void: Result /= Void
		end

	window_origin: WEL_POINT is
			-- Window origin for the dc
		require
			exists: exists
		do
			create Result.make (0, 0)
			cwin_get_window_org_ex (item, Result.item)
		ensure
			result_not_void: Result /= Void
		end

	window_extent: WEL_SIZE is
			-- Window extent for the dc
		require
			exists: exists
		do
			create Result.make (0, 0)
			cwin_get_window_ext_ex (item, Result.item)
		ensure
			result_not_void: Result /= Void
		end

	position: WEL_POINT is
			-- Current position in logical coordinates
		require
			exists: exists
		do
			create Result.make (0, 0)
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
			a_wel_string: WEL_STRING
		do
			create a_wel_string.make (s)
			create Result.make (0, 0)
			cwin_get_text_extend_point (item, a_wel_string.item, s.count,
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

	tabbed_text_size (text: STRING): WEL_SIZE is
			-- Size of a tabbed `text'
		require
			exists: exists
			text_not_void: text /= Void
		local
			a_wel_string: WEL_STRING
			size: INTEGER
		do
			create a_wel_string.make (text)
			size := cwin_get_tabbed_text_extent (item, a_wel_string.item,
				text.count, 0, default_pointer)
			create Result.make (cwin_lo_word (size), cwin_hi_word (size))
		ensure
			result_not_void: Result /= Void
			positive_width: Result.width >= 0
			positive_height: Result.height >= 0
		end

	tabbed_text_width (text: STRING): INTEGER is
			-- Width of a tabbed `text'
		require
			exists: exists
			text_not_void: text /= Void
		do
			Result := tabbed_text_size (text).width
		ensure
			positive_width: Result >= 0
		end

	tabbed_text_height (text: STRING): INTEGER is
			-- Height of a tabbed `text'
		require
			exists: exists
			text_not_void: text /= Void
		do
			Result := tabbed_text_size (text).height
		ensure
			positive_height: Result >= 0
		end

	tabbed_text_size_with_tabulation (text: STRING;
			tabulations: ARRAY [INTEGER]): WEL_SIZE is
			-- Size of a tabbed `text', with `tabulations' as
			-- tabulation positions.
		require
			exists: exists
			text_not_void: text /= Void
			tabulations_not_void: tabulations /= Void
		local
			a: WEL_INTEGER_ARRAY
			a_wel_string: WEL_STRING
			size: INTEGER
		do
			create a_wel_string.make (text)
			create a.make (tabulations)
			size := cwin_get_tabbed_text_extent (item, a_wel_string.item,
				text.count, tabulations.count, a.item)
			create Result.make (cwin_lo_word (size), cwin_hi_word (size))
		ensure
			result_not_void: Result /= Void
			positive_width: Result.width >= 0
			positive_height: Result.height >= 0
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
			-- See class WEL_MM_CONSTANTS for values.
		require
			exists: exists
		do
			Result := cwin_get_map_mode (item)
		ensure
			valid_map_mode: valid_map_mode_constant (Result)
		end

	polygon_fill_mode: INTEGER is
			-- Current polygon fill mode
			-- See class WEL_POLYGON_FILL_MODE_CONSTANTS for values.
		require
			exists: exists
		do
			Result := cwin_get_poly_fill_mode (item)
		ensure
			valid_polygon_fill_mode:
				valid_polygon_fill_mode_constant (Result)
		end

	valid_extent_map_mode (mode: INTEGER): BOOLEAN is
			-- Is `mode' a valid window or viewport extent map mode?
		require
			valid_map_mode: valid_map_mode_constant (mode)
		do
			Result := mode = Mm_anisotropic or else
				mode = Mm_isotropic
		end

	stretch_blt_mode: INTEGER is
			-- Current stretching mode. The stretching mode
			-- defines how color data is added to or removed from
			-- bitmaps that are stretched or compressed when
			-- `stretch_blt' is called.
		require
			exists: exists
		do
			Result := cwin_get_stretch_blt_mode (item)
		ensure
			valid_stretch_mode: valid_stretch_mode_constant (Result)
		end

	text_face: STRING is
			-- Typeface name of the font that is currently selected
		require
			exists: exists
		local
			a_wel_string: WEL_STRING
			nb: INTEGER
		do
			create Result.make (Max_text_face)
			Result.fill_blank
			create a_wel_string.make (Result)
			nb := cwin_get_text_face (item,
				Max_text_face, a_wel_string.item)
			Result := a_wel_string.string
			Result.head (nb)
		ensure
			result_not_void: Result /= Void
		end

	width: INTEGER is
			-- Width of the screen (in pixels)
		require
			exists: exists
		do
			Result := device_caps (Horizontal_resolution)
		end

	height: INTEGER is
			-- Height of screen (in raster lines)
		require
			exists: exists
		do
			Result := device_caps (Vertical_resolution)
		end

	mask_blt_supported: BOOLEAN is
		once
			if not mask_blt_funcaddr_retrieved then
				retrieve_mask_blt_funcaddr
			end
			Result := (internal_mask_blt_funcaddr /= Void)
		end

feature -- Status setting

	set_text_alignment (an_alignment: INTEGER) is
			-- Set the text alignment with `an_alignement'.
			-- See class WEL_TA_CONSTANTS for `an_alignement'.
		require
			exists: exists
			valid_alignement: valid_text_alignement_constant (an_alignment)
		do
			cwin_set_text_align (item, an_alignment)
		ensure
			text_alignment_set: text_alignment = an_alignment
		end

	set_map_mode (mode: INTEGER) is
			-- Set the mapping mode `mode' of the device context.
			-- See class WEL_MM_CONSTANTS for `mode' values.
		require
			exists: exists
			valid_map_mode: valid_map_mode_constant (mode)
		do
			cwin_set_map_mode (item, mode)
		ensure
			map_mode_set: map_mode = mode
		end

	set_polygon_fill_mode (mode: INTEGER) is
			-- Set the polygon fill mode `polygon_fill_mode' with
			-- `mode'.
			-- See class WEL_POLYGON_FILL_MODE_CONSTANTS for
			-- `mode' values.
		require
			exists: exists
			valid_polygon_fill_mode:
				valid_polygon_fill_mode_constant (mode)
		do
			cwin_set_poly_fill_mode (item, mode)
		ensure
			polygon_fill_mode_set: polygon_fill_mode = mode
		end

	set_window_extent (x_extent, y_extent: INTEGER) is
			-- Set the `x_extent' and `y_extent' of the window
			-- associated with the device context
		require
			exists: exists
			valid_current_map_mode: valid_extent_map_mode (map_mode)
		do
			cwin_set_window_ext_ex (item, x_extent, y_extent,
				default_pointer)
		ensure
			x_window_extent_set: map_mode /= Mm_isotropic implies window_extent.width = x_extent
			y_window_extent_set: map_mode /= Mm_isotropic implies window_extent.height = y_extent
		end

	set_window_origin (x_origin, y_origin: INTEGER) is
			-- Set the `x_origin' and `y_origin' of the window
			-- associated with the device context
		require
			exists: exists
		do
			cwin_set_window_org_ex (item, x_origin, y_origin,
				default_pointer)
		ensure
			x_window_origin_set: window_origin.x = x_origin
			y_window_origin_set: window_origin.y = y_origin
		end

	set_viewport_extent (x_extent, y_extent: INTEGER) is
			-- Set the `x_extent' and `y_extent' of the viewport
			-- associated with the device context
		require
			exists: exists
			valid_current_map_mode: valid_extent_map_mode (map_mode)
		do
			cwin_set_viewport_ext_ex (item, x_extent, y_extent,
				default_pointer)
		ensure
			x_viewport_extent_set: map_mode /= Mm_isotropic implies viewport_extent.width = x_extent
			y_viewport_extent_set: map_mode /= Mm_isotropic implies viewport_extent.height = y_extent
		end

	set_viewport_origin (x_origin, y_origin: INTEGER) is
			-- Set the `x_origin' and `y_origin' of the viewport
			-- associated with the device context
		require
			exists: exists
		do
			cwin_set_viewport_org_ex (item, x_origin, y_origin,
				default_pointer)
		ensure
			x_viewport_origin_set: viewport_origin.x = x_origin
			y_viewport_origin_set: viewport_origin.y = y_origin
		end

	set_background_color (color: WEL_COLOR_REF) is
			-- Set the `background_color' to `color'
		require
			exists: exists
			color_not_void: color /= Void
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

	set_rop2 (a_rop2: INTEGER) is
			-- Set the current foreground mix mode. GDI uses the
			-- foreground mix mode to combine pens and interiors of
			-- filled objects with the colors already on the screen.
			-- The foreground mix mode defines how colors from the
			-- brush or pen and the colors in the existing image
			-- are to be combined.
			-- For `a_rop2' values, see class WEL_ROP2_CONSTANTS.
		require
			exists: exists
			valid_rop2_constant: valid_rop2_constant (a_rop2)
		do
			cwin_set_rop2 (item, a_rop2)
		ensure
			rop2_set: rop2 = a_rop2
		end

	set_stretch_blt_mode (a_mode: INTEGER) is
			-- Set the bitmap stretching mode with `a_mode'.
			-- See class WEL_STRETCH_MODE_CONSTANTS for `a_mode'
			-- values.
		require
			exists: exists
			valid_stretch_mode_constant: valid_stretch_mode_constant (a_mode)
		do
			cwin_set_stretch_blt_mode (item, a_mode)
		ensure
			stretch_blt_mode_set: stretch_blt_mode = a_mode
		end

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
				old_hpen := cwin_select_object_result (item, a_pen.item)
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
				old_hbrush := cwin_select_object_result (item, a_brush.item)
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
			pen_selected: pen_selected
		do
			check
				old_hpen_not_null:
					old_hpen /= default_pointer
			end
			cwin_select_object (item, old_hpen)
			pen := Void
		ensure
			pen_not_selected: not pen_selected
		end

	unselect_brush is
			-- Deselect the brush and restore the old one
		require
			exists: exists
			brush_selected: brush_selected
		do
			check
				old_hbrush_not_null:
					old_hbrush /= default_pointer
			end
			cwin_select_object (item, old_hbrush)
			brush := Void
		ensure
			brush_not_selected: not brush_selected
		end

	unselect_region is
			-- Deselect the region and restore the old one
		require
			exists: exists
			region_selected: region_selected
		do
			check
				old_hregion_not_null:
					old_hregion /= default_pointer
			end
			cwin_select_object (item, old_hregion)
			region := Void
		ensure
			region_not_selected: not region_selected
		end

	unselect_palette is
			-- Deselect the palette and restore the old one
		require
			exists: exists
			palette_selected: palette_selected
		do
			check
				old_hpalette_not_null:
					old_hpalette /= default_pointer
			end
			cwin_select_palette (item, old_hpalette, false)
			palette := Void
		ensure
			palette_not_selected: not palette_selected
		end

	unselect_font is
			-- Deselect the font and restore the old one
		require
			exists: exists
			font_selected: font_selected
		do
			check
				old_hfont_not_null:
					old_hfont /= default_pointer
			end
			cwin_select_object (item, old_hfont)
			font := Void
		ensure
			font_not_selected: not font_selected
		end

	unselect_bitmap is
			-- Deselect the bitmap and restore the old one
		require
			exists: exists
			bitmap_selected: bitmap_selected
		do
			check
				old_hbitmap_not_null:
					old_hbitmap /= default_pointer
			end
			cwin_select_object (item, old_hbitmap)
			bitmap := Void
		ensure
			bitmap_not_selected: not bitmap_selected
		end

	unselect_all is
			-- Deselect all objects and restore the old ones
		require
			exists: exists
		do
			if pen_selected then
				unselect_pen
			end
			if brush_selected then
				unselect_brush
			end
			if region_selected then
				unselect_region
			end
			if palette_selected then
				unselect_palette
			end
			if font_selected then
				unselect_font
			end
			if bitmap_selected then
				unselect_bitmap
			end
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
		require
			exists: exists
			a_region_not_void: a_region /= Void
			a_region_exists: a_region.exists
		do
			cwin_select_clip_rgn (item, a_region.item)
		end

	remove_clip_region is
			-- Remove the current clipping region
		require
			exists: exists
		do
			cwin_select_clip_rgn (item, Default_pointer)
		end

	text_out (x, y: INTEGER; string: STRING) is
			-- Write `string' on `x' and `y' position
		require
			exists: exists
			string_not_void: string /= Void
		local
			a_wel_string: WEL_STRING
		do
			create a_wel_string.make (string)
			cwin_text_out (item, x, y, a_wel_string.item, string.count)
		end

	tabbed_text_out (x, y: INTEGER; string: STRING;
			tabulations: ARRAY [INTEGER];
			tabulations_origin: INTEGER) is
			-- Write `string' on `x' and `y' position expanding
			-- tabs to the values specified in `tabulations'.
			-- `tabulations_origin' specifies the x-coordinate of
			-- the starting position from which tabs are expanded.
		require
			exists: exists
			string_not_void: string /= Void
			tabulations_not_void: tabulations /= Void
		local
			a: WEL_INTEGER_ARRAY
			a_wel_string: WEL_STRING
		do
			create a_wel_string.make (string)
			create a.make (tabulations)
			cwin_tabbed_text_out (item, x, y, a_wel_string.item, string.count,
				tabulations.count, a.item, tabulations_origin)
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
			a_wel_string: WEL_STRING
		do
			create a_wel_string.make (string)
			cwin_draw_text (item, a_wel_string.item, string.count, rect.item,
				format)
		end

	draw_centered_text (string: STRING; rect: WEL_RECT) is
			-- Draw the text `string' centered in `rect'.
		require
			exists: exists
			string_not_void: string /= Void
			rect_not_void: rect /= Void
		local
			a_wel_string: WEL_STRING
		do
			create a_wel_string.make (string)
			cwin_draw_text (item, a_wel_string.item, string.count, rect.item,
				Dt_singleline + Dt_center + Dt_vcenter)
		end

	draw_bitmap (a_bitmap: WEL_BITMAP; x, y, a_width, a_height: INTEGER) is
			-- Draw `bitmap' at the `x', `y' position
			-- using `a_width' and `a_height'.
		require
			exists: exists
			a_bitmap_not_void: a_bitmap /= Void
			a_bitmap_exists: a_bitmap.exists
		local
			bitmap_dc: WEL_MEMORY_DC
		do
			create bitmap_dc.make_by_dc (Current)
			if palette_selected then
				bitmap_dc.select_palette (palette)
				bitmap_dc.realize_palette
			end
			bitmap_dc.select_bitmap (a_bitmap)
			bit_blt (x, y, a_width, a_height, bitmap_dc, 0, 0, Srccopy)
			bitmap_dc.unselect_bitmap
			if bitmap_dc.palette_selected then
				bitmap_dc.unselect_palette
			end
			bitmap_dc.delete
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

	draw_icon_ex (icon: WEL_ICON; x, y, icon_width, icon_height, frame_index: INTEGER; flicker_free_background: WEL_BRUSH; di_flags: INTEGER) is
			-- Draw `icon' at the `x', `y' position.
		require
			exists: exists
			icon_not_void: icon /= Void
			icon_exists: icon.exists
		local
			ffdraw: POINTER
		do
			if flicker_free_background = Void then 
				ffdraw := Default_pointer
			else
				ffdraw := flicker_free_background.item
			end

			cwin_draw_icon_ex (item, x, y, icon.item, icon_width, icon_height, frame_index, ffdraw, di_flags)
		end

	draw_cursor (cursor: WEL_CURSOR; x, y: INTEGER) is
			-- Draw `cursor' at the `x', `y' position.
		require
			exists: exists
			cursor_not_void: cursor /= Void
			cursor_exists: cursor.exists
		do
			cwin_draw_icon (item, x, y, cursor.item)
		end

	set_pixel (x, y: INTEGER; color: WEL_COLOR_REF) is
			-- Set the pixel at `x', `y' position
			-- with the `color' color.
		require
			exists: exists
			color_not_void: color /= Void
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

	polyline (points: ARRAY [INTEGER]) is
			-- Draws a series of line segments by connecting the
			-- points specified in `points'.
		require
			exists: exists
			points_not_void: points /= Void
			points_count: points.count \\ 2 = 0
		local
			a: WEL_INTEGER_ARRAY
		do
			create a.make (points)
			cwin_polyline (item, a.item, points.count // 2)
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
			-- to `right', `bottom'.
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
			a_brush_not_void: a_brush /= Void
			a_brush_exists: a_brush.exists
		do
			cwin_fill_rect (item, a_rect.item, a_brush.item)
		end

	fill_region (a_region: WEL_REGION; a_brush: WEL_BRUSH) is
			-- Fill `a_region' by using `a_brush' to fill it
		require
			exists: exists
			a_region_not_void: a_region /= Void
			a_brush_not_void: a_brush /= Void
			a_brush_exists: a_brush.exists
		do
			cwin_fill_region (item, a_region.item, a_brush.item)
		end

	invert_rect (a_rect: WEL_RECT) is
			-- Invert `a_rect' in a window by performing a logical
			-- NOT operation on the color values for each pixel.
		require
			exists: exists
			a_rect_not_void: a_rect /= Void
		do
			cwin_invert_rect (item, a_rect.item)
		end

	invert_region (a_region: WEL_REGION) is
			-- Invert the colors in `a_region'.
		require
			exists: exists
			a_region_not_void: a_region /= Void
			a_region_exists: a_region.exists
		do
			cwin_invert_rgn (item, a_region.item)
		end

	flood_fill_border (x, y: INTEGER; color: WEL_COLOR_REF) is
			-- Fill an area which is bounded by `color' starting
			-- at `x', `y'.
		require
			exists: exists
			color_not_void: color /= Void
		do
			cwin_ext_flood_fill (item, x, y, color.item,
				Floodfillborder)
		end

	flood_fill_surface (x, y: INTEGER; color: WEL_COLOR_REF) is
			-- Fill an area which is defined by `color' starting
			-- at `x', `y'. Filling continues outward in all
			-- directions as long as the color is encountered.
		require
			exists: exists
			color_not_void: color /= Void
		do
			cwin_ext_flood_fill (item, x, y, color.item,
				Floodfillsurface)
		end

	polygon (points: ARRAY [INTEGER]) is
			-- Draw a polygon consisting of two or more `points'
			-- connected by lines.
		require
			exists: exists
			points_not_void: points /= Void
			points_count: points.count \\ 2 = 0
		local
			a: WEL_INTEGER_ARRAY
		do
			create a.make (points)
			cwin_polygon (item, a.item, points.count // 2)
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
			dc_source_not_void: dc_source /= Void
			dc_source_exists: dc_source.exists
		do
			cwin_bit_blt (item, rect.left, rect.top, rect.width,
				rect.height, dc_source.item, rect.left,
				rect.top, Srccopy)
		end

	bit_blt (x_destination, y_destination, a_width, a_height: INTEGER;
			dc_source: WEL_DC; x_source, y_source,
			raster_operation: INTEGER) is
			-- Copy a bitmap from the `dc_source' to
			-- the current device context, from `x_source',
			-- `y_source' to `x_destination', `y_destination',
			-- using `a_width' and `a_height' with `raster_operation'.
			-- See class WEL_RASTER_OPERATIONS_CONSTANTS for
			-- `raster_operation' values.
		require
			exists: exists
			positive_width: a_width >= 0
			positive_height: a_height >= 0
			dc_source_not_void: dc_source /= Void
			dc_source_exists: dc_source.exists
		do
			cwin_bit_blt (item, x_destination, y_destination,
				a_width, a_height, dc_source.item, x_source,
				y_source, raster_operation)
		end

	mask_blt (x_destination, y_destination, a_width, a_height: INTEGER;
			dc_source: WEL_DC; x_source, y_source: INTEGER;
			mask_bitmap: WEL_BITMAP; x_mask, y_mask,
			raster_operation: INTEGER) is
		-- Combines the color data for the source and destination bitmaps using the specified mask and raster operation. 
			-- See class WEL_RASTER_OPERATIONS_CONSTANTS for
			-- `raster_operation' values.
		require
			exists: exists
			positive_width: a_width >= 0
			positive_height: a_height >= 0
			dc_source_not_void: dc_source /= Void
			dc_source_exists: dc_source.exists
			mask_bitmap_not_void: mask_bitmap /= Void
			function_is_supported: mask_blt_supported
		do
			if not mask_blt_funcaddr_retrieved then
				retrieve_mask_blt_funcaddr
			end
			cwin_mask_blt (mask_blt_funcaddr, item, x_destination, y_destination,
				a_width, a_height, dc_source.item, x_source, y_source,
				mask_bitmap.item, x_mask, y_mask, raster_operation)
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
			-- `raster_operation' values.
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

	stretch_di_bits (x_destination, y_destination, a_width, a_height,
				x_source, y_source, dib_width,
				dib_height: INTEGER;
				dib: WEL_DIB; bitmap_info: WEL_BITMAP_INFO;
				rgb_mode, raster_operation: INTEGER) is
			-- Copy a dib to the current device context, from
			-- `x_source', `y_source' to `x_destination',
			-- `y_destination', using `a_width' and `a_height'
			-- with `raster_operation' and `rgb_mode'
			-- See class WEL_RASTER_OPERATIONS_CONSTANTS for
			-- `raster_operation' values
			-- See class WEL_DIB_COLORS_CONSTANTS for
			-- `rgb_mode' values
		require
			exists: exists
			positive_width: a_width >= 0
			positive_height: a_height >= 0
			dib_not_void: dib /= Void
			bitmap_not_void: bitmap_info /= Void
			valid_rgb_mode: valid_dib_colors_constant (rgb_mode)
		do
			cwin_stretch_di_bits (item, x_destination,
				y_destination, a_width, a_height, x_source,
				y_source, dib_width, dib_height,
				dib.item_bits, bitmap_info.item, rgb_mode,
				raster_operation)
		end

	pat_blt (x_destination, y_destination, a_width, a_height: INTEGER;
			raster_operation: INTEGER) is
			-- Paint the rectangle specified by `x_destination', 
			-- `y_destination', `a_width', `a_height' using the brush
			-- that is currently selected into this device context.
			-- The brush color and the surface color or colors are 
			-- combined by using the `raster_operation'.
			-- See class WEL_RASTER_OPERATIONS_CONSTANTS for
			-- `raster_operation' values.
		require
			exists: exists
			positive_width: a_width >= 0
			positive_height: a_height >= 0
		do
			cwin_pat_blt (item, x_destination, y_destination,
				a_width, a_height, raster_operation)
		end

	save_bitmap (a_bitmap: WEL_BITMAP; file: FILE_NAME) is
			-- Save `a_bitmap' in `file'.
		require
			exists: exists
			a_bitmap_not_void: a_bitmap /= Void
			a_bitmap_exists: a_bitmap.exists
			file_not_void: file /= Void
			file_is_valid: file.is_valid
		local
			bmi, bmi2: WEL_BITMAP_INFO
			bfh: WEL_BITMAP_FILE_HEADER
			bits: WEL_CHARACTER_ARRAY
			size: INTEGER
			rgb_quad: WEL_RGB_QUAD
			rf: RAW_FILE
		do
			create rgb_quad.make
			create bmi.make_by_dc (Current, a_bitmap, Dib_rgb_colors)
			inspect
				bmi.header.bit_count
			when 24 then
				size := bmi.header.structure_size
				create bmi2.make (bmi.header, 0)
			when 16, 32 then
				size := bmi.header.structure_size +
					rgb_quad.structure_size * 3
				create bmi2.make (bmi.header, 3)
			else
				size := (bmi.header.structure_size +
					rgb_quad.structure_size *
					(2 ^ bmi.header.bit_count)).truncated_to_integer
				create bmi2.make (bmi.header, (2 ^ bmi.header.bit_count).truncated_to_integer)
			end
			create bfh.make
			bfh.set_type (19778) -- 'BM'
			bfh.set_size (bfh.structure_size +
				bmi2.header.structure_size + size +
				bmi2.header.size_image)
			bfh.set_off_bits (bfh.structure_size + size)

			-- Create the file
			create rf.make_create_read_write (file)

			-- Write the file header
			c_file_ps (rf.file_pointer, bfh.item, bfh.structure_size)

			create bits.make (di_bits (a_bitmap, 0, bmi2.header.height, bmi2,
				Dib_rgb_colors))

			-- Write the bitmap info header
			c_file_ps (rf.file_pointer, bmi2.item, size)

			-- Write the DIB and close the file
			c_file_ps (rf.file_pointer, bits.item, bmi2.header.size_image)
			rf.close
		end

	di_bits (a_bitmap: WEL_BITMAP; start_scan, scan_lines: INTEGER;
			bitmap_info: WEL_BITMAP_INFO;
			usage: INTEGER): ARRAY [CHARACTER] is
			-- Device-independent bits of `a_bitmap'.
			-- `start_scan' specifies the first scan line to
			-- retrieve and `scan_lines' specifies the number of
			-- scan lines to retrieve. `bitmap_info' specifies the
			-- desired format for the dib data.
		require
			exists: exists
			a_bitmap_not_void: a_bitmap /= Void
			a_bitmap_exists: a_bitmap.exists
			positive_start_scan: start_scan >= 0
			positive_scan_lines: scan_lines >= 0
			bitmap_info_not_void: bitmap_info /= Void
			valid_usage: valid_dib_colors_constant (usage)
		local
			a: WEL_CHARACTER_ARRAY
		do
			create Result.make (1,
				bitmap_info.header.size_image)
			create a.make (Result)
			cwin_get_di_bits (item, a_bitmap.item, start_scan,
				scan_lines, a.item, bitmap_info.item, usage)
			Result := a.to_array (1)
		ensure
			result_not_void: Result /= Void
			consistent_count: Result.count = bitmap_info.header.size_image
		end

	poly_bezier (points: ARRAY [INTEGER]) is
			-- Draw one or more Bezier curves by using the
			-- endpoints and control points specified by `points'.
			-- The first curve is drawn from the first point to the
			-- fourth point by using the second and third points as
			-- control points. Each subsequent curve in the sequence
			-- needs exactly three more points: the ending point of
			-- the previous curve is used as the starting point, the
			-- next two points in the sequence are control points,
			-- and the third is the ending point.
			-- The current position is neither used nor updated by
			-- this procedure.
		require
			points_not_void: points /= Void
			points_count_ok: points.count \\ 2 = 0
		local
			a: WEL_INTEGER_ARRAY
		do
			create a.make (points)
			cwin_poly_bezier (item, a.item, points.count // 2)
		end

	poly_bezier_to (points: ARRAY [INTEGER]) is
			-- Draw one or more Bezier curves by using the control
			-- points specified by `points'. The first curve is
			-- drawn from the current position to the third point
			-- by using the first two points as control points.
			-- For each subsequent curve, the procedure needs
			-- exactly three more points, and uses the ending point
			-- of the previous curve as the starting point for the
			-- next.
			-- This procedure moves the current position to the
			-- ending point of the last Bezier curve.
		require
			points_not_void: points /= Void
			points_count_ok: points.count \\ 2 = 0
		local
			a: WEL_INTEGER_ARRAY
		do
			create a.make (points)
			cwin_poly_bezier_to (item, a.item, points.count // 2)
		end

feature -- Removal

	delete is
			-- Delete the current device context.
		require
			exists: exists
		do
				-- Protect the call to DeleteDC, because
				-- delete can be called by the GC so without
				-- assertions.
			if item /= Void then
				cwin_delete_dc (item)
			end
			item := default_pointer
		ensure
			not_exists: not exists
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

	Max_text_face: INTEGER is 255
		-- Maximum text face name for `text_face'

feature -- Obsolete

	set_bk_color (color: WEL_COLOR_REF) is
		obsolete
			"Use ``set_background_color''"
		do
			set_background_color (color)
		end

	poly_line (points: ARRAY [INTEGER]) is
		obsolete
			"Use ``polyline''"
		do
			polyline (points)
		end

	save (a_bitmap: WEL_BITMAP; file: FILE_NAME) is
		obsolete
			"Use ``save_bitmap''"
		do
			save_bitmap (a_bitmap, file)
		end

feature {NONE} -- Externals

	cwin_text_out (hdc: POINTER; x, y: INTEGER; string: POINTER;
			length: INTEGER) is
			-- SDK TextOut
		external
			"C [macro <windows.h>] (HDC, int, int, LPCSTR, int)"
		alias
			"TextOut"
		end

	cwin_tabbed_text_out (hdc: POINTER; x, y: INTEGER; string: POINTER;
			lenght, tab_count: INTEGER; tabs: POINTER;
			tab_origin: INTEGER) is
			-- SDK TabbedTextOut
		external
			"C [macro <windows.h>] (HDC, int, int, LPCTSTR, int, int, %
				%LPINT, int)"
		alias
			"TabbedTextOut"
		end

	cwin_draw_text (hdc: POINTER; string: POINTER; length: INTEGER; 
			rect: POINTER; format: INTEGER) is
			-- SDK DrawText
		external
			"C [macro <windows.h>] (HDC, LPCSTR, int, LPRECT, UINT)"
		alias
			"DrawText"
		end

	cwin_draw_icon (hdc: POINTER; x, y: INTEGER; hicon: POINTER) is
			-- SDK DrawIcon
		external
			"C [macro <windows.h>] (HDC, int, int, HICON)"
		alias
			"DrawIcon"
		end

	cwin_draw_icon_ex (hdc: POINTER; x, y: INTEGER; hicon: POINTER; icon_width, icon_height, frame_index: INTEGER; ffdraw: POINTER; di_flags: INTEGER) is
			-- SDK DrawIcon
		external
			"C [macro <windows.h>] (HDC, int, int, HICON, int, int, UINT, HBRUSH, UINT)"
		alias
			"DrawIconEx"
		end

	cwin_set_pixel (hdc: POINTER; x, y: INTEGER; color: INTEGER) is
			-- SDK SetPixel
		external
			"C [macro <windows.h>] (HDC, int, int, COLORREF)"
		alias
			"SetPixel"
		end

	cwin_get_pixel (hdc: POINTER; x, y: INTEGER): INTEGER is
			-- SDK GetPixel
		external
			"C [macro <windows.h>] (HDC, int, int): COLORREF"
		alias
			"GetPixel"
		end

	cwin_move_to_ex (hdc: POINTER; x, y: INTEGER; point: POINTER) is
			-- SDK MoveToEx
		external
			"C [macro <windows.h>] (HDC, int, int, LPPOINT)"
		alias
			"MoveToEx"
		end

	cwin_line_to (hdc: POINTER; x, y: INTEGER) is
			-- SDK LineTo
		external
			"C [macro <windows.h>] (HDC, int, int)"
		alias
			"LineTo"
		end

	cwin_polyline (hdc, pts: POINTER; num: INTEGER) is
			-- SDK Polyline
		external
			"C [macro <windows.h>] (HDC, POINT *, int)"
		alias
			"Polyline"
		end

	cwin_rectangle (hdc: POINTER; x1, y1, x2, y2: INTEGER) is
			-- SDK Rectangle
		external
			"C [macro <windows.h>] (HDC, int, int, int, int)"
		alias
			"Rectangle"
		end

	cwin_invert_rect (hdc: POINTER; rect: POINTER) is
			-- SDK InvertRect
		external
			"C [macro <windows.h>] (HDC, RECT *)"
		alias
			"InvertRect"
		end

	cwin_invert_rgn (hdc: POINTER; rgn: POINTER) is
			-- SDK InvertRgn
		external
			"C [macro <windows.h>] (HDC, HRGN)"
		alias
			"InvertRgn"
		end

	cwin_fill_rect (hdc, rect, hbrush: POINTER) is
			-- SDK FillRect
		external
			"C [macro <windows.h>] (HDC, RECT *, HBRUSH)"
		alias
			"FillRect"
		end

	-- Fill region to implement in order to avoid the falshing of the windows

	cwin_fill_region (hdc, hrgn, hbrush: POINTER) is
			-- SDK fillRgn
		external
			"C [macro <windows.h>] (HDC, HRGN, HBRUSH)"
		alias
			"FillRgn"
		end

	cwin_ext_flood_fill (hdc: POINTER; x, y: INTEGER; color: INTEGER; type: INTEGER) is
			-- SDK ExtFloodFill
		external
			"C [macro <windows.h>] (HDC, int, int, COLORREF, UINT)"
		alias
			"ExtFloodFill"
		end

	cwin_polygon (hdc, pts: POINTER; num: INTEGER) is
			-- SDK Polygon
		external
			"C [macro <windows.h>] (HDC, POINT *, int)"
		alias
			"Polygon"
		end

	cwin_poly_bezier (hdc, pts: POINTER; num: INTEGER) is
			-- SDK PolyBezier
		external
			"C [macro <windows.h>] (HDC, POINT *, DWORD)"
		alias
			"PolyBezier"
		end

	cwin_poly_bezier_to (hdc, pts: POINTER; num: INTEGER) is
			-- SDK PolyBezierTo
		external
			"C [macro <windows.h>] (HDC, POINT *, DWORD)"
		alias
			"PolyBezierTo"
		end

	cwin_ellipse (hdc: POINTER; x1, y1, x2, y2: INTEGER) is
			-- SDK Ellipse
		external
			"C [macro <windows.h>] (HDC, int, int, int, int)"
		alias
			"Ellipse"
		end

	cwin_arc (hdc: POINTER; x1, y1, x2, y2, x_start, y_start,
			x_end, y_end: INTEGER) is
			-- SDK Arc
		external
			"C [macro <windows.h>] (HDC, int, int, int, %
				%int, int, int, int, int)"
		alias
			"Arc"
		end

	cwin_chord (hdc: POINTER; x1, y1, x2, y2, x_start, y_start,
			x_end, y_end: INTEGER) is
			-- SDK Chord
		external
			"C [macro <windows.h>] (HDC, int, int, int, %
				%int, int, int, int, int)"
		alias
			"Chord"
		end

	cwin_pie (hdc: POINTER; x1, y1, x2, y2, x_start, y_start,
			x_end, y_end: INTEGER) is
			-- SDK Pie
		external
			"C [macro <windows.h>] (HDC, int, int, int, %
				%int, int, int, int, int)"
		alias
			"Pie"
		end

	cwin_round_rect (hdc: POINTER; x1, y1, x2, y2, a_width,
			a_height: INTEGER) is
			-- SDK RoundRect
		external
			"C [macro <windows.h>] (HDC, int, int, int, int, int, int)"
		alias
			"RoundRect"
		end

	cwin_bit_blt (hdc_dest: POINTER; x_dest, y_dest, a_width,
			a_height: INTEGER; hdc_src: POINTER; x_src,
			y_src, rop: INTEGER) is
			-- SDK BitBlt
		external
			"C [macro <windows.h>] (HDC, int, int, int, int, HDC, %
				%int, int, DWORD)"
		alias
			"BitBlt"
		end

	cwin_stretch_di_bits (hdc: POINTER; xdest, ydest, cxdest, cydest, xsrc,
			ysrc, cxsrc, cysrc: INTEGER; lpvBits,
			lpbmi: POINTER; color_use, rop: INTEGER) is
			-- SDK StretchDIBits
		external
			"C [macro <windows.h>] (HDC,int, int, int, int, int, int, %
				%int, int, void *, LPBITMAPINFO, UINT, DWORD)"
		alias
			"StretchDIBits"
		end

	cwin_stretch_blt (hdc_dest: POINTER; x_dest, y_dest, width_dest,
			height_dest: INTEGER; hdc_src: POINTER; x_src, y_src,
			width_src, height_src, rop: INTEGER) is
			-- SDK StretchBlt
		external
			"C [macro <windows.h>] (HDC, int, int, int, int, HDC, %
				%int, int, int, int, DWORD)"
		alias
			"StretchBlt"
		end

	cwin_set_stretch_blt_mode (hdc: POINTER; a_mode: INTEGER) is
			-- SDK SetStretchBltMode
		external
			"C [macro <windows.h>] (HDC, int)"
		alias
			"SetStretchBltMode"
		end

	cwin_pat_blt (hdc_dest: POINTER; x_dest, y_dest, a_width,
			a_height: INTEGER; rop: INTEGER) is
			-- SDK PatBlt
		external
			"C [macro <windows.h>] (HDC, int, int, int, int, DWORD)"
		alias
			"PatBlt"
		end

	cwin_realize_palette (hdc: POINTER) is
			-- SDK RealizePalette
		external
			"C [macro <windows.h>] (HDC)"
		alias
			"RealizePalette"
		end

	cwin_select_palette (hdc, hgpal: POINTER; palback: BOOLEAN) is
			-- SDK SelectPalette
		external
			"C [macro <windows.h>] (HDC, HPALETTE, BOOL)"
		alias
			"SelectPalette"
		end

	cwin_select_palette_result (hdc, hgpal: POINTER;
			palback: BOOLEAN): POINTER is
			-- SDK SelectPalette
		external
			"C [macro <windows.h>] (HDC, HPALETTE, BOOL): EIF_POINTER"
		alias
			"SelectPalette"
		end

	cwin_select_object_result (hdc, hgdi_obj: POINTER): POINTER is
			-- SDK SelectObject
		external
			"C [macro <windows.h>] (HDC, HGDIOBJ): HGDIOBJ"
		alias
			"SelectObject"
		end

	cwin_select_object (hdc, hgdi_obj: POINTER) is
			-- SDK SelectObject
		external
			"C [macro <windows.h>] (HDC, HGDIOBJ)"
		alias
			"SelectObject"
		end

	cwin_select_clip_rgn (hdc, hrgn: POINTER) is
			-- SDK SelectClipRgn
		external
			"C [macro <windows.h>] (HDC, HRGN)"
		alias
			"SelectClipRgn"
		end

	cwin_create_dc (a_driver, a_device, a_output,
			init_data: POINTER): POINTER is
			-- SDK CreateDC
		external
			"C [macro <windows.h>] (LPCSTR, LPCSTR, LPCSTR, CONST DEVMODE* ): EIF_POINTER"
		alias
			"CreateDC"
		end

	cwin_delete_dc (hdc: POINTER) is
			-- SDK DeleteDC
		external
			"C [macro <windows.h>] (HDC)"
		alias
			"DeleteDC"
		end

	cwin_set_text_align (hdc: POINTER; an_alignment: INTEGER) is
			-- SDK SetTextAlign
		external
			"C [macro <windows.h>] (HDC, UINT)"
		alias
			"SetTextAlign"
		end

	cwin_set_map_mode (hdc: POINTER; mode: INTEGER) is
			-- SDK SetMapMode
		external
			"C [macro <windows.h>] (HDC, int)"
		alias
			"SetMapMode"
		end

	cwin_set_poly_fill_mode (hdc: POINTER; mode: INTEGER) is
			-- SDK SetPolyFillMode
		external
			"C [macro <windows.h>] (HDC, int)"
		alias
			"SetPolyFillMode"
		end

	cwin_get_map_mode (hdc: POINTER): INTEGER is
			-- SDK GetMapMode
		external
			"C [macro <windows.h>] (HDC): EIF_INTEGER"
		alias
			"GetMapMode"
		end

	cwin_get_poly_fill_mode (hdc: POINTER): INTEGER is
			-- SDK GetPolyFillMode
		external
			"C [macro <windows.h>] (HDC): EIF_INTEGER"
		alias
			"GetPolyFillMode"
		end

	cwin_get_text_align (hdc: POINTER): INTEGER is
			-- SDK GetTextAlign
		external
			"C [macro <windows.h>] (HDC): EIF_INTEGER"
		alias
			"GetTextAlign"
		end

	cwin_get_stretch_blt_mode (hdc: POINTER): INTEGER is
			-- SDK GetStretchBltMode
		external
			"C [macro <windows.h>] (HDC): EIF_INTEGER"
		alias
			"GetStretchBltMode"
		end

	cwin_set_window_ext_ex (hdc: POINTER; x_extent, y_extent: INTEGER;
			size: POINTER) is
			-- SDK SetWindowExtEx
		external
			"C [macro <windows.h>] (HDC, int, int, LPSIZE)"
		alias
			"SetWindowExtEx"
		end

	cwin_set_window_org_ex (hdc: POINTER; x_origin, y_origin: INTEGER;
			size: POINTER) is
			-- SDK SetWindowOrgEx
		external
			"C [macro <windows.h>] (HDC, int, int, LPPOINT)"
		alias
			"SetWindowOrgEx"
		end

	cwin_set_viewport_ext_ex (hdc: POINTER; x_extent, y_extent: INTEGER;
			size: POINTER) is
			-- SDK SetViewportExt
		external
			"C [macro <windows.h>] (HDC, int, int, LPSIZE)"
		alias
			"SetViewportExtEx"
		end

	cwin_set_viewport_org_ex (hdc: POINTER; x_origin, y_origin: INTEGER;
			size: POINTER) is
			-- SDK SetViewportOrgEx
		external
			"C [macro <windows.h>] (HDC, int, int, LPPOINT)"
		alias
			"SetViewportOrgEx"
		end

	cwin_set_bk_mode (hdc: POINTER; mode: INTEGER) is
			-- SDK SetBkMode
		external
			"C [macro <windows.h>] (HDC, int)"
		alias
			"SetBkMode"
		end

	cwin_get_bk_mode (hdc: POINTER): INTEGER is
			-- SDK GetBkMode
		external
			"C [macro <windows.h>] (HDC): EIF_INTEGER"
		alias
			"GetBkMode"
		end

	cwin_set_bk_color (hdc: POINTER; color: INTEGER) is
			-- SDK SetBkColor
		external
			"C [macro <windows.h>] (HDC, COLORREF)"
		alias
			"SetBkColor"
		end

	cwin_get_bk_color (hdc: POINTER): INTEGER  is
			-- SDK GetBkColor
		external
			"C [macro <windows.h>] (HDC): COLORREF"
		alias
			"GetBkColor"
		end

	cwin_set_text_color (hdc: POINTER; color: INTEGER) is
			-- SDK SetBkColor
		external
			"C [macro <windows.h>] (HDC, COLORREF)"
		alias
			"SetTextColor"
		end

	cwin_get_text_color (hdc: POINTER): INTEGER is
			-- SDK GetBkColor
		external
			"C [macro <windows.h>] (HDC): COLORREF"
		alias
			"GetTextColor"
		end

	cwin_set_rop2 (hdc: POINTER; mode: INTEGER) is
			-- SDK SetROP2
		external
			"C [macro <windows.h>] (HDC, int)"
		alias
			"SetROP2"
		end

	cwin_get_rop2 (hdc: POINTER): INTEGER is
			-- SDK GetROP2
		external
			"C [macro <windows.h>] (HDC): EIF_INTEGER"
		alias
			"GetROP2"
		end

	cwin_get_text_extend_point (hdc: POINTER; s: POINTER; len: INTEGER;
			si: POINTER) is
			-- SDK GetTextExtentPoint
		external
			"C [macro <windows.h>] (HDC, LPCSTR, int, LPSIZE)"
		alias
			"GetTextExtentPoint"
		end

	cwin_get_tabbed_text_extent (hdc: POINTER; s: POINTER;
			len, tab_count: INTEGER; tabs: POINTER): INTEGER is
			-- SDK GetTabbedTextExtent
		external
			"C [macro <windows.h>] (HDC, LPCSTR, int, int, %
				%LPINT): EIF_INTEGER"
		alias
			"GetTabbedTextExtent"
		end

	cwin_device_caps (hdc: POINTER; capability: INTEGER): INTEGER is
			-- SDK GetDeviceCaps
		external
			"C [macro <windows.h>] (HDC, int): EIF_INTEGER"
		alias
			"GetDeviceCaps"
		end

	cwin_get_window_org_ex (hdc, point: POINTER) is
			-- SDK GetWindowOrgEx
		external
			"C [macro <windows.h>] (HDC, LPPOINT)"
		alias
			"GetWindowOrgEx"
		end

	cwin_get_window_ext_ex (hdc, point: POINTER) is
			-- SDK GetWindowExtEx
		external
			"C [macro <windows.h>] (HDC, LPSIZE)"
		alias
			"GetWindowExtEx"
		end

	cwin_get_viewport_org_ex (hdc, point: POINTER) is
			-- SDK GetViewportOrgEx
		external
			"C [macro <windows.h>] (HDC, LPPOINT)"
		alias
			"GetViewportOrgEx"
		end

	cwin_get_viewport_ext_ex (hdc, point: POINTER) is
			-- SDK GetViewportExtEx
		external
			"C [macro <windows.h>] (HDC, LPSIZE)"
		alias
			"GetViewportExtEx"
		end

	cwin_get_current_position_ex (hdc, point: POINTER) is
			-- SDK GetCurrentPositionEx
		external
			"C [macro <windows.h>] (HDC, POINT *)"
		alias
			"GetCurrentPositionEx"
		end

	cwin_get_text_face (hdc: POINTER; count: INTEGER;
				buffer: POINTER): INTEGER is
			-- SDK GetTextFace
		external
			"C [macro <windows.h>] (HDC, int, LPSTR): EIF_INTEGER"
		alias
			"GetTextFace"
		end

	cwin_get_di_bits (hdc, hbmp: POINTER; start_scan, scan_lines: INTEGER;
			bits, bi: POINTER; usage: INTEGER) is
			-- SDK GetDIBits
		external
			"C [macro <windows.h>] (HDC, HBITMAP, UINT, UINT, %
				%VOID *, BITMAPINFO *, UINT)"
		alias
			"GetDIBits"
		end

	c_file_ps (file: POINTER; a_string: POINTER; length: INTEGER) is
			-- Run-time function to print `a_string' to `file'.
		external
			"C(FILE *, char *, EIF_INTEGER) | %"eif_file.h%""
		alias
			"file_ps"
		end

	

	Opaque: INTEGER is
		external
			"C [macro <windows.h>]"
		alias
			"OPAQUE"
		end

	Transparent: INTEGER is
		external
			"C [macro <windows.h>]"
		alias
			"TRANSPARENT"
		end

	cwin_get_function_address (module_name: POINTER; function_name: POINTER): POINTER is
		external
			"C(char *, char *): FARPROC | %"wel_dynload.h%""
		end

	cwin_mask_blt (function_addr: POINTER; hdc_dest: POINTER; x_dest, y_dest, a_width,
			a_height: INTEGER; hdc_src: POINTER; x_src,
			y_src: INTEGER; hbm_mask: POINTER; x_mask, y_mask, rop: INTEGER) is
			-- SDK MaskBlt
		external
			"C (FARPROC, HDC, int, int, int, int, HDC, int, int, HBITMAP, int, int, DWORD) | %"wel_dynload.h%""
		end

	mask_blt_funcaddr: POINTER is
		require
			mask_blt_is_supported: mask_blt_supported
		do
			Result := internal_mask_blt_funcaddr
		end

	mask_blt_funcaddr_retrieved: BOOLEAN
		-- Have we already retrieved the address of the function "MaskBlt" ?

	internal_mask_blt_funcaddr: POINTER
		-- Address of the function "MaskBlt" if it exists.
		-- Void if the function is not present on the current system.

	retrieve_mask_blt_funcaddr is
		local
			a_string: STRING
			module_name_ptr: ANY
			function_name_ptr: ANY
		do
			a_string := "Gdi32.dll"
			module_name_ptr := a_string.to_c
			a_string := "MaskBlt"
			function_name_ptr := a_string.to_c
			internal_mask_blt_funcaddr := cwin_get_function_address($module_name_ptr, $function_name_ptr)
		end

invariant
	valid_background_mode: exists implies is_opaque /= is_transparent

end -- class WEL_DC

--|----------------------------------------------------------------
--| Windows Eiffel Library: library of reusable components for ISE Eiffel.
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

