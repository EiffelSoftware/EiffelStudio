indexing
	description: "EiffelVision pixmap. Mswindows implementation"
	status: "See notice at end of class"
	date: "$Date$"
	revision: "$Revision$"

class

	EV_PIXMAP_IMP

inherit

	EV_PIXMAP_I

	WEL_MEMORY_DC
		rename
			make as wel_make
		undefine
			width,
			height
		end

	WEL_DIB_COLORS_CONSTANTS
		export
			{NONE} all
		end

creation

	make

feature {NONE} -- Initialization

	make (par: EV_PIXMAP_CONTAINER) is
		local
			compatible_window: WEL_WINDOW
		do
			compatible_window ?= par.implementation
			check
				parent_not_void: compatible_window /= Void
			end
			!! compatible_dc.make (compatible_window)
			compatible_dc.get
			make_by_dc (compatible_dc)
			compatible_dc.release
		end

feature -- Access

	compatible_dc: WEL_PAINT_DC

feature -- Measurement

	width: INTEGER is
		do
			Result := bitmap.width
		end

	height: INTEGER is
		do
			Result := bitmap.height
		end

feature -- Element change
	
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
			compatible_dc.get
			compatible_dc.select_palette (dib.palette)
			compatible_dc.realize_palette
			!! bmp.make_by_dib (compatible_dc, dib, Dib_rgb_colors)
			select_palette (compatible_dc.palette)
			select_bitmap (bmp)
			compatible_dc.release
	--		compatible_dc.delete
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
