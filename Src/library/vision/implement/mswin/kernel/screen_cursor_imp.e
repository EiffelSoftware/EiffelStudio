indexing

	description: "This class represents a MS_WINDOWS cursor";
	status: "See notice at end of class";
	date: "$Date$";
	revision: "$Revision$"

class
	SCREEN_CURSOR_IMP

inherit

	SCREEN_CURSOR_I

	WEL_CURSOR

	WEL_IDC_CONSTANTS
		export
			{NONE} all
		end

	BASIC_ROUTINES

creation
	make,
	make_for_screen

feature -- Initialization

	make (a_cursor: SCREEN_CURSOR) is
			-- Create the screen cursor
		do
			set_type (X_cursor)
		end

	make_for_screen (a_cursor: SCREEN_CURSOR; a_screen: SCREEN) is
			-- Create the screen cursor
		do
			set_type (X_cursor)
		end

feature -- Status report

	type: INTEGER
			-- Type of a predefined cursor

feature -- Status setting

	set_type (new_type: INTEGER) is
			-- Set cursor to `new_type'.
			-- If this type is not predefined, the type will be Arrow.
		do
			inspect
				new_type
			when Arrow then
				make_by_predefined_id (idc_arrow)
			when Based_arrow_up then
				make_by_predefined_id (idc_uparrow)
			when Bottom_left_corner, Top_right_corner then
				make_by_predefined_id (idc_sizenesw)
			when Bottom_right_corner, top_left_corner then
				make_by_predefined_id (idc_sizenwse)
			when Clock, Watch then
				make_by_predefined_id (idc_wait)
			when Crosshair,Fleur then
				make_by_predefined_id (idc_sizeall)
			when Sb_h_double_arrow then
				make_by_predefined_id (idc_sizewe)
			when Sb_v_double_arrow then
				make_by_predefined_id (idc_sizens)
			else
				make_by_predefined_id (idc_arrow)				
			end
			check
				exists: exists
			end
			type := new_type
		end

	set_pixmap (pixmap, mask: PIXMAP) is
			-- Set `pixmap' as the new shape of the cursor.
			-- `mask' is the pixel of pixmap that are to be displayed.
			-- If `mask' is Void, a suitable mask is drawn from `pixmap'.
			-- Note that `pixmap' and `mask' are not kept by the cursor,
			-- they may be disposed, and if they change, cursor will be
			-- altered.
		local
			pw,mw: PIXMAP_IMP
			xmw, xdib: X_BITMAP_WINDOWS
			and_mask, xor_mask: ARRAY [CHARACTER]
			i, cursor_size: INTEGER
			c: CHARACTER
		do
			pw ?= pixmap.implementation
			if mask /= Void then
				mw ?= mask.implementation
			else
				mw ?= pixmap.implementation
			end
			if pw.cursor /= Void then
				item := pw.cursor.item
			elseif pw.dib /= Void then
				xdib ?= pw.dib
				if xdib /= Void then
					xmw ?= mw.dib
					cursor_size := cursor_width // 8 * cursor_height
					and_mask := mask_from_pixmap_array (xdib.array)
						-- Mask currently ignored
						-- Behavior indeterminate otherwise
					!! xor_mask.make (1, cursor_size)
					from
						c := charconv (255)
						i := 1
					until
						i > cursor_size
					loop
						xor_mask.put (c, i)
						i := i + 1
					end
					make_by_bitmask (pw.hot_x, pw.hot_y, xor_mask, and_mask)
				end
			end
			type := user_defined_pixmap
		end

	mask_from_pixmap_array (array: ARRAY2 [CHARACTER]): ARRAY [CHARACTER] is
				-- Create a mask from the pixmap in `array'
		local
			row, column: INTEGER
		do
			from
				!! Result.make (1, cursor_width // 8 * cursor_height)
				row := 1
			until
				row > cursor_height or row > array.height
			loop
				from
					column := 1
				until
					column > cursor_width // 8 or column > array.width
				loop
					Result.put (array.item (row, column), (row-1)*cursor_width // 8 + column)
					column := column + 1
				end
				row := row + 1
			end
		end

end -- SCREEN_CURSOR_IMP


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

