indexing
	description:
		"Simple containers"

	status:	"See note at end of class"
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

end -- class BASIC_CONTAINER

--|----------------------------------------------------------------
--| EiffelTest: Reusable components for developing unit tests.
--| Copyright (C) 2000 Interactive Software Engineering Inc (ISE).
--| EiffelTest may be used by anyone as FREE SOFTWARE to
--| develop any product, public-domain or commercial, without
--| payment to ISE, under the terms of the ISE Free Eiffel Library
--| License (IFELL) at http://eiffel.com/products/base/license.html.
--|
--| Interactive Software Engineering Inc.
--| ISE Building, 2nd floor
--| 270 Storke Road, Goleta, CA 93117 USA
--| Telephone 805-685-1006, Fax 805-685-6869
--| Electronic mail <info@eiffel.com>
--| Customer support e-mail <support@eiffel.com>
--| For latest info see award-winning pages: http://www.eiffel.com
--|----------------------------------------------------------------
