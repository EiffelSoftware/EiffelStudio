indexing
	description: 
		"EiffelVision pixmap container, implementation interface."
	status: "See notice at end of class"
	id: "$Id$"
	date: "$Date$"
	revision: "$Revision$"
	
deferred class
	EV_PIXMAPABLE_I

inherit
	EV_ANY_I

feature -- Access

	pixmap: EV_PIXMAP is
			-- Implementation of the pixmap contained 
		require
			exists: not destroyed
		deferred
		end

feature -- Element change

	set_pixmap (pix: EV_PIXMAP) is
			-- Make `pix' the new pixmap of the widget.
		require
			exists: not destroyed
			valid_pixmap: is_valid (pix)
			valid_size: pixmap_size_ok (pix)
			free_pixmap: not pix.is_locked
		deferred
		ensure then
			pixmap_set: pixmap = pix
		end

	unset_pixmap is
			-- Remove the pixmap from the container
		require
			has_pixmap: pixmap /= Void
		deferred
		ensure then
			pixmap_removed: pixmap = Void
		end

feature -- Assertion features

	pixmap_size_ok (pix: EV_PIXMAP): BOOLEAN is
			-- Check if the size of the pixmap is ok for
			-- the container.
		do
			Result := (pix.width <= 16) and (pix.height <= 16)
		end

end -- class EV_PIXMAP_CONTAINER_I

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
