--| FIXME NOT_REVIEWED this file has not been reviewed
indexing	
	description: 
		"EiffelVision item. Implementation interface"
	status: "See notice at end of class"
	id: "$$"
	date: "$Date$"
	revision: "$Revision$"

deferred class 
	EV_SIMPLE_ITEM_I

inherit
	EV_ITEM_I
		redefine
			interface
		end

	EV_PIXMAPABLE_I
		redefine
			interface
		end

	EV_TEXTABLE_I
		redefine
			interface
		end

feature -- Access

	maximum_pixmap_width: INTEGER is
			-- Maximum width allowed for `pixmap'.
		do	
			Result := 16
				-- FIXME This should be constant
				-- ie standard_icon_width = 16
		end

	maximum_pixmap_height: INTEGER is
			-- Maximum height allowed for `pixmap'.
		do
			Result := 16
				-- FIXME This should be constant
				-- ie standard_icon_width = 16
		end

feature {EV_SIMPLE_ITEM_I} -- Implementation

	interface: EV_SIMPLE_ITEM

end -- class EV_SIMPLE_ITEM_I

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
--| Revision 1.21  2000/02/14 11:40:34  oconnor
--| merged changes from prerelease_20000214
--|
--| Revision 1.20.6.8  2000/02/04 21:29:59  king
--| Removed text features as it now inherits from textable
--|
--| Revision 1.20.6.7  2000/02/04 04:02:41  oconnor
--| released
--|
--| Revision 1.20.6.6  2000/01/27 19:29:52  oconnor
--| added --| FIXME Not for release
--|
--| Revision 1.20.6.5  2000/01/06 18:43:42  king
--| Commented out maximum_pixmap_* from inheritance clause.
--|
--| Revision 1.20.6.4  2000/01/04 20:03:51  rogers
--| maximum_pixmap_height and maximum_pixmap_width are now undefined from ev_pixmapable_i.
--|
--| Revision 1.20.6.3  1999/12/09 03:15:05  oconnor
--| commented out make_with_* features, these should be in interface only
--|
--| Revision 1.20.6.2  1999/11/30 22:51:01  oconnor
--| Redefined interface to more refined type
--|
--| Revision 1.20.6.1  1999/11/24 17:30:03  oconnor
--| merged with DEVEL branch
--|
--| Revision 1.20.2.3  1999/11/04 23:10:32  oconnor
--| updates for new color model, removed exists: not destroyed
--|
--| Revision 1.20.2.2  1999/11/02 17:20:05  oconnor
--| Added CVS log, redoing creation sequence
--|
--|
--|-----------------------------------------------------------------------------
--| End of CVS log
--|-----------------------------------------------------------------------------
