--| FIXME Not for release
--| FIXME NOT_REVIEWED this file has not been reviewed
indexing	
	description: 
		" EiffelVision composed item, mswindows implementation."
	note: "On windows, only the first pixmap is displayed."
	status: "See notice at end of class"
	id: "$$"
	date: "$Date$"
	revision: "$Revision$"

deferred class 
	EV_COMPOSED_ITEM_IMP

inherit
	EV_COMPOSED_ITEM_I

	EV_ITEM_IMP

feature {NONE} -- Initialization

	make (an_interface: like interface)is
			-- Create the row with one column by default.
			-- The sub-items start at 2. 1 is the index of
			-- the current item.
		do
			base_make (an_interface)
			create internal_text.make (1)
			internal_text.extend ("")
			create internal_pixmap.make (1)
			internal_pixmap.extend (Void)
		end

	initialize is
		do
			is_initialized := True
		end

feature -- Access

	count: INTEGER is
			-- Number of element in the item
		do
			Result := internal_text.count
		end

	cell_text (value: INTEGER): STRING is
			-- Return the text of the cell number `value' 
		do
			Result := internal_text @ value
		end

	text: LINKED_LIST [STRING] is
			-- Current label of the item
		local
			list: ARRAYED_LIST [STRING]
		do
			from
				!! Result.make
				list := internal_text
				list.start
			until
				list.after
			loop
				Result.extend (list.item)
				list.forth
			end
		end

	cell_pixmap (value: INTEGER): EV_PIXMAP is
			-- Return the pixmap of the cell number
			-- `value'. On windows platform, 
			-- if value > 1, the result is void.
		do
			Result := internal_pixmap @ value
		end

	pixmap: LINKED_LIST [EV_PIXMAP] is
			-- Return all the pixmaps of the item.
			-- Only 1 on windows platform.
		local
			list: ARRAYED_LIST [EV_PIXMAP]
		do
			from
				!! Result.make
				list := internal_pixmap
				list.start
			until
				list.after
			loop
				Result.extend (list.item)
				list.forth
			end
		end

               set_parent (par: like parent) is
                       -- Make `par' the new parent of the widget.
                       -- `par' can be Void then the parent is the screen.
               do
				if par /= Void then
				--	parent_imp ?= par.implementation
				else
				--	parent_imp := Void
				end
               end

feature -- Element change

	set_count (value: INTEGER) is
			-- Make `value' the new count.
			-- When there is a parent, the item has the
			-- count done by the parent.
		local
			txt: ARRAYED_LIST [STRING]
			pix: ARRAYED_LIST [EV_PIXMAP]
		do
			txt := internal_text
			pix := internal_pixmap
			if count < value then
				from
				until
					txt.count = value
				loop
					txt.extend ("")
					pix.extend (Void)
				end
			elseif count > value then
				from
					txt.go_i_th (value + 1)
				until
					txt.after
				loop
					txt.remove
					pix.remove
				end
			end
		end

	set_cell_text (value: INTEGER; txt: STRING) is
			-- Make `txt' the new label of the `value'-th
			-- cell of the item.
		do
			internal_text.put_i_th (txt, value)
		end

	set_cell_pixmap (value: INTEGER; pix: EV_PIXMAP) is
			-- Make `pix' the new pixmap of the 
			-- `value'-th cell of the item.
		do
			internal_pixmap.put_i_th (pix, value)
		end

--	unset_cell_pixmap (value: INTEGER) is
--			-- Remove the pixmap of the 
--			-- `value'-th cell of the item.
--		do
--			-- To implement.
--		end

feature {EV_ITEM_LIST_IMP} -- Implementation

	internal_text: ARRAYED_LIST [STRING]
			-- List of strings of the item.
			-- We use an internal array for these text to avoid
			-- the user to have access to it.

	internal_pixmap: ARRAYED_LIST [EV_PIXMAP]
			-- List of pixmaps of the item.
			-- We use an internal array for these pixmaps to avoid
			-- the user to have access to it.

end -- class EV_COMPOSED_ITEM_I

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

--|-----------------------------------------------------------------------------
--| CVS log
--|-----------------------------------------------------------------------------
--|
--| $Log$
--| Revision 1.5  2000/02/14 11:40:39  oconnor
--| merged changes from prerelease_20000214
--|
--| Revision 1.4.6.5  2000/02/03 17:18:10  brendel
--| Commented out two lines where parent is treated as a variable.
--|
--| Revision 1.4.6.4  2000/01/27 19:30:07  oconnor
--| added --| FIXME Not for release
--|
--| Revision 1.4.6.3  2000/01/12 18:05:43  rogers
--| Base make is now called correctly with `an_interface', and `is_initialized' is set to True in initialize.
--|
--| Revision 1.4.6.2  1999/12/17 17:36:29  rogers
--| Altered to fit in with the review branch. Make now takes an interface.
--|
--| Revision 1.4.6.1  1999/11/24 17:30:15  oconnor
--| merged with DEVEL branch
--|
--| Revision 1.4.2.2  1999/11/02 17:20:07  oconnor
--| Added CVS log, redoing creation sequence
--|
--|
--|-----------------------------------------------------------------------------
--| End of CVS log
--|-----------------------------------------------------------------------------
