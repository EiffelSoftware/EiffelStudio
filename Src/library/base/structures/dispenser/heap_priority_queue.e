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
		end;

	HEAP [G]
		rename
			duplicate as array_duplicate
		export
			{HEAP_PRIORITY_QUEUE}
				put_i_th
		undefine
			full
		redefine
			linear_representation
		end
					

creation

	make

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

feature -- Status report

	full: BOOLEAN is
			-- Is structure filled to capacity?
		do
			Result := count = capacity
		end
					
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
