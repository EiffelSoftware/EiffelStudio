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

	make (par: EV_PIXMAPABLE) is
		do
			parent_imp ?= par.implementation
			check
				parent_not_void: parent_imp /= Void
			end
			!! compatible_dc.make (parent_imp.wel_window)
			compatible_dc.get
			make_by_dc (compatible_dc)
			compatible_dc.release
		end

feature -- Access

	parent_imp: EV_PIXMAPABLE_IMP

	compatible_dc: WEL_PAINT_DC

feature -- Status report

	destroyed: BOOLEAN is
			-- Is Current object destroyed?  
		do
			Result := not exists
		end

feature -- Status setting

	destroy is
			-- Destroy actual object.
		do
			destroy_item
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
			parent_imp.pixmap_size_changed
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
