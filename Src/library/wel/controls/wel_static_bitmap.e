indexing
	description: "Control with a text."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	WEL_STATIC_BITMAP

inherit
	WEL_STATIC
		redefine
			make,
			Default_style
		end

	WEL_STM_CONSTANTS
		export
			{NONE} all
		end

	WEL_IMAGE_CONSTANTS
		export
			{NONE} all
		end

	WEL_DIB_COLORS_CONSTANTS
		export
			{NONE} all
		end

creation 
	make, make_by_bitmap_id

feature {NONE} -- Initialization

	make (a_parent: WEL_WINDOW; a_name: STRING;
			a_x, a_y, a_width, a_height, an_id: INTEGER) is
			-- Make a static control
		local
			bitmap_dib: WEL_DIB
			dc: WEL_SCREEN_DC
			raw_file: RAW_FILE
		do
			internal_window_make (a_parent, "", default_style, a_x, a_y, a_width, a_height, an_id, default_pointer)
			id := an_id
		
				-- Read the bitmap file
			create raw_file.make_open_read(a_name)
			create bitmap_dib.make_by_file(raw_file)

				-- Convert the bitmap to the current device
			create dc
			dc.get
			create bitmap.make_by_dib(dc, bitmap_dib, Dib_pal_colors)
			cwin_send_message(item, Stm_setimage, Image_bitmap, bitmap.to_integer)
			dc.release
		end

	make_by_bitmap_id (a_parent: WEL_WINDOW; bitmap_id: INTEGER;
			a_x, a_y, a_width, a_height, an_id: INTEGER) is
			-- Make a static control
		do
			internal_window_make (a_parent, "", default_style, a_x, a_y, a_width, a_height, an_id, default_pointer)
			id := an_id
		
				-- Read the bitmap file
			create bitmap.make_by_id(bitmap_id)

				-- Convert the bitmap to the current device
			cwin_send_message(item, Stm_setimage, Image_bitmap, bitmap.to_integer)
		end

feature -- Access

	bitmap: WEL_BITMAP
		-- displayed bitmap
	
feature {NONE} -- Implementation

	default_style: INTEGER is
			-- Default style used to create the control
		once
			Result := Ws_visible + Ws_child + Ws_group +
				Ws_tabstop + Ss_bitmap + Ss_centerimage
		end

end -- class WEL_STATIC_BITMAP


--|----------------------------------------------------------------
--| Windows Eiffel Library: library of reusable components for ISE Eiffel.
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

