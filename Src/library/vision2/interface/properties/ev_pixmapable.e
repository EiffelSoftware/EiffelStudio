indexing
	description:
		"Abstraction for objects that have a pixmap property."
	status: "See notice at end of class"
	keywords: "pixmap, bitmap, icon, graphic, image"
	date: "$Date$"
	revision: "$Revision$"
	
deferred class 
	EV_PIXMAPABLE

inherit
	EV_ANY
		redefine
			implementation,
			is_in_default_state
		end
	
feature -- Access

	pixmap: EV_PIXMAP is
			-- Copy of image displayed on `Current'.
			-- Void if none.
		require
			not_destroyed: not is_destroyed
		do
			Result := implementation.pixmap
		ensure
			bridge_ok: (Result = Void and implementation.pixmap = Void) or
				Result.is_equal (implementation.pixmap)
		end

feature -- Element change

	set_pixmap (a_pixmap: EV_PIXMAP) is
			-- Display image of `a_pixmap' on `Current'.
			-- Image of `pixmap' will be a copy of `a_pixmap'.
			-- Image may be scaled in some descendents, i.e EV_TREE_ITEM
			-- See EV_TREE.set_pixmaps_size.
		require
			not_destroyed: not is_destroyed
			pixmap_not_void: a_pixmap /= Void
		do
			implementation.set_pixmap (a_pixmap)
		ensure
			pixmap_assigned: pixmap_equal_to (a_pixmap) and pixmap /= a_pixmap
		end

	remove_pixmap is
			-- Remove image displayed on `Current'.
		require
			not_destroyed: not is_destroyed
		do
			implementation.remove_pixmap
		ensure
			pixmap_removed: pixmap = Void
		end

feature {NONE} -- Contract support

	is_in_default_state: BOOLEAN is
			-- Is `Current' in its default state?
		do
			Result := Precursor {EV_ANY} and pixmap = void
		end
		
	pixmap_equal_to (a_pixmap: EV_PIXMAP): BOOLEAN is
			-- Is `a_pixmap' equal to `pixmap'?
		do
			Result := implementation.pixmap_equal_to (a_pixmap)
		end

feature {EV_ANY_I} -- Implementation
	
	implementation: EV_PIXMAPABLE_I
			-- Responsible for interaction with native graphics toolkit.

end -- class EV_PIXMAPABLE

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

