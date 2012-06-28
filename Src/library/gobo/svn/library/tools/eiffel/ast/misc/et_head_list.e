indexing

	description:

		"Eiffel AST lists where insertions to and removals from the head are optimized"

	library: "Gobo Eiffel Tools Library"
	copyright: "Copyright (c) 2002-2004, Eric Bezault and others"
	license: "MIT License"
	date: "$Date$"
	revision: "$Revision$"

deferred class ET_HEAD_LIST [G]

feature {NONE} -- Initialization

	make is
			-- Create a new empty list.
		do
			count := 0
			storage := Void
		ensure
			is_empty: is_empty
			capacity_set: capacity = 0
		end

	make_with_capacity (nb: INTEGER) is
			-- Create a new empty list with capacity `nb'.
		require
			nb_positive: nb >= 0
		do
			count := 0
			if nb > 0 then
				storage := fixed_array.make (nb)
			else
				storage := Void
			end
		ensure
			is_empty: is_empty
			capacity_set: capacity = nb
		end

feature -- Access

	item (i: INTEGER): G is
			-- Item at index `i' in list
		require
			i_large_enough: i >= 1
			i_small_enough: i <= count
		do
			Result := storage.item (count - i)
		ensure
			item_not_void: Result /= Void
		end

	first: like item is
			-- First item
		require
			not_empty: not is_empty
		do
			Result := storage.item (count - 1)
		ensure
			first_not_void: Result /= Void
			definition: Result = item (1)
		end

	last: like item is
			-- Last item
		require
			not_empty: not is_empty
		do
			Result := storage.item (0)
		ensure
			last_not_void: Result /= Void
			definition: Result = item (count)
		end

feature -- Measurement

	count: INTEGER
			-- Number of items in list

	capacity: INTEGER is
			-- Maximum number of items in list
		do
			if storage /= Void then
				Result := storage.count
			end
		end

feature -- Status report

	is_empty: BOOLEAN is
			-- Is there no item in list?
		do
			Result := (count = 0)
		ensure
			definition: Result = (count = 0)
		end

	has (an_item: like item): BOOLEAN is
			-- Does list contain `an_item'?
			-- (Use `=' as comparison criterion.)
		require
			an_item_not_void: an_item /= Void
		local
			i, nb: INTEGER
		do
			nb := count - 1
			from i := 0 until i > nb loop
				if storage.item (i) = an_item then
					Result := True
					i := nb + 1 -- Jump out of the loop.
				else
					i := i + 1
				end
			end
		end

	valid_index (i: INTEGER): BOOLEAN is
			-- Is there an item at index `i'?
		do
			Result := (1 <= i and i <= count)
		ensure
			definition: Result = (1 <= i and i <= count)
		end

feature -- Element change

	put_first (an_item: like item) is
			-- Put `an_item' at first position in list.
		require
			an_item_not_void: an_item /= Void
			not_full: count < capacity
		do
			storage.put (an_item, count)
			count := count + 1
		ensure
			one_more: count = old count + 1
			first_set: first = an_item
		end

	force_first (an_item: like item) is
			-- Put `an_item' at first position in list.
			-- Resize list if necessary.
		require
			an_item_not_void: an_item /= Void
		local
			new_capacity: INTEGER
		do
			if count >= capacity then
				new_capacity := (capacity + 1) * 2
				if storage = Void then
					storage := fixed_array.make (new_capacity)
				else
					storage := fixed_array.resize (storage, new_capacity)
				end
			end
			storage.put (an_item, count)
			count := count + 1
		ensure
			one_more: count = old count + 1
			first_set: first = an_item
		end

	put (an_item: like item; i: INTEGER) is
			-- Put `an_item' at index `i' in list.
		require
			an_item_not_void: an_item /= Void
			i_large_enough: i >= 1
			i_small_enough: i <= count
		do
			storage.put (an_item, count - i)
		ensure
			same_count: count = old count
			inserted: item (i) = an_item
		end

feature -- Removal

	remove_first is
			-- Remove first item.
		require
			not_empty: not is_empty
		local
			dead_item: like item
		do
			count := count - 1
			storage.put (dead_item, count)
		ensure
			one_less: count = old count - 1
		end

	remove (i: INTEGER) is
			-- Remove item at index `i'.
		require
			i_large_enough: i >= 1
			i_small_enough: i <= count
		local
			j, nb: INTEGER
			dead_item: like item
		do
			j := count - i
			nb := count - 2
			from until j > nb loop
				storage.put (storage.item (j + 1), j)
				j := j + 1
			end
			storage.put (dead_item, j)
			count := count - 1
		ensure
			one_less: count = old count - 1
		end

	wipe_out is
			-- Remove all items.
		local
			i: INTEGER
			dead_item: like item
		do
			from i := count - 1 until i < 0 loop
				storage.put (dead_item, i)
				i := i - 1
			end
			count := 0
		ensure
			wiped_out: is_empty
		end

feature -- Resizing

	resize (nb: INTEGER) is
			-- Resize to accommodate at least `n' items.
		require
			nb_positive: nb >= 0
		do
			if nb > capacity then
				if storage = Void then
					storage := fixed_array.make (nb)
				else
					storage := fixed_array.resize (storage, nb)
				end
			end
		ensure
			resized: capacity >= nb
		end

feature -- Iteration

	do_all (an_action: PROCEDURE [ANY, TUPLE [like item]]) is
			-- Apply `an_action' to every item, from first to last.
			-- (Semantics not guaranteed if `an_action' changes the list.)
		require
			an_action_not_void: an_action /= Void
		local
			i: INTEGER
		do
			from
				i := count - 1
			until
				i < 0
			loop
				an_action.call ([storage.item (i)])
				i := i - 1
			end
		end

	do_if (an_action: PROCEDURE [ANY, TUPLE [like item]]; a_test: FUNCTION [ANY, TUPLE [like item], BOOLEAN]) is
			-- Apply `an_action' to every item that satisfies `a_test', from first to last.
			-- (Semantics not guaranteed if `an_action' or `a_test' change the list.)
		require
			an_action_not_void: an_action /= Void
			a_test_not_void: a_test /= Void
		local
			i: INTEGER
			l_item: like item
		do
			from
				i := count - 1
			until
				i < 0
			loop
				l_item := storage.item (i)
				if a_test.item ([l_item]) then
					an_action.call ([l_item])
				end
				i := i - 1
			end
		end

feature {NONE} -- Implementation

	storage: SPECIAL [like item]
			-- Internal storage

	fixed_array: KL_SPECIAL_ROUTINES [G] is
			-- Fixed array routines
		deferred
		ensure
			fixed_array_not_void: Result /= Void
		end

invariant

	count_positive: count >= 0
	consistent_count: count <= capacity
	storage_not_void: not is_empty implies storage /= Void

end
