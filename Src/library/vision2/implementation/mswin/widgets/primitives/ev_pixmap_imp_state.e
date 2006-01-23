indexing
	description	: "EiffelVision pixmap. Common attributes between%
				  %all different EV_PIXMAP Windows implementation"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date		: "$Date$"
	revision	: "$Revision$"

deferred class
	EV_PIXMAP_IMP_STATE

inherit

	EV_WIDGET_ACTION_SEQUENCES_IMP

	EV_PICK_AND_DROPABLE_ACTION_SEQUENCES_IMP

	EV_PIXMAP_ACTION_SEQUENCES_IMP

	WEL_COLOR_REF
		rename
			make as col_ref_make,
			make_by_pointer as col_ref_make_by_pointer
		end

feature -- Access

	get_bitmap: WEL_BITMAP is
			-- Current bitmap used.
			--
			-- The number of references if incremented when calling
			-- this feature, call `WEL_BITMAP.decrement_reference'
		deferred
		ensure
			Result_not_void: Result /= Void
		end

	get_mask_bitmap: WEL_BITMAP is
			-- Monochrome bitmap used as mask.
			--
			-- The number of references if incremented when calling
			-- this feature, call `WEL_BITMAP.decrement_reference'
		require
			mask_in_use: has_mask
		deferred
		ensure
			Result_not_void: Result /= Void
		end

	icon: WEL_ICON is
			-- Current pixmap in HICON format. Void if none.
		deferred
		end

	cursor: WEL_CURSOR is
			-- Current pixmap in HCURSOR format. Void if none.
		deferred
		end

	has_mask: BOOLEAN is
			-- Has the current pixmap a mask?
		deferred
		ensure
			has_mask_implies_mask_bitmap_not_void: Result implies get_mask_bitmap /= Void
		end

	palette: WEL_PALETTE is
		-- Current palette used. Void if none.
		deferred
		end

feature -- Saving

	save_to_named_file (a_format: EV_GRAPHICAL_FORMAT; a_filename: FILE_NAME) is
			-- Save `Current' to `a_filename' in `a_format' format.
		require
			a_format_not_void: a_format /= Void
			a_filename_not_void: a_filename /= Void
			a_filename_valid: a_filename.is_valid
		local
			bmp_format: EV_BMP_FORMAT
			png_format: EV_PNG_FORMAT
			mem_dc: WEL_MEMORY_DC
			a_wel_bitmap: WEL_BITMAP
			a_fn: WEL_STRING
			char_array: WEL_CHARACTER_ARRAY
			a_width, a_height: INTEGER
			l_raw_image_data: like raw_image_data
		do
			bmp_format ?= a_format
			png_format ?= a_format
			l_raw_image_data := raw_image_data
			if bmp_format /= Void then
				create mem_dc.make
					--| FIXME. Add code for dealing with cursors & icons.
				a_wel_bitmap := get_bitmap
				mem_dc.select_bitmap (a_wel_bitmap)
				mem_dc.save_bitmap (a_wel_bitmap, a_filename)
				mem_dc.unselect_bitmap
				mem_dc.delete
				a_wel_bitmap.decrement_reference
			elseif png_format /= Void then
				create a_fn.make (a_filename)
				create char_array.make (l_raw_image_data)
				if png_format.scale_height /= 0 then
					a_height := png_format.scale_height
				else
					a_height := l_raw_image_data.height
				end
	
				if png_format.scale_width /= 0 then
					a_width := png_format.scale_width
				else
					a_width := l_raw_image_data.width
				end
				c_ev_save_png (char_array.item, a_fn.item, l_raw_image_data.width,
					l_raw_image_data.height, a_width, a_height, png_format.color_mode)
			end
			save_with_format (a_format, a_filename, l_raw_image_data)
		end

feature {NONE} -- Savings

	save_with_format (a_format: EV_GRAPHICAL_FORMAT; a_filename: FILE_NAME; a_raw_image_data: like raw_image_data) is
			-- Call `save' on `a_format'. Implemented in descendant since `save' from
			-- EV_GRAPHICAL_FORMAT is only exported to EV_PIXMAP_I.
		require
			a_format_not_void: a_format /= Void
			a_filename_not_void: a_filename /= Void
			a_filename_valid: a_filename.is_valid
			a_raw_image_data_not_void: a_raw_image_data /= Void
		deferred
		end

feature -- Misc.

	raw_image_data: EV_RAW_IMAGE_DATA is
			-- RGBA representation of `Current'.
		local
			mem_dc: WEL_MEMORY_DC
			a_width: INTEGER
			array_offset, array_size: INTEGER
			array_area: SPECIAL [CHARACTER]
			col_Ref_item: integer
			temp_alpha: CHARACTER
			temp_alpha_int: INTEGER
			mem_dc_item: POINTER
			tmp_bitmap: WEL_BITMAP
		do
			create Result.make_with_alpha_zero (width, height)
			create mem_dc.make
			tmp_bitmap := get_bitmap
			mem_dc.select_bitmap (tmp_bitmap)
			Result.set_originating_pixmap (interface)
			from
				a_width := width * 4
				array_size := a_width * height
				array_area := Result.area
				mem_dc_item := mem_dc.item
				temp_alpha_int := 255
				temp_alpha := temp_alpha_int.to_character
			until
				array_offset = array_size
			loop
				col_ref_item := cwin_get_pixel (
						mem_dc_item,
						(array_offset \\ (a_width) // 4),
						((array_offset) // a_width)
				)
				array_area.put (cwin_get_r_value (col_ref_item).to_character, array_offset)
				array_area.put (cwin_get_g_value (col_ref_item).to_character, array_offset + 1)
				array_area.put (cwin_get_b_value (col_ref_item).to_character, array_offset + 2)
				array_area.put (temp_alpha, array_offset + 3)
				array_offset := array_offset + 4
			end
			mem_dc.unselect_bitmap
			mem_dc.delete
			tmp_bitmap.decrement_reference
			tmp_bitmap := Void
		end

	gdi_compact is
			-- Spare GDI ressource by freeing icons, cursors, ... that
			-- can be reloaded from file.
		do
		end

	build_icon: WEL_ICON is
			-- Build a WEL_ICON from `bitmap' and `mask_bitmap'.
		do
			Result ?= build_graphical_resource (True)
		ensure
			Result_not_void: Result /= Void
		end

	build_cursor: WEL_CURSOR is
			-- Build a WEL_CURSOR from `bitmap' and `mask_bitmap'.
		do
			Result ?= build_graphical_resource (False)
		ensure
			Result_not_void: Result /= Void
		end
		
feature -- Measurement

	width: INTEGER is
			-- Width of the pixmap in pixels.
		deferred
		end

	height: INTEGER is
			-- Height of the pixmap in pixels.
		deferred
		end

feature {NONE} -- Implementation

	build_graphical_resource (is_icon: BOOLEAN): WEL_GRAPHICAL_RESOURCE is
			-- Build an icon if `is_icon' is set, or a cursor
			-- otherwise.
		local
			icon_info: WEL_ICON_INFO
			mem_dc: WEL_MEMORY_DC
			empty_mask_bitmap: WEL_BITMAP
			raster_operations: WEL_RASTER_OPERATIONS_CONSTANTS
			ev_cursor_interface: EV_CURSOR
			tmp_bitmap: WEL_BITMAP
			tmp_mask_bitmap: WEL_BITMAP
		do
			create icon_info.make
			icon_info.set_unshared
			icon_info.set_is_icon (is_icon)
			tmp_bitmap := get_bitmap
			icon_info.set_color_bitmap (tmp_bitmap)
			
			if not is_icon then
				ev_cursor_interface ?= interface
				if ev_cursor_interface /= Void then
					-- This is a cursor, so set the hotspot
					icon_info.set_x_hotspot (ev_cursor_interface.x_hotspot)
					icon_info.set_y_hotspot (ev_cursor_interface.y_hotspot)
				end
			end

			if has_mask then
				tmp_mask_bitmap := get_mask_bitmap
				icon_info.set_mask_bitmap (tmp_mask_bitmap)
				if is_icon then
					create {WEL_ICON} Result.make_by_icon_info (icon_info)
				else
					create {WEL_CURSOR} Result.make_by_icon_info (icon_info)
				end
			else
				-- create an empty mask
				create mem_dc.make
				create empty_mask_bitmap.make_compatible (
					mem_dc,
					width,
					height
					)
				empty_mask_bitmap.enable_reference_tracking
				mem_dc.select_bitmap (empty_mask_bitmap)
				create raster_operations
				mem_dc.pat_blt (0, 0, width, height, 
					raster_operations.blackness)
				mem_dc.unselect_bitmap
				mem_dc.delete
				icon_info.set_mask_bitmap (empty_mask_bitmap)
				if is_icon then
					create {WEL_ICON} Result.make_by_icon_info (icon_info)
				else
					create {WEL_CURSOR} Result.make_by_icon_info (icon_info)
				end
				empty_mask_bitmap.decrement_reference
			end
			icon_info.delete
			tmp_bitmap.decrement_reference
			tmp_bitmap := Void
			if tmp_mask_bitmap /= Void then
				tmp_mask_bitmap.decrement_reference
				tmp_mask_bitmap := Void
			end
		end

feature {NONE} -- External

	cwin_get_pixel (hdc: POINTER; x, y: INTEGER): INTEGER is
			-- SDK GetPixel
		external
			"C [macro <windows.h>] (HDC, int, int): COLORREF"
		alias
			"GetPixel"
		end

	c_ev_save_png (char_array, path: POINTER;
			array_width,
			array_height,
			a_scale_width,
			a_scale_height,
			a_colormode: INTEGER) is
		external
			"C signature (char *, char *, int, int, int, int, int) use %"load_pixmap.h%""
		end

feature {
		EV_PIXMAP_IMP, 
		EV_PIXMAP_IMP_DRAWABLE,
		EV_PIXMAP_IMP_WIDGET
		} -- Implementation

	interface: EV_PIXMAP;

indexing
	copyright:	"Copyright (c) 1984-2006, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			 Eiffel Software
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"




end -- class EV_PIXMAP_IMP_STATE

