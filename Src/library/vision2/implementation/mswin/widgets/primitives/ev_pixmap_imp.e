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
		redefine
			dc
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
			bmp: WEL_BITMAP
			screen: WEL_SCREEN_DC
		do
			!! screen
			screen.get
			!! dc.make_by_dc (screen)
			dc.set_background_opaque
			!! bmp.make_compatible (screen, 1, 1)
			dc.select_bitmap (bmp)
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
			!! dc.make_by_dc (screen)
			!! bmp.make_compatible (screen, w, h)
			dc.select_bitmap (bmp)
			screen.release

			!! default_colors
			set_background_color (default_colors.Color_dialog)
			!! color.make_rgb (0, 0, 0)
			set_foreground_color (color)
			clear
		end

feature -- Access

	bitmap: WEL_BITMAP is
			-- Bitmap selected in the dc
		do	
			Result := dc.bitmap
		end

	dc: WEL_MEMORY_DC
		-- A dc to draw on it

feature -- Status report

	destroyed: BOOLEAN is
			-- Is Current object destroyed?  
		do
			Result := not dc.exists
		end

feature -- Status setting

	destroy is
			-- Destroy actual object.
		do
			dc.delete
		end

feature -- Measurement

	width: INTEGER is
		do
			if bitmap /= Void then
				Result := bitmap.width
			else
				Result := 0
			end
		end

	height: INTEGER is
		do
			if bitmap /= Void then
				Result := bitmap.height
			else
				Result := 0
			end
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
			dc.select_palette (dib.palette)
			!! bmp.make_by_dib (dc, dib, Dib_rgb_colors)
			dc.select_bitmap (bmp)
		end	

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
