indexing	
	description:
		" EiffelVision composed item is composed of cell.%
		% each cell displays one text and one pixmap."
	note: "On windows, only the first pixmap is displayed."
	status: "See notice at end of class"
	id: "$$"
	date: "$Date$"
	revision: "$Revision$"

deferred class 
	EV_COMPOSED_ITEM

inherit
	EV_ITEM
		redefine
			implementation
		end

feature -- Access

	count: INTEGER is
			-- Number of element in the item
		require
			exists: not destroyed
		do
			Result := implementation.count
		end

	cell_text (index: INTEGER): STRING is
			-- Return the text of the cell number `index' 
		require
			exists: not destroyed
			valid_index: index >= 1 and index <= count
		do
			Result := implementation.cell_text (index)
		end

	text: LINKED_LIST [STRING] is
			-- Current label of the item
		require
			exists: not destroyed
		do
			Result := implementation.text
		end

	cell_pixmap (index: INTEGER): EV_PIXMAP is
			-- Return the pixmap of the cell number
			-- `index'. On windows platform, 
			-- if index > 1, the result is void.
		require
			exists: not destroyed
		do
			Result := implementation.cell_pixmap (index)
		end

	pixmap: LINKED_LIST [EV_PIXMAP] is
			-- Return all the pixmaps of the item.
			-- Only 1 on windows platform.
		require
			exists: not destroyed
		do
			Result := implementation.pixmap
		end

feature -- Element change

	set_count (value: INTEGER) is
			-- Make `value' the new count.
			-- When there is a parent, the item has the
			-- count done by the parent.
		require
			exists: not destroyed
			no_parent: parent = Void
			valid_value: value > 0
		do
			implementation.set_count (value)
		end

	set_cell_text (index: INTEGER; txt: STRING) is
			-- Make `txt' the new label of the `index'-th
			-- cell of the item.
		require
			exists: not destroyed
			valid_index: index >= 1 and index <= count
			valid_text: txt /= Void
		do
			implementation.set_cell_text (index, txt)
		end

	set_text (txt: ARRAY [STRING]) is
			-- Make `txt' the new label of the item.
		require
			exists: not destroyed
			valid_text: txt /= Void
			valid_text_length: txt.count = count
		do
			implementation.set_text (txt)
		end

	set_cell_pixmap (index: INTEGER; pix: EV_PIXMAP) is
			-- Make `pix' the new pixmap of the 
			-- `index'-th cell of the item.
		require
			exists: not destroyed
			valid_index: index >= 1 and index <= count
			valid_pixmap: is_valid (pix)
		do
			implementation.set_cell_pixmap (index, pix)
		end

	unset_cell_pixmap (index: INTEGER) is
			-- Remove the pixmap of the 
			-- `index'-th cell of the item.
		require
			valid_index: index >= 1 and index <= count
			has_pixmap: (pixmap @ index) /= Void
		do
			implementation.unset_cell_pixmap (index)
		end

	set_pixmap (pix: ARRAY [EV_PIXMAP]) is
			-- Make `pix' the new pixmaps of the item.
		require
			exists: not destroyed
			valid_pixmaps: pix /= Void
		do
			implementation.set_pixmap (pix)
		end

feature -- Implementation

	implementation: EV_COMPOSED_ITEM_I
		-- Platform dependent access

end -- class EV_COMPOSED_ITEM

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
