class
	COLUMN [G]

inherit
	LINKED_LIST [G]

creation
	make

feature -- Access

	remove_top is
			-- Remove the top of the column.
		require
			not_empty: not empty
		do
			finish
			remove
		ensure
			new_count: old count = count + 1
		end

	the_top: G is
			-- The top of the column
		require
			not_empty: not empty
		do
			finish
			Result := item
		ensure
			same_count: old count = count
		end

	add (a_item: G) is
			-- Add 'a_item' to the column,
			-- 'a_item' becomes the top
		require
			no_void_item: a_item /= Void
		do
			extend (a_item)
		ensure
			new_count: count = old count + 1
		end

	one_from_top: G is
			-- The item under the top of the column
		do
			if count > 1 then
				finish
				back
				Result := item
			end
		ensure
			result_is_valid: count > 1 implies Result /= Void
		end

end -- class COLUMN

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

