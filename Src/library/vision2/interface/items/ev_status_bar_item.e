indexing
	description: "Eiffel Vision status bar item."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	EV_STATUS_BAR_ITEM

inherit
	EV_ITEM
		redefine
			implementation
		end

creation
	make,
	make_with_text,
	make_with_pixmap,
	make_with_all

feature {NONE} -- Initialization

	make (par: EV_STATUS_BAR) is
			-- Create the widget with `par' as parent.
		do
			!EV_STATUS_BAR_ITEM_IMP! implementation.make
			implementation.set_interface (Current)
			set_parent (par)
		end

	make_with_text (par: EV_STATUS_BAR; txt: STRING) is
			-- Create an item with `par' as parent and `txt'
			-- as text.
		do
			!EV_STATUS_BAR_ITEM_IMP! implementation.make_with_text (txt)
			implementation.set_interface (Current)
			set_parent (par)
		end

	make_with_pixmap (par: EV_STATUS_BAR; pix: EV_PIXMAP) is
			-- Create an item with `par' as parent and `pix'
			-- as pixmap.
		do
			!EV_STATUS_BAR_ITEM_IMP! implementation.make_with_pixmap (pix)
			implementation.set_interface (Current)
			set_parent (par)
		end

	make_with_all (par: EV_STATUS_BAR; txt: STRING; pix: EV_PIXMAP) is
			-- Create an item with `par' as parent, `txt' as text
			-- and `pix' as pixmap.
		do
			!EV_STATUS_BAR_ITEM_IMP! implementation.make_with_all (txt, pix)
			implementation.set_interface (Current)
			set_parent (par)
		end

feature -- Access

	parent: EV_STATUS_BAR is
			-- Parent of the current item.
		require
			exists: not destroyed
		do
			Result := implementation.parent
		end

feature -- Measurement

	width: INTEGER is
			-- The width of the item in the status bar.
		require
			exists: not destroyed
		do
			Result := implementation.width
		end

feature -- Status setting

	set_width (value: INTEGER) is
			-- Make `value' the new width of the item.
			-- If -1, then the item reach the right of the status
			-- bar.
		require
			exists: not destroyed
			valid_value: value >= 0 or value = -1
		do
			implementation.set_width (value)
		ensure
			width_set: width = value
		end

feature -- Element change

	set_parent (par: EV_STATUS_BAR) is
			-- Make `par' the new parent of the widget.
			-- `par' can be Void then the parent is the screen.
		require
			exists: not destroyed
		do
			implementation.set_parent (par)
		ensure
			parent_set: parent = par
		end

feature {NONE} -- Implementation

	implementation: EV_STATUS_BAR_ITEM_I

end -- class EV_STATUS_BAR_ITEM

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
