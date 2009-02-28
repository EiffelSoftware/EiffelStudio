note
	description:

		"Simple list for use within the Erl runtime. (Modified version of ET_TAIL_LIST from Gobo)"

	author: "Andreas Leitner"
	date: "$Date$"
	revision: "$Revision$"

class ERL_LIST [G]

create

	make,
	make_with_capacity

feature {NONE} -- Initialization

	make
			-- Create a new empty list.
		do
			count := 0
			storage := Void
		ensure
			is_empty: is_empty
			capacity_set: capacity = 0
		end

	make_with_capacity (nb: INTEGER)
			-- Create a new empty list with capacity `nb'.
		require
			nb_positive: nb >= 0
		local
			special_maker: TO_SPECIAL [G]
		do
			count := 0
			if nb > 0 then
				create special_maker.make_area (nb + 1)
				storage := special_maker.area
			else
				storage := Void
			end
		ensure
			is_empty: is_empty
			capacity_set: capacity = nb
		end

feature -- Access

	item (i: INTEGER): detachable G
			-- Item at index `i' in list
		require
			i_large_enough: i >= 1
			i_small_enough: i <= count
		local
			l_storage: like storage
		do
			l_storage := storage
			check l_storage /= Void end
			Result := l_storage.item (i)
		end

	first: like item
			-- First item
		require
			not_empty: not is_empty
		local
			l_storage: like storage
		do
			l_storage := storage
			check l_storage /= Void end
			Result := l_storage.item (1)
		ensure
			definition: Result = item (1)
		end

	last: like item
			-- Last item
		require
			not_empty: not is_empty
		local
			l_storage: like storage
		do
			l_storage := storage
			check l_storage /= Void end
			Result := l_storage.item (count)
		ensure
			definition: Result = item (count)
		end

feature -- Measurement

	count: INTEGER
			-- Number of items in list

	capacity: INTEGER
			-- Maximum number of items in list
		local
			l_storage: like storage
		do
			l_storage := storage
			if l_storage /= Void then
				Result := l_storage.count - 1
			end
		end

feature -- Status report

	is_empty: BOOLEAN
			-- Is there no item in list?
		do
			Result := (count = 0)
		ensure
			definition: Result = (count = 0)
		end

	has (an_item: like item): BOOLEAN
			-- Does list contain `an_item'?
			-- (Use `=' as comparison criterion.)
		local
			i, nb: INTEGER
			l_storage: like storage
		do
			nb := count
			from i := 1 until i > nb loop
				l_storage := storage
				check l_storage /= Void end
				if l_storage.item (i) = an_item then
					Result := True
					i := nb + 1 -- Jump out of the loop.
				else
					i := i + 1
				end
			end
		end

feature -- Element change

	put_last (an_item: like item)
			-- Put `an_item' at last position in list.
		require
			not_full: count < capacity
		local
			l_storage: like storage
		do
			count := count + 1
			l_storage := storage
			check l_storage /= Void end
			l_storage.put (an_item, count)
		ensure
			one_more: count = old count + 1
			last_set: last = an_item
		end

	force_last (an_item: like item)
			-- Put `an_item' at last position in list.
			-- Resize list if necessary.
		local
			new_capacity: INTEGER
			special_maker: TO_SPECIAL [G]
			l_storage: like storage
		do
			if count >= capacity then
				new_capacity := (capacity + 1) * 2
				l_storage := storage
				if l_storage = Void then
					create special_maker.make_area (new_capacity + 1)
					l_storage := special_maker.area
				elseif new_capacity + 1 > l_storage.count then
					l_storage := l_storage.resized_area (new_capacity + 1)
				end
				storage := l_storage
			else
				check l_storage /= Void end
			end
			count := count + 1
			l_storage.put (an_item, count)
		ensure
			one_more: count = old count + 1
			last_set: last = an_item
		end

	put (an_item: like item; i: INTEGER)
			-- Put `an_item' at index `i' in list.
		require
			i_large_enough: i >= 1
			i_small_enough: i <= count
		local
			l_storage: like storage
		do
			l_storage := storage
			check l_storage /= Void end
			l_storage.put (an_item, i)
		ensure
			same_count: count = old count
			inserted: item (i) = an_item
		end

	force_put (an_item: like item; i: INTEGER)
			-- Put `an_item' at index `i', resize the list when necessary.
		require
			i_large_enough: i >= 1
		local
			l_new_capacity: INTEGER
			l_special_maker: TO_SPECIAL [G]
			l_storage: like storage
		do
			l_storage := storage
			if i <= count then
				check l_storage /= Void end
				l_storage.put (an_item, i)
			elseif i <= capacity then
				check l_storage /= Void end
				l_storage.put (an_item, i)
				count := i
			else
				l_new_capacity := i * 2 + 1
				if l_storage = Void then
					create l_special_maker.make_area (l_new_capacity)
					l_storage := l_special_maker.area
				else
					l_storage := l_storage.resized_area (l_new_capacity)
				end
				storage := l_storage
				count := i
				l_storage.put (an_item, i)
			end
		ensure
			count_correct: (i <= old count implies count = old count) and (i > old count implies i = count)
			capacity_correct: capacity >= i
			an_item_inserted: item (i) = an_item
		end

feature -- Removal

	remove_last
			-- Remove last item.
		require
			not_empty: not is_empty
		local
			dead_item: like item
			l_storage: like storage
		do
			l_storage := storage
			check l_storage /= Void end
			l_storage.put (dead_item, count)
			count := count - 1
		ensure
			one_less: count = old count - 1
		end

	remove (i: INTEGER)
			-- Remove item at index `i'.
		require
			i_large_enough: i >= 1
			i_small_enough: i <= count
		local
			j, nb: INTEGER
			dead_item: like item
			l_storage: like storage
		do
			j := i
			nb := count - 1
			l_storage := storage
			check l_storage /= Void end
			from until j > nb loop
				l_storage.put (l_storage.item (j + 1), j)
				j := j + 1
			end
			l_storage.put (dead_item, j)
			count := count - 1
		ensure
			one_less: count = old count - 1
		end

	wipe_out
			-- Remove all items.
		local
			i: INTEGER
			dead_item: detachable like item
			l_storage: like storage
		do
			from i := count until i < 1 loop
				l_storage := storage
				check l_storage /= Void end
				l_storage.put (dead_item, i)
				i := i - 1
			end
			count := 0
		ensure
			wiped_out: is_empty
		end

feature -- Resizing

	resize (nb: INTEGER)
			-- Resize to accommodate at least `n' items.
		require
			nb_positive: nb >= 0
		local
			special_maker: TO_SPECIAL [G]
			l_storage: like storage
		do
			if nb > capacity then
				l_storage := storage
				if l_storage = Void then
					create special_maker.make_area (nb + 1)
					storage := special_maker.area
				elseif nb + 1 > l_storage.count then
					l_storage := l_storage.resized_area (nb + 1)
				end
			end
		ensure
			resized: capacity >= nb
		end

feature {NONE} -- Implementation

	storage: detachable SPECIAL [like item]
			-- Internal storage

invariant

	count_positive: count >= 0
	consistent_count: count <= capacity
	storage_not_void: not is_empty implies storage /= Void

note
	copyright: "Copyright (c) 1984-2009, Eiffel Software and others"
	license: "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"
end
