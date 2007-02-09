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

	ANY
		redefine
			copy, is_equal
		end


create

	make, make_from_array

feature {NONE} -- Initialization


	make (n: INTEGER) is
			-- Create a new special object.
		require
			non_negative_n: n >= 0
		do
			create storage.make (0, n - 1)
		ensure
			count_set: count = n
		end


	make_from_array (an_array: ARRAY [G]) is
			-- Create a new special object and fill it
			-- with items from `an_array'.
		require
			an_array_not_void: an_array /= Void





		local
			i, j, nb: INTEGER
		do
			i := an_array.lower
			nb := an_array.upper
			make (nb - i + 1)
			from until i > nb loop
				put (an_array.item (i), j)
				j := j + 1
				i := i + 1
			end

		ensure
			count_set: count = an_array.count
			-- same_items: forall i in 0.. (count - 1), item (i) = an_array.item (an_array.lower + i)
		end


feature -- Access

	item (i: INTEGER): G is
			-- Item at index `i'
		require
			i_large_enough: i >= 0
			i_small_enough: i < count
		do
			Result := storage.item (i)
		end

feature -- Measurement

	count: INTEGER is
			-- Number of items in special object
		do
			Result := storage.count
		end

	lower: INTEGER is 0
			-- Lower bound

feature -- Element change

	put (v: G; i: INTEGER) is
			-- Put `v' at index `i'.
		require
			i_large_enough: i >= 0
			i_small_enough: i < count
		do
			storage.put (v, i)
		ensure
			inserted: item (i) = v
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
				storage.resize (0, n - 1)

			end
		ensure
			special_not_void: Result /= Void
			count_set: Result.count = n
		end


feature -- Comparison

	is_equal (other: like Current): BOOLEAN is
			-- Is current special equal to `other'?
		do
			Result := storage.is_equal (other.storage)
		end

feature -- Duplication

	copy (other: like Current) is
			-- Copy `other' to `Current'.
		do
			standard_copy (other)
			storage := clone (storage)
		end

	twin: like Current is
			-- New object equal to `Current'
		do
			Result := clone (Current)
		ensure
			twin_not_void: Result /= Void
			is_equal: Result.is_equal (Current)
		end

feature -- Removal

	clear_all is
			-- Reset all items to default values.
		do
			storage.clear_all
		ensure
			-- all_cleared: forall i in 0..(count - 1), item (i) = Void or else item (i) = item (i).default
		end

feature {SPECIAL} -- Implementation

	storage: ARRAY [G]
			-- Storage


invariant


	storage_not_void: storage /= Void
	lower_zero: storage.lower = 0

	zero_based: lower = 0


end
