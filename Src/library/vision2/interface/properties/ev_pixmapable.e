indexing
	description: 
		"EiffelVision pixmap container. Pixmap container is used%
		% internally in EiffelVision to allow an EV_PIXMAP to be%
		% put inside a widget."
	status: "See notice at end of class"
	id: "$Id$"
	date: "$Date$"
	revision: "$Revision$"
	
deferred class 
	EV_PIXMAPABLE

inherit
	EV_ANY
		redefine
			implementation
		end
	
feature -- Access

	pixmap: EV_PIXMAP is
			-- Implementation of the pixmap contained 
		require
			exists: not destroyed
		do
			Result := implementation.pixmap
		end

feature -- Element change

	set_pixmap (pix: EV_PIXMAP) is
			-- Make `pix' the new pixmap of the widget.
		require
			exists: not destroyed
			valid_pixmap: is_valid (pix)
			valid_size: implementation.pixmap_size_ok (pix)
			valid_lock: not pix.is_locked
			valid_drawable: implementation.pixmap_drawable_ok (pix)
		do
			implementation.set_pixmap (pix)
		ensure then
			pixmap_set: pixmap = pix
		end

	unset_pixmap is
			-- Remove the pixmap from the container
		require
			has_pixmap: pixmap /= Void
		do
			implementation.unset_pixmap
		ensure then
			pixmap_removed: pixmap = Void
			unlocked_pixmap: not (old pixmap).is_locked
		end

feature -- Implementation
	
	implementation: EV_PIXMAPABLE_I
			
end -- class EV_PIXMAPABLE

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
