indexing
	legal: "See notice at end of class."
	status: "See notice at end of class."
class
	COLUMN [G]

inherit
	LINKED_LIST [G]

create
	make

feature -- Access

	remove_top is
			-- Remove the top of the column.
		require
			not_empty: not is_empty
		do
			finish
			remove
		ensure
			new_count: old count = count + 1
		end

	the_top: G is
			-- The top of the column
		require
			not_empty: not is_empty
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

indexing
	copyright:	"Copyright (c) 1984-2006, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			 Eiffel Software
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"


end -- class COLUMN

