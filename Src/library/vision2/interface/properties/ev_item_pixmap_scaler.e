indexing
	description:
		"[
			Objects that may contain pixmapable items whose image size may be adjusted uniformly.
			For example, calling set_pixmaps_size (24, 24) will ensure that the pixmaps of all items contained
			will be displayed as 24x24 pixels.
		]"
	date: "$Date$"
	revision: "$Revision$"

deferred class
	EV_ITEM_PIXMAP_SCALER
	
inherit
	EV_ANY
		redefine
			implementation
		end

feature -- Access

	pixmaps_width: INTEGER is
			-- Width of displayed pixmaps in the list.
		require
			not_destroyed: not is_destroyed
		do
			Result := implementation.pixmaps_width
		ensure
			bridge_ok: Result = implementation.pixmaps_width
		end

	pixmaps_height: INTEGER is
			-- Height of displayed pixmaps in the list.
		require
			not_destroyed: not is_destroyed
		do
			Result := implementation.pixmaps_height
		ensure
			bridge_ok: Result = implementation.pixmaps_height
		end

feature -- Status report

	set_pixmaps_size (a_width: INTEGER; a_height: INTEGER) is
			-- Set size of pixmaps disaplyed in `Current'.
			-- Note: Default value is 16x16
		require
			not_destroyed: not is_destroyed
			valid_width: a_width > 0
			valid_height: a_height > 0
		do
			implementation.set_pixmaps_size (a_width, a_height)
		ensure
			width_set: pixmaps_width = a_width
			height_set: pixmaps_height = a_height
		end
		
feature {EV_ANY, EV_ANY_I} -- Implementation

	implementation: EV_ITEM_PIXMAP_SCALER_I
		-- Responsible for interaction with native graphics toolkit.

invariant
	pixmaps_size_positive: pixmaps_height > 0 and pixmaps_width > 0

end -- class EV_PIXMAPABLE_ITEM_HOLDER

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

