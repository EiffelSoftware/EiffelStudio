indexing
	description: "EiffelVision pixmap container. Mswindows implementation."
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
			-- Give a copy of pixmap used by `Current'.
		do
			if private_pixmap /= Void then
				create Result
				Result.copy (private_pixmap)
			end
		end

	pixmap_imp: EV_PIXMAP_IMP_STATE is
			-- Implementation of pixmap in `Current'.
		do
			if private_pixmap /= Void then
				Result ?= private_pixmap.implementation
			end
		end

feature -- Element change

	set_pixmap (pix: EV_PIXMAP) is
			-- Make `pix' the new pixmap of `Current'.
		do
			private_pixmap := pix
		end

	remove_pixmap is
			-- Remove the pixmap from `Current'.
		do
			private_pixmap := Void
		end

feature {NONE} -- Implementation

	private_pixmap: EV_PIXMAP
			-- Pixmap of `Current'.

end -- class EV_PIXMAPABLE_IMP

--!-----------------------------------------------------------------------------
--! EiffelVision: library of reusable components for ISE Eiffel.
--! Copyright (C) 1986-1998 Interactive Software Engineering Inc.
--! All rights reserved. Duplication and distribution prohibited.
--! May be used only with ISE Eiffel, under terms of user license. 
--! Contact ISE for any other use.
--!
--! Interactive Software Engineering Inc.
--! ISE Building, 2nd floor
--! 270 Storke Road, Goleta, CA 93117 USA
--! Telephone 805-685-1006, Fax 805-685-6869
--! Electronic mail <info@eiffel.com>
--! Customer support e-mail <support@eiffel.com>
--! For latest info see award-winning pages: http://www.eiffel.com
--!-----------------------------------------------------------------------------

--|----------------------------------------------------------------
--| CVS log
--|----------------------------------------------------------------
--|
--| $Log$
--| Revision 1.17  2001/07/14 12:16:29  manus
--| Cosmetics, replace the long:
--| --|-----------------------------------------------------------------------------
--| by the short version which is standard among all ISE libraries
--| --|----------------------------------------------------------------
--|
--| Revision 1.16  2001/06/07 23:08:13  rogers
--| Merged DEVEL branch into Main trunc.
--|
--| Revision 1.9.4.6  2000/08/11 19:13:24  rogers
--| Fixed copyright clause. Now use ! instead of |.
--|
--| Revision 1.9.4.5  2000/06/19 21:45:53  manus
--| Now `pixmap' of `EV_PIXMAPABLE_IMP' returns a copy of the internal pixmap to
--| satisfy the Vision2 interface behavior.
--|
--| Revision 1.9.4.4  2000/06/12 15:49:33  rogers
--| Removed invalidate as redundent.
--|
--| Revision 1.9.4.3  2000/06/05 16:49:19  manus
--| Now `pixmap_imp' is of type `EV_PIXMAP_IMP_STATE' which is widely accepted instead of the
--| too restrictive EV_PIXMAP_IMP.
--|
--| Now `set_pixmap' does not call `remove_pixmap' anymore because of a poor performance
--| of the resizing done in redefinitions of `remove_pixmap' (eg the one in EV_BUTTON_IMP).
--|
--| Also due to the poor performance of the `copy' in `set_pixmap' we do aliasing on the
--| EV_PIXMAP object given as parameter. It is not much a problem because when we give
--| the PIXMAP object to Windows, Windows does a copy.
--|
--| Revision 1.9.4.2  2000/05/05 22:29:29  pichery
--| Replaced (Create + Copy) with `ev_clone'
--|
--| Revision 1.9.4.1  2000/05/03 19:09:16  oconnor
--| mergred from HEAD
--|
--| Revision 1.14  2000/05/02 00:20:41  rogers
--| Removed FIXME NOT_REVIEWED. Comments and formatting.
--|
--| Revision 1.13  2000/04/11 19:35:52  pichery
--| cosmetics, removed unused features and instructions.
--|
--| Revision 1.12  2000/03/07 01:17:01  brendel
--| Improved implementation of set_pixmap.
--|
--| Revision 1.11  2000/02/19 05:44:59  oconnor
--| released
--|
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
--|----------------------------------------------------------------
--| End of CVS log
--|----------------------------------------------------------------
