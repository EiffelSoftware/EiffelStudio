indexing

	description:
		"Priority queues implemented as heaps";

	copyright: "See notice at end of class";
	names: sorted_priority_queue, dispenser, heap;
	representation: heap;
	access: fixed, membership;
	contents: generic;
	date: "$Date$";
	revision: "$Revision$"

class HEAP_PRIORITY_QUEUE [G -> COMPARABLE] inherit

	PRIORITY_QUEUE [G]
		undefine
			is_equal, setup, copy, consistent, empty
		redefine
			linear_representation
		select
			count
		end;

	ARRAY [G]
		rename
			make as array_make,
			item as i_th,
			put as put_i_th,
			bag_put as put,
			force as array_force,
			count as array_count,
			duplicate as array_duplicate
		export
			{NONE}
				all
			{HEAP_PRIORITY_QUEUE}
				put_i_th
		redefine
			full, prunable,
			put, extendible,
			linear_representation
		end
		
creation

	make

feature -- Initialization

	make (n: INTEGER) is
			-- Allocate heap space.
		do
			array_make (1, n);
		end;	

feature -- Access

	item: G is
			-- Entry at top of heap.
		do
			Result := area.item (0);
		end;

feature -- Measurement

	count: INTEGER;

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

	prunable: BOOLEAN is true;
			-- May items be removed? (Answer: yes.)
		
feature -- Element change

	force, put (v: like item) is
			-- Insert item `v' at its proper position.
		do
			count := count + 1;
			array_force (v, count);
			up_heap;
		end;

feature -- Removal

	remove is
			-- Remove item of 
		do
			put_i_th (i_th (count), 1);
			count := count - 1;
			down_heap;
		end;

feature -- Conversion

	linear_representation: ARRAYED_LIST [G] is
			-- Representation as a linear structure
			-- (Sorted according to decreasing priority)
		local
			i: INTEGER;
		do
			from
				!!Result.make (count);
			until
				empty
			loop
				Result.extend (item);
				remove;
			end;
			from
				i := 1
			until
				i > Result.count
			loop
				put_i_th (Result.i_th (i), i);
				i := i + 1
			end;	
		end;

feature -- Duplication

	duplicate (n: INTEGER): like Current is
			-- New queue containing the n greatest items
		local
			temp: ARRAY [G];
			i, j: INTEGER
		do
			from
				!!temp.make (1, n);
				i := 1;
			until
				i <= n
			loop
				temp.put (item, i);
				remove;
				i := i + 1
			end;
			from
				i := count;
				j := i + n - 1
			until
				i < 1
			loop
				area.put (area.item (i), j);
				i := i - 1;
				j := j - 1;
			end;
			from
				Result.make (n);
				i := 1;
			until
				i > n
			loop
				Result.put_i_th (temp.item (i), i);
				put_i_th (temp.item (i), i);
			end
		end;

feature {NONE} -- Inapplicable

	replace (v : like item) is
		do
		end

feature {NONE} --Implementation

	down_heap is
		local
			i,j,k: INTEGER;
			up, left, right: like item;
			stop: BOOLEAN
		do
			from
				up := area.item (0)
			until
				stop
			loop
				j := 2 * i + 1;
				if j < count - 1 then
					left := area.item (j);
					k := j + 1;
					right := area.item (k);
					if right > left then
						j := k;
						left := right
					end;
				elseif j = count - 1 then
					left := area.item (j);
				else
					stop := true
				end;
				if not stop then
					if left > up then
						area.put (left, i);
						i := j;
					else
						stop := true
					end
				end
			end;
			area.put (up, i)
		end;


	up_heap is
		local
			i,j: INTEGER;
			up, down: like item;
			stop: BOOLEAN
		do
			from
				i := count - 1;
				down := area.item (i)
			until
				stop or i = 0
			loop
				j := (i - 1) // 2;
				up := area.item (j);
				if up < down then
					area.put (up, i);
					i := j
				else
					stop := true
				end
			end;
			area.put (down, i)
		end;

end -- class HEAP_PRIORITY_QUEUE


--|----------------------------------------------------------------
--| EiffelBase: library of reusable components for ISE Eiffel 3.
--| Copyright (C) 1986, 1990, 1993, Interactive Software
--|   Engineering Inc.
--| All rights reserved. Duplication and distribution prohibited.
--|
--| 270 Storke Road, Suite 7, Goleta, CA 93117 USA
--| Telephone 805-685-1006
--| Fax 805-685-6869
--| Electronic mail <info@eiffel.com>
--| Customer support e-mail <eiffel@eiffel.com>
--|----------------------------------------------------------------
