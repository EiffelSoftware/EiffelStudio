indexing

	description: 
		"EiffelVision menu_item, implementation interface."
	status: "See notice at end of class"
	id: "$Id$"
	date: "$Date$"
	revision: "$Revision$"
	
deferred class
	EV_MENU_ITEM_I
	
inherit
	EV_ITEM_I
		redefine
			pixmap_size_ok
		end

	EV_MENU_ITEM_HOLDER_I

feature -- Access

	parent_imp: EV_MENU_ITEM_HOLDER_IMP
			-- Parent implementation

feature -- Status report

	insensitive: BOOLEAN is
			-- Is current widget insensitive?
		require
			exists: not destroyed
		deferred
		end

feature -- Status setting

	set_insensitive (flag: BOOLEAN) is
   			-- Set current item in insensitive mode if
   			-- `flag'. 
   		deferred
   		end

feature -- Element change

	set_parent (par: EV_MENU_ITEM_HOLDER) is
			-- Make `par' the new parent of the widget.
			-- `par' can be Void then the parent is the screen.
		deferred
		end

feature {NONE} -- Implementation

	pixmap_size_ok (pix: EV_PIXMAP): BOOLEAN is
			-- Check if the size of the pixmap is ok for
			-- the container.
		do
			Result := (pixmap.width <= 16) and (pixmap.height <= 16)
		end

end -- class EV_MENU_ITEM_I

--|----------------------------------------------------------------
--| EiffelVision library: library of reusable components for ISE Eiffel.
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
