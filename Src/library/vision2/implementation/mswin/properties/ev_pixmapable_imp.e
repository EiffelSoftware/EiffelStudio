indexing
	description: "EiffelVision pixmap container. %
				% Mswindows implementation."
	status: "See notice at end of class"
	id: "$Id$"
	date: "$Date$"
	revision: "$Revision$"

deferred class
	EV_PIXMAPABLE_IMP

inherit
	EV_PIXMAPABLE_I

feature -- Access

	pixmap: EV_PIXMAP is
			-- Current pixmap
		do
			if pixmap_imp /= Void then
				Result ?= pixmap_imp.interface
			else
				Result := Void
			end
		end

	pixmap_imp: EV_PIXMAP_IMP
			-- Implementation of the pixmap contained 

feature -- Element change

	set_pixmap (pix: EV_PIXMAP) is
			-- Make `pix' the new pixmap of the widget.
			-- We need to destroy the dc that comes with it,
			-- because a bitmap can be linked to only one dc
			-- at a time.
		do
			pixmap_imp ?= pix.implementation
			pixmap_imp.reference
		end

	unset_pixmap is
			-- Remove the pixmap from the container
		do
			pixmap_imp.unreference
			pixmap_imp ?= Void
		end

end -- class EV_PIXMAPABLE_IMP

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
