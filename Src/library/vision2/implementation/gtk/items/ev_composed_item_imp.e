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

	EV_ITEM_IMP

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

	internal_pixmaps: ARRAYED_LIST [EV_PIXMAP_IMP]
		-- Pixmaps in the cells.
		-- They have to be stored in the right order.

	internal_text: ARRAYED_LIST [STRING]
		-- Text in the cells.
		-- They have to be stored in the right order.


end -- class EV_COMPOSED_ITEM_IMP

--|----------------------------------------------------------------
--| EiffelVision : library of reusable components for ISE Eiffel.
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
