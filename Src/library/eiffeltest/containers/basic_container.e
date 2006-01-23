indexing
	description:
		"Simple containers"
	legal: "See notice at end of class."

	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

deferred class 
	BASIC_CONTAINER [G]

feature -- Measurement

	count: INTEGER is
			-- Number of elements
		deferred
		end
	 
feature -- Status report

	is_empty: BOOLEAN is
			-- Is container empty?
		deferred
		end

	insertable (v: G): BOOLEAN is
			-- Can `v' be inserted?
		require
			item_exists: v /= Void
		deferred
		end
	 
	valid_index (i: INTEGER): BOOLEAN is
			-- Is index `i' valid?
		deferred
		ensure
			valid_index: 1 <= i and i <= count
		end
		
feature -- Element change

	extend (v: G) is
			-- Add `v' to the end.
		require
			item_exists: v /= Void
			insertable: insertable (v)
		deferred
		ensure
			one_more_item: count = old count + 1
		end

	replace (v: G; i: INTEGER) is
			-- Replace `i'-th item with `v'.
		require
			not_empty: not is_empty
			valid_index: valid_index (i)
			item_exists: v /= Void
		deferred
		ensure
			count_unchanged: count = old count
		end
	 
feature -- Removal

	remove (i: INTEGER) is
			-- Remove `i'-th item.
		require
			not_empty: not is_empty
			valid_index: valid_index (i)
		deferred
		ensure
			one_less_item: count = old count - 1
		end

	wipe_out is
			-- Remove all items.
		deferred
		ensure
			empty: is_empty
		end

invariant

	empty_definition: is_empty = (count = 0)

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




end -- class BASIC_CONTAINER

