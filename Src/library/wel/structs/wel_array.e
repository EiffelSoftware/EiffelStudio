indexing
	description: "Fixed array for WEL_STRUCTURE. Used internally by WEL."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	WEL_ARRAY [G -> WEL_STRUCTURE]

inherit
	WEL_STRUCTURE
		rename
			make as structure_make
		end

creation
	make

feature {NONE} -- Initialization

	make (a_count, an_item_size: INTEGER) is
			-- Create a fixed array.
			-- `a_count' specifies the number of items and
			-- `an_item_size' specifies the item_size of an item.
		require
			positive_count: a_count >= 0
			positive_item_size: an_item_size >= 0
		do
			count := a_count
			item_size := an_item_size
			structure_make
		ensure
			count_set: count = a_count
			item_size_set: item_size = an_item_size
		end

feature -- Element change

	put (an_item: G; index: INTEGER) is
			-- Put `an_item' at zero based index `index'.
		require
			an_item_not_void: an_item /= Void
			valid_item_size: item_size = an_item.structure_size
			index_large_enough: index >= 0
			index_small_enough: index < count
		do
			c_memcpy (cwel_integer_to_pointer (
				to_integer + (index * item_size)),
				an_item.item, item_size)
		end

	i_th_item (index: INTEGER): POINTER is
			-- Retrieve the pointer at the zero-based `index'.
		require
			index_large_enough: index >= 0
			index_small_enpugh: index < count
		do
			Result := cwel_integer_to_pointer (to_integer +
				(index * item_size))
		end

feature -- Measurement

	count: INTEGER
			-- Number of items in the array

	item_size: INTEGER
			-- Size of an item (in bytes)

	structure_size: INTEGER is
			-- Size of the array (in bytes)
		do
			Result := item_size * count
		end

invariant
	positive_count: count >= 0
	positive_item_size: item_size >= 0

end -- class WEL_ARRAY


--|----------------------------------------------------------------
--| Windows Eiffel Library: library of reusable components for ISE Eiffel.
--| Copyright (C) 1986-2001 Interactive Software Engineering Inc.
--| All rights reserved. Duplication and distribution prohibited.
--| May be used only with ISE Eiffel, under terms of user license. 
--| Contact ISE for any other use.
--|
--| Interactive Software Engineering Inc.
--| ISE Building
--| 360 Storke Road, Goleta, CA 93117 USA
--| Telephone 805-685-1006, Fax 805-685-6869
--| Electronic mail <info@eiffel.com>
--| Customer support: http://support.eiffel.com>
--| For latest info see award-winning pages: http://www.eiffel.com
--|----------------------------------------------------------------

