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

	make is
			-- Create the row with one column by default.
			-- The sub-items start at 2. 1 is the index of
			-- the current item.
		do
			create internal_text.make (1)
			internal_text.extend ("")
			create internal_pixmap.make (1)
			internal_pixmap.extend (Void)
		end

	make_with_text (txt: ARRAY [STRING]) is
			-- Create the row with the given text that also
			-- set the length of the row.
		do
			internal_text ?= txt.linear_representation
			create internal_pixmap.make_filled (txt.count)
		end

feature -- Access

	count: INTEGER is
			-- Number of element in the item
		do
			Result := internal_text.count
		end

	cell_text (index: INTEGER): STRING is
			-- Return the text of the cell number `index' 
		do
			Result := internal_text @ index
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

	pixmap_cell (index: INTEGER): EV_PIXMAP is
			-- Return the pixmap of the cell number
			-- `index'. On windows platform, 
			-- if index > 1, the result is void.
		do
			Result := internal_pixmap @ index
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

	set_cell_text (index: INTEGER; txt: STRING) is
			-- Make `txt' the new label of the `index'-th
			-- cell of the item.
		do
			internal_text.put_i_th (txt, index)
		end

	set_cell_pixmap (index: INTEGER; pix: EV_PIXMAP) is
			-- Make `pix' the new pixmap of the 
			-- `index'-th cell of the item.
		do
			internal_pixmap.put_i_th (pix, index)
		end

feature {EV_ITEM_HOLDER_IMP} -- Implementation

	internal_text: ARRAYED_LIST [STRING]
			-- List of strings of the item.
			-- We use an internal array for these text to avoid
			-- the user to have access to it.

	internal_pixmap: ARRAYED_LIST [EV_PIXMAP]
			-- List of pixmaps of the item.
			-- We use an internal array for these pixmaps to avoid
			-- the user to have access to it.

	parent_imp: EV_ITEM_HOLDER_IMP is
			-- The parent of the Current widget
			-- Can be void.
		deferred
		end

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
