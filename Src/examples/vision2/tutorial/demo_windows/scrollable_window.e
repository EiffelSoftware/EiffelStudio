indexing
	description:
		"The demo that goes with the button demo";
	date: "$Date$";
	revision: "$Revision$"

class
	SCROLLABLE_WINDOW

inherit
	EV_SCROLLABLE_AREA
		redefine
			make
		end

	PIXMAP_PATH

creation
	make

feature {NONE} -- Initialization

	make (par: EV_CONTAINER) is
			-- Create the demo in `par'.
		local
			pix: EV_PIXMAP
		do
			{EV_SCROLLABLE_AREA} Precursor (par)
			create pix.make_from_file (pixmap_path ("SevenFalls.bmp"))
			create ta.make_with_pixmap (Current, pix)
		end

feature -- Access

	ta: EV_DRAWING_AREA
		-- A drawing_area for the demo

end -- class SCROLLABLE_WINDOW

--|----------------------------------------------------------------
--| EiffelVision Tutorial: Example for the ISE EiffelVision library.
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
