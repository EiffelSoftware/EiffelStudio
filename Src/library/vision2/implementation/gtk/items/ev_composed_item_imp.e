--| FIXME Not for release
--| FIXME NOT_REVIEWED this file has not been reviewed
indexing
	description:
		" EiffelVision composed item, gtk implementation."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

deferred class
	EV_COMPOSED_ITEM_IMP

inherit
	EV_COMPOSED_ITEM_I
		redefine
			interface
		end

	EV_ITEM_IMP
		redefine
			interface
		end

feature -- Access

	cell_text (column: INTEGER): STRING is
			-- `text' at the current row in the given column.
		do
			Result ?= (internal_text @ column)		
		end

	text: LINKED_LIST [STRING] is
			-- Return all the strings of the item.
			-- Created for the user, supposed to
			-- be in read-only mode.
		local
			list: ARRAYED_LIST [STRING]
		do
			from
				create Result.make
				list := internal_text
				list.start
			until
				list.after
			loop
				Result.extend (list.item)
				list.forth
			end		
		end

	cell_pixmap (column: INTEGER): EV_PIXMAP is
			-- Return the pixmap of the cell number
			-- `column'. On windows platform, 
			-- if index > 1, the result is void.
		do
			Result ?= (internal_pixmaps @ column).interface		
		end

	pixmap: LINKED_LIST [EV_PIXMAP] is
			-- Return all the pixmaps of the item.
			-- Only 1 on windows platform.
			-- Created for the user, supposed to
			-- be in read-only mode.
		local
			list: ARRAYED_LIST [EV_PIXMAP_IMP]
			pix: EV_PIXMAP
		do
			from
				create Result.make
				list := internal_pixmaps
				list.start
			until
				list.after
			loop
				if (list.item /= Void) then
					pix ?= list.item.interface
				else
					pix := Void
				end
				Result.extend (pix)
				list.forth
			end
		end

feature {EV_ANY_I} -- Implementation

	interface: EV_COMPOSED_ITEM

	internal_pixmaps: ARRAYED_LIST [EV_PIXMAP_IMP]
		-- Pixmaps in the cells.
		-- They have to be stored in the right order.

	internal_text: ARRAYED_LIST [STRING]
		-- Text in the cells.
		-- They have to be stored in the right order.


end -- class EV_COMPOSED_ITEM_IMP

--!----------------------------------------------------------------
--! EiffelVision : library of reusable components for ISE Eiffel.
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
--| Revision 1.4  2000/02/14 11:40:27  oconnor
--| merged changes from prerelease_20000214
--|
--| Revision 1.3.6.3  2000/02/02 23:40:29  king
--| Defined interface
--|
--| Revision 1.3.6.2  2000/01/27 19:29:24  oconnor
--| added --| FIXME Not for release
--|
--| Revision 1.3.6.1  1999/11/24 17:29:42  oconnor
--| merged with DEVEL branch
--|
--| Revision 1.3.2.2  1999/11/02 17:20:02  oconnor
--| Added CVS log, redoing creation sequence
--|
--|
--|-----------------------------------------------------------------------------
--| End of CVS log
--|-----------------------------------------------------------------------------
