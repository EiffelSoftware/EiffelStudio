indexing
	description	: "EiffelVision pixmap. Common attributes between%
				  %all different EV_PIXMAP Windows implementation"
	status		: "See notice at end of class"
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
				temp_alpha := temp_alpha_int.ascii_char
			until
				array_offset = array_size
			loop
				col_ref_item := cwin_get_pixel (
						mem_dc_item,
						(array_offset \\ (a_width) // 4),
						((array_offset) // a_width)
				)
				array_area.put (cwin_get_r_value (col_ref_item).ascii_char, array_offset)
				array_area.put (cwin_get_g_value (col_ref_item).ascii_char, array_offset + 1)
				array_area.put (cwin_get_b_value (col_ref_item).ascii_char, array_offset + 2)
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

feature {
		EV_PIXMAP_IMP, 
		EV_PIXMAP_IMP_DRAWABLE,
		EV_PIXMAP_IMP_WIDGET
		} -- Implementation

	interface: EV_PIXMAP



end -- class EV_PIXMAP_IMP_STATE

--!-----------------------------------------------------------------------------
--! EiffelVision: library of reusable components for ISE Eiffel.
--! Copyright (C) 1986-2000 Interactive Software Engineering Inc.
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

--|----------------------------------------------------------------
--| CVS log
--|----------------------------------------------------------------
--|
--| $Log$
--| Revision 1.9  2001/07/14 12:16:30  manus
--| Cosmetics, replace the long:
--| --|-----------------------------------------------------------------------------
--| by the short version which is standard among all ISE libraries
--| --|----------------------------------------------------------------
--|
--| Revision 1.8  2001/07/10 16:58:06  rogers
--| Standardized indexing clauses.
--|
--| Revision 1.7  2001/06/07 23:08:17  rogers
--| Merged DEVEL branch into Main trunc.
--|
--| Revision 1.5.2.15  2001/03/04 22:35:25  pichery
--| - Added postconditions/preconditions
--| - Added reference_tracking
--| - renammed `bitmap' into `get_bitmap'
--|
--| Revision 1.5.2.14  2001/02/23 23:50:41  pichery
--| - Added tight reference tracking for wel_bitmaps.
--| - Refactored `build_cursor' and `build_icon'
--|
--| Revision 1.5.2.13  2001/02/01 19:06:42  rogers
--| Formatted raw_image_data and removed debuggin output.
--|
--| Revision 1.5.2.12  2001/01/26 17:38:02  king
--| Optimized raw_image_data further by removing unnecessary creation of objects
--|
--| Revision 1.5.2.11  2001/01/15 16:39:26  king
--| Optimized raw_image_data
--|
--| Revision 1.5.2.10  2000/10/16 14:44:41  pichery
--| - replaced `dispose' with `delete'.
--| - cosmetics
--| - improved `destroy'.
--|
--| Revision 1.5.2.9  2000/10/12 15:50:29  pichery
--| Added reference tracking for GDI objects to decrease
--| the number of GDI objects alive.
--|
--| Revision 1.5.2.8  2000/10/06 00:08:17  king
--| Implemented raw_image_data
--|
--| Revision 1.5.2.6  2000/09/13 00:14:41  manus
--| Fixed a bug where `build_icon' and `build_cursor' did not save `icon' or `cursor'. As a
--| result we were creating too may ìcons or cursors exploding our GDI usage. Now the GDI usage
--| is more constant.
--|
--| Revision 1.5.2.5  2000/08/11 18:26:43  rogers
--| Fixed copyright clauses. Now use ! instead of |.
--|
--| Revision 1.5.2.4  2000/07/25 16:29:03  rogers
--| Added inheritance from EV_WIDGET_ACTION_SEQUENCES_IMP,
--| EV_PICK_AND_dROPABLE_ACTION_SEQUENCES_IMP,
--| EV_PIXMAP_ACTION_SEQUENCES_IMP. This class is a common ancester for
--| the different implementations of pixmaps on windows. This change
--| simplifies further inheritance changes.
--|
--| Revision 1.5.2.3  2000/06/19 21:37:11  rogers
--| Removed FIXME NOT_REVIEWED. Comments, formatting.
--|
--| Revision 1.5.2.2  2000/05/04 04:23:59  pichery
--| Added feature `build_cursor' and added
--| `interface'.
--|
--| Revision 1.5.2.1  2000/05/03 19:09:53  oconnor
--| mergred from HEAD
--|
--| Revision 1.5  2000/05/03 04:36:40  pichery
--| Removed parameter in feature `set_with_default'.
--|
--| Revision 1.4  2000/05/03 00:37:00  pichery
--| Added feature `build_icon' + Refactoring.
--|
--| Revision 1.3  2000/04/25 01:25:12  pichery
--| Added `icon' attribute for polymorphism
--|
--| Revision 1.2  2000/04/13 18:33:12  pichery
--| Added access to width & height
--|
--| Revision 1.1  2000/04/12 01:34:56  pichery
--| New pixmap implementation.
--| Use 3 differents states depending on
--| what the user is doing with the pixmap.
--|
--|
--|----------------------------------------------------------------
--| End of CVS log
--|----------------------------------------------------------------
