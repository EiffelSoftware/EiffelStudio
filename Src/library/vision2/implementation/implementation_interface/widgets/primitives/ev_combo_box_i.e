indexing 
	description: "EiffelVision Combo-box. Implementation interface."
	status: "See notice at end of class"
	date: "$Date$"
	revision: "$Revision$"

deferred class
	EV_COMBO_BOX_I

inherit
	EV_TEXT_FIELD_I
		redefine
			interface
		end

	EV_LIST_ITEM_LIST_I
		redefine
			interface
		end

feature -- Status report

	pixmaps_width: INTEGER
			-- Width of displayed pixmaps in `Current'.

	pixmaps_height: INTEGER
			-- Height of displayed pixmaps in `Current'.

feature -- Status setting

	set_pixmaps_size (a_width: INTEGER; a_height: INTEGER) is
			-- Set the size of displayed pixmaps in the Multicolumn list
			-- `a_width' by `a_height'.
		do
			if pixmaps_width /= a_width or pixmaps_height /= a_height then
				pixmaps_width := a_width
				pixmaps_height := a_height
				pixmaps_size_changed
			end
		end

feature {NONE} -- Implementation

	pixmaps_size_changed is
			-- The size of the displayed pixmaps has just
			-- changed.
		do
			-- Do nothing by default
		end

	initialize_pixmaps is
			-- Assign default sizes to pixmaps.
		do
			pixmaps_width := default_pixmaps_width
			pixmaps_height := default_pixmaps_height
		end

	default_pixmaps_width: INTEGER is 16
		-- Default width for pixmaps.

	default_pixmaps_height: INTEGER is 16
		-- Default height for pixmaps.

feature {EV_COMBO_BOX_I} -- Implementation

	interface: EV_COMBO_BOX

end -- class EV_COMBO_BOX_I

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

