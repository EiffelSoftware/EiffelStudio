indexing

	description:
		"Unbounded queues implemented as linked lists";

	copyright: "See notice at end of class";
	names: linked_queue, dispenser, linked_list;
	representation: linked;
	access: fixed, fifo, membership;
	contents: generic;
	date: "$Date$";
	revision: "$Revision$"

class LINKED_QUEUE [G] inherit

	QUEUE [G]
		undefine
			empty
		redefine
			linear_representation, prune_all, extend
		select
			item
		end;

	LINKED_LIST [G]
		rename
			item as ll_item,
			remove as ll_remove,
			make as ll_make,
			remove_left as remove
		export
			{NONE} 
				all;
			{ANY}
				writable, extendible, wipe_out,
				readable
		undefine
			put, fill, append, prune,
			readable, writable, prune_all, extend,
			force
		redefine
			duplicate, linear_representation
		select
			remove
		end;

creation

	make

feature -- Initialization

	make is
		do
			after := true
		end;
			
feature -- Access

	item: G is
			-- Oldest item	
		require else
			not empty
		do
				check
					after and not empty implies (active = last_element)
				end;
			Result := active.item	
		end;

feature -- Element change

	put, extend, force (v: G) is
			-- Add `v' as newest element.
		do
			put_front (v)
			before := false
			after := true
		ensure then
			(old empty) implies (item = v);
		end;

feature -- Conversion

	linear_representation: ARRAYED_LIST [G] is
			-- Representation as a linear structure
			-- (order is same as original order of insertion)
		local
			i: INTEGER;
			default_value: G;
		do
			from
				!!Result.make (count);
				i := 1
			until
				i > count
			loop
				Result.extend (default_value);
				i := i + 1	
			end;
			from
				start;
				Result.finish;
			until
				after
			loop
				Result.replace (item);
				forth;
				Result.back
			end;
		end;

feature -- Duplication

	duplicate (n: INTEGER): like Current is
			-- New queue containing the `n' oldest items in current queue.
			-- If `n' is greater than `count', identical to current queue.
		require else
			positive_argument: n > 0
		do
			start;
			from
				!! Result.make;
				start
			until
				after or Result.count = n
			loop
				Result.extend (ll_item);
				forth;
			end;
			finish
		end;

feature {NONE} -- Not applicable
	
	prune (v: like item) is
			-- Remove one occurence of `v'.
			-- Not available.
		do
			-- Do nothing
		end;
	
	prune_all (v: like item) is
			-- Remove all occurences of `v'.
			-- Not available
		do
			-- Do nothing
		end;

invariant

	is_always_after: not empty implies after

end -- class LINKED_QUEUE


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
