note
	description: "Control with a text."
	legal: "See notice at end of class."
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

create
	make, make_by_bitmap_id

feature {NONE} -- Initialization

	make (a_parent: WEL_WINDOW; a_name: STRING;
			a_x, a_y, a_width, a_height, an_id: INTEGER)
			-- Make a static control
		local
			bitmap_dib: WEL_DIB
			dc: WEL_SCREEN_DC
			raw_file: RAW_FILE
			l_bitmap: like bitmap
		do
			internal_window_make (a_parent, Void, default_style, a_x, a_y, a_width, a_height, an_id, default_pointer)
			id := an_id

				-- Read the bitmap file
			create raw_file.make_open_read(a_name)
			create bitmap_dib.make_by_file(raw_file)

				-- Convert the bitmap to the current device
			create dc
			dc.get
			create l_bitmap.make_by_dib(dc, bitmap_dib, Dib_pal_colors)
			bitmap := l_bitmap
			{WEL_API}.send_message(item, Stm_setimage, to_wparam (Image_bitmap), l_bitmap.item)
			dc.release
		end

	make_by_bitmap_id (a_parent: WEL_WINDOW; bitmap_id: INTEGER;
			a_x, a_y, a_width, a_height, an_id: INTEGER)
			-- Make a static control
		require
			a_parent_not_void: a_parent /= Void
			a_parent_exists: a_parent.exists
			bitmap_id_positive: bitmap_id > 0
		local
			l_bitmap: like bitmap
		do
			internal_window_make (a_parent, Void, default_style, a_x, a_y, a_width, a_height, an_id, default_pointer)
			id := an_id

				-- Read the bitmap file
			create l_bitmap.make_by_id (bitmap_id)
			bitmap := l_bitmap

				-- Convert the bitmap to the current device
			{WEL_API}.send_message(item, Stm_setimage, to_wparam (Image_bitmap), l_bitmap.item)
		end

feature -- Access

	bitmap: detachable WEL_BITMAP
		-- displayed bitmap

feature {NONE} -- Implementation

	default_style: INTEGER
			-- Default style used to create the control
		once
			Result := Ws_visible + Ws_child + Ws_group +
				Ws_tabstop + Ss_bitmap + Ss_centerimage
		end

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




end -- class WEL_STATIC_BITMAP

