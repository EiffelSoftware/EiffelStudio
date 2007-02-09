indexing

	description:

		"Class similuating ISE's class SPECIAL with features `item', `put' and `count'"

	library: "Gobo Eiffel Kernel Library"
	copyright: "Copyright (c) 2003, Eric Bezault and others"
	license: "Eiffel Forum License v2 (see forum.txt)"
	date: "$Date$"
	revision: "$Revision$"




class SPECIAL [G]


inherit

	FIXED_ARRAY [G]
		rename
			resize as array_resize
		end











create

	make, make_from_array

feature {NONE} -- Initialization













	make_from_array (an_array: ARRAY [G]) is
			-- Create a new special object and fill it
			-- with items from `an_array'.
		require
			an_array_not_void: an_array /= Void

		do
			from_collection (an_array)














		ensure
			count_set: count = an_array.count
			-- same_items: forall i in 0.. (count - 1), item (i) = an_array.item (an_array.lower + i)
		end






































feature -- Resizing

	resize (n: INTEGER): SPECIAL [G] is
			-- Resize current special object so that it contains
			-- `n' items. Do not lose any previously entered items.
			-- Note: the returned special object might be `Current'
			-- or a newly created special object where items from
			-- `Current' have been copied to.
		require
			n_large_enough: n >= count
		do
			if n = count then
				Result := Current
			else

				Result := Current
				array_resize (n)





			end
		ensure
			special_not_void: Result /= Void
			count_set: Result.count = n
		end












































invariant





	zero_based: lower = 0


end
