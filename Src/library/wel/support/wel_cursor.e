indexing
	description: "Small picture whose location on the screen is controlled %
		%by a pointing device."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	WEL_CURSOR

inherit
	WEL_GRAPHICAL_RESOURCE

	WEL_SYSTEM_METRICS
		export
			{NONE} all
		end

creation
	make_by_id,
	make_by_name,
	make_by_file,
	make_by_bitmask,
	make_by_predefined_id,
	make_by_pointer,
	make_by_icon_info

feature {NONE} -- Initialization

	make_by_bitmask (x_hot_spot, y_hot_spot: INTEGER;
			and_plane, xor_plane: ARRAY [CHARACTER]) is
			-- Make a cursor using bitmask arrays.
			-- `and_plane' and `xor_plane' points to an array of
			-- byte that contains the bit values for the AND and XOR
			-- bitmasks of the cursor, as in a device-dependent
			-- monochrome bitmap. `x_hot_spot', and `y_hot_spot'
			-- specify the horizontal and vertical position of
			-- the cursor's hot spot.
		require
			x_hot_spot_large_enough: x_hot_spot >= 0
			x_hot_spot_small_enough: x_hot_spot < cursor_width
			y_hot_spot_large_enough: y_hot_spot >= 0
			y_hot_spot_small_enough: y_hot_spot < cursor_height
			and_plane_not_void: and_plane /= Void
			xor_plane_not_void: xor_plane /= Void
			and_plane_not_empty: not and_plane.empty
			xor_plane_not_empty: not xor_plane.empty
		local
			a1, a2: WEL_CHARACTER_ARRAY
		do
			create a1.make (and_plane)
			create a2.make (xor_plane)
			item := cwin_create_cursor (
				main_args.current_instance.item,
				x_hot_spot, y_hot_spot, cursor_width,
				cursor_height, a1.item, a2.item)
			gdi_make
		end

feature -- Access

	x_hotspot: INTEGER is
			-- X-coordinate of `Current's hot spot. 
		local
			icon_info: WEL_ICON_INFO
		do
			icon_info := get_icon_info
			if icon_info /= Void then
				Result := icon_info.x_hotspot
	
					-- Destroy `icon_info' structure
				icon_info.enable_reference_tracking_on_bitmaps
				icon_info.dispose
			else
				Result := 0
			end
		end
	
	y_hotspot: INTEGER is
			-- Y-coordinate of a `Current's hot spot. 
		local
			icon_info: WEL_ICON_INFO
		do
			icon_info := get_icon_info
			if icon_info /= Void then
				Result := icon_info.y_hotspot
	
					-- Destroy `icon_info' structure
				icon_info.enable_reference_tracking_on_bitmaps
				icon_info.dispose
			else
				Result := 0
			end
		end

	previous_cursor: WEL_CURSOR is
			-- Previously assigned cursor
		do
			if internal_previous_cursor /= default_pointer then
				create Result.make_by_pointer (internal_previous_cursor)
			end
		end

feature -- Basic operations

	set is
			-- Set current cursor for entire application and
			-- save old one in `previous_cursor' if there was
			-- one.
		require
			exists: exists
		do
			internal_previous_cursor := cwin_set_cursor (item)
		end

	restore_previous is
			-- Restore `previous_cursor'.
		require
			previous_cursor_not_void: previous_cursor /= Void
		local
			p: POINTER
		do
			p := cwin_set_cursor (internal_previous_cursor)
			internal_previous_cursor := default_pointer
		ensure
			previous_cursor_void: previous_cursor = Void
		end

feature {NONE} -- Implementation

	load_item (hinstance, id: POINTER) is
			-- Load cursor.
		do
			item := cwin_load_cursor (hinstance, id)
		end

	internal_previous_cursor: POINTER
			-- Pointer on previous cursor

	destroy_resource: BOOLEAN is
			-- SDK DestroyIcon/DestroyCursor
		do
			Result := cwin_destroy_cursor (item)
		end

feature {NONE} -- Externals

	cwin_set_cursor (hcursor: POINTER): POINTER is
			-- SDK SetCursor
		external
			"C [macro <wel.h>] (HCURSOR): EIF_POINTER"
		alias
			"SetCursor"
		end

	cwin_load_cursor (hinstance: POINTER; id: POINTER): POINTER is
			-- SDK LoadCursor
		external
			"C [macro <wel.h>] (HINSTANCE, LPCSTR): EIF_POINTER"
		alias
			"LoadCursor"
		end

	cwin_destroy_cursor (hcursor: POINTER): BOOLEAN is
			-- SDK DestroyCursor
		external
			"C [macro <wel.h>] (HCURSOR): BOOL"
		alias
			"DestroyCursor"
		end

	cwin_create_cursor (hinstance: POINTER; x_hot_spot, y_hot_spot, width,
			height: INTEGER; and_plane,
			xor_plane: POINTER): POINTER is
			-- SDK CreateCursor
		external
			"C [macro <wel.h>] (HINSTANCE, int, int, int, int,%
				% void *, void *): EIF_POINTER"
		alias
			"CreateCursor"
		end

feature {NONE} -- Constants

	Image_type: INTEGER is
		-- Constant defining the type of the image
		-- See WEL_IMAGE_CONSTANTS for possible values.
		do
			Result := Image_cursor
		end

end -- class WEL_CURSOR

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

