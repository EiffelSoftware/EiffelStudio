--| FIXME Not for release
--| FIXME NOT_REVIEWED this file has not been reviewed
indexing	
	description: "EiffelVision item. Mswindows implementation"
	note: "It is not necessary to inherit from%
		% EV_TEXTABLE_IMP because all the features%
		% use `wel_window', but such a big object isn't%
		% necessary here."
	status: "See notice at end of class"
	id: "$$"
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

	EV_PIXMAPABLE_IMP
		--| FIXME Not in pixmapable anymore.
--		undefine
--			maximum_pixmap_height,
--			maximum_pixmap_width
		redefine
			interface
		end

	EV_TEXTABLE_IMP
		rename
			interface as textable_interface
		end

feature -- Access

	text: STRING
			-- Current label of the item

feature -- Element change

	set_text (txt: STRING) is
			-- Make `txt' the new label of the item.
		do
			text := txt
		end

feature {NONE}

	interface: EV_SIMPLE_ITEM

end -- class EV_SIMPLE_ITEM_IMP

--|----------------------------------------------------------------
--| Windows Eiffel Library: library of reusable components for ISE Eiffel.
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
--| Revision 1.15  2000/02/14 11:40:39  oconnor
--| merged changes from prerelease_20000214
--|
--| Revision 1.14.10.6  2000/02/05 02:10:33  brendel
--| Added inheritance from EV_TEXTABLE_IMP.
--|
--| Revision 1.14.10.5  2000/01/27 19:30:08  oconnor
--| added --| FIXME Not for release
--|
--| Revision 1.14.10.4  2000/01/06 18:42:24  king
--| Commented out maximum_pixmap_* from inheritance clause.
--|
--| Revision 1.14.10.3  2000/01/04 20:16:36  rogers
--| maximum_pixmap_height and maximum_pixmap_width are undefined from ev_pixmapable_imp.
--|
--| Revision 1.14.10.2  1999/12/17 17:32:19  rogers
--| Altered to fit in with the review branch. Redefinitions of interface
--|
--| Revision 1.14.10.1  1999/11/24 17:30:16  oconnor
--| merged with DEVEL branch
--|
--| Revision 1.14.6.2  1999/11/02 17:20:07  oconnor
--| Added CVS log, redoing creation sequence
--|
--|
--|-----------------------------------------------------------------------------
--| End of CVS log
--|-----------------------------------------------------------------------------
