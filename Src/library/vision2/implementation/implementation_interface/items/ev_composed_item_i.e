indexing	
	description: 
		" EiffelVision composed item, implementation interface."
	note: "On windows, only the first pixmap is displayed."
	status: "See notice at end of class"
	id: "$$"
	date: "$Date$"
	revision: "$Revision$"

deferred class 
	EV_COMPOSED_ITEM_I

inherit
	EV_ITEM_I

feature {NONE} -- Initialization

	make is
			-- Create an row with one empty column.
		deferred
		end

	make_with_text (txt: ARRAY [STRING]) is
			-- Create a row with text in it.
		require
			valid_text: txt /= Void
			no_void_text: not txt.has (Void)
		deferred
 		end

feature -- Access

	count: INTEGER is
			-- Number of element in the item
		require
			exists: not destroyed
		deferred
		end

	cell_text (index: INTEGER): STRING is
			-- Return the text of the cell number `index' 
		require
			exists: not destroyed
			valid_index: index >= 1 and index <= count
		deferred
		end

	text: LINKED_LIST [STRING] is
			-- Current label of the item
		require
			exists: not destroyed
		deferred
		end

	cell_pixmap (index: INTEGER): EV_PIXMAP is
			-- Return the pixmap of the cell number
			-- `index'. On windows platform, 
			-- if index > 1, the result is void.
		require
			exists: not destroyed
		deferred
		end

	pixmap: LINKED_LIST [EV_PIXMAP] is
			-- Return all the pixmaps of the item.
			-- Only 1 on windows platform.
		require
			exists: not destroyed
		deferred
		end

feature -- Element change

	set_count (value: INTEGER) is
			-- Make `value' the new count.
			-- When there is a parent, the item has the
			-- count done by the parent.
		require
			exists: not destroyed
			no_parent: parent_imp = Void
			valid_value: value > 0
		deferred
		end

	set_cell_text (index: INTEGER; txt: STRING) is
			-- Make `txt' the new label of the `index'-th
			-- cell of the item.
		require
			exists: not destroyed
			valid_index: index >= 1 and index <= count
			valid_text: txt /= Void
		deferred
		end

	set_text (txt: ARRAY [STRING]) is
			-- Make `txt' the new label of the item.
		require
			exists: not destroyed
			valid_text: txt /= Void
		local
			i: INTEGER
			list_i: INTEGER
		do
			from
				i := txt.lower
				list_i := 1
			until
				i = txt.upper + 1
			loop
				set_cell_text (list_i, txt @ i)
				i := i + 1
				list_i := list_i + 1
			end
		end

	set_cell_pixmap (index: INTEGER; pix: EV_PIXMAP) is
			-- Make `pix' the new pixmap of the 
			-- `index'-th cell of the item.
		require
			exists: not destroyed
			valid_index: index >= 1 and index <= count
			valid_pixmap: is_valid (pix)
			valid_size: pixmap_size_ok (pix)
		deferred
		end

	unset_cell_pixmap (index: INTEGER) is
			-- Remove the pixmap of the 
			-- `index'-th cell of the item.
		require
			valid_index: index >= 1 and index <= count
			has_pixmap: (pixmap @ index) /= Void
		deferred
		end

	set_pixmap (pix: ARRAY [EV_PIXMAP]) is
			-- Make `pix' the new pixmaps of the item.
		require
			exists: not destroyed
			valid_pixmaps: pix /= Void
			valid_size: pixmaps_size_ok (pix)
		local
			i: INTEGER
			list_i: INTEGER
		do
			from
				i := pix.lower
				list_i := 1
			until
				i = pix.upper + 1
			loop
				set_cell_pixmap (list_i, pix @ i)
				i := i + 1
				list_i := list_i + 1
			end
		end

feature -- Assertion features

	pixmap_size_ok (pix: EV_PIXMAP): BOOLEAN is
			-- Check if the size of the pixmap is ok for
			-- the container.
		do
			Result := (pix.width <= 16) and (pix.height <= 16)
		end

	pixmaps_size_ok (pix_array: ARRAY[EV_PIXMAP]): BOOLEAN is
			-- Check if the size of the pixmaps is ok for
			-- the container.
		local
			pixmaps: ARRAY [EV_PIXMAP]
			i: INTEGER
			pix: EV_PIXMAP
		do
			from
				pixmaps := pix_array
				i := 1
				Result := True
			until
				(Result = False) or (i > pixmaps.upper)	
			loop
				pix := pixmaps @ i
				Result := (pix.width <= 16) and (pix.height <= 16)
				i := i + 1
			end
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
