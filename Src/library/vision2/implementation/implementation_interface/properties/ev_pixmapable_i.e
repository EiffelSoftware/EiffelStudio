indexing
	description: 
		"Eiffel Vision pixmapable. Implementation interface."
	status: "See notice at end of class"
	keywords: "pixmap, bitmap, icon, graphic, image"
	date: "$Date$"
	revision: "$Revision$"
	
deferred class 
	EV_PIXMAPABLE_I

inherit
	EV_ANY_I
		redefine
			interface
		end
	
feature -- Access

	pixmap: EV_PIXMAP is
			-- Image displayed on `Current'.
		deferred
		end

feature -- Element change

	set_pixmap (a_pixmap: EV_PIXMAP) is
			-- Assign `a_pixmap' to `pixmap'.
		require
			pixmap_not_void: a_pixmap /= Void
		deferred
		end

	remove_pixmap is
			-- Make `pixmap' `Void'.
		deferred
		ensure
			pixmap_removed: pixmap = Void
		end

feature {EV_ANY_I} -- Implementation

	interface: EV_PIXMAPABLE
			-- Provides a common user interface to platform dependent
			-- functionality implemented by `Current'.

end -- class EV_PIXMAPABLE_I

--!-----------------------------------------------------------------------------
--! EiffelVision2: library of reusable components for ISE Eiffel.
--! Copyright (C) 1986-2000 Interactive Software Engineering Inc.
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

--|-----------------------------------------------------------------------------
--| CVS log
--|-----------------------------------------------------------------------------
--|
--| $Log$
--| Revision 1.17  2001/06/07 23:08:09  rogers
--| Merged DEVEL branch into Main trunc.
--|
--| Revision 1.13.4.2  2000/05/09 20:30:38  king
--| Added post cond to remove pixmap
--|
--| Revision 1.13.4.1  2000/05/03 19:08:59  oconnor
--| mergred from HEAD
--|
--| Revision 1.15  2000/02/22 18:39:42  oconnor
--| updated copyright date and formatting
--|
--| Revision 1.14  2000/02/14 11:40:35  oconnor
--| merged changes from prerelease_20000214
--|
--| Revision 1.13.6.12  2000/02/04 04:00:10  oconnor
--| released
--|
--| Revision 1.13.6.11  2000/01/27 19:29:57  oconnor
--| added --| FIXME Not for release
--|
--| Revision 1.13.6.10  2000/01/13 22:59:48  oconnor
--| formatting and comments
--|
--| Revision 1.13.6.9  2000/01/10 20:04:28  king
--| Added precondition to set_pixmap, corrected comment on remove_pixmap
--|
--| Revision 1.13.6.8  2000/01/07 00:55:49  king
--| Removed unneeded features
--|
--| Revision 1.13.6.7  2000/01/06 18:40:21  king
--| Removed maximum dimension of pixmap features.
--|
--| Revision 1.13.6.6  2000/01/04 20:02:21  rogers
--| maximum_pixmap_height and maximum_pixmap_width are no longer deferred,
--| they now return aqn arbitarily large number. This change has been made in
--| order to fit in with changes that Vincent is making on pixmapable.
--| These functions may be removed soon.
--|
--| Revision 1.13.6.5  1999/12/22 20:08:04  king
--| Made max_pix_hgt/wid effective
--|
--| Revision 1.13.6.4  1999/12/19 19:33:24  oconnor
--| made to conform to improved interface
--|
--| Revision 1.13.6.3  1999/12/13 19:41:28  oconnor
--| commented out not yet implemented contracts
--|
--| Revision 1.13.6.2  1999/11/30 22:50:35  oconnor
--| Redefined interface to more refined type
--|
--| Revision 1.13.6.1  1999/11/24 17:30:06  oconnor
--| merged with DEVEL branch
--|
--| Revision 1.13.2.3  1999/11/04 23:10:35  oconnor
--| updates for new color model, removed exists: not destroyed
--|
--| Revision 1.13.2.2  1999/11/02 17:20:05  oconnor
--| Added CVS log, redoing creation sequence
--|
--|-----------------------------------------------------------------------------
--| End of CVS log
--|-----------------------------------------------------------------------------
