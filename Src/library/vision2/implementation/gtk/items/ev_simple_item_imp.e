--| FIXME NOT_REVIEWED this file has not been reviewed
indexing
	description: "EiffelVision simple item, gtk implementation."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

deferred class
	EV_SIMPLE_ITEM_IMP

inherit
	EV_SIMPLE_ITEM_I
		redefine
			interface
		select
			interface
		end

	EV_ITEM_IMP
		redefine
			interface
		end

	EV_TEXTABLE_IMP
		rename
			--FIXME why doesn't EV_SIMPLE_ITEM inherit EV_TEXTABLE??
			interface as textable_interface
		end

	EV_PIXMAPABLE_IMP
		redefine
			interface
		end

feature {EV_SIMPLE_ITEM_IMP} -- Implementation

	interface: EV_SIMPLE_ITEM

end -- class EV_SIMPLE_ITEM_IMP

--!----------------------------------------------------------------
--! EiffelVision2: library of reusable components for ISE Eiffel.
--! Copyright (C) 1986-1999 Interactive Software Engineering Inc.
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
--!----------------------------------------------------------------

--|-----------------------------------------------------------------------------
--| CVS log
--|-----------------------------------------------------------------------------
--|
--| $Log$
--| Revision 1.6  2000/02/14 11:40:27  oconnor
--| merged changes from prerelease_20000214
--|
--| Revision 1.5.6.12  2000/02/04 04:25:36  oconnor
--| released
--|
--| Revision 1.5.6.11  2000/01/28 18:45:42  king
--| Using initialize from ev_item_imp
--|
--| Revision 1.5.6.10  2000/01/27 19:29:26  oconnor
--| added --| FIXME Not for release
--|
--| Revision 1.5.6.9  2000/01/10 20:09:46  king
--| Removed redundant label_widget routines
--|
--| Revision 1.5.6.8  2000/01/07 23:29:06  king
--| Altered initialize to account for name change in ev_textable_imp of ev_textable_imp_initialize
--|
--| Revision 1.5.6.7  1999/12/22 20:04:46  king
--| Made compatible with ev_pixmapable_imp
--|
--| Revision 1.5.6.6  1999/12/17 23:26:43  oconnor
--| removed obsolete feature from rename cluase
--|
--| Revision 1.5.6.5  1999/12/04 18:33:15  oconnor
--| added comment re inheritance
--|
--| Revision 1.5.6.4  1999/12/03 07:49:58  oconnor
--| removed old command stuff
--|
--| Revision 1.5.6.3  1999/11/30 22:55:05  oconnor
--| removed redefine of initialize, textable initialize will be renamed
--|
--| Revision 1.5.6.2  1999/11/30 17:25:13  brendel
--| Added redefine of initialize because of change in EV_TEXTABLE_IMP.
--|
--| Revision 1.5.6.1  1999/11/24 17:29:43  oconnor
--| merged with DEVEL branch
--|
--| Revision 1.5.2.2  1999/11/02 17:20:02  oconnor
--| Added CVS log, redoing creation sequence
--|
--|
--|-----------------------------------------------------------------------------
--| End of CVS log
--|-----------------------------------------------------------------------------
