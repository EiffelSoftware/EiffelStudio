class
	CHILD_WINDOW

inherit
	WEL_MDI_CHILD_WINDOW
		rename
			make as mdi_child_window_make
		redefine
			on_paint,
			class_icon
		end

	APPLICATION_IDS
		export
			{NONE} all
		end

	WEL_DIB_COLORS_CONSTANTS
		export
			{NONE} all
		end

creation
	make

feature -- Initialization

	make (a_parent: WEL_MDI_FRAME_WINDOW; a_name: STRING) is
		local
			file: RAW_FILE
			dc: WEL_CLIENT_DC
		do
			mdi_child_window_make (a_parent, a_name)
			!! file.make_open_read (a_name)
			!! dib.make_by_file (file)
			file.close
			!! dc.make (Current)
			dc.get
			!! bitmap.make_by_dib (dc, dib, Dib_rgb_colors)
			dc.release
			!! scroller.make (Current, bitmap.width, bitmap.height, 1, 20)
		end

feature -- Access

	bitmap: WEL_BITMAP
			-- Bitmap selected by the user

	dib: WEL_DIB
			-- DIB informations about `bitmap'

feature -- Basic operations

	on_paint (paint_dc: WEL_PAINT_DC; invalid_rect: WEL_RECT) is
			-- Paint the bitmap
		do
			paint_dc.draw_bitmap (bitmap, 
				(client_rect.width - bitmap.width) // 2,
				(client_rect.height - bitmap.height) // 2, 
				bitmap.width, bitmap.height)
		end

feature {NONE} -- Implementation

	class_icon: WEL_ICON is
			-- Window's icon
		once
			!! Result.make_by_id (Id_ico_child_window)
		end

end -- class CHILD_WINDOW

--|-------------------------------------------------------------------------
--| Windows Eiffel Library: library of reusable components for ISE Eiffel 3.
--| Copyright (C) 1995, Interactive Software Engineering, Inc.
--| All rights reserved. Duplication and distribution prohibited.
--|
--| 270 Storke Road, Suite 7, Goleta, CA 93117 USA
--| Telephone 805-685-1006
--| Fax 805-685-6869
--| Information e-mail <info@eiffel.com>
--| Customer support e-mail <support@eiffel.com>
--|-------------------------------------------------------------------------
