indexing

	description:
		"Priority queues implemented as heaps"

	status: "See notice at end of class"
	names: sorted_priority_queue, dispenser, heap;
	representation: heap;
	access: fixed, membership;
	contents: generic;
	date: "$Date$"
	revision: "$Revision$"

class HEAP_PRIORITY_QUEUE [G -> COMPARABLE] inherit

	PRIORITY_QUEUE [G]
		undefine
			is_equal, copy, is_empty
		redefine
			linear_representation
		select
			count
		end

	ARRAY [G]
		rename
			make as array_make,
			item as i_th,
			put as put_i_th,
			bag_put as put,
			force as array_force,
			count as array_count
		export
			{NONE}
				all
			{HEAP_PRIORITY_QUEUE}
				put_i_th
		redefine
			full, prunable,
			put, extendible,
			linear_representation,
			index_set
		end

create

	make

feature -- Initialization

	make (n: INTEGER) is
			-- Allocate heap space.
		do
			array_make (1, n)
		end

feature -- Access

	item: G is
			-- Entry at top of heap.
		do
			Result := area.item (0)
		end

feature -- Measurement

	count: INTEGER
			-- Number of items

	index_set: INTEGER_INTERVAL is
			-- Range of acceptable indexes
		do
			create Result.make (1, count)
		ensure then
			count_definition: Result.count = count
		end

feature -- Status report

	extendible: BOOLEAN is
			-- May items be added?
		do
			Result := not full
		end

	full: BOOLEAN is
			-- Is structure filled to capacity?
		do
			Result := (count = capacity)
		end

	prunable: BOOLEAN is True
			-- May items be removed? (Answer: yes.)

feature -- Element change

	force, put (v: like item) is
			-- Insert item `v' at its proper position.
		do
			count := count + 1
			array_force (v, count)
			up_heap
		end

feature -- Removal

	remove is
			-- Remove item of highest value.
		do
			put_i_th (i_th (count), 1)
			count := count - 1
			down_heap
		end

feature -- Conversion

	linear_representation: ARRAYED_LIST [G] is
			-- Representation as a linear structure
			-- (Sorted according to decreasing priority)
		local
			i: INTEGER
		do
			from
				create Result.make (count)
			until
				is_empty
			loop
				Result.extend (item)
				remove
			end
			from
				i := 1
			until
				i > Result.count
			loop
				put_i_th (Result.i_th (i), i)
				i := i + 1
			end
		end

feature -- Duplication

	duplicate (n: INTEGER): like Current is
			-- New priority queue containing the `n' greatest items
		local
			temp: ARRAY [G]
			i, j: INTEGER
		do
			from
				create temp.make (1, n)
				i := 1
			until
				i <= n
			loop
				temp.put (item, i)
				remove
				i := i + 1
			end
			from
				i := count
				j := i + n - 1
			until
				i < 1
			loop
				area.put (area.item (i), j)
				i := i - 1
				j := j - 1
			end
			from
				create Result.make (n)
				i := 1
			until
				i > n
			loop
				Result.put_i_th (temp.item (i), i)
				put_i_th (temp.item (i), i)
			end
		end

feature {NONE} -- Inapplicable

	replace (v: like item) is
		do
		end

feature {NONE} -- Implementation

	down_heap is
		-- Move the heap downwards.
		local
			i, j, k: INTEGER
			up, left, right: like item
			stop: BOOLEAN
		do
			from
				up := area.item (0)
			until
				stop
			loop
				j := 2 * i + 1
				if j < count - 1 then
					left := area.item (j)
					k := j + 1
					right := area.item (k)
					if right > left then
						j := k
						left := right
					end
				elseif j = count - 1 then
					left := area.item (j)
				else
					stop := True
				end
				if not stop then
					if left > up then
						area.put (left, i)
						i := j
					else
						stop := True
					end
				end
			end
			area.put (up, i)
		end


	up_heap is
			-- Move the heap downwards.
		local
			i, j: INTEGER
			up, down: like item
			stop: BOOLEAN
		do
			from
				i := count - 1
				down := area.item (i)
			until
				stop or i = 0
			loop
				j := (i - 1) // 2
				up := area.item (j)
				if up < down then
					area.put (up, i)
					i := j
				else
					stop := True
				end
			end
			area.put (down, i)
		end

invariant

	empty_means_storage_empty: is_empty implies all_default

indexing

	library: "[
			EiffelBase: Library of reusable components for Eiffel.
			]"

	status: "[
			Copyright 1986-2001 Interactive Software Engineering (ISE).
			For ISE customers the original versions are an ISE product
			covered by the ISE Eiffel license and support agreements.
			]"

	license: "[
			EiffelBase may now be used by anyone as FREE SOFTWARE to
			develop any product, public-domain or commercial, without
			payment to ISE, under the terms of the ISE Free Eiffel Library
			License (IFELL) at http://eiffel.com/products/base/license.html.
			]"

	source: "[
			Interactive Software Engineering Inc.
			ISE Building
			360 Storke Road, Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Electronic mail <info@eiffel.com>
			Customer support http://support.eiffel.com
			]"

	info: "[
			For latest info see award-winning pages: http://eiffel.com
			]"

end -- class HEAP_PRIORITY_QUEUE
