indexing
	description: "EiffelVision pixmap. Mswindows implementation"
	status: "See notice at end of class"
	date: "$Date$"
	revision: "$Revision$"

class
	EV_PIXMAP_IMP

inherit
	EV_PIXMAP_I

	EV_DRAWABLE_IMP
		rename
			dc as internal_dc
		redefine
			internal_dc
		end

	WEL_DIB_COLORS_CONSTANTS
		export
			{NONE} all
		end

creation
	make,
	make_with_size

feature {NONE} -- Initialization

	make is
			-- Create an empty pixmap, its size is 1x1.
		local
			screen: WEL_SCREEN_DC
			bmp: WEL_BITMAP
		do
			!! screen
			screen.get
			!! internal_dc.make_by_dc (screen)
--			internal_dc.set_background_opaque
			!! bmp.make_compatible (screen, 1, 1)
			internal_dc.select_bitmap (bmp)
			screen.release
		end

	make_with_size (w, h: INTEGER) is
			-- Create an empty pixmap, its size is `w' and `h' as size.
		local
			bmp: WEL_BITMAP
			screen: WEL_SCREEN_DC
			color: EV_COLOR
			default_colors: EV_DEFAULT_COLORS
		do
			!! screen
			screen.get
			!! internal_dc.make_by_dc (screen)
			!! bmp.make_compatible (screen, w, h)
			internal_dc.select_bitmap (bmp)
			screen.release

			!! default_colors
			set_background_color (default_colors.Color_dialog)
			!! color.make_rgb (0, 0, 0)
			set_foreground_color (color)
			clear
		end

feature -- Access

	bitmap: WEL_BITMAP is
			-- Bitmap selected in the internal_dc
		do
			if internal_bitmap /= Void then
				Result := internal_bitmap
			else
				Result := internal_dc.bitmap
			end
		end

	mask: EV_PIXMAP is
			-- Mask used when the pixmap is diplayed.
		do
			-- ToDo
		end

feature -- Status report

	destroyed: BOOLEAN is
			-- Is Current object destroyed?  
		do
			Result := (bitmap = Void)
		end

feature -- Status setting

	destroy is
			-- Destroy actual object.
		do
			internal_dc.delete
			internal_dc := Void
			internal_bitmap := Void
		end

feature -- Measurement

	width: INTEGER is
			-- Width of the pixmap.
		do
			Result := bitmap.width
		end

	height: INTEGER is
			-- Height of the pixmap.
		do
			Result := bitmap.height
		end

feature -- Status report

	is_monochrome: BOOLEAN is
			-- Is the current pixmap monochrome?
		local
			info: WEL_LOG_BITMAP
			int: INTEGER
		do
			info := bitmap.log_bitmap
			int := info.planes
			int := info.bits_pixel
			Result := (info.planes = 1) and (info.bits_pixel = 1)
		end

feature -- Element change

	set_mask (pix: EV_PIXMAP) is
			-- Make `pix' the new mask of the pixmap.
		do
			-- To Do
		end

feature -- Basic operation

	read_from_file (file_name: STRING) is
			-- Load the pixmap described in 'file_name'. 
			-- If the file does not exist or it is in a 
			-- wrong format, an exception is raised.
		local
			file: RAW_FILE
			dib: WEL_DIB
			bmp:WEL_BITMAP
		do
			!! file.make_open_read (file_name)
			!! dib.make_by_file (file)
			internal_dc.select_palette (dib.palette)
			!! bmp.make_by_dib (internal_dc, dib, Dib_rgb_colors)
			internal_dc.select_bitmap (bmp)
		end

	character_representation: ARRAY [CHARACTER] is
			-- Return a representation of the pixmap in
			-- an array of character.
		local
			info: WEL_BITMAP_INFO
			bmp: WEL_BITMAP
			int: INTEGER
		do
			bmp := deep_clone (bitmap)
			create info.make_by_dc (internal_dc, bmp, Dib_rgb_colors)
			Result := internal_dc.di_bits (bmp, 0, height, info, Dib_rgb_colors)
		end

feature -- Implementation

	internal_dc: WEL_MEMORY_DC
			-- A dc to draw on it

	internal_bitmap: WEL_BITMAP
			-- A bitmap kept in memory when the dc is destroyed.

	internal_create_dc is
			-- Create the `internal_dc' that allow to draw on the
			-- pixmap.
		require
			valid_internal_bitmap: internal_bitmap /= Void
			valid_internal_dc: internal_dc = Void
		local
			screen: WEL_SCREEN_DC
		do
			!! screen
			screen.get
			!! internal_dc.make_by_dc (screen)
			internal_dc.select_bitmap (internal_bitmap)
			internal_bitmap := Void
			screen.release
		ensure
			valid_internal_dc: internal_dc /= Void and internal_dc.exists
			valid_internal_bitmap: internal_bitmap = Void
		end

	internal_delete_dc is
			-- store the bitmap in `internal_bitmap' and 
			-- delete the `internal_dc'.
		require
			valid_internal_dc: internal_dc /= Void and internal_dc.exists
			valid_internal_bitmap: internal_bitmap = Void
		do
			internal_bitmap := internal_dc.bitmap
			internal_dc.delete
			internal_dc := Void
		ensure
			valid_internal_bitmap: internal_bitmap /= Void
			valid_internal_dc: internal_dc = Void
		end

invariant

	not_double_data: not (internal_bitmap /= Void and internal_dc /= Void)
	dc_void_or_valid: (internal_dc /= Void) implies (internal_dc.exists)

end -- class EV_PIXMAP_IMP

--|----------------------------------------------------------------
--| EiffelVision: library of reusable components for ISE Eiffel.
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
