indexing
	description: "Item pixmap scaler. Implementation interface."
	date: "$Date$"
	revision: "$Revision$"

deferred class
	EV_ITEM_PIXMAP_SCALER_I
	
inherit
	EV_ANY_I
		redefine
			interface
		end

feature -- Access

	pixmaps_width: INTEGER
			-- Width of displayed pixmaps in `Current'.

	pixmaps_height: INTEGER
			-- Height of displayed pixmaps in `Current'.

feature -- Status setting

	set_pixmaps_size (a_width: INTEGER; a_height: INTEGER) is
			-- Set the size of displayed pixmaps in `Current' to
			-- `a_width' by `a_height'.
		do
			if pixmaps_width /= a_width or pixmaps_height /= a_height then
				pixmaps_width := a_width
				pixmaps_height := a_height
				pixmaps_size_changed
			end
		ensure
			width_set: pixmaps_width = a_width
			height_set: pixmaps_height = a_height
		end

feature {NONE} -- Implementation

	pixmaps_size_changed is
			-- The size of the displayed pixmaps has just
			-- changed.
		deferred
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

feature {EV_ANY_I} -- Implementation

	interface: EV_ITEM_PIXMAP_SCALER
			-- Provides a common user interface to possibly dependent
			-- functionality implemented by `Current'.

end -- class EV_PIXMAPABLE_ITEM_HOLDER_I

--|----------------------------------------------------------------
--| EiffelVision2: library of reusable components for ISE Eiffel.
--| Copyright (C) 1985-2004 Eiffel Software. All rights reserved.
--| Duplication and distribution prohibited.  May be used only with
--| ISE Eiffel, under terms of user license.
--| Contact Eiffel Software for any other use.
--|
--| Interactive Software Engineering Inc.
--| dba Eiffel Software
--| 356 Storke Road, Goleta, CA 93117 USA
--| Telephone 805-685-1006, Fax 805-685-6869
--| Contact us at: http://www.eiffel.com/general/email.html
--| Customer support: http://support.eiffel.com
--| For latest info on our award winning products, visit:
--|	http://www.eiffel.com
--|----------------------------------------------------------------

