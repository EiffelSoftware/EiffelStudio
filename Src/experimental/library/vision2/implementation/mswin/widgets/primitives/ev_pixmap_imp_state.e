note
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
		export
			{EV_PIXMAP_IMP_STATE}
				all
		end

	EV_PICK_AND_DROPABLE_ACTION_SEQUENCES_IMP
		export
			{EV_PIXMAP_IMP_STATE}
				all
		end

	EV_PIXMAP_ACTION_SEQUENCES_IMP
		export
			{EV_PIXMAP_IMP_STATE}
				expose_actions_internal
		end

	WEL_COLOR_REF
		rename
			make as col_ref_make,
			make_by_pointer as col_ref_make_by_pointer
		end

feature -- Access

	get_bitmap: WEL_BITMAP
			-- Current bitmap used.
			--
			-- The number of references if incremented when calling
			-- this feature, call `WEL_BITMAP.decrement_reference'
		deferred
		ensure
			Result_not_void: Result /= Void
		end

	get_mask_bitmap: WEL_BITMAP
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

	icon: WEL_ICON
			-- Current pixmap in HICON format. Void if none.
		deferred
		end

	cursor: WEL_CURSOR
			-- Current pixmap in HCURSOR format. Void if none.
		deferred
		end

	has_mask: BOOLEAN
			-- Has the current pixmap a mask?
		deferred
		ensure
			has_mask_implies_mask_bitmap_not_void: Result implies get_mask_bitmap /= Void
		end

	palette: WEL_PALETTE
		-- Current palette used. Void if none.
		deferred
		end

feature -- Saving

	save_to_named_file (a_format: EV_GRAPHICAL_FORMAT; a_filename: FILE_NAME)
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
			a_fn: C_STRING
			l_area: ANY
			a_width, a_height: INTEGER
			l_raw_image_data: like raw_image_data
			l_managed_pointer: MANAGED_POINTER
			l_area_ptr: POINTER
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
				if {PLATFORM}.is_dotnet then
					create l_managed_pointer.make_from_array (l_raw_image_data)
					l_area_ptr := l_managed_pointer.item
				else
					l_area := l_raw_image_data.to_c
					l_area_ptr := $l_area
				end
				c_ev_save_png (l_area_ptr, a_fn.item, l_raw_image_data.width,
					l_raw_image_data.height, a_width, a_height, png_format.color_mode)
			end
			save_with_format (a_format, a_filename, l_raw_image_data)
		end

feature {NONE} -- Savings

	save_with_format (a_format: EV_GRAPHICAL_FORMAT; a_filename: FILE_NAME; a_raw_image_data: like raw_image_data)
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

	copy_events_from_other (other: EV_PIXMAP_IMP_STATE)
			-- Copy all events from `other' to `Current'.
			-- Note that `other' is EV_PIXMAP_I and not EV_PIXMAP_IMP,
			-- as we need to use this in cases where `other' will
			-- not conform to EV_PIXMAP_IMP.
		do
			expose_actions_internal := other.expose_actions_internal
			focus_in_actions_internal := other.focus_in_actions_internal
			focus_out_actions_internal := other.focus_out_actions_internal
			key_press_actions_internal := other.key_press_actions_internal
			key_press_string_actions_internal := other.key_press_string_actions_internal
			key_release_actions_internal := other.key_release_actions_internal
			pointer_button_press_actions_internal := other.pointer_button_press_actions_internal
			pointer_button_release_actions_internal := other.pointer_button_release_actions_internal
			pointer_double_press_actions_internal := other.pointer_double_press_actions_internal
			pointer_enter_actions_internal := other.pointer_enter_actions_internal
			pointer_leave_actions_internal := other.pointer_leave_actions_internal
			pointer_motion_actions_internal := other.pointer_motion_actions_internal
			resize_actions_internal := other.resize_actions_internal
			conforming_pick_actions_internal := other.conforming_pick_actions_internal
			drop_actions_internal := other.drop_actions_internal
			pick_actions_internal := other.pick_actions_internal
			pick_ended_actions_internal := other.pick_ended_actions_internal
		end

	raw_image_data: EV_RAW_IMAGE_DATA
			-- RGBA representation of `Current'.
		local
			mask_dc, mem_dc: WEL_MEMORY_DC
			a_width: INTEGER
			array_offset, array_size: INTEGER
			array_area: SPECIAL [NATURAL_8]
			col_Ref_item: NATURAL_32
			mask_dc_item, mem_dc_item: POINTER
			tmp_mask_bitmap, tmp_bitmap: WEL_BITMAP
			l_has_mask: BOOLEAN
			l_x, l_y: INTEGER
		do
			create Result.make_with_alpha_zero (width, height)
			create mem_dc.make
			tmp_bitmap := get_bitmap
			mem_dc.select_bitmap (tmp_bitmap)
			l_has_mask := has_mask
			if l_has_mask then
				create mask_dc.make
				tmp_mask_bitmap := get_mask_bitmap
				mask_dc.select_bitmap (tmp_mask_bitmap)
				mask_dc_item := mask_dc.item
			end

			Result.set_originating_pixmap (interface)
			from
				a_width := width * 4
				array_size := a_width * height
				array_area := Result.area
				mem_dc_item := mem_dc.item
			until
				array_offset = array_size
			loop
				l_x := (array_offset \\ (a_width) // 4)
				l_y := ((array_offset) // a_width)
				col_ref_item := cwin_get_pixel (
						mem_dc_item,
						l_x,
						l_y
				)
				array_area.put (get_rvalue (col_ref_item), array_offset)
				array_area.put (get_gvalue (col_ref_item), array_offset + 1)
				array_area.put (get_bvalue (col_ref_item), array_offset + 2)
				if l_has_mask then
					col_ref_item := cwin_get_pixel (
						mask_dc_item,
						l_x,
						l_y
					)
						-- If mask color is 1 then pixel is opaque, so we use 255 for the mask value.
					if get_rvalue (col_ref_item) /= 0 then
						array_area.put (255, array_offset + 3)
					else
						array_area.put (0, array_offset + 3)
					end
				else
					array_area.put (255, array_offset + 3)
				end

				array_offset := array_offset + 4
			end

			if l_has_mask then
				mask_dc.unselect_bitmap
				mask_dc.delete
				tmp_mask_bitmap.decrement_reference
				tmp_mask_bitmap := Void
			end

			mem_dc.unselect_bitmap
			mem_dc.delete
			tmp_bitmap.decrement_reference
			tmp_bitmap := Void
		end

	gdi_compact
			-- Spare GDI resource by freeing icons, cursors, ... that
			-- can be reloaded from file.
		do
		end

	build_icon: WEL_ICON
			-- Build a WEL_ICON from `bitmap' and `mask_bitmap'.
		do
			Result ?= build_graphical_resource (True)
		ensure
			Result_not_void: Result /= Void
		end

	build_cursor: WEL_CURSOR
			-- Build a WEL_CURSOR from `bitmap' and `mask_bitmap'.
		do
			Result ?= build_graphical_resource (False)
		ensure
			Result_not_void: Result /= Void
		end

	init_from_pixel_buffer (a_pixel_buffer: EV_PIXEL_BUFFER)
			-- Initialize from `a_pixel_buffer'
		local
			l_pixel_buffer: EV_PIXEL_BUFFER_IMP
		do
			l_pixel_buffer ?= a_pixel_buffer.implementation
			l_pixel_buffer.draw_to_drawable (interface)
		end

feature -- Measurement

	width: INTEGER
			-- Width of the pixmap in pixels.
		deferred
		end

	height: INTEGER
			-- Height of the pixmap in pixels.
		deferred
		end

feature {EV_POINTER_STYLE_IMP} -- Implementation

	build_graphical_resource (is_icon: BOOLEAN): WEL_GRAPHICAL_RESOURCE
			-- Build an icon if `is_icon' is set, or a cursor
			-- otherwise.
		local
			icon_info: WEL_ICON_INFO
			mem_dc: WEL_MEMORY_DC
			empty_mask_bitmap: WEL_BITMAP
			raster_operations: WEL_RASTER_OPERATIONS_CONSTANTS
			ev_cursor_interface: EV_CURSOR
			l_bitmap: WEL_BITMAP
			tmp_bitmap: WEL_BITMAP
			tmp_mask_bitmap: WEL_BITMAP
			l_mask_bitmap_dc: WEL_MEMORY_DC
			l_bitmap_dc: WEL_MEMORY_DC
		do
			create icon_info.make
			icon_info.set_unshared
			icon_info.set_is_icon (is_icon)
			l_bitmap := get_bitmap
			create tmp_bitmap.make_by_bitmap (l_bitmap)
			tmp_bitmap.enable_reference_tracking
			l_bitmap.decrement_reference

			if not is_icon then
				ev_cursor_interface ?= interface
				if ev_cursor_interface /= Void then
					-- This is a cursor, so set the hotspot
					icon_info.set_x_hotspot (ev_cursor_interface.x_hotspot)
					icon_info.set_y_hotspot (ev_cursor_interface.y_hotspot)
				end
			end

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
			if has_mask then
				mem_dc.pat_blt (0, 0, width, height,
				raster_operations.whiteness)
				tmp_mask_bitmap := get_mask_bitmap
				create l_mask_bitmap_dc.make_by_dc (mem_dc)
				l_mask_bitmap_dc.select_bitmap (tmp_mask_bitmap)
					-- We need to invert the mask as Windows uses 0 for Opaque and 1 for Transparent.
				mem_dc.bit_blt (0, 0, width, height, l_mask_bitmap_dc, 0, 0, raster_operations.srcinvert)

				create l_bitmap_dc.make
				l_bitmap_dc.select_bitmap (tmp_bitmap)
				l_bitmap_dc.bit_blt (0, 0, width, height, mem_dc, 0, 0, raster_operations.maskpaint)
				l_bitmap_dc.unselect_bitmap
				l_bitmap_dc.delete

				l_mask_bitmap_dc.unselect_bitmap
				l_mask_bitmap_dc.delete
			else
					-- We have no mask so make sure that all of the pixmap is visible.
				mem_dc.pat_blt (0, 0, width, height, raster_operations.blackness)
			end
			mem_dc.unselect_bitmap
			mem_dc.delete

			icon_info.set_color_bitmap (tmp_bitmap)
			icon_info.set_mask_bitmap (empty_mask_bitmap)
			if is_icon then
				create {WEL_ICON} Result.make_by_icon_info (icon_info)
			else
				create {WEL_CURSOR} Result.make_by_icon_info (icon_info)
			end
			empty_mask_bitmap.decrement_reference
			icon_info.delete
			tmp_bitmap.decrement_reference
			tmp_bitmap := Void
			if tmp_mask_bitmap /= Void then
				tmp_mask_bitmap.decrement_reference
				tmp_mask_bitmap := Void
			end
		end

feature {EV_ANY_I} -- Implementation

	update_for_pick_and_drop (starting: BOOLEAN)
			-- Pick and drop status has changed so update appearance of
			-- `Current' to reflect available targets.
		do
			-- Nothing to do here.
		end

feature {NONE} -- External

	get_rvalue (color: NATURAL_32): NATURAL_8
			-- SDK GetRValue
		external
			"C [macro <windows.h>] (DWORD): BYTE"
		alias
			"GetRValue"
		end

	get_gvalue (color: NATURAL_32): NATURAL_8
			-- SDK GetGValue
		external
			"C [macro <windows.h>] (DWORD): BYTE"
		alias
			"GetGValue"
		end

	get_bvalue (color: NATURAL_32): NATURAL_8
			-- SDK GetBValue
		external
			"C [macro <windows.h>] (DWORD): BYTE"
		alias
			"GetBValue"
		end


	cwin_get_pixel (hdc: POINTER; x, y: INTEGER): NATURAL_32
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
			a_colormode: INTEGER)
		external
			"C signature (char *, char *, int, int, int, int, int) use %"load_pixmap.h%""
		end

feature {
		EV_PIXMAP_IMP,
		EV_PIXMAP_IMP_DRAWABLE,
		EV_PIXMAP_IMP_WIDGET
		} -- Implementation

	interface: EV_PIXMAP;

note
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

