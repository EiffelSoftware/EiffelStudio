--| FIXME Not for release
--| FIXME NOT_REVIEWED this file has not been reviewed
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

	pixmap: EV_PIXMAP
			-- An image.

	pixmap_imp: EV_PIXMAP_IMP is
			-- Implementation of the pixmap contained 
		do
			if pixmap /= Void then
				Result ?= pixmap.implementation
			end
		end

feature -- Element change

	set_pixmap (pix: EV_PIXMAP) is
			-- Make `pix' the new pixmap of the widget.
			-- We need to destroy the dc that comes with it,
			-- because a bitmap can be linked to only one dc
			-- at a time.
		do
			pixmap := pix
		end

	set_pixmap_by_filename (file_name: FILE_NAME) is
			-- Load `file_name' into the pixmap.
		do
			check
				to_be_implemented: False
			end
		end

	remove_pixmap is
			-- Remove the pixmap from the container
		local
			current_pixmap_imp: EV_PIXMAP_IMP
		do
			pixmap := Void
	--		current_pixmap_imp := pixmap_imp
	--		current_pixmap_imp.unreference
	--		current_pixmap_imp ?= Void
	--		invalidate
		end

feature {NONE} -- deferred features

	invalidate is
			deferred
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

--|-----------------------------------------------------------------------------
--| CVS log
--|-----------------------------------------------------------------------------
--|
--| $Log$
--| Revision 1.10  2000/02/14 11:40:40  oconnor
--| merged changes from prerelease_20000214
--|
--| Revision 1.9.6.7  2000/02/05 02:12:13  brendel
--| Changed to very basic implementation, where before it did not work at all.
--|
--| Revision 1.9.6.6  2000/01/27 19:30:13  oconnor
--| added --| FIXME Not for release
--|
--| Revision 1.9.6.5  2000/01/20 17:50:25  king
--| Commented out reference and unreference of pixmap until we figure out whether it
--| is useful.
--|
--| Revision 1.9.6.4  2000/01/06 18:41:33  king
--| Added imp of set_pixmap_by_filename.
--| Declared remove_pixmap as obsolete.
--|
--| Revision 1.9.6.3  1999/12/22 19:18:52  rogers
--| set_pixmap and remove_pixmap now need locals of type EV_PIXMAP_IMP as pixmap_imp is a function and cannot be assigned directly.
--|
--| Revision 1.9.6.2  1999/12/19 20:11:08  oconnor
--| reversed implementation of pixmap and pixmap_imp
--|
--| Revision 1.9.6.1  1999/11/24 17:30:20  oconnor
--| merged with DEVEL branch
--|
--| Revision 1.9.2.2  1999/11/02 17:20:08  oconnor
--| Added CVS log, redoing creation sequence
--|
--|
--|-----------------------------------------------------------------------------
--| End of CVS log
--|-----------------------------------------------------------------------------
