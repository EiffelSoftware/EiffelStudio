class
	ON_OFF_CONTROL

inherit
	WEL_CONTROL_WINDOW
		rename
			make as control_make
		redefine
			on_left_button_down,
			on_paint
		end

	APPLICATION_IDS
		export
			{NONE} all
		end
creation
	make

feature -- Initialization

	make (a_parent: WEL_COMPOSITE_WINDOW; a_x, a_y: INTEGER) is
			-- Load the bitmaps
		require
			a_parent_not_void: a_parent /= Void
			a_parent_exists: a_parent.exists
		do
			control_make (a_parent, "")
			create on_bitmap.make_by_id (On_bmp_id)
			create off_bitmap.make_by_id (Off_bmp_id)
			move_and_resize (a_x, a_y, on_bitmap.width,
				on_bitmap.height, False)
		end

feature -- Access

	on: BOOLEAN
			-- Is the control turned on?

feature {NONE} -- Implementation

	on_paint (paint_dc: WEL_PAINT_DC; invalid_rect: WEL_RECT) is
			-- Paint the bitmap according to `off'.
		do
			if on then
				paint_dc.draw_bitmap (on_bitmap, 0, 0, on_bitmap.width, on_bitmap.height)
			else				
				paint_dc.draw_bitmap (off_bitmap, 0, 0, off_bitmap.width, off_bitmap.height)
			end
		end

	on_left_button_down (keys, x_pos, y_pos: INTEGER) is
			-- Switch the value of `off'.
		do
			on := not on
			invalidate
		end

	off_bitmap: WEL_BITMAP
			-- Bitmap corresponding to off

	on_bitmap: WEL_BITMAP
			-- Bitmap corresponding to on

end -- class ON_OFF_CONTROL

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

