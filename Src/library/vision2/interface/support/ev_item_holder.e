indexing
	description:
		" A common class for the primitives with item in it."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

deferred class
	EV_ITEM_HOLDER [G -> EV_ITEM]

inherit
	EV_ANY
		redefine
			implementation
		end

feature -- Access

	count: INTEGER is
			-- Number of direct children of the holder.
		require
			exists: not destroyed
		do
			Result := implementation.count
		ensure
			positive_result: Result >= 0
		end

--	get_item (index: INTEGER): G is
	get_item (index: INTEGER): EV_ITEM is
			-- Give the item of the list at the zero-base
			-- `index'.
		require
			exists: not destroyed
			item_exists: (index <= count) and (index >= 0)
		do
			Result := implementation.get_item (index)
		ensure
			Result_not_void: Result /= Void
		end

feature -- Element change

	clear_items is
			-- Clear all the items of the list.
		require
			exists: not destroyed
		do
			implementation.clear_items
		end

feature -- Basic operations

--	find_item_by_data (data: ANY): G is
	find_item_by_data (data: ANY): EV_ITEM is
			-- Find a child with data equal to `data'.
		require
			exists: not destroyed
			valid_data: data /= Void
		do
			Result := implementation.find_item_by_data (data)
		end

feature -- Implementation

	implementation: EV_ITEM_HOLDER_I
			-- Platform specific access.

end -- class EV_ITEM_HOLDER

--|----------------------------------------------------------------
--| EiffelVision: library of reusable components for ISE Eiffel.
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
