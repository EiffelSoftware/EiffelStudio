indexing
	description: "Demo for pictures."
	Id: "$Id$"
	date: "$Date$"
	revision: "$Revision$"

class
	PICTURE_ITEM

inherit
	FIGURE_ITEM

creation
	make

feature {NONE} -- Initialization

	make (par: EV_TREE_ITEM_HOLDER) is
			-- Create the item and the demo that
			-- goes with it.
		do
			make_with_title (par, "EV_PICTURE")
		end

feature -- Access

	figure: EV_PICTURE is
		local
			pict: EV_PIXMAP
		do
			!! Result.make
			!! pict.make_from_file ("c:\winnt\winnt256.bmp")
			Result.set_pixmap (pict)
		end

end -- class PICTURE_ITEM

--|----------------------------------------------------------------
--| EiffelVision2: library of reusable components for ISE Eiffel.
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

