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
		undefine
			create_action_sequences
		redefine
			implementation
		end
	
feature -- Access

	pixmap: EV_PIXMAP is
			-- Image displayed on `Current'.
		do
			Result := implementation.pixmap
		ensure
			bridge_ok: (Result = Void and implementation.pixmap = Void) or
				Result.is_equal (implementation.pixmap)
		end

feature -- Element change

	set_pixmap (a_pixmap: EV_PIXMAP) is
			-- Assign `a_pixmap' to `pixmap'.
		require
			pixmap_not_void: a_pixmap /= Void
		do
			implementation.set_pixmap (a_pixmap)
		ensure
			pixmap_assigned: a_pixmap.is_equal (pixmap) and pixmap /= a_pixmap
		end

	remove_pixmap is
			-- Make `pixmap' `Void'.
		do
			implementation.remove_pixmap
		ensure
			pixmap_removed: pixmap = Void
		end

feature {EV_PIXMAPABLE_I} -- Implementation
	
	implementation: EV_PIXMAPABLE_I
			-- Responsible for interaction with the native graphics toolkit.

end -- class EV_PIXMAPABLE

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
--| Revision 1.18  2000/06/07 17:28:07  oconnor
--| merged from DEVEL tag MERGED_TO_TRUNK_20000607
--|
--| Revision 1.12.4.2  2000/05/09 20:29:37  king
--| Spelling corrections
--|
--| Revision 1.12.4.1  2000/05/03 19:10:03  oconnor
--| mergred from HEAD
--|
--| Revision 1.17  2000/03/17 01:23:34  oconnor
--| formatting and layout
--|
--| Revision 1.16  2000/03/03 01:44:01  oconnor
--| fixed call on void problem in PC of set_pixmap
--|
--| Revision 1.15  2000/03/01 22:30:26  oconnor
--| corrected postconditions
--|
--| Revision 1.14  2000/02/22 18:39:49  oconnor
--| updated copyright date and formatting
--|
--| Revision 1.13  2000/02/14 11:40:49  oconnor
--| merged changes from prerelease_20000214
--|
--| Revision 1.12.6.11  2000/01/28 20:00:10  oconnor
--| released
--|
--| Revision 1.12.6.10  2000/01/27 19:30:46  oconnor
--| added --| FIXME Not for release
--|
--| Revision 1.12.6.9  2000/01/13 22:59:17  oconnor
--| formatting
--|
--| Revision 1.12.6.8  2000/01/13 22:55:51  oconnor
--| tweaked comments
--|
--| Revision 1.12.6.7  2000/01/10 20:06:25  king
--| Corrected remove_pixmap by adding implementation and assertions
--|
--| Revision 1.12.6.6  2000/01/07 17:20:19  oconnor
--| removed obsolete decleraction from remove_text
--|
--| Revision 1.12.6.5  2000/01/06 21:33:39  king
--| Made remove_pixmap obsolete
--|
--| Revision 1.12.6.4  2000/01/06 18:38:04  king
--| Removed maximum-pixmap-dimension functions
--| Added feature set_pixmap_by_filename.
--|
--| Revision 1.12.6.3  1999/12/19 19:32:44  oconnor
--| improved interface
--|
--| Revision 1.12.6.2  1999/12/13 19:31:13  oconnor
--| kernel/ev_application.e
--|
--| Revision 1.12.6.1  1999/11/24 17:30:48  oconnor
--| merged with DEVEL branch
--|
--| Revision 1.12.2.4  1999/11/23 23:01:25  oconnor
--| undefine create_action_sequences on repeated inherit
--|
--| Revision 1.12.2.3  1999/11/04 23:10:54  oconnor
--| updates for new color model, removed exists: not destroyed
--|
--| Revision 1.12.2.2  1999/11/02 17:20:12  oconnor
--| Added CVS log, redoing creation sequence
--|
--|-----------------------------------------------------------------------------
--| End of CVS log
--|-----------------------------------------------------------------------------
