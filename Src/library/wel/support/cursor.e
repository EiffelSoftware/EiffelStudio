indexing
	description: "Small picture whose location on the screen is controlled %
		%by a pointing device."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	WEL_CURSOR

inherit
	WEL_RESOURCE

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
	make_by_pointer

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
			!! a1.make (and_plane)
			!! a2.make (xor_plane)
			item := cwin_create_cursor (
				main_args.current_instance.item,
				x_hot_spot, y_hot_spot, cursor_width,
				cursor_height, a1.item, a2.item)
		end

	make_by_file (file_name: FILE_NAME) is
			-- Load a cusor file named `file_name'.
			-- Only Windows 95.
		require
			file_name_not_void: file_name /= Void
		local
			a_wel_string: WEL_STRING
		do
			!! a_wel_string.make (file_name)
			item := cwin_load_image (default_pointer, a_wel_string.item,
				Image_cursor, 0, 0, Lr_loadfromfile)
		end

feature -- Access

	previous_cursor: WEL_CURSOR
			-- Previously assigned cursor

feature -- Basic operations

	set is
			-- Set the current cursor for the entire application and
			-- save the old one in `previous_cursor' if there was
			-- one.
		require
			exists: exists
		local
			p: POINTER
		do
			p := cwin_set_cursor (item)
			if p /= default_pointer then
				!! previous_cursor.make_by_pointer (p)
			end
		end

	restore_previous is
			-- Restore the `previous_cursor'.
		require
			previous_cursor_not_void: previous_cursor /= Void
		local
			p: POINTER
		do
			p := cwin_set_cursor (previous_cursor.item)
			previous_cursor := Void
		ensure
			previous_cursor_void: previous_cursor = Void
		end

feature {NONE} -- Implementation

	load_item (hinstance, id: POINTER) is
			-- Load cursor.
		do
			item := cwin_load_cursor (hinstance, id)
		end

	destroy_item is
			-- Destroy cursor.
		do
			cwin_destroy_cursor (item)
			item := default_pointer
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

	cwin_destroy_cursor (hcursor: POINTER) is
			-- SDK DestroyCursor
		external
			"C [macro <wel.h>] (HCURSOR)"
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

	cwin_load_image (hinstance, name: POINTER; type, width, height,
				load_flags: INTEGER): POINTER is
			-- SDK LoadImage
		external
			"C [macro <wel.h>] (HINSTANCE, LPCSTR, UINT, int, int, %
				%UINT): EIF_POINTER"
		alias
			"LoadImage"
		end

	Lr_loadfromfile: INTEGER is
		external
			"C [macro <wel.h>]"
		alias
			"LR_LOADFROMFILE"
		end

	Image_cursor: INTEGER is
		external
			"C [macro <wel.h>]"
		alias
			"IMAGE_CURSOR"
		end

end -- class WEL_CURSOR

--|-------------------------------------------------------------------------
--| Windows Eiffel Library: library of reusable components for ISE Eiffel.
--| Copyright (C) 1995-1997, Interactive Software Engineering, Inc.
--| All rights reserved. Duplication and distribution prohibited.
--|
--| 270 Storke Road, Suite 7, Goleta, CA 93117 USA
--| Telephone 805-685-1006
--| Fax 805-685-6869
--| Information e-mail <info@eiffel.com>
--| Customer support e-mail <support@eiffel.com>
--|-------------------------------------------------------------------------
